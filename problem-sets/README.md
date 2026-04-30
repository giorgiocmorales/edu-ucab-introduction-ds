# Problem Sets

Problem sets are primary course artifacts parallel to lectures.

The maintainable source belongs here. Canvas-ready exports and instructor-only
generated materials belong under `outputs/problem-sets/` and should not be
committed unless explicitly requested.

## Artifact Types

- Script problem set: `.R` assignment scaffold.
- Rendered problem set: `.qmd` assignment scaffold.
- Canvas-ready question bank: copy-paste-ready assessment text for Canvas.
- Review script: runnable R code for instructor validation of elaborate coding
  problems.

## Source Layout

Use `problem-sets/_templates/` for starter files. Individual source folders
should use numbered names such as:

```text
problem-sets/01-r-basics/
  README.md
  student-facing.md
  01-r-basics-review.R
```

Use `.R` templates when the assignment is intended to be completed as a script.
Use `.qmd` templates when students should render a document.

## Canvas Workflow

Problem sets should be consolidated in a format that can be copied into Canvas
with minimal manual cleanup. Keep instructor answers, explanations, and review
code separate from student-facing prompts.

Elaborate coding problems should have corresponding R review scripts so the
expected answer can be reproduced. Keep a single review script at the problem
set root. Add a `review-scripts/` subfolder only when a problem set needs
multiple review scripts.

Generated Canvas-ready files should go under:

```text
outputs/problem-sets/
```

Those generated files are instructor-only by default.
