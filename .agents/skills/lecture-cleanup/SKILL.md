# Lecture Cleanup Skill

Use this workflow when cleaning existing lecture folders.

1. Identify generated files or folders inside lecture source folders, especially
   `slides_files/`, ad hoc exports, caches, or copied render artifacts.
2. Move or regenerate shareable outputs under `outputs/`; do not keep them in
   lecture source folders.
3. Keep lecture-specific images in the lecture `assets/` folder.
4. Keep reusable logos, backgrounds, CSS, and background logic in
   `lectures/_format/`.
5. Preserve handout script numbering unless the user asks for a renumbering
   pass.
6. Update `lectures/README.md` if the folder contract changes.
