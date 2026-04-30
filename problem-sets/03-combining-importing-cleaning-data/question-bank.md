# Problem Set 03 Question Bank

Lecture: Combining, Importing, and Cleaning Data

This is instructor-facing source. It includes student prompts, answer options, correct answers, explanations, and coding-bank validation notes.

## Source Basis

- `lectures/03-combining-importing-cleaning-data/slides.qmd`
- `lectures/03-combining-importing-cleaning-data/handouts/09_joins_binds.R`
- `lectures/03-combining-importing-cleaning-data/handouts/10_import_clean_data.R`

## Canvas Configuration

- True/False bank: 14 questions; draw 4.
- Multiple-choice banks: 5 banks; draw 1 to 2 from each.
- Coding bank: 6 questions; draw 1.

## True/False Bank

### TF03-01

Prompt: A key is a variable that helps identify matching observations across tables.

Correct answer: True

Explanation: Lecture 03 defines keys as the way tables recognize matching observations.

### TF03-02

Prompt: Row position is always a safe replacement for a key when combining two tables.

Correct answer: False

Explanation: Lecture 03 shows that two related tables can store rows in different orders.

### TF03-03

Prompt: `identical()` checks whether two R objects are exactly the same.

Correct answer: True

Explanation: Lecture 03 uses `identical()` to check whether state names appear in the same order.

### TF03-04

Prompt: `left_join()` keeps all rows from the first table.

Correct answer: True

Explanation: This is the central row-retention rule for a left join.

### TF03-05

Prompt: `inner_join()` keeps rows that do not match in either table.

Correct answer: False

Explanation: `inner_join()` keeps only rows whose keys match in both tables.

### TF03-06

Prompt: `semi_join()` can add columns from the second table.

Correct answer: False

Explanation: Filtering joins keep or drop rows but do not add right-table columns.

### TF03-07

Prompt: `anti_join()` is useful for finding rows in the first table that have no match in the second table.

Correct answer: True

Explanation: Lecture 03 describes `anti_join()` as useful for checking nonmatches.

### TF03-08

Prompt: `by = join_by(state)` explicitly states that rows should match using `state`.

Correct answer: True

Explanation: Lecture 03 introduces `join_by()` as explicit matching-rule syntax.

### TF03-09

Prompt: Binding tables searches for matching key values before combining rows or columns.

Correct answer: False

Explanation: Binds combine by position or compatible structure, not by key matching.

### TF03-10

Prompt: `setdiff(x, y)` always gives the same result as `setdiff(y, x)`.

Correct answer: False

Explanation: Lecture 03 notes that `setdiff()` is directional.

### TF03-11

Prompt: A reproducible import should record the file source, reading function, options, and object name.

Correct answer: True

Explanation: Lecture 03 emphasizes written import commands for reproducibility.

### TF03-12

Prompt: `parse_number()` is useful when numeric values arrive as text with extra characters.

Correct answer: True

Explanation: Lecture 03 uses `parse_number()` to extract numeric values from messy text.

### TF03-13

Prompt: `str_replace()` and `str_replace_all()` always replace the same number of matches in each string.

Correct answer: False

Explanation: Lecture 03 distinguishes first-match replacement with `str_replace()` from all-match replacement with `str_replace_all()`.

### TF03-14

Prompt: In a regular expression, `\\d` can be used to detect a digit.

Correct answer: True

Explanation: Lecture 03 introduces `\\d` as a simple regular-expression pattern for digits.

## Multiple-Choice Bank 03-A: Keys and Join Choice

### MC03-A01

Prompt: What is the main purpose of a key in a join?

A. To sort rows alphabetically.
B. To identify which observations in separate tables match.
C. To convert text to numeric values.
D. To remove missing values from a dataset.

Correct answer: B

Explanation: A key tells R which rows belong together across tables.

### MC03-A02

Prompt: Why is row position not enough for combining two related tables?

A. Rows may appear in different orders across tables.
B. R cannot count row positions.
C. Row position always creates character variables.
D. Row position removes column names.

Correct answer: A

Explanation: Lecture 03 shows that related tables can store rows in different orders.

### MC03-A03

Prompt: You have a main table and want to keep every row from it while adding matching lookup columns. Which join should you use?

A. `left_join()`
B. `inner_join()`
C. `anti_join()`
D. `bind_rows()`

Correct answer: A

Explanation: `left_join()` keeps all rows from the first table and adds matching columns.

### MC03-A04

Prompt: Which join keeps only rows whose keys appear in both tables?

A. `full_join()`
B. `inner_join()`
C. `right_join()`
D. `bind_cols()`

Correct answer: B

Explanation: `inner_join()` drops nonmatching rows.

### MC03-A05

Prompt: In `left_join(tab1, tab2, by = join_by(state))`, what does `join_by(state)` do?

A. It says to match rows using `state`.
B. It sorts both tables by `state`.
C. It deletes the `state` column.
D. It stacks the tables by rows.

Correct answer: A

Explanation: `join_by()` writes the matching rule explicitly.

## Multiple-Choice Bank 03-B: Filtering Joins, Binds, and Sets

### MC03-B01

Prompt: Which function keeps rows from `tab1` that have a match in `tab2`, without adding columns from `tab2`?

A. `semi_join(tab1, tab2, by = "state")`
B. `left_join(tab1, tab2, by = "state")`
C. `bind_rows(tab1, tab2)`
D. `full_join(tab1, tab2, by = "state")`

Correct answer: A

Explanation: `semi_join()` is a filtering join that keeps matching left rows only.

### MC03-B02

Prompt: Which function is best for finding rows in `tab1` that do not match `tab2`?

A. `inner_join()`
B. `anti_join()`
C. `bind_cols()`
D. `union()`

Correct answer: B

Explanation: `anti_join()` keeps nonmatching rows from the first table.

### MC03-B03

Prompt: When should you use a bind rather than a join?

A. When you need to match rows by a key.
B. When you want to combine objects by compatible row or column structure.
C. When you need to parse numbers from text.
D. When you need to detect commas in a string.

Correct answer: B

Explanation: Binds combine by position or compatible structure, not key matches.

### MC03-B04

Prompt: What is the result of `intersect(1:10, 6:15)`?

A. `1 2 3 4 5`
B. `6 7 8 9 10`
C. `1 2 3 4 5 6 7 8 9 10 11 12 13 14 15`
D. `11 12 13 14 15`

Correct answer: B

Explanation: `intersect()` returns values shared by both inputs.

### MC03-B05

Prompt: Why does `setequal(1:5, 5:1)` return `TRUE` while `identical(1:5, 5:1)` returns `FALSE`?

A. `setequal()` ignores order, while `identical()` is stricter.
B. `setequal()` works only with text.
C. `identical()` ignores order, while `setequal()` is stricter.
D. Both should return `FALSE`.

Correct answer: A

Explanation: Lecture 03 contrasts set equality with exact object identity.

## Multiple-Choice Bank 03-C: Importing and Type Inspection

### MC03-C01

Prompt: Which item should a reproducible import script record?

A. Only the current time.
B. The file source, reading function, options, and object name.
C. Only the number of rows in the file.
D. Only the final plot.

Correct answer: B

Explanation: Lecture 03 lists these as parts of a reproducible import.

### MC03-C02

Prompt: What does `read_csv()` do in Lecture 03?

A. Reads a CSV file into R.
B. Joins two tables by a key.
C. Converts messy text into numbers.
D. Splits one column into several.

Correct answer: A

Explanation: `read_csv()` imports comma-separated files.

### MC03-C03

Prompt: What is the purpose of `system.file("extdata", "murders.csv", package = "dslabs")`?

A. To build a reproducible path to a file inside an installed package.
B. To summarize a dataset by region.
C. To convert state names to title case.
D. To remove duplicated rows.

Correct answer: A

Explanation: Lecture 03 uses `system.file()` to locate a package example file.

### MC03-C04

Prompt: After importing data, why should you use `class()` on important columns?

A. To check whether R interpreted their types as expected.
B. To join two tables.
C. To change the current working directory.
D. To remove all missing values.

Correct answer: A

Explanation: Imported numbers, dates, or categories may arrive as text.

### MC03-C05

Prompt: Which is a reasonable Excel-import consideration from Lecture 03?

A. Sheet name or number.
B. The color of the RStudio console.
C. The order of installed packages.
D. The font used in the plot pane.

Correct answer: A

Explanation: Lecture 03 names sheet, skipped rows, ranges, merged cells, dates, and types as Excel considerations.

## Multiple-Choice Bank 03-D: Cleaning Text and Keys

### MC03-D01

Prompt: What does `str_detect()` check?

A. Whether a character vector contains a pattern.
B. Whether two tables have the same rows.
C. Whether a dataset is grouped.
D. Whether a table has exactly five columns.

Correct answer: A

Explanation: Lecture 03 uses `str_detect()` to check for commas in text values.

### MC03-D02

Prompt: Which function changes matching text?

A. `str_replace_all()`
B. `group_by()`
C. `left_join()`
D. `summarise()`

Correct answer: A

Explanation: `str_replace_all()` replaces matching text patterns.

### MC03-D03

Prompt: Why is `parse_number("1,234 people")` useful?

A. It can extract the numeric value from messy text.
B. It joins two tables by a key.
C. It converts a table from wide to long.
D. It sorts rows in descending order.

Correct answer: A

Explanation: `parse_number()` is designed for numeric content embedded in text.

### MC03-D04

Prompt: What does `str_to_title("california")` return?

A. `"California"`
B. `"CALIFORNIA"`
C. `"california"`
D. `"c,a,l,i,f,o,r,n,i,a"`

Correct answer: A

Explanation: `str_to_title()` converts text to title case.

### MC03-D05

Prompt: Why might key cleaning be necessary before a join?

A. Key values may be written in incompatible formats, such as different capitalization.
B. Joins require every numeric column to be rounded.
C. `left_join()` cannot use text columns.
D. `group_by()` always deletes key columns.

Correct answer: A

Explanation: Lecture 03 standardizes lower-case state names before joining.

### MC03-D06

Prompt: What is the difference between `str_replace()` and `str_replace_all()` in Lecture 03?

A. `str_replace()` changes the first match in each string, while `str_replace_all()` changes every match.
B. `str_replace()` imports CSV files, while `str_replace_all()` imports Excel files.
C. `str_replace()` works only with numbers, while `str_replace_all()` works only with tables.
D. There is no difference.

Correct answer: A

Explanation: Lecture 03 uses a value with multiple commas to show the first-match versus every-match distinction.

### MC03-D07

Prompt: What does `all(str_detect(x, ","))` check?

A. Whether every value in `x` contains a comma.
B. Whether at least one value in `x` contains a comma.
C. Whether commas should be used as decimal separators.
D. Whether `x` is a numeric vector.

Correct answer: A

Explanation: `str_detect()` returns one logical value per string, and `all()` asks whether all of them are `TRUE`.

### MC03-D08

Prompt: In the pattern `"cm|inches"`, what does `|` mean?

A. Or.
B. Not equal to.
C. Divide by.
D. End of string.

Correct answer: A

Explanation: Lecture 03 introduces `|` as the simple regular-expression "or" operator.

## Multiple-Choice Bank 03-E: Integrated Workflow

### MC03-E01

Prompt: Which sequence best matches the Lecture 03 workflow?

A. Summarize, then import, then clean, then join.
B. Import or start with data, inspect types, clean values, join lookup data, then summarize.
C. Plot first, then delete keys, then import.
D. Join by row position, then inspect the columns.

Correct answer: B

Explanation: Lecture 03 emphasizes structure and types before summary analysis.

### MC03-E02

Prompt: In the final pipeline, why does `mutate(rate = total / population * 100000)` come before `group_by()` and `summarise()`?

A. The rate must exist before it can be averaged by group.
B. `group_by()` cannot work on tibbles.
C. `summarise()` automatically creates `rate`.
D. `mutate()` imports CSV files.

Correct answer: A

Explanation: Derived variables must exist before grouped summaries can use them.

### MC03-E03

Prompt: In the final pipeline, what is the purpose of joining `region_lookup`?

A. To add region information needed for grouped summaries.
B. To remove all numeric columns.
C. To convert the table to a vector.
D. To sort rows alphabetically.

Correct answer: A

Explanation: The lookup table supplies the grouping variable.

### MC03-E04

Prompt: What could happen if key values are not standardized before joining?

A. Matching rows may fail to match.
B. `read_csv()` will stop existing.
C. `summarise()` will always return zero.
D. R will automatically fix every spelling difference.

Correct answer: A

Explanation: Joins depend on compatible key values.

### MC03-E05

Prompt: Which line creates one summary row per `short_region` in the final pipeline?

A. `group_by(short_region)` followed by `summarise(...)`
B. `class(clean_counts$population)`
C. `str_detect(population_text, ",")`
D. `system.file(...)`

Correct answer: A

Explanation: `group_by()` defines groups and `summarise()` computes one row per group.

## Coding Question Bank

Canvas should draw 1 coding question from this bank. Students should use `tidyverse`. Lookup tables are fully provided in the prompts. Final answers are machine-checkable.

### Code03-C1

Prompt: Use the built-in `airquality` dataset. Create this lookup table:

```r
month_lookup <- tibble(
  Month = c(5, 6, 7, 8, 9),
  month_name = c("May", "June", "July", "August", "September")
)
```

Join the lookup table to `airquality` by `Month`. Compute average `Temp` by `month_name`. Which month has the highest average temperature?

Final answer format: one exact month name.

Correct answer: `August`

Explanation: After joining month names and averaging temperature by month, August has the highest average.

### Code03-C2

Prompt: Use the built-in `CO2` dataset. Create this lookup table:

```r
treatment_lookup <- tibble(
  Treatment = c("nonchilled", "chilled"),
  treatment_label = c("Not chilled", "Chilled")
)
```

Join the lookup table to `CO2` by `Treatment`. Compute average `uptake` by `treatment_label`. Which treatment label has the highest average uptake?

Final answer format: one exact treatment label.

Correct answer: `Not chilled`

Explanation: The nonchilled plants have the higher average uptake in `CO2`.

### Code03-C3

Prompt: Use the built-in `Orange` dataset. Create this lookup table exactly as shown. It uses `factor(..., ordered = TRUE)` so the lookup key has the same type as `Orange$Tree`.

```r
tree_lookup <- tibble(
  Tree = factor(c(1, 2, 3, 4, 5), levels = levels(Orange$Tree), ordered = TRUE),
  tree_label = c("Tree 1", "Tree 2", "Tree 3", "Tree 4", "Tree 5")
)
```

Join the lookup table to `Orange` by `Tree`. Compute average `circumference` by `tree_label`. Which tree label has the highest average circumference?

Final answer format: one exact tree label.

Correct answer: `Tree 4`

Explanation: Tree 4 has the highest average circumference in `Orange`.

### Code03-C4

Prompt: Use the built-in `InsectSprays` dataset. Create this lookup table:

```r
spray_lookup <- tibble(
  spray = LETTERS[1:6],
  spray_label = paste("Spray", LETTERS[1:6])
)
```

Join the lookup table to `InsectSprays` by `spray`. Compute average `count` by `spray_label`. Which spray label has the highest average count?

Final answer format: one exact spray label.

Correct answer: `Spray F`

Explanation: Spray F has the highest average insect count in `InsectSprays`.

### Code03-C5

Prompt: Use the built-in `warpbreaks` dataset. Create this lookup table:

```r
tension_lookup <- tibble(
  tension = c("L", "M", "H"),
  tension_label = c("Low tension", "Medium tension", "High tension")
)
```

Join the lookup table to `warpbreaks` by `tension`. Compute average `breaks` by `tension_label`. Which tension label has the highest average number of breaks?

Final answer format: one exact tension label.

Correct answer: `Low tension`

Explanation: Low tension has the highest average number of breaks in `warpbreaks`.

### Code03-C6

Prompt: Use the built-in `sleep` dataset. Create this lookup table exactly as shown. It uses `factor()` so the lookup key has the same type as `sleep$group`.

```r
group_lookup <- tibble(
  group = factor(c(1, 2), levels = levels(sleep$group)),
  group_label = c("Group 1", "Group 2")
)
```

Join the lookup table to `sleep` by `group`. Compute average `extra` by `group_label`. Which group label has the highest average extra sleep?

Final answer format: one exact group label.

Correct answer: `Group 2`

Explanation: Group 2 has the higher average extra sleep in `sleep`.

## Coding Review Script

Instructor validation code is in:

- `problem-sets/03-combining-importing-cleaning-data/03-coding-bank-review.R`

Verified outputs:

- `03-C1 = August`
- `03-C2 = Not chilled`
- `03-C3 = Tree 4`
- `03-C4 = Spray F`
- `03-C5 = Low tension`
- `03-C6 = Group 2`

## Instructor Audit Notes

- Coding questions use different base R datasets within the bank and do not reuse the Lecture 02 coding-bank datasets.
- Every coding question provides its lookup table in the prompt.
- Coding questions focus on Lecture 03 joins plus Lecture 02 grouped summaries.
- Advanced `join_by()` helpers, complex regex cleaning, and Excel syntax are intentionally excluded from coding questions.
