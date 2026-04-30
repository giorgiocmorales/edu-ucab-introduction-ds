param(
  [switch]$IncludeRenderedSlides
)

$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $PSScriptRoot

$targets = @(
  ".quarto",
  ".Rproj.user"
)

if ($IncludeRenderedSlides) {
  $targets += "outputs\rendered-slides"
}

foreach ($target in $targets) {
  $path = Join-Path $repoRoot $target
  if (Test-Path -LiteralPath $path) {
    Remove-Item -LiteralPath $path -Recurse -Force
    Write-Host "Removed $target"
  }
}

