# Lecture 03 Plan

## Source Inspection Summary

Repo instructions and repo-local skills reviewed:

- `AGENTS.md`
- `.agents/skills/lecture-create/SKILL.md`
- `.agents/skills/lecture-review/SKILL.md`
- `.agents/skills/lecture-cleanup/SKILL.md`
- `.agents/skills/problem-set-create/SKILL.md`

Reference implementations reviewed:

- `lectures/01-course-intro-r-basics/slides.qmd`
- `lectures/01-course-intro-r-basics/handouts/01_the_basics.R` through `06_indexing.R`
- `lectures/02-data-wrangling-dplyr/slides.qmd`
- `lectures/02-data-wrangling-dplyr/handouts/07_basic_dplyr.R`
- `lectures/02-data-wrangling-dplyr/handouts/08_reshape_data.R`
- `lectures/_templates/lecture-slides.qmd`
- `lectures/_templates/lecture-handout.R`

Lecture 03 source materials inspected:

- `legacy/original-slides/06_DS-Introduction.pptx`
- `legacy/original-scripts/09_joins_binds_df.R`
- `legacy/original-scripts/10_import_data.R`
- `legacy/original-scripts/10_importar-datos.R`
- `legacy/original-scripts/11_strings.R`
- `legacy/original-scripts/11_manejo-strings.R`
- `data/raw/bcv_ipc_amc_1950.xls`
- `references/books/Irizarry - Introduction to Data Science.pdf`

Relevant Irizarry reference sections:

- Chapter 6, "Importing data", especially paths, `readr`, `readxl`, and base importing functions.
- Chapter 21, "Introduction to Data Wrangling", for the overall workflow framing.
- Chapter 23, "Joining tables", especially joins, binding, and set operations.
- Chapter 24, "Web Scraping", as background for the inherited Wikipedia example, but not necessarily as student-facing scope for Lecture 03.
- Chapter 25, "String Processing", especially `stringr`, detecting/replacing patterns, and regular expressions.

## Likely Lecture Objective And Scope

Working title:

> Lecture 03: Combining, Importing, and Cleaning Data

Likely main message:

> Real data work rarely starts with one clean table. We need to import files, combine related tables through keys, and clean text values before the tidyverse workflow from Lecture 02 can produce reliable analysis.

Primary objective:

- Move students from single-table wrangling to multi-source data preparation.
- Teach how joins differ from simple row/column binding.
- Teach how to import common file formats reproducibly.
- Introduce minimal string cleaning needed to turn imported text into analysis-ready variables.

Recommended scope:

- Core: keys, mutating joins, filtering joins, binds, set operations.
- Core: reproducible imports from CSV and Excel files.
- Core: simple string cleaning with `str_detect()`, `str_replace()` or `str_replace_all()`, and `parse_number()`.
- Optional/time permitting: a brief preview of regular expressions.
- Defer: live web scraping, full HTML parsing, date-time parsing, loops for reading many Excel sheets, and advanced regular expressions.

Rationale:

- Lecture 02 already covered tidy data, `dplyr`, grouped summaries, and reshaping with `pivot_longer()`, `pivot_wider()`, `separate()`, and `unite()`.
- The remaining material in legacy Lesson 6 naturally extends Lecture 02: first combine tables, then import external files, then clean the imported values.
- Trying to cover the full inherited `11_strings.R` script would overload Lecture 03. The plan should adapt only the parts that support the lecture arc.

## Alignment With Lectures 01 And 02

Lecture 03 should inherit the current course pattern:

- Start and end with `## Main Message {.main-message}`.
- Use `#` for major sections and `##` for individual slides.
- Include several `## Intervention Space {.intervention-slide}` slides with hidden answers in `::: fragment`.
- Use the shared revealjs format from `lectures/_metadata.yml` and `lectures/_format/`.
- Keep lecture-specific assets in `lectures/03-.../assets/`.
- Keep handouts in `lectures/03-.../handouts/` with continuous course-wide numbering.

Conceptual continuity:

- From Lecture 01:
  - Reuse data frames, vectors, logical tests, `class()`, `head()`, `names()`, and indexing only as prerequisites.
  - Avoid reteaching base R except where needed to explain join keys or character-to-numeric conversion.
- From Lecture 02:
  - Continue using `%>%`, `select()`, `filter()`, `mutate()`, `arrange()`, `summarise()`, and `group_by()`.
  - Treat `pivot_longer()`, `pivot_wider()`, `separate()`, and `unite()` as known tools, not new central topics.
  - Keep code examples in the same style: short prose setup, a small code block, then interpretation.

Pacing continuity:

- Lecture 01 is intentionally broad. Lecture 03 should follow Lecture 02 by being focused and narrower.
- Lecture 02 uses progressive fragments heavily for code. Lecture 03 should do the same, especially for join comparisons and import-cleaning pipelines.
- Handout numbering should continue after Lecture 02's `08_reshape_data.R`, so Lecture 03 should likely introduce:
  - `09_joins_binds.R`
  - `10_import_clean_data.R`

## Source Materials To Integrate

### Legacy Slides

Primary source:

- `legacy/original-slides/06_DS-Introduction.pptx`

Use from this deck:

- Definition of a key variable.
- Distinction between mutating joins and filtering joins.
- List and interpretation of `left_join()`, `right_join()`, `inner_join()`, `full_join()`, `semi_join()`, and `anti_join()`.
- Distinction between joins and binds.
- Basic set operations: `intersect()`, `union()`, `setdiff()`, `setequal()`.
- Importing data framing from script 10.
- String-handling framing from script 11.

Do not copy mechanically:

- Slides 15-21 repeat reshaping material already covered in Lecture 02 and should be omitted or referenced only as a quick bridge.
- The old assignment logistics should not be copied into the new deck unless the instructor asks for project-task slides.
- Break slides should not be copied into the canonical source.

Context-only sources:

- `legacy/original-slides/05_DS-Introduction.pptx` aligns with Lecture 02 and helps confirm that current Lecture 02 already absorbed dplyr and reshaping.
- `legacy/original-slides/09_DS-Introduction.pptx` starts data visualization and should be treated as a likely Lecture 04 or later source, not Lecture 03.

### Legacy Scripts

Primary code source:

- `legacy/original-scripts/09_joins_binds_df.R`

Integrate:

- `murders` plus `results_us_election_2016` from `dslabs`.
- `identical(results_us_election_2016$state, murders$state)` as motivation for key-based matching.
- A focused comparison of `left_join()`, `right_join()`, `inner_join()`, and `full_join()` using small `tab1` and `tab2`.
- `semi_join()` and `anti_join()` as row-checking tools.
- `bind_cols()` and `bind_rows()` as "paste by position or stack rows" examples.
- `intersect()`, `union()`, `setdiff()`, and `setequal()` only if time allows.

Adapt or omit:

- Avoid `View()` in slides and handouts because it is interactive and not render-friendly.
- Avoid `rm()` in teaching examples unless needed for a specific point.
- Avoid unstructured long script sections; break each join type into small, visible examples.
- Fix the legacy row-binding note so `bind_rows()` and `rbind()` are described correctly.

Secondary code source:

- `legacy/original-scripts/10_import_data.R`
- `legacy/original-scripts/10_importar-datos.R`

Integrate:

- `getwd()` as a conceptual check, not as a workflow foundation.
- `system.file()` and `file.path()` using the `dslabs` bundled CSV for reproducible file paths.
- Prefer `readr::read_csv()` over base `read.csv()` for consistency with tidyverse, but mention base `read.csv()` as an inherited/source contrast if useful.
- `readxl::excel_sheets()` and `readxl::read_excel()` using `data/raw/bcv_ipc_amc_1950.xls` if the local file is acceptable for canonical lecture use.

Adapt or omit:

- Avoid `file.copy(filename, "murders.csv")` in the lecture source folder or repo root unless it writes to a controlled temporary directory. Generated ad hoc files should not pollute the workspace.
- Use `tempdir()` or read directly from package files for renderable examples.
- Defer the for-loop section for reading all Excel sheets. It introduces loops and lists before students need them in this lecture.

Secondary code source:

- `legacy/original-scripts/11_strings.R`
- `legacy/original-scripts/11_manejo-strings.R`

Integrate:

- The motivating problem: imported numeric values can arrive as character strings because of separators or extra text.
- `str_detect()` for finding a pattern.
- `str_replace()` or `str_replace_all()` for removing a pattern.
- `parse_number()` for converting messy numeric text.
- `mutate(across(..., parse_number))` only if the class is ready for `across()`; otherwise use one column first and show the generalization as optional.
- Case conversion functions only if needed for key matching, for example `str_to_upper()` or `str_to_title()`.

Adapt or omit:

- Avoid live Wikipedia scraping with `read_html(url)` in the main lecture because it depends on network access and a webpage whose table structure can change.
- Avoid `rvest`, `zoo`, and `lubridate` unless a later decision makes web scraping or dates part of the lecture.
- Use a small local toy tibble that mimics imported messy strings, or a stable local raw file, for renderable examples.
- Defer most regular expressions to a later data-cleaning lecture.

### Reference Materials

Use Irizarry as conceptual backbone:

- Chapter 23 for joins and binding. This should guide the join taxonomy and the `murders` plus election-results example.
- Chapter 6 for import concepts, paths, and file formats.
- Chapter 25 for string processing, especially the difference between detecting a pattern, replacing a pattern, and parsing a number.
- Chapter 24 only as instructor background if adapting the old web-scraping source, not as core Lecture 03 material.

## Proposed Lecture Structure

Suggested folder:

- `lectures/03-combining-importing-cleaning-data/`

Suggested subtitle:

- `Combining, Importing, and Cleaning Data`

Suggested sections:

1. `## Main Message {.main-message}`
   - One to three short sentences connecting real-world data preparation to reliable analysis.

2. `# From One Table To Several Tables`
   - Bridge from Lecture 02.
   - Explain that `dplyr` verbs work well once the data is in one tidy table, but real projects often begin with several related tables.
   - Introduce keys as columns that identify matching observations.

3. `## A Key Is How Tables Recognize Each Other`
   - Use `murders` and `results_us_election_2016`.
   - Show `head()` and selected columns from each table.
   - Explain why row position is not enough.

4. `## Intervention Space {.intervention-slide}`
   - Prompt: "If two tables both have a `state` column, what should we check before joining?"
   - Hidden answer: shared name, shared meaning, compatible values, expected uniqueness.

5. `# Joins`
   - Introduce mutating joins as adding columns by matching keys.
   - Show one core `left_join()` example using `state`.
   - Show a small `tab1` and `tab2` example before comparing join types.

6. `## Four Mutating Joins`
   - Use fragments to reveal:
     - `left_join(tab1, tab2, by = "state")`
     - `right_join(tab1, tab2, by = "state")`
     - `inner_join(tab1, tab2, by = "state")`
     - `full_join(tab1, tab2, by = "state")`
   - Add short interpretation after each result.

7. `## Filtering Joins`
   - Explain `semi_join()` and `anti_join()` as checks, not column-adding joins.
   - Use them to find which rows in one table have or lack matches in the other.

8. `## Intervention Space {.intervention-slide}`
   - Prompt: "Which join would you use if you want every row from your main dataset, plus whatever matches from a lookup table?"
   - Hidden answer: `left_join()` when the main dataset is on the left.

9. `# Binding And Set Operations`
   - Explain binds as combining by position or shared structure, not by a key.
   - Use small examples for `bind_cols()` and `bind_rows()`.
   - Keep set operations short or optional: `intersect()`, `union()`, `setdiff()`, `setequal()`.

10. `## Joins Versus Binds`
    - Conceptual comparison table:
      - joins need a key and match rows;
      - binds do not match by key;
      - row binds require compatible columns;
      - column binds require compatible row order/count.

11. `# Importing Files`
    - Explain that imported files are usually the starting point in real projects.
    - Show paths and file formats without overemphasizing working-directory mechanics.

12. `## Reading A CSV`
    - Use `system.file()` and `file.path()` to locate a `dslabs` CSV.
    - Use `read_csv()` with `show_col_types = FALSE`.
    - Preview with `head()` or `glimpse()`.

13. `## Reading An Excel Workbook`
    - Use `data/raw/bcv_ipc_amc_1950.xls` if this file is approved as a course input.
    - Show `excel_sheets()` first, then `read_excel(sheet = ...)`.
    - Emphasize sheet choice and reproducible paths.

14. `## Intervention Space {.intervention-slide}`
    - Prompt: "Why is clicking the RStudio Import button less reproducible than writing an import command in a script?"
    - Hidden answer: the script records the file path, function, arguments, and sheet choices; the click does not automatically preserve the workflow.

15. `# Cleaning Imported Text`
    - Motivate with imported numbers that contain commas, percent signs, or labels.
    - Use a small tibble such as `messy_counts <- tibble(state = ..., population = c("1,234,000", ...))`.

16. `## Detect, Replace, Parse`
    - Progressive reveal:
      - `str_detect(population, ",")`
      - `str_replace_all(population, ",", "")`
      - `parse_number(population)`
    - Interpret class changes after each step.

17. `## Cleaning Inside A Pipeline`
    - Show a compact `mutate()` example.
    - Optional: show `across()` only after one-column cleaning is clear.

18. `## Intervention Space {.intervention-slide}`
    - Prompt: "Why can `as.numeric('1,234')` produce `NA`, while `parse_number('1,234')` returns `1234`?"
    - Hidden answer: `as.numeric()` expects a clean numeric string; `parse_number()` is designed to extract numeric content from messy text.

19. `# Practice Or Challenge`
    - Students import or build a small table, clean one text-number column, join it to another table, and compute one summary.
    - Keep the challenge solvable with Lecture 01-03 functions only.

20. `## Main Message {.main-message}`
    - Restate that analysis-ready data often requires three linked steps: combine, import, clean.

## Proposed Code Presentation Strategy

General strategy:

- Keep each slide to one new idea.
- Explain the concept before code.
- Reveal code in fragments when comparing alternatives.
- Interpret each printed output before moving to the next function.
- Use visible comments to label the conceptual step in code.
- Avoid long inherited script blocks.

Progressive reveal patterns:

- For joins:
  - First reveal `tab1`.
  - Then reveal `tab2`.
  - Then reveal one join at a time.
  - After each join, ask what rows are kept and what columns are added.
- For import:
  - First reveal path construction.
  - Then reveal file reading.
  - Then reveal preview/type inspection.
- For string cleaning:
  - First reveal messy data.
  - Then detect the problem.
  - Then replace or parse.
  - Then check `class()` or `glimpse()` after cleaning.

Recommended datasets:

- Use `dslabs::murders` and `dslabs::results_us_election_2016` for joins because they are already used in the inherited script and align with the Irizarry source.
- Use `dslabs` package files through `system.file()` for CSV import because this is renderable and avoids writing files.
- Use `data/raw/bcv_ipc_amc_1950.xls` for Excel import only if the instructor wants that local dataset to become part of the redesigned lecture source.
- Use a small toy tibble for string cleaning to avoid live network dependency.

Functions to introduce explicitly:

- `left_join()`, `right_join()`, `inner_join()`, `full_join()`
- `semi_join()`, `anti_join()`
- `bind_cols()`, `bind_rows()`
- `intersect()`, `union()`, `setdiff()`, `setequal()` if included
- `system.file()`, `file.path()`
- `read_csv()`, `read_excel()`, `excel_sheets()`
- `str_detect()`, `str_replace_all()`, `parse_number()`
- Optional: `across()`

Functions to avoid or defer:

- `View()`
- `rm(list = ls())`
- `file.copy()` into the working directory
- `read_html()`, `html_nodes()`, `html_table()` unless the lecture explicitly includes web scraping
- for-loops for reading many sheets
- advanced regex helpers such as `str_view()` and complex bracket/range patterns

## Handout Implications

Handout numbering should continue from Lecture 02:

- `lectures/03-combining-importing-cleaning-data/handouts/09_joins_binds.R`
- `lectures/03-combining-importing-cleaning-data/handouts/10_import_clean_data.R`

Handout 09 should mirror:

- package loading with `library(tidyverse)` and `library(dslabs)`
- loading `murders` and `results_us_election_2016`
- inspecting keys
- `left_join()`, `right_join()`, `inner_join()`, `full_join()`
- `semi_join()` and `anti_join()`
- `bind_cols()` and `bind_rows()`
- optional set operations

Handout 10 should mirror:

- package loading
- reproducible path construction
- reading a CSV
- inspecting types
- reading Excel if included
- constructing or loading a small messy text example
- `str_detect()`, `str_replace_all()`, `parse_number()`
- a short final pipeline that imports/cleans/joins/summarises

Handout constraints:

- Handouts should be runnable standalone from the repo root.
- Avoid relying on the current interactive working directory.
- If using `data/raw/bcv_ipc_amc_1950.xls`, use a stable path with `here::here()` or a repo-root relative path, and ensure `here` and `readxl` are listed in setup.
- Do not write temporary CSV files into the repo root or lecture folder.
- If a temporary file is needed, write to `tempdir()`.

Dependency implications:

- `tidyverse`, `dslabs`, and `here` are already in `scripts/setup_project.R`.
- `readxl` is not currently in `scripts/setup_project.R`; add it if Excel import becomes part of the lecture.
- `rvest`, `zoo`, and `lubridate` should not be added unless the lecture includes web scraping or date parsing.
- `stringr` and `readr` come through `tidyverse`, but student-facing code can still mention the specific packages if helpful.

## Render And Validation Steps

Once Lecture 03 is drafted, validate in this order:

1. Check folder contract:
   - `slides.qmd`
   - `handouts/`
   - `assets/`
   - no rendered outputs or cache folders inside the lecture source folder.

2. Check slide structure:
   - starts with `## Main Message {.main-message}`
   - ends with `## Main Message {.main-message}`
   - major sections use `#`
   - individual slides use `##`
   - intervention slides use `.intervention-slide` and hidden answers.

3. Check code/handout mirroring:
   - every visible slide example appears in the matching handout in the same order.
   - handouts are runnable from the repo root.
   - no slide-only example depends on an object created only interactively.

4. Check dependencies:
   - run or review `source("scripts/setup_project.R")` if dependencies change.
   - update `scripts/setup_project.R` if `readxl` is used.

5. Render the lecture from the repo root:
   - `quarto render lectures/03-combining-importing-cleaning-data/slides.qmd`

6. Run handouts:
   - execute `09_joins_binds.R`
   - execute `10_import_clean_data.R`

7. If shared metadata or format is unchanged:
   - only Lecture 03 needs rendering.

8. If shared metadata or format is changed, which is not recommended for this task:
   - render the preview deck and one existing active lecture as well.

## Open Questions Or Missing Inputs

- Should Lecture 03 include Excel import using `data/raw/bcv_ipc_amc_1950.xls`, or should the lecture avoid local-only data and rely only on `dslabs` package files plus toy examples?
- Should string handling be a short import-cleaning module in Lecture 03, or should it become its own later lecture?
- Should `readxl` be added to `scripts/setup_project.R` now, or only if the final draft includes Excel examples?
- Should the lecture include any project logistics from the legacy Lesson 6 assignment slides, or should those remain outside the canonical lecture deck?
- Should the current course skip microdata for now and move from Lecture 03 directly into data visualization, or preserve the legacy sequence more closely?
- If web scraping is important for the course, should a local HTML snapshot be added later so examples do not depend on live Wikipedia structure?
- What should the exact lecture folder slug be? This plan recommends `03-combining-importing-cleaning-data`, but a shorter `03-data-integration-import-cleaning` may also work.

## Recommended Next Step

Create `lectures/03-combining-importing-cleaning-data/` from the lecture template, then draft the joins section first. It is the clearest continuation from Lecture 02 and determines how much time remains for import and string cleaning.
