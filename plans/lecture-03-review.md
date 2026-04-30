# Lecture 03 Review

Review target:

- `lectures/03-combining-importing-cleaning-data/slides.qmd`
- `lectures/03-combining-importing-cleaning-data/handouts/09_joins_binds.R`
- `lectures/03-combining-importing-cleaning-data/handouts/10_import_clean_data.R`

Review basis:

- `AGENTS.md`
- repo-local skill `.agents/skills/lecture-review/SKILL.md`
- Lectures 01 and 02 as current reference implementations
- current Lecture 03 bespoke image and `join_by()` edits

## Overall Assessment

Lecture 03 is structurally sound, uses the shared Quarto/Reveal scaffold, and renders successfully. It aligns well with Lecture 02 by extending the one-table `dplyr` workflow into keys, joins, binds, imports, and text cleaning. The lecture is coherent and teachable, and the recent join-diagram pass improves conceptual support before code examples.

The main remaining issues are not render blockers. They are final-polish items around handout mirroring, first-use explanations for a few functions, and visual density on image/list slides.

## Structural Issues

No blocking scaffold issues found.

- The lecture lives in `lectures/03-combining-importing-cleaning-data/`.
- The lecture root contains only the expected entries: `slides.qmd`, `handouts/`, and `assets/`.
- No rendered outputs, `slides_files/`, copied exports, cache folders, or ad hoc artifacts were found inside the lecture source folder.
- Lecture-specific images are correctly stored in `assets/`.

Source-control readiness issue:

- The assets used by the deck are currently untracked in git. Before finalizing, track at least the referenced images: `07-dplyr_joins.svg`, `w_setup.png`, `w_setup2.png`, `w_match-types.png`, `w_left.png`, `w_right.png`, `w_inner.png`, `w_full.png`, `w_semi.png`, `w_anti.png`, and `w_join_by1.png` through `w_join_by5.png`.
- The asset folder also contains unused image families (`g_*`, `w2_*`, and other summary images). This is not a scaffold violation, but decide whether they are intentional local source material or should remain out of the final commit.

## Format Or Styling Issues

No shared-format violations found.

- `slides.qmd` uses `format: revealjs` and inherits shared metadata and styling.
- No local CSS, local Reveal configuration, or lecture-specific styling overrides were introduced.
- Images used in the slides include `fig-alt` text where practical.
- The lecture follows the same broad slide grammar as Lectures 01 and 02: prose first, then code, with intervention slides for checks.

Visual-pass risks:

- The set-operations slide at `slides.qmd:425-475` is text-heavy and uses a two-column layout with several code fragments. It renders, but it should be checked in-browser for crowding.
- The `join_by()` special-matches slide at `slides.qmd:362-373` combines six function bullets and four images. It renders, but it may still be visually dense depending on the classroom display.
- The long `anti_join()` explanation at `slides.qmd:334` may wrap heavily in the right column.

## Lecture Pattern Issues

No lecture-pattern blockers found.

- The lecture starts with `## Main Message {.main-message}` at `slides.qmd:7`.
- The lecture ends with `## Main Message {.main-message}` at `slides.qmd:703`.
- Major sections use `#` headings.
- Individual slides use `##` headings.
- Intervention slides use `## Intervention Space {.intervention-slide}` and include prompt/answer structure.

Minor observation:

- The final synthesis is now an intervention slide rather than a `# Practice` section. That is consistent with the user request and the shared intervention pattern, but it means the lecture no longer has a distinct practice section heading.

## Pedagogical Issues

The instructional arc is strong.

- Lecture 03 explicitly connects back to Lecture 02's one-table verbs before adding multi-table and import/cleaning workflows.
- The joins section now has a clear progression: key concept, row-order warning, match multiplicity, join overview, main `left_join()` example, toy tables, individual join types, then `join_by()` as a more explicit matching-rule syntax.
- The import and cleaning sections are appropriately conservative: stable package CSV import, type inspection, toy messy text, parsing, and key standardization.

Potential pacing issue:

- The scope remains broad for one session: six join types, `join_by()`, binds, set operations, import functions, type inspection, string detection/replacement/parsing, key cleaning, and a final grouped summary. If time becomes tight, the set-operations slide and the advanced `join_by()` special-match slide are the best candidates to mark as reference-only.

## Code Presentation Issues

Code presentation is mostly aligned with Lectures 01 and 02.

- Examples are broken into small fragments.
- Visible comments usually label the conceptual step.
- The joins section uses images before code, which helps explain the operation before asking students to parse output.
- `identical()` is now explained before its first use.
- `join_by(state)` is introduced with a simple `tab1`/`tab2` example before the advanced patterns.

Recommended code-presentation fixes:

- `slice()` appears in the small join setup at `slides.qmd:207` and `slides.qmd:220` without a first-use explanation. Add a short note that it selects rows by position, or replace it with a familiar operation.
- `summarise(across(everything(), ~ class(.x)[1]))` at `slides.qmd:525` introduces `across()`, `everything()`, formula shorthand, and `.x` all at once. This is likely the highest syntax-burden slide. Consider either explaining those pieces or replacing the type check with simpler `class(imported_murders$state)` style calls.
- `tibble()` appears in visible code at `slides.qmd:404`, `slides.qmd:564`, and `slides.qmd:649`. Add a brief first-use explanation that a tibble is the tidyverse version of a data frame.
- `str_to_title()` appears at `slides.qmd:660` and again inside the final pipeline at `slides.qmd:688`. Add one sentence that it converts text to title case so key values can match.
- The advanced `join_by()` patterns at `slides.qmd:362-373` are correctly labeled as beyond required examples, but they include many helpers. Keep them clearly framed as reference material unless you plan to teach non-equi or rolling joins in class.

## Handout Mirroring Issues

Both handouts are runnable, but `09_joins_binds.R` no longer exactly mirrors the current slide order/content.

Blocking-before-final handout issues:

- In the slides, `semi_join()` and `anti_join()` are taught before the `join_by()` slide (`slides.qmd:305-360`). In `09_joins_binds.R`, the `join_by()` example appears before the filtering joins at lines 74-84. Move the `join_by()` example after `anti_join()` to match the slide flow.
- The set-operations slide includes the additional asymmetric example `setdiff(6:15, 1:10)` at `slides.qmd:460-461`, but that example is missing from `09_joins_binds.R`.
- The set-operations slide presents `intersect()`, `union()`, `setdiff()`, then `setequal()`/`identical()` (`slides.qmd:432-471`). The handout currently orders them as `intersect()`, `setdiff()`, `union()`, then `setequal()`/`identical()` at lines 101-112. Reorder the handout to match the slide.

Other handout notes:

- Handout numbering remains continuous with the course: `09_joins_binds.R` and `10_import_clean_data.R`.
- Both handouts begin with lecture number/title comments and use RStudio-style section comments.
- `10_import_clean_data.R` mirrors the import and cleaning examples well.
- If the first-use explanations above are added to slides, mirror short comments in the handouts so they remain standalone teaching scripts.

## Rendering Issues

No rendering blockers found.

Checks run from the repo root:

- `Rscript lectures\03-combining-importing-cleaning-data\handouts\09_joins_binds.R` passed.
- `Rscript lectures\03-combining-importing-cleaning-data\handouts\10_import_clean_data.R` passed.
- `quarto render lectures\03-combining-importing-cleaning-data\slides.qmd` passed.

Render output:

- `outputs/rendered-slides/lectures/03-combining-importing-cleaning-data/slides.html`

The lecture source folder remained free of generated render artifacts.

## Recommended Fixes

1. Fix `09_joins_binds.R` so the `join_by()` and set-operation examples exactly mirror the current slide order/content.
2. Add first-use explanations for `slice()`, `tibble()`, and `str_to_title()`.
3. Simplify or explicitly explain the `summarise(across(everything(), ~ class(.x)[1]))` type-inspection example.
4. Do a browser visual pass on the set-operations slide, the advanced `join_by()` slide, and the join slides with longer explanatory text.
5. Decide which image assets should be committed. At minimum, commit every image referenced by `slides.qmd`; leave unused families untracked only if they are intentionally local scratch material.

## Final Judgment

Lecture 03 is render-ready and structurally consistent with Lectures 01 and 02. It should be considered close to final after one small handout-alignment pass and a few first-use explanation edits. No structural rewrite is needed.
