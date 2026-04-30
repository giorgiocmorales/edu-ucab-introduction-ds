# Lecture Review Skill

Use this workflow when reviewing a lecture for consistency with the course
format.

Check:

- the lecture folder follows the standard `slides.qmd`, `handouts/`, `assets/`
  contract
- shared styling comes from `lectures/_format/` and `lectures/_metadata.yml`
- no generated render artifacts are inside the lecture source folder
- handout script numbering continues the course-wide sequence
- code chunks and handout scripts use the packages prepared by
  `scripts/setup_project.R`
- the lecture renders successfully with `quarto render`

Report content issues separately from scaffold issues.
