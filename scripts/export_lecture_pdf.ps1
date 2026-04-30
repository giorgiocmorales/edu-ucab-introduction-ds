param(
  [Parameter(Mandatory = $true)]
  [string]$LectureDir
)

$ErrorActionPreference = "Stop"

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$lecturePath = Resolve-Path (Join-Path $repoRoot $LectureDir)
$lectureName = Split-Path $lecturePath -Leaf

if ($lectureName -notmatch '^(\d{2})-') {
  throw "Lecture folder name must start with NN-, for example 01-course-intro-r-basics."
}

$lectureNumber = $Matches[1]
$slidesQmd = Join-Path $lecturePath "slides.qmd"
if (-not (Test-Path $slidesQmd)) {
  throw "Could not find slides.qmd in $lecturePath"
}

$edgeCandidates = @(
  "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe",
  "C:\Program Files\Microsoft\Edge\Application\msedge.exe"
)

$edgePath = $edgeCandidates | Where-Object { Test-Path $_ } | Select-Object -First 1
if (-not $edgePath) {
  throw "Microsoft Edge was not found in the standard install locations."
}

Push-Location $lecturePath
try {
  & quarto render slides.qmd
}
finally {
  Pop-Location
}

$outputDir = Join-Path $repoRoot "outputs\rendered-slides\lectures\$lectureName"
$slidesHtml = Join-Path $outputDir "slides.html"
$pdfOutput = Join-Path $outputDir ("lecture-{0}-slides.pdf" -f $lectureNumber)
$exportStartedAt = Get-Date

if (-not (Test-Path $slidesHtml)) {
  throw "Expected rendered HTML at $slidesHtml"
}

$null = New-Item -ItemType Directory -Path $outputDir -Force
if (Test-Path $pdfOutput) {
  Remove-Item -LiteralPath $pdfOutput -Force
}

$fileUrl = "file:///" + ($slidesHtml.Replace('\', '/')) + "?print-pdf"

& $edgePath `
  --headless `
  --disable-gpu `
  --allow-file-access-from-files `
  --run-all-compositor-stages-before-draw `
  --virtual-time-budget=15000 `
  "--print-to-pdf=$pdfOutput" `
  --print-to-pdf-no-header `
  $fileUrl

for ($i = 0; $i -lt 30 -and -not (Test-Path $pdfOutput); $i++) {
  Start-Sleep -Milliseconds 500
}

if (-not (Test-Path $pdfOutput)) {
  throw "PDF export failed: $pdfOutput was not created."
}

$pdfItem = Get-Item $pdfOutput
if ($pdfItem.LastWriteTime -lt $exportStartedAt) {
  throw "PDF export failed: $pdfOutput was not refreshed."
}

$pdfItem | Select-Object FullName, Length, LastWriteTime
