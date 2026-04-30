---
name: lecture-cleanup
description: Clean up and standardize lecture folders and related course materials while preserving source lineage and keeping generated artifacts out of lecture source directories.
---

# Lecture Cleanup

Use this skill when cleaning, standardizing, or lightly restructuring existing
lecture materials.

## Goal

Improve structural consistency and reduce clutter without making destructive or
unnecessary content changes.

## Cleanup Principles

- Prefer conservative cleanup over broad rewrites.
- Preserve source lineage.
- Separate structural cleanup from major content revision whenever possible.
- Do not treat archival or legacy material as disposable.
- Standardize only where that improves clarity and consistency.

## Focus Areas

Look for:

- generated files inside lecture source folders
- inconsistent lecture folder contents
- misplaced assets
- stray exports or copied files
- local format overrides that should instead live in shared format files
- naming inconsistencies across lecture folders
- handout materials that do not mirror runnable slide examples
- package dependencies missing from `scripts/setup_project.R`

## Folder Rules to Enforce

A lecture folder should normally contain only these root-level entries:

- `slides.qmd`
- `handouts/`
- `assets/`

Generated artifacts such as:

- `slides_files/`
- copied HTML/PDF exports
- cache folders
- ad hoc render output

should not remain inside lecture source folders. Place shareable or generated
outputs under `outputs/` when appropriate.

## Asset and Format Rules

- Keep lecture-specific images and files in the lecture's `assets/` folder.
- Keep reusable logos, backgrounds, CSS, and shared format logic in
  `lectures/_format/`.
- Keep external source notes in local planning notes unless the instructor asks
  for public citation.
- Do not introduce new local styling hacks during cleanup unless explicitly
  asked.

## Safety Rules

- Do not reorganize, move, or delete `data/`, `references/`, or `legacy/`
  unless explicitly asked.
- Do not delete legacy source materials merely because they are old.
- Prefer clearly segregating, documenting, or archiving clutter over
  irreversible deletion.
- Do not mix cleanup with large pedagogical rewrites unless explicitly
  requested.

## Workflow

1. Inspect the repository and identify structural clutter or drift from the
   course scaffold.
2. If the cleanup is substantial, write a plan under `plans/` before making
   changes.
3. Identify generated artifacts or misplaced files inside lecture folders.
4. Move or regenerate outputs in appropriate locations under `outputs/` where
   relevant.
5. Standardize lecture folder contents to match the repo contract.
6. Keep lecture-specific assets in `assets/`.
7. Preserve global handout numbering unless explicitly asked to revise it.
8. Preserve the exact runnable mirror relationship between handouts and slide
   examples.
9. Update README files if the structural contract changes.
10. Render affected lectures after cleanup where feasible.
11. Summarize what changed and what was intentionally left untouched.

## Output

Provide a concise summary covering:

- what structural issues were found
- what was cleaned or standardized
- what was preserved intentionally
- any unresolved inconsistencies
- whether render checks passed
