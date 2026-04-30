---
name: lecture-create
description: Create or substantially expand a standardized lecture in this course repository using the established lecture scaffold, legacy course materials, and reference books.
---

# Lecture Create

Use this skill when creating a new lecture or substantially expanding an
existing one.

## Goal

Produce a lecture that fits the course structure, uses the shared format
correctly, integrates relevant source material, mirrors slide examples in
handouts, and is ready for rendering and review.

## Inputs to Gather

Before drafting, identify and review the most relevant source materials
available for the target lecture:

- relevant neighboring lectures in `lectures/`
- the lecture template in `lectures/_templates/`
- relevant legacy slides in `legacy/`
- relevant legacy scripts or code examples in `legacy/` or other established
  source locations
- relevant reference books, bibliography, or course readings in `references/`
- any existing handouts, examples, or supporting materials already used in the
  course

If some inputs are missing, proceed with the best available materials but state
clearly what was and was not used.

## Drafting Principles

- Preserve the course scaffold and shared course identity.
- Prefer adaptation, consolidation, and modernization of prior course materials
  over copying legacy content mechanically.
- Use legacy slides, legacy scripts, and reference books as substantive source
  material for the first draft.
- Treat relevant legacy scripts as the minimum procedural coverage for a first
  draft. Every substantive operation, example pattern, or data-cleaning
  procedure should be represented in essence, even when adapted to a more
  suitable data source, lecture arc, or progressive reveal.
- Adapt legacy code into smaller instructional units; do not copy mechanically,
  but document any substantive legacy-script procedure that is intentionally
  omitted, deferred, or replaced.
- Keep the lecture aligned with the level, tone, notation, and structure of
  neighboring lectures.
- Prefer a student-facing explanation style: clear, paced, and teachable.
- Avoid introducing structural, visual, or notation changes that would create
  drift across the course unless explicitly asked.

## Folder and File Contract

Create or update the lecture under `lectures/NN-short-topic-name/`.

A lecture folder should normally contain only these root-level entries:

- `slides.qmd`
- `handouts/`
- `assets/`

Do not keep rendered outputs, `slides_files/`, copied exports, cache folders,
or ad hoc artifacts inside the lecture source folder. Generated artifacts belong
under `outputs/`.

## Format and Styling Rules

- Use the shared course-wide styling and Reveal behavior from
  `lectures/_format/` and `lectures/_metadata.yml`.
- Do not add local theme CSS, local Reveal overrides, or lecture-specific
  format logic unless explicitly revising the shared course format.
- Every completed lecture should begin and end with
  `## Main Message {.main-message}`.
- Use `#` headings for major sections and `##` headings for individual slides.
- Use `## Intervention Space {.intervention-slide}` for in-class checks.
  Prefer a prompt plus a hidden answer revealed with `::: fragment`.
- Keep lecture-specific images in `assets/` and include `fig-alt` text where
  practical.

## Code Presentation Rules

- Explain each new student-facing R function, operator, or workflow the first
  time it is taught.
- R code shown in lecture slides should normally be presented incrementally as
  the lecture progresses.
- Prefer code examples that unfold in pedagogically meaningful fragments rather
  than dumping full blocks at once.
- Introduce the concept in prose before showing code.
- Use visible code comments to label conceptual steps.
- Add interpretation text after code when students should notice an output or
  consequence.
- Use hidden setup chunks with `#| include: false` only for package/data setup
  needed for rendering but not taught on that slide.
- Preserve executable logic, but optimize presentation for teaching clarity
  rather than script-like compactness.

## Handout Rules

- Handout scripts should be an exact runnable mirror of slide examples.
- Preserve continuous course-wide numbering across the full course.
- Start each handout with comments identifying the lecture number and handout
  title.
- Use RStudio-style section comments, such as
  `# PACKAGES ---------------------------------------------------------------`.
- If the lecture uses a toy dataset, define it in the handout where students
  first need it.
- If a lecture introduces a new required package, update
  `scripts/setup_project.R`.

## Workflow

1. Inspect the repository structure and identify the relevant lecture template
   in `lectures/_templates/`.
2. Inspect neighboring lectures to match course level, notation, pacing, and
   structure.
3. Review the relevant legacy slides, legacy scripts, and reference materials
   before drafting.
4. Build a source-coverage checklist from the relevant legacy scripts and
   reference materials. For legacy scripts, treat procedures as mandatory
   minimum coverage unless there is a clear documented reason to omit them.
5. Identify the useful concepts, explanations, code examples, and sequencing
   from those source materials.
6. If the task is substantial, write a plan in `plans/` before major changes.
7. Create or update the target lecture folder under
   `lectures/NN-short-topic-name/`.
8. Draft or revise `slides.qmd` using the established course scaffold.
9. Integrate useful source material into a coherent draft adapted to the current
   course format.
10. Structure code examples for teaching: break them into smaller conceptual
   steps and present them progressively where appropriate.
11. Keep lecture-specific images and files in `assets/`.
12. Create or update handouts so they exactly mirror runnable slide examples.
13. Keep the lecture folder lean and free of generated artifacts.
14. Render the lecture from the repo root before considering the task complete.
15. Report any rendering errors, unresolved dependencies, structural
   inconsistencies, or missing inputs.

## Quality Checks

- The lecture folder follows the standard scaffold.
- Shared styling and metadata are used consistently.
- The lecture starts and ends with `Main Message` slides.
- Intervention slides include a prompt and, preferably, a hidden answer.
- The draft clearly reflects relevant legacy slides, legacy scripts, and
  reference materials where appropriate.
- Relevant legacy-script procedures are covered in essence, or omissions are
  documented as intentional.
- Code examples are broken into clear pedagogical units and revealed
  progressively where appropriate.
- Handouts exactly mirror runnable slide examples.
- No generated render artifacts remain inside the lecture source folder.
- The lecture renders successfully, or render failures are clearly documented.
- The lecture is structurally consistent with neighboring lectures.

## Output

At the end, provide a concise summary covering:

- what was created or revised
- which source materials were used
- any important omissions or unresolved issues
- whether the lecture rendered successfully
- what should be reviewed next
