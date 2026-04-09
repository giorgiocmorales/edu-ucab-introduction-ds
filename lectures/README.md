# Lectures Workspace

`lectures/` is the canonical authoring area for Quarto lecture decks in this course.

## Current Mode

The lecture workspace uses a minimal Quarto-native setup based on the official presentations guide:

- https://quarto.org/docs/presentations/
- https://quarto.org/docs/presentations/revealjs/

Two active decks now matter:

- [`00-quarto-guide-preview/slides.qmd`](/d:/Documents/3_Trabajos/UCAB/Profesor/Introduction%20to%20Data%20Science/edu-ucab-introduction-ds/lectures/00-quarto-guide-preview/slides.qmd): feature preview for the baseline revealjs workflow.
- [`01-course-intro-r-basics/slides.qmd`](/d:/Documents/3_Trabajos/UCAB/Profesor/Introduction%20to%20Data%20Science/edu-ucab-introduction-ds/lectures/01-course-intro-r-basics/slides.qmd): first lecture draft built from legacy presentations 01-02 and scripts 01-06.

## Folder Contract

- `_metadata.yml`: shared revealjs defaults.
- `_shared/`: reusable shared assets only.
- `_templates/`: minimal starter files for future lecture decks.
- `00-quarto-guide-preview/`: preview deck used to evaluate the official Quarto presentation workflow.
- `01-course-intro-r-basics/`: current Lecture 01 draft and handouts.
- `NN-short-lecture-name/`: future lecture folders.

## Active Baseline

The live setup relies on Quarto's native presentation features instead of custom slide-type CSS:

- title slides from document YAML
- section slides from `#` headings
- regular slides from `##` headings
- horizontal rules for untitled slides
- `.incremental` and `.nonincremental`
- native `columns`
- `.notes` for speaker notes
- slide background attributes such as `background-color` and `background-image`

## Next Step

1. Review the Lecture 01 draft.
2. Decide which slide patterns feel natural once real course content is present.
3. Only then introduce any additional theme or layout customization.
