# Problem Set 02 Question Bank

Lecture: Data Wrangling with `dplyr` and Tidy Data

This is instructor-facing source. It includes student prompts, answer options, correct answers, explanations, and coding-bank validation notes.

## Source Basis

- `lectures/02-data-wrangling-dplyr/slides.qmd`
- `lectures/02-data-wrangling-dplyr/handouts/07_basic_dplyr.R`
- `lectures/02-data-wrangling-dplyr/handouts/08_reshape_data.R`

## Canvas Configuration

- True/False bank: 12 questions; draw 4.
- Multiple-choice banks: 4 banks with 5 questions each; draw 1 to 2 from each.
- Coding bank: 6 questions; draw 1.

## True/False Bank

### TF02-01

Prompt: In tidy data, each row should represent one observation.

Correct answer: True

Explanation: Lecture 02 defines tidy data as rows for observations, columns for variables, and cells for values.

### TF02-02

Prompt: In tidy data, a single column name should hide multiple variables whenever possible.

Correct answer: False

Explanation: Hidden variables in headers are a common reason data must be reshaped.

### TF02-03

Prompt: `select()` is used to keep, remove, or reorder columns.

Correct answer: True

Explanation: `select()` works on variables or columns, not observations.

### TF02-04

Prompt: `filter()` is used to keep rows that satisfy conditions.

Correct answer: True

Explanation: Lecture 02 contrasts `filter()` for rows with `select()` for columns.

### TF02-05

Prompt: `mutate()` can create a new variable from existing variables.

Correct answer: True

Explanation: Lecture 02 uses `mutate()` to create GDP per capita and homicide rates.

### TF02-06

Prompt: `arrange()` changes values in a column.

Correct answer: False

Explanation: `arrange()` changes row order; it does not change the values themselves.

### TF02-07

Prompt: The pipe `%>%` helps write transformations from top to bottom.

Correct answer: True

Explanation: Lecture 02 presents the pipe as a readable way to chain operations.

### TF02-08

Prompt: Without `group_by()`, `summarise()` returns one summary for the full table.

Correct answer: True

Explanation: Without groups, the whole input table is the unit of analysis.

### TF02-09

Prompt: `group_by()` changes the unit of analysis for later summaries.

Correct answer: True

Explanation: After grouping, `summarise()` returns one row per group.

### TF02-10

Prompt: `pivot_longer()` usually converts repeated columns into key-value rows.

Correct answer: True

Explanation: Lecture 02 teaches `pivot_longer()` as gathering columns into longer tidy structure.

### TF02-11

Prompt: `pivot_wider()` converts long data back into a wider form by spreading values across columns.

Correct answer: True

Explanation: Lecture 02 presents `pivot_wider()` as the opposite direction of `pivot_longer()`.

### TF02-12

Prompt: `separate()` combines several columns into one column.

Correct answer: False

Explanation: `separate()` splits one column into several; `unite()` combines columns.

## Multiple-Choice Bank 02-A: Tidy Data and Reshaping Concepts

### MC02-A01

Prompt: Which statement best describes tidy data?

A. Each row is a variable, each column is a dataset, and each cell is a model.
B. Each row is an observation, each column is a variable, and each cell is a value.
C. Each row contains several unrelated tables, and each column contains file paths.
D. Each column name should store as much information as possible.

Correct answer: B

Explanation: This is the tidy-data definition used in Lecture 02.

### MC02-A02

Prompt: A table has columns named `Female_1990`, `Female_2017`, `Male_1990`, and `Male_2017`. What is the main structural issue?

A. It has too many rows.
B. The values are necessarily incorrect.
C. Variables such as sex and year are hidden in column names.
D. The table cannot be read by R.

Correct answer: C

Explanation: Lecture 02 uses this style of table to show why reshaping is needed.

### MC02-A03

Prompt: Which function is most appropriate for converting many year columns into one `year` column and one value column?

A. `pivot_longer()`
B. `pivot_wider()`
C. `arrange()`
D. `rename()`

Correct answer: A

Explanation: `pivot_longer()` gathers several columns into key-value rows.

### MC02-A04

Prompt: In `pivot_longer()`, what does `values_to` specify?

A. The rows to remove before pivoting.
B. The variable that should become column names.
C. The name of the column that will store gathered cell values.
D. The sorting order of the output.

Correct answer: C

Explanation: `values_to` names the column that stores the values from the old wide columns.

### MC02-A05

Prompt: Which function spreads values back across multiple columns?

A. `pivot_wider()`
B. `filter()`
C. `separate()`
D. `summarise()`

Correct answer: A

Explanation: Lecture 02 teaches `pivot_wider()` as spreading values into wider form.

## Multiple-Choice Bank 02-B: Basic `dplyr` Verbs

### MC02-B01

Prompt: Which function should you use to keep only `country`, `year`, and `population` columns?

A. `filter()`
B. `select()`
C. `mutate()`
D. `arrange()`

Correct answer: B

Explanation: `select()` keeps or reorders columns.

### MC02-B02

Prompt: Which function should you use to keep only rows where `continent == "Asia"`?

A. `filter()`
B. `select()`
C. `rename()`
D. `pivot_wider()`

Correct answer: A

Explanation: `filter()` keeps observations that satisfy conditions.

### MC02-B03

Prompt: What does this line do?

```r
mutate(rate = total / population * 100000)
```

A. Removes the `rate` column.
B. Creates or rewrites a `rate` column.
C. Sorts rows by `rate`.
D. Groups rows by `rate`.

Correct answer: B

Explanation: `mutate()` creates or transforms columns.

### MC02-B04

Prompt: Which expression sorts a table from highest to lowest life expectancy?

A. `arrange(life_expectancy)`
B. `arrange(desc(life_expectancy))`
C. `filter(life_expectancy)`
D. `select(desc(life_expectancy))`

Correct answer: B

Explanation: `desc()` reverses the sort order inside `arrange()`.

### MC02-B05

Prompt: What is the main benefit of the pipe `%>%` in Lecture 02?

A. It automatically fixes missing values.
B. It makes a sequence of transformations readable from top to bottom.
C. It converts wide data to long data by itself.
D. It prevents all coding errors.

Correct answer: B

Explanation: The pipe helps express workflows as readable chains.

## Multiple-Choice Bank 02-C: Grouped Summaries

### MC02-C01

Prompt: What does `summarise()` do?

A. It collapses many rows into summary values.
B. It changes column names only.
C. It always keeps the same number of rows.
D. It imports a CSV file.

Correct answer: A

Explanation: Lecture 02 defines `summarise()` as computing aggregate summaries.

### MC02-C02

Prompt: Why does `group_by(continent)` change the output of `summarise()`?

A. It removes all missing values automatically.
B. It changes the unit of analysis to one summary per continent.
C. It converts numbers to text.
D. It sorts the rows alphabetically.

Correct answer: B

Explanation: Grouping makes each group its own summary unit.

### MC02-C03

Prompt: In a grouped summary, what does `n()` count?

A. The number of rows in each group.
B. The number of columns in the original dataset.
C. The number of packages loaded.
D. The number of missing values in every column.

Correct answer: A

Explanation: Lecture 02 uses `n()` to count rows within each group.

### MC02-C04

Prompt: What does `.groups = "drop"` do in a `summarise()` call?

A. It drops all numeric columns.
B. It removes the grouping metadata after the summary.
C. It drops every row with a missing value.
D. It removes the first group only.

Correct answer: B

Explanation: Lecture 02 explains that `.groups = "drop"` returns an ungrouped result.

### MC02-C05

Prompt: Which summary better accounts for population size when averaging state homicide rates by region?

A. A simple mean of state rates only.
B. A weighted mean using population as weights.
C. Alphabetical order of state names.
D. The first state in each region.

Correct answer: B

Explanation: Lecture 02 uses `weighted.mean(rate, w = population)` for population-weighted regional rates.

## Multiple-Choice Bank 02-D: Compound Reshaping and Split Keys

### MC02-D01

Prompt: Why might `year` arrive as text after `pivot_longer()`?

A. Values from column headers often become character strings.
B. `pivot_longer()` deletes all numeric columns.
C. `read_csv()` cannot read years.
D. `year` is never numeric in R.

Correct answer: A

Explanation: Lecture 02 shows that values gathered from column names can arrive as character text.

### MC02-D02

Prompt: What does `names_transform = list(year = as.integer)` do in the lecture example?

A. It removes the `year` column.
B. It converts the new `year` column to integer during pivoting.
C. It sorts the table by year.
D. It renames `year` to `integer`.

Correct answer: B

Explanation: `names_transform` applies a conversion to the new names column.

### MC02-D03

Prompt: What does `separate()` do?

A. It splits one column into multiple columns.
B. It combines multiple columns into one.
C. It imports a file.
D. It computes a grouped mean.

Correct answer: A

Explanation: Lecture 02 uses `separate()` to split a compound key.

### MC02-D04

Prompt: Why is `extra = "merge"` useful when splitting `1960_life_expectancy`?

A. It keeps text after the second separator together instead of dropping it.
B. It removes the year.
C. It converts all values to numeric.
D. It pivots the table wider.

Correct answer: A

Explanation: The lecture explains that `extra = "merge"` keeps remaining pieces in the final output column.

### MC02-D05

Prompt: What does `unite()` do?

A. It combines several columns into one column.
B. It filters rows.
C. It computes a mean.
D. It sorts rows from high to low.

Correct answer: A

Explanation: Lecture 02 presents `unite()` as the opposite direction of `separate()`.

## Coding Question Bank

Canvas should draw 1 coding question from this bank. Students should use `tidyverse`. Final answers are machine-checkable.

### Code02-C1

Prompt: Use the built-in `mtcars` dataset. Convert it to a tibble if desired. Compute the average `mpg` for each `cyl` value. Which `cyl` value has the highest average `mpg`?

Final answer format: one integer.

Correct answer: `4`

Explanation: Four-cylinder cars have the highest average miles per gallon in `mtcars`.

### Code02-C2

Prompt: Use the built-in `iris` dataset. Compute the average `Sepal.Length` for each `Species`. Which species has the highest average `Sepal.Length`?

Final answer format: one exact species name.

Correct answer: `virginica`

Explanation: The grouped average is largest for `virginica`.

### Code02-C3

Prompt: Use the built-in `ToothGrowth` dataset. Compute the average `len` for each `supp` group. Which supplement group has the larger average tooth length?

Final answer format: one exact supplement code.

Correct answer: `OJ`

Explanation: `OJ` has the larger average `len`.

### Code02-C4

Prompt: Use the built-in `ChickWeight` dataset. Keep only rows where `Time == 21`. Compute the average `weight` for each `Diet`. Which diet has the highest average weight at time 21?

Final answer format: one diet number.

Correct answer: `3`

Explanation: Diet 3 has the highest average weight at time 21.

### Code02-C5

Prompt: Use the built-in `PlantGrowth` dataset. Compute the average `weight` for each `group`. Which group has the highest average weight?

Final answer format: one exact group label.

Correct answer: `trt2`

Explanation: `trt2` has the highest average plant weight.

### Code02-C6

Prompt: Use the built-in `USArrests` dataset. The state names are stored as row names. Use this setup before your `dplyr` pipeline:

```r
usarrests_tbl <- as_tibble(USArrests)
usarrests_tbl$state <- rownames(USArrests)
```

Create a new variable `violent_total = Murder + Assault`. Which state has the largest `violent_total`?

Final answer format: one exact state name.

Correct answer: `Florida`

Explanation: Florida has the largest combined `Murder + Assault` value in `USArrests`.

## Coding Review Script

Instructor validation code is in:

- `problem-sets/02-data-wrangling-dplyr/02-coding-bank-review.R`

Verified outputs:

- `02-C1 = 4`
- `02-C2 = virginica`
- `02-C3 = OJ`
- `02-C4 = 3`
- `02-C5 = trt2`
- `02-C6 = Florida`

## Instructor Audit Notes

- Coding questions use different base R datasets within the bank.
- Coding questions avoid requiring exact reshaping syntax from memory.
- `USArrests` needs starter code because state names are row names.
- The bank is aligned to functions taught in Lecture 02.
