# Agent Operating Contract

This repository is the instructor production workspace for UCAB's
Introduction to Data Science course. Treat it as a course-authoring repo, not
as a package or a general website.

## Source of Truth

- Lecture source lives in `lectures/`.
- The shared slide reference format lives in `lectures/_format/` and
  `lectures/_metadata.yml`.
- Lecture starter files live in `lectures/_templates/`.
- Problem-set source and templates live in `problem-sets/`.
- Automation scripts live in `scripts/`.
- Plans live in `plans/`.
- Agent-specific skills live in `.agents/skills/`.

## Folder Rules

Each lecture folder should stay lean:

- `slides.qmd`
- `handouts/`
- `assets/`

Do not put rendered outputs, `slides_files/`, ad hoc exports, or cache folders
inside lecture source folders. Generated artifacts belong under `outputs/`.

`data/`, `references/`, and `legacy/` are local-only areas. Do not reorganize
or delete their contents unless the user explicitly asks.

## Lecture Format

Use the shared format in `lectures/_format/` for course-wide styling,
backgrounds, logos, and Reveal behavior. Individual lectures should not carry
local styling unless the format contract has been reviewed and updated.

Handout scripts should follow the lecture flow and use continuous course-wide
numbering across lectures.

## Setup and Rendering

This repo does not use `renv`. Use:

```r
source("scripts/setup_project.R")
```

Render checks from the repo root:

```powershell
quarto render lectures/00-quarto-guide-preview/slides.qmd
quarto render lectures/01-course-intro-r-basics/slides.qmd
quarto render lectures/02-data-wrangling-dplyr/slides.qmd
```

PDF exports should use:

```powershell
powershell -ExecutionPolicy Bypass -File scripts/export_lecture_pdf.ps1 -LectureDir lectures/NN-short-lecture-name
```

## Editing Discipline

Prefer small, mechanical changes that preserve the course scaffold. Update
README files when moving folders or changing workflow contracts. Avoid broad
refactors of lecture content while changing repository structure.
