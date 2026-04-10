# Setup on Another Computer

This repository is designed to be editable on a second machine with a small amount of local bootstrapping.

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

## Clone and Switch to the Lecture Branch

```powershell
git clone <repo-url>
cd edu-ucab-introduction-ds
git switch --track origin/codex/quarto-lecture-reset
```

If you already cloned the repo previously:

```powershell
git fetch origin
git switch codex/quarto-lecture-reset
git pull
```

## Restore the R Environment

Open [`edu-ucab-introduction-ds.Rproj`](/d:/Documents/3_Trabajos/UCAB/Profesor/Introduction%20to%20Data%20Science/edu-ucab-introduction-ds/edu-ucab-introduction-ds.Rproj) in `RStudio`, then run:

```r
source("R/setup_project.R")
```

That script:

- installs `renv` if needed
- restores the project library from [`renv.lock`](/d:/Documents/3_Trabajos/UCAB/Profesor/Introduction%20to%20Data%20Science/edu-ucab-introduction-ds/renv.lock)

If you prefer to do it manually:

```r
install.packages("renv")
renv::restore()
```

## Local-Only Content Not Stored on GitHub

Some material is intentionally excluded from version control:

- `references/`: PDFs, book files, extracted notes, and other copyrighted or bulky source material
- `legacy/`: archived inherited course files and experiments
- `data/`: local datasets that may be too large, private, or not ready to publish
- `outputs/`: rendered artifacts

For a new machine, copy any needed local material from your main computer into the same folder structure after cloning. At minimum, that usually means the local contents of:

- `references/`
- `legacy/`
- `data/`

The tracked `README.md` files inside those folders describe the intended structure, but the actual local assets are expected to be copied separately.

## Render Check

Run these commands from the repo root:

```powershell
quarto render lectures/00-quarto-guide-preview/slides.qmd
quarto render lectures/01-course-intro-r-basics/slides.qmd
```

Rendered files should appear under `outputs/rendered-slides/`.

## Recommended Sync Pattern for Local References

Do not rely on memory for the non-GitHub material. Keep one canonical local archive outside the repo and copy or sync it into each clone. Reasonable options are:

- a cloud-synced folder
- an external drive
- a private institutional storage location

The key constraint is that GitHub is the source of truth for the lecture code and structure, while local storage is the source of truth for excluded reference and archive files.
