# Repo Structure Streamlining Plan

## Purpose

Reduce shallow folder overhead in the course-authoring repo without changing
lecture content, problem-set content, or local-only archival material.

## Scope

- Flatten problem-set review scripts when each problem set has only one review
  script.
- Consolidate shared format image assets under `lectures/_format/assets/`.
- Remove unused tracked output placeholder folders.
- Remove unused `plans/active/` scaffold because current plans live directly
  under `plans/`.
- Update README and contract references to match the streamlined structure.

## Out of Scope

- Do not reorganize `data/`, `legacy/`, or `references/`.
- Do not delete generated render outputs beyond source-controlled placeholders.
- Do not rewrite lecture or assessment content.
- Do not change the Quarto render target under `outputs/rendered-slides/`.

## Verification

- Check that no stale references remain for moved review scripts or removed
  placeholder folders.
- Run a render check for the preview deck if shared-format paths change in a
  way that affects rendering.
