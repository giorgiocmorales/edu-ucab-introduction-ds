# Introduction to Data Science Course

This repository is the instructor production workspace for the elective course _Introduction to Data Science_ offered by the School of Economics of Universidad Catolica Andres Bello (UCAB).

It is designed to support:

- Quarto slide design and standalone lecture rendering
- a minimal lecture-first authoring system
- dataset organization for lectures, assignments, and project work
- preservation of inherited course material in a clearly separated legacy area
- reference management for sources such as Irizarry and Analytics Edge

Student-facing logistics live on the university platform. This repository is the canonical source for slide creation, internal organization, and reusable teaching assets.

## Repository Structure

- `lectures/`: canonical lecture workspace.
- `lectures/_metadata.yml`: shared Quarto revealjs defaults.
- `lectures/_shared/`: reusable shared assets such as logos.
- `lectures/_templates/`: minimal starter templates for future lecture decks and handouts.
- `lectures/00-quarto-guide-preview/`: preview deck based on the official Quarto presentation guide.
- `lectures/01-course-intro-r-basics/`: first draft lecture built from legacy presentations 01-02 and scripts 01-06.
- `data/`: datasets used in lectures, assignments, and project work.
- `R/`: reusable helper scripts for lecture rendering or course utilities.
- `templates/`: non-lecture scaffolds such as problem-set templates.
- `references/`: reference books and adaptation notes.
- `legacy/`: archived material from previous course versions and discarded presentation experiments.
- `outputs/rendered-slides/`: standalone rendered lecture decks.
- `outputs/figures/` and `outputs/tables/`: generated artifacts.

## Quarto Workflow

- The repo is configured for standalone `revealjs` slides.
- The current baseline follows the official Quarto presentations guide: https://quarto.org/docs/presentations/
- Render the preview deck with `quarto render lectures/00-quarto-guide-preview/slides.qmd`.
- Render Lecture 01 with `quarto render lectures/01-course-intro-r-basics/slides.qmd`.
- Shared defaults live in [`lectures/_metadata.yml`](/d:/Documents/3_Trabajos/UCAB/Profesor/Introduction%20to%20Data%20Science/edu-ucab-introduction-ds/lectures/_metadata.yml).
- Future decks should start from [`lectures/_templates/lecture-slides.qmd`](/d:/Documents/3_Trabajos/UCAB/Profesor/Introduction%20to%20Data%20Science/edu-ucab-introduction-ds/lectures/_templates/lecture-slides.qmd).

## Active Status

The presentation setup was reset to a minimal Quarto-native baseline, and Lecture 01 now exists as a content-first draft. The preview deck remains available for structure checks, but the active lecture draft is based directly on the legacy opening presentations and scripts.
