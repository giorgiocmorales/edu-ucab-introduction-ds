# Lecture 02 and Lecture 03 Problem Set Plan

## Source Basis

This plan is based on the completed Lecture 02 and Lecture 03 materials:

- `lectures/02-data-wrangling-dplyr/slides.qmd`
- `lectures/02-data-wrangling-dplyr/handouts/07_basic_dplyr.R`
- `lectures/02-data-wrangling-dplyr/handouts/08_reshape_data.R`
- `lectures/03-combining-importing-cleaning-data/slides.qmd`
- `lectures/03-combining-importing-cleaning-data/handouts/09_joins_binds.R`
- `lectures/03-combining-importing-cleaning-data/handouts/10_import_clean_data.R`

The plan is now split into two separate assessments:

1. Lecture 02 problem set: tidy data, `dplyr`, grouped summaries, and reshaping.
2. Lecture 03 problem set: keys, joins, binds/set operations, imports, and cleaning.

Do not generate the full banks yet. This file defines coverage, bank structure, coding-bank design, and assessment risks.

## Global Bank Rules

Use the same overall structure for both problem sets:

- One True/False bank per problem set.
- Multiple-choice banks divided by lecture subsection.
- One coding-question bank per problem set.
- Coding-question bank size: at least 6 questions per problem set.
- Coding-question draw: Canvas should draw 1 coding question from the bank.
- Coding-question difficulty: similar across the 6 questions in the same bank.
- Coding-question datasets: each coding question must use a different dataset.
- Coding-question answers: each must be machine-checkable as a number, integer, or precise string.
- Coding-question validation: each question needs runnable instructor R code when banks are generated.

For coding banks, prefer base R datasets first. Use `dslabs` datasets only when the lecture already used them and the setup is explicit.

# Problem Set 02: Data Wrangling With `dplyr` and Tidy Data

## Lecture 02 Subsections

1. Tidy data and the `tidyverse`
   - Data frames as rectangular objects.
   - Tidy data: rows as observations, columns as variables, cells as values.
   - Wide versus long structure.

2. `dplyr` basics
   - `%>%` pipelines.
   - `select()` for columns.
   - `filter()` for rows.
   - `mutate()` for new or transformed columns.
   - `rename()` for labels.
   - `arrange()` and `desc()` for sorting.

3. Grouped summaries
   - `summarise()` collapses rows.
   - `group_by()` changes the unit of analysis.
   - `n()`, `sum()`, `mean()`, `weighted.mean()`, and `.groups = "drop"`.

4. Reshaping data
   - `pivot_longer()` and `pivot_wider()`.
   - `names_to`, `values_to`, `names_sep`, `names_transform`.
   - `separate()`, `extra = "merge"`, and `unite()`.

## Lecture 02 True/False Bank Coverage

Plan a bank of 12 True/False questions. Canvas should draw 4. Difficulty should be easy.

Coverage:

- Tidy data definition: rows, columns, cells.
- Wide versus long structure.
- `select()` changes columns, not rows.
- `filter()` keeps rows based on conditions.
- `mutate()` creates or rewrites variables.
- `arrange()` changes row order without changing values.
- `%>%` sends the left-hand result into the next function.
- `summarise()` returns one row without groups.
- `group_by()` changes summaries to one row per group.
- `.groups = "drop"` removes grouping metadata.
- `pivot_longer()` gathers columns into rows.
- `pivot_wider()` spreads values into columns.

Avoid:

- Very precise syntax claims about `separate(extra = "merge")`.
- Questions requiring students to remember `names_transform` syntax without code.

## Lecture 02 Multiple-Choice Banks

Each bank should contain at least 5 questions with exactly 4 options. Canvas can draw 1 to 2 from each bank.

### Bank 02-A: Tidy Data and Reshaping Concepts

Coverage:

- Identify tidy versus untidy structures.
- Choose wide or long format for analysis.
- Choose `pivot_longer()` versus `pivot_wider()`.
- Interpret `names_to`, `values_to`, and `names_sep`.
- Understand why hidden variables in headers are a problem.

### Bank 02-B: Basic `dplyr` Verbs

Coverage:

- Select the correct verb for a task.
- Interpret small pipelines using `select()`, `filter()`, `mutate()`, `rename()`, and `arrange()`.
- Distinguish column operations from row operations.
- Recognize the purpose of `desc()`.
- Identify where a new variable is created.

### Bank 02-C: Grouped Summaries

Coverage:

- Difference between grouped and ungrouped `summarise()`.
- Use of `mean()`, `sum()`, `n()`, and `.groups = "drop"`.
- Interpreting one-row versus multi-row summary outputs.
- Weighted versus simple averages at a conceptual level.
- Reading a short summary pipeline.

### Bank 02-D: Compound Reshaping and Split Keys

Coverage:

- Why `separate()` is used after `pivot_longer()`.
- What `extra = "merge"` solves.
- What `unite()` does.
- Why year columns may arrive as text after reshaping.
- What `names_transform` accomplishes at a conceptual level.

## Lecture 02 Coding-Question Bank

Create at least 6 coding questions. Canvas should draw 1. Each question should require a few lines of `tidyverse` code and produce a machine-checkable final answer.

All six should be similar difficulty: filter or mutate, group if needed, summarize or arrange, then report one number or one exact string.

Proposed datasets and task designs:

1. Dataset: `mtcars`
   - Task: compute average `mpg` by `cyl`, sort descending, and report the cylinder count with the highest average `mpg`.
   - Final answer type: integer.
   - Taught functions: `group_by()`, `summarise()`, `mean()`, `arrange(desc())`.

2. Dataset: `iris`
   - Task: compute average `Sepal.Length` by `Species`, sort descending, and report the species with the highest average.
   - Final answer type: precise string.
   - Taught functions: `group_by()`, `summarise()`, `mean()`, `arrange(desc())`.

3. Dataset: `ToothGrowth`
   - Task: filter to one supplement type or compare supplement groups, compute mean `len`, and report the group with the larger average.
   - Final answer type: precise string.
   - Taught functions: `filter()`, `group_by()`, `summarise()`, `mean()`, `arrange(desc())`.

4. Dataset: `ChickWeight`
   - Task: filter to a selected `Time`, compute average `weight` by `Diet`, and report the diet with the highest average.
   - Final answer type: integer or precise string depending on prompt wording.
   - Taught functions: `filter()`, `group_by()`, `summarise()`, `mean()`, `arrange(desc())`.

5. Dataset: `PlantGrowth`
   - Task: compute average `weight` by `group` and report the group with the highest average.
   - Final answer type: precise string.
   - Taught functions: `group_by()`, `summarise()`, `mean()`, `arrange(desc())`.

6. Dataset: `USArrests`
   - Task: convert row names to a `state` column with provided starter code, compute a derived violent-crime total such as `Murder + Assault`, sort, and report the state with the largest value.
   - Final answer type: precise string.
   - New function handling: if `rownames_to_column()` is used, introduce it in the prompt; otherwise provide the `state <- rownames(USArrests)` setup code.
   - Taught functions: `mutate()`, `arrange(desc())`, `select()`.

Generation notes:

- Avoid using `pull()` in student-facing prompts unless introduced.
- If `slice(1)` is needed to extract the top row, remind students it selects rows by position, or ask them to report the first row after sorting.
- Review scripts may use helper extraction functions for validation.

# Problem Set 03: Combining, Importing, and Cleaning Data

## Lecture 03 Subsections

1. Keys and multi-table thinking
   - Real projects often start with multiple tables or files.
   - A key identifies matching observations across tables.
   - Row position is not a key.
   - `identical()` checks whether two R objects are exactly the same.
   - Key matches can be one-to-one, missing, or repeated.

2. Joins
   - `left_join()`, `right_join()`, `inner_join()`, and `full_join()`.
   - `semi_join()` and `anti_join()`.
   - `join_by()` as explicit matching syntax.
   - Advanced `join_by()` patterns as reference-only.

3. Binds and set operations
   - Binds combine by compatible structure or position, not by key.
   - `bind_cols()` and `bind_rows()`.
   - `intersect()`, `union()`, `setdiff()`, `setequal()`, and `identical()`.

4. Importing files
   - Reproducible import records source, reader, options, and object name.
   - `system.file()` for package files.
   - `read_csv()` for CSV import.
   - `class()` for imported type checks.
   - Other import functions and Excel considerations.

5. Cleaning imported text
   - `str_detect()`, `any()`, and `all()` for pattern checks.
   - `str_replace()` versus `str_replace_all()`.
   - `parse_number()` for extracting numbers from messy text.
   - `across()` for applying the same cleaning function to several columns.
   - `str_to_lower()`, `str_to_upper()`, `str_to_title()`, and `str_to_sentence()`.
   - Simple regular-expression patterns: `|`, `\\d`, and `[a-zA-Z]`.
   - Check types before computing.
   - Standardize keys before joining.

6. Integrated workflow
   - Import or start with data.
   - Inspect and clean types.
   - Standardize keys.
   - Join lookup data.
   - Group and summarize after the data is usable.

## Lecture 03 True/False Bank Coverage

Plan a bank of 12 True/False questions. Canvas should draw 4. Difficulty should be easy.

Coverage:

- A key connects rows across tables.
- Row order should not be treated as a key.
- `identical()` checks exact sameness.
- `left_join()` keeps rows from the first table.
- `inner_join()` drops nonmatches.
- `semi_join()` and `anti_join()` do not add columns from the second table.
- `join_by(state)` explicitly states the matching rule.
- Binds do not search for matching key values.
- `setdiff(x, y)` is directional.
- A reproducible import should be written in code.
- Imported numeric-looking values can be character strings.
- `parse_number()` can extract numbers from messy text.
- `str_replace()` replaces only the first match while `str_replace_all()` replaces every match.
- Simple regex patterns such as `\\d` can detect digits.

Avoid:

- Testing advanced `join_by()` helper syntax as required knowledge.
- Testing exact Excel import syntax.
- Testing row-count effects of repeated keys without explicit small tables.

## Lecture 03 Multiple-Choice Banks

Each bank should contain at least 5 questions with exactly 4 options. Canvas can draw 1 to 2 from each bank.

### Bank 03-A: Keys and Join Choice

Coverage:

- Key definition and compatibility.
- Why row position is unsafe.
- Choosing among mutating joins.
- Understanding `by = "state"` and `by = join_by(state)`.
- Interpreting unmatched rows and `NA`.

### Bank 03-B: Filtering Joins, Binds, and Sets

Coverage:

- Choosing `semi_join()` or `anti_join()`.
- Distinguishing joins from binds.
- `bind_cols()` versus `bind_rows()`.
- Interpreting `intersect()`, `union()`, `setdiff()`, and `setequal()`.
- Difference between `setequal()` and `identical()`.

### Bank 03-C: Importing and Type Inspection

Coverage:

- What reproducible import records.
- Why scripted imports are preferable to only point-and-click workflows.
- Role of `system.file()`.
- Role of `read_csv()`.
- Role of `class()`.
- Conceptual Excel import checks.

### Bank 03-D: Cleaning Text and Keys

Coverage:

- Detecting patterns with `str_detect()`.
- Combining `str_detect()` with `any()` and `all()`.
- Replacing text with `str_replace()` and `str_replace_all()`.
- Parsing messy numbers with `parse_number()`.
- Applying one parser across several columns with `across()`.
- Confirming numeric type with `class()`.
- Standardizing keys and labels with case functions.
- Recognizing simple regex patterns such as `|`, `\\d`, and `[a-zA-Z]`.

### Bank 03-E: Integrated Workflow

Coverage:

- Correct sequence: inspect, clean, standardize keys, join, summarize.
- Identify the purpose of each line in a short pipeline.
- Consequences of joining before key cleaning.
- Consequences of summarizing before needed variables exist.
- Combining Lecture 02 `group_by()` / `summarise()` with Lecture 03 joins and cleaning.

## Lecture 03 Coding-Question Bank

Create at least 6 coding questions. Canvas should draw 1. Each question should require a few lines of code and produce a machine-checkable final answer.

All six should be similar difficulty: create or use a small lookup table, join by a key, optionally clean or inspect a type, summarize, and report one number or one exact string.

Proposed datasets and task designs:

1. Dataset: `airquality`
   - Task: create a month lookup table, join by `Month`, compute average `Temp` by month name, and report the month with the highest average.
   - Final answer type: precise string.
   - Taught functions: `tibble()`, `left_join()`, `group_by()`, `summarise()`, `mean()`, `arrange(desc())`.

2. Dataset: `CO2`
   - Task: create a lookup table mapping `Treatment` values to treatment labels, join by `Treatment`, compute average `uptake` by label, and report the label with the highest average.
   - Final answer type: precise string.
   - Taught functions: `tibble()`, `left_join()`, `group_by()`, `summarise()`, `mean()`.

3. Dataset: `Orange`
   - Task: create a lookup table mapping `Tree` values to tree labels, join by `Tree`, compute average `circumference` by label, and report the label with the highest average.
   - Final answer type: precise string.
   - Taught functions: `left_join()`, `group_by()`, `summarise()`, `mean()`.
   - Key note: provide the lookup table with a compatible factor key.

4. Dataset: `InsectSprays`
   - Task: create a lookup table mapping `spray` to spray labels, join by `spray`, compute average `count` by label, and report the label with the highest average.
   - Final answer type: precise string.
   - Taught functions: `left_join()`, `group_by()`, `summarise()`, `mean()`, `arrange(desc())`.

5. Dataset: `warpbreaks`
   - Task: create a lookup table mapping `tension` values to tension labels, join by `tension`, compute average `breaks` by label, and report the label with the highest average.
   - Final answer type: precise string.
   - Taught functions: `left_join()`, `group_by()`, `summarise()`, `mean()`.

6. Dataset: `sleep`
   - Task: create a lookup table mapping `group` values to group labels, join by `group`, compute average `extra` by label, and report the label with the highest average.
   - Final answer type: precise string.
   - Taught functions: `left_join()`, `group_by()`, `summarise()`, `mean()`.
   - Key note: provide the lookup table with a compatible factor key.

Generation notes:

- Keep lookup tables small and fully provided in each prompt.
- Avoid requiring students to invent labels or use external data.
- Use `na.rm = TRUE` only where needed and state it in the prompt if missing values exist.
- Student-facing prompts should not require `pull()`.
- Instructor review scripts may use `slice(1)` or `pull()` to validate outputs.

## Thin Or Unclear Areas To Avoid Or Handle Carefully

1. Advanced `join_by()` helpers
   - Lecture 03 lists inequality, closest, interval, and cross patterns as reference-only.
   - Do not generate required coding questions with these helpers.

2. `read_excel()`
   - Lecture 03 names the function and Excel considerations but does not demonstrate syntax.
   - Assess conceptually only.

3. `weighted.mean()`
   - Lecture 02 teaches it, but it is narrower than the core `dplyr` grammar.
   - Use sparingly and keep any question clearly connected to the murders example.

4. `separate(extra = "merge")` and `unite()`
   - Covered in Lecture 02, but exact syntax is comparatively thin.
   - Best suited for recognition or shown-code interpretation, not coding-bank tasks.

5. Set operations
   - Covered in Lecture 03 but not deeply practiced.
   - Suitable for True/False and short MC items. Do not make it a main coding-bank focus.

6. `system.file()` and package paths
   - Use only with shown code or conceptual questions.
   - Do not expect students to discover package file paths from memory.

7. Row-count effects of repeated keys
   - Good conceptual coverage, limited code practice.
   - Use tiny explicit tables if assessing row-count behavior.

8. Regex-heavy string cleaning
   - Lecture examples now include introductory regex patterns: `|`, `\\d`,
     and `[a-zA-Z]`.
   - Assess these simple patterns conceptually or with shown code.
   - Avoid complex regular expressions, anchors, groups, quantifiers, and
     multi-step regex cleaning functions unless the prompt fully scaffolds them.

## Generation Notes For The Next Pass

When generating the full assessments later:

- Generate separate artifacts for Problem Set 02 and Problem Set 03.
- For each problem set, write 12 True/False items; Canvas draws 4.
- For each multiple-choice bank, write at least 5 items with exactly 4 options.
- For each problem set, write at least 6 coding questions of comparable difficulty.
- Ensure every coding question uses a different dataset within its bank; Lecture 03 should not reuse Lecture 02 coding-bank datasets.
- Keep Lecture 02 coding focused on transformation, grouped summaries, and reshaping.
- Keep Lecture 03 coding focused on joining provided lookup tables and then summarizing.
- Provide instructor keys and runnable R review scripts when the full banks are generated.
- Keep Canvas-ready generated outputs under `outputs/problem-sets/` unless instructed otherwise.
