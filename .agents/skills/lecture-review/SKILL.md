---
name: lecture-review
description: Review a lecture for consistency with the course scaffold, shared format, pedagogy, code presentation, numbering conventions, handout mirroring, and render readiness.
---

# Lecture Review

Use this skill when reviewing an existing lecture before finalizing it.

## Goal

Evaluate whether a lecture is structurally consistent, pedagogically clear,
aligned with course conventions, mirrored by its handouts, and ready for
rendering and use.

## Review Dimensions

Review the lecture across the following dimensions:

1. Structure and scaffold consistency
2. Shared format and styling consistency
3. Pedagogical flow
4. Code presentation quality
5. Handout mirroring
6. Render readiness
7. Source integration quality when applicable

## Structure and Scaffold Checks

Check whether:

- the lecture lives in `lectures/NN-short-topic-name/`
- the lecture root normally contains only:
  - `slides.qmd`
  - `handouts/`
  - `assets/`
- generated artifacts such as `slides_files/`, copied exports, cache folders,
  or ad hoc outputs are not stored inside the lecture source folder
- lecture-specific images and files are stored in `assets/`

## Format and Styling Checks

Check whether:

- shared styling comes from `lectures/_format/`
- shared metadata comes from `lectures/_metadata.yml`
- the lecture does not introduce unnecessary local styling overrides
- Reveal behavior appears consistent with the rest of the course
- content fits the slide without overlapping footer, logo, slide numbers, or
  background framing
- images include `fig-alt` text where practical

## Lecture Pattern Checks

Check whether:

- the lecture starts with `## Main Message {.main-message}`
- the lecture ends with `## Main Message {.main-message}`
- major sections use `#` headings
- individual slides use `##` headings
- `Intervention Space` slides use the shared class and preferably include both
  a prompt and hidden answer

Lecture 01 is allowed to be broader than future lectures because it introduces
course logistics, R/RStudio, and first code.

## Pedagogical Checks

Check whether:

- the lecture has a clear instructional arc
- concepts are introduced in a sensible order
- transitions between sections are understandable
- notation and terminology are consistent with neighboring lectures
- the lecture matches the level and tone of the course
- explanations are student-facing and not written like rough instructor notes

## Code Presentation Checks

Check whether:

- each new student-facing function, operator, or workflow is explained the
  first time it is taught
- code examples are broken into pedagogically meaningful units
- code is revealed progressively where appropriate
- the pacing of code supports explanation
- the lecture avoids unnecessarily long uninterrupted code blocks
- hidden setup chunks are used only for package/data setup needed for rendering
- legacy code has been adapted for teaching clarity rather than copied
  mechanically
- code chunks are readable and plausible for the course level

## Handout Checks

Check whether:

- handout materials are an exact runnable mirror of slide examples
- numbering remains continuous across the full course unless intentionally
  changed
- handouts begin with the lecture number and handout title
- handouts use RStudio-style section comments
- handouts and slides feel aligned rather than assembled separately

## Source Integration Checks

When the lecture was built from legacy materials or references, check whether:

- useful content from legacy slides was integrated thoughtfully
- legacy scripts were adapted rather than copied blindly
- relevant legacy-script procedures are represented in essence, especially for
  first drafts, or omissions are documented with a clear reason
- relevant source books or references appear to have informed the draft
- local planning notes capture source lineage where needed
- the lecture reads as one coherent document rather than a stitched compilation

## Workflow

1. Read the lecture end to end.
2. Inspect the lecture folder structure.
3. Compare the lecture against the repo contract in `AGENTS.md`.
4. Compare against neighboring lectures if useful for consistency.
5. Review the pacing, sequencing, and code reveal logic.
6. Compare handouts to slide examples for runnable mirroring.
7. Run a render check if feasible.
8. Separate structural issues from pedagogy and content issues.
9. Provide a concise review with prioritized recommendations.

## Output

Organize the review as:

- structural issues
- format or styling issues
- lecture pattern issues
- pedagogical issues
- code presentation issues
- handout mirroring issues
- rendering issues
- recommended fixes

## Quality Bar

A lecture is in good shape when:

- it follows the standard scaffold
- it uses shared styling and metadata correctly
- it starts and ends with `Main Message` slides
- it is coherent and teachable
- code reveal supports explanation
- handouts mirror runnable slide examples
- it renders successfully, or render issues are clearly identified
