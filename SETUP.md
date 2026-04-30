# Setup on Another Computer

This repository is designed to be editable on a second machine with a small
amount of local bootstrapping.

## Prerequisites

Install these tools first:

- `git`
- `R` 4.5 or later
- `RStudio` (recommended)
- `Quarto`

You can verify the CLI tools with:

```powershell
git --version
Rscript --version
quarto --version
```

## Clone the Repository

```powershell
git clone <repo-url>
cd edu-ucab-introduction-ds
```

If you already cloned the repo previously:

```powershell
git fetch origin
git pull
```

## Prepare the R Packages

Open `edu-ucab-introduction-ds.Rproj` in RStudio, then run:

```r
source("scripts/setup_project.R")
```

That script checks for the R packages currently used by the lecture and handout
workflow and installs any that are missing.

This repo does not use `renv`. Keep package setup lightweight unless exact
package snapshots become necessary for grading or archival reproduction.

## Local-Only Content Not Stored on GitHub

Some material is intentionally excluded from version control:

- `references/`: PDFs, book files, extracted notes, and other copyrighted or
  bulky source material
- `legacy/`: archived inherited course files and experiments
- `data/`: local datasets that may be too large, private, or not ready to
  publish
- `outputs/`: rendered artifacts

For a new machine, copy any needed local material from your main computer into
the same folder structure after cloning. At minimum, that usually means the
local contents of:

- `references/`
- `legacy/`
- `data/`

The tracked `README.md` files inside those folders describe the intended
structure, but the actual local assets are expected to be copied separately.

## Render Check

Run these commands from the repo root:

```powershell
quarto render lectures/00-quarto-guide-preview/slides.qmd
quarto render lectures/01-course-intro-r-basics/slides.qmd
quarto render lectures/02-data-wrangling-dplyr/slides.qmd
```

Rendered files should appear under `outputs/rendered-slides/`.

## PDF Export Standard

For shareable lecture PDFs, use the repo helper instead of a manual browser
export:

```powershell
powershell -ExecutionPolicy Bypass -File scripts/export_lecture_pdf.ps1 -LectureDir lectures/01-course-intro-r-basics
```

That workflow:

- renders the lecture from its own folder
- exports the current Reveal deck through headless Edge in `?print-pdf` mode
- preserves the slide backgrounds and page resolution better than ad hoc PDF
  printing
- writes a lecture-numbered file such as `lecture-01-slides.pdf` into
  `outputs/rendered-slides/...`

## Recommended Sync Pattern for Local References

Do not rely on memory for the non-GitHub material. Keep one canonical local
archive outside the repo and copy or sync it into each clone. Reasonable
options are:

- a cloud-synced folder
- an external drive
- a private institutional storage location

The key constraint is that GitHub is the source of truth for the lecture code
and structure, while local storage is the source of truth for excluded
reference and archive files.
