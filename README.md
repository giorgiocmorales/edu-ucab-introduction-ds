# Introduction to Data Science Course

This repository is the instructor production workspace for the elective course
_Introduction to Data Science_ offered by the School of Economics of
Universidad Catolica Andres Bello (UCAB).

The repo is organized around a small number of course artifacts:

- standardized Quarto lectures
- runnable script handouts
- problem sets
- reusable course scripts and templates
- local-only data, references, and legacy source material
- agent instructions, skills, and planning notes for assisted maintenance

Student-facing logistics live on the university platform. This repository is
the canonical source for slide creation, internal organization, and reusable
teaching assets.

## Repository Structure

- `lectures/`: canonical lecture workspace.
- `lectures/_metadata.yml`: shared Quarto revealjs defaults.
- `lectures/_format/`: locked shared slide format, including theme files,
  background logic, reusable logos, and visual assets.
- `lectures/_templates/`: starter templates for lecture decks and handouts.
- `problem-sets/`: problem-set source files and problem-set templates.
- `scripts/`: reusable automation for setup, rendering, and export.
- `data/`: local datasets used in lectures, assignments, and project work.
- `references/`: local reference books, PDFs, and adaptation notes.
- `legacy/`: archived material from previous course versions and discarded
  presentation experiments.
- `outputs/`: generated render artifacts, including rendered slides and
  generated problem-set exports.
- `plans/`: repo maintenance plans, with old plans under `plans/archived/`.
- `.agents/`: local agent skills and workflow notes.
- `AGENTS.md`: repo-wide operating contract for coding agents.

Each lecture source folder should stay lean:

- `slides.qmd`
- `handouts/`
- `assets/`

Generated render artifacts should live under `outputs/`, not inside lecture
authoring folders.

## Lecture Workflow

The repo is configured for standalone `revealjs` slides. Course-wide defaults
live in `lectures/_metadata.yml`, while the locked visual reference format
lives in `lectures/_format/`.

Render checks:

```powershell
quarto render lectures/00-quarto-guide-preview/slides.qmd
quarto render lectures/01-course-intro-r-basics/slides.qmd
quarto render lectures/02-data-wrangling-dplyr/slides.qmd
```

Future decks should start from `lectures/_templates/lecture-slides.qmd`.

To clear local generated folders that make the workspace look deeper than the
source tree, run:

```powershell
powershell -ExecutionPolicy Bypass -File scripts/clean_generated.ps1
```

Student-share convention:

- keep the normal Quarto render as `slides.html`
- create a lecture-numbered export alongside it, such as
  `lecture-01-slides.html` or `lecture-02-slides.html`
- PDFs should follow the same pattern, for example `lecture-01-slides.pdf`
- generate lecture PDFs with `scripts/export_lecture_pdf.ps1` so Reveal
  backgrounds and resolution are preserved consistently

## Problem Sets

Problem-set source lives in `problem-sets/`. Shared starter files belong in
`problem-sets/_templates/`, and individual source folders should use numbered
names such as:

```text
problem-sets/01-r-basics/
  README.md
  student-facing.md
  01-r-basics-review.R
```

Problem sets should be consolidated in a format that can be copied into Canvas
with minimal cleanup. Elaborate coding problems should also have corresponding
R review scripts so expected answers can be reproduced.

Canvas-ready and instructor-only generated outputs belong under
`outputs/problem-sets/` and should not be committed unless explicitly requested.

## Machine Setup

Use `SETUP.md` when cloning the course workspace onto another computer.
Bootstrapping from RStudio can be done with:

```r
source("scripts/setup_project.R")
```

This repo no longer uses `renv`. The setup script installs/checks the small set
of R packages needed by the current lecture and handout workflow.

## Local-Only Content Policy

- `data/`, `references/`, and `legacy/` are intentionally ignored except for
  their tracked `README.md` files.
- GitHub stores the lecture system and source-controlled assets, but not local
  PDFs, archives, inherited bulk material, or private datasets.
- A second machine should clone the repo from GitHub and then copy any needed
  local-only materials from a separate private archive.

## Active Status

The course scaffold is being streamlined around standardized lectures,
problem sets, script handouts, and agent-assisted maintenance. The current
lecture format is centralized in `lectures/_format/` and should be treated as
the reviewable reference contract before individual lectures diverge.
