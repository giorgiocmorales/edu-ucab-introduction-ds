# Lectures Workspace

`lectures/` is the canonical authoring area for course slide decks and lecture
handouts.

## Shared Format

All lectures inherit the same revealjs baseline from:

- `_metadata.yml`: shared revealjs options and course-wide defaults.
- `_format/slide-theme.css`: shared typography, footer, logo, and title
  styling.
- `_format/slide-backgrounds.html`: shared background assignment logic.
- `_format/backgrounds/` and `_format/assets/`: reusable visual assets only.

Theme or layout changes that should affect the full course belong in
`_format/` or `_metadata.yml`, not inside individual lecture folders.

Treat `_format/` as the locked reference format subject to review. Individual
lectures should diverge only when the lecture needs local assets or content, not
custom styling.

## Folder Contract

Each lecture should follow the same structure:

- `NN-short-lecture-name/slides.qmd`: canonical slide deck.
- `NN-short-lecture-name/handouts/`: runnable scripts that follow the lecture
  flow.
- `NN-short-lecture-name/assets/`: lecture-specific images only.

Handout files should use continuous course-wide numbering, not per-lecture
resets. Example: `01_...`, `02_...`, ..., `07_...`, `08_...`.

Supporting folders:

- `_templates/`: starter files for new lectures.
- `00-quarto-guide-preview/`: experimental preview deck kept as reference.

Lecture source folders should not keep rendered support folders such as
`slides_files/` or other Quarto output artifacts. Those belong under `outputs/`.

## Active Lectures

- `01-course-intro-r-basics/slides.qmd`: introduction to the course, `R`,
  `RStudio`, and foundational vector/data-frame concepts.
- `02-data-wrangling-dplyr/slides.qmd`: lecture on `dplyr`-based data
  wrangling and reshaping.

## Working Rule

Legacy material in `legacy/` is reference material only. New edits should land
in `lectures/`.

## Shareable Outputs

Rendered lecture files live under
`outputs/rendered-slides/lectures/NN-short-lecture-name/`.

Use lecture-numbered filenames for files intended to be shared with students:

- `lecture-01-slides.html`
- `lecture-01-slides.pdf`
- `lecture-02-slides.html`

For PDFs, use the shared export helper:

```powershell
powershell -ExecutionPolicy Bypass -File scripts/export_lecture_pdf.ps1 -LectureDir lectures/NN-short-lecture-name
```
