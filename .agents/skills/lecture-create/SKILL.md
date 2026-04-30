# Lecture Create Skill

Use this workflow when creating a standardized lecture.

1. Start from `lectures/_templates/lecture-slides.qmd`.
2. Create a folder named `lectures/NN-short-topic-name/`.
3. Add only the standard lecture files and folders:
   - `slides.qmd`
   - `handouts/`
   - `assets/`
4. Keep course-wide styling in `lectures/_format/`; do not add local theme CSS
   unless the shared format is being reviewed.
5. Number handout scripts continuously across the course, not from `01` inside
   each lecture.
6. Render the lecture from the repo root before considering it ready.
