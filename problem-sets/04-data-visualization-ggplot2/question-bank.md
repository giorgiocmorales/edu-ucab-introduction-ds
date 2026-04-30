# Problem Set 04 Question Bank

Lecture: Data Visualization with `ggplot2`

This is instructor-facing source. It includes student prompts, answer options, correct answers, explanations, and coding-bank validation notes.

## Source Basis

- `lectures/04-data-visualization-ggplot2/slides.qmd`
- `lectures/04-data-visualization-ggplot2/handouts/11_ggplot2_basics.R`
- Lecture 02 `dplyr` and Lecture 03 import/cleaning material as prerequisite context.

## Canvas Configuration

- True/False bank: 12 questions; draw 4.
- Multiple-choice banks: 4 banks with 5 questions each; draw 1 to 2 from each.
- Coding bank: 6 questions; draw 1.
- Difficulty settings: True/False easy to moderate; multiple choice moderate; coding hard but limited to slide and handout material.

## True/False Bank

### TF04-01

Prompt: Exploratory visualizations can be rough because their main purpose is to help inspect patterns, outliers, and possible data problems.

Correct answer: True

Explanation: Lecture 04 distinguishes exploratory graphics from polished publication graphics.

### TF04-02

Prompt: Publication graphics should usually communicate one clear comparison to a specific audience.

Correct answer: True

Explanation: The lecture frames publication graphics as audience-facing communication.

### TF04-03

Prompt: Anscombe's quartet shows that similar summary statistics can hide very different data patterns.

Correct answer: True

Explanation: The Anscombe example asks students to compare summaries before seeing the plots.

### TF04-04

Prompt: In `ggplot2`, `aes(color = region)` maps the variable `region` to color, while `color = "steelblue"` sets one constant color.

Correct answer: True

Explanation: This is the mapping-versus-setting distinction taught in the geoms and mappings section.

### TF04-05

Prompt: A geom decides how mapped variables become visible marks such as points, lines, bars, or text.

Correct answer: True

Explanation: Lecture 04 defines geoms as the layer that draws the visual marks.

### TF04-06

Prompt: A global mapping in `ggplot()` cannot be inherited by later geoms.

Correct answer: False

Explanation: The lecture shows that global mappings are inherited by layers unless changed locally.

### TF04-07

Prompt: Layer order matters because later layers are drawn on top of earlier layers.

Correct answer: True

Explanation: The lecture recommends drawing background/reference layers first.

### TF04-08

Prompt: Faceting repeats the same plot across groups using common plotting logic.

Correct answer: True

Explanation: The facets section teaches `facet_grid()` and `facet_wrap()` as repeated panels.

### TF04-09

Prompt: Time-series plots usually put time on the y-axis.

Correct answer: False

Explanation: The lecture states that time usually belongs on the x-axis.

### TF04-10

Prompt: Histogram bin width can change the apparent structure of a distribution.

Correct answer: True

Explanation: The histogram section compares small and wide bins.

### TF04-11

Prompt: Bar charts that use length to encode magnitude usually need a zero baseline.

Correct answer: True

Explanation: The principles section shows how truncating a bar axis can exaggerate differences.

### TF04-12

Prompt: Color should be used only as decoration because it cannot encode information.

Correct answer: False

Explanation: The lecture uses color to encode groups and discusses accessible color choices.

## Multiple-Choice Bank 04-A: Visualization Purposes and Principles

### MC04-A01

Prompt: Which statement best describes the main difference between exploratory and publication visualization?

A. Exploratory graphics are for inspecting data, while publication graphics are for communicating a clear comparison.
B. Exploratory graphics should always have more typography than publication graphics.
C. Publication graphics should avoid labels because readers already know the data.
D. Exploratory graphics must always use facets, while publication graphics cannot use facets.

Correct answer: A

Explanation: This matches the lecture's opening distinction.

### MC04-A02

Prompt: What is the main lesson of Anscombe's quartet?

A. Scatterplots are unnecessary when correlations are available.
B. Similar summaries can hide different visual patterns.
C. Four datasets should always be combined into one average.
D. Linear models always explain all variation in a dataset.

Correct answer: B

Explanation: The quartet is used to show why plotting is necessary.

### MC04-A03

Prompt: A graph has heavy decorative images behind the data, two unrelated y-axes, and labels that make comparison harder. Which principle is most directly violated?

A. The graph should use more colors to separate the two axes.
B. The graph makes the intended comparison less direct and less legible.
C. The graph should use a pie chart because there are two variables.
D. The graph should remove labels so the background is easier to see.

Correct answer: B

Explanation: The bad-graph examples focus on legibility, scale, and direct comparison.

### MC04-A04

Prompt: Why are aligned bars often easier to compare than pie slices?

A. Bars use aligned lengths on a common scale.
B. Bars always require fewer categories than pie charts.
C. Pie charts are better only when values are sorted first.
D. Pie charts avoid the need to choose a scale.

Correct answer: A

Explanation: The principles section contrasts angles with aligned lengths.

### MC04-A05

Prompt: When is removing zero from an axis especially dangerous?

A. When a bar length encodes magnitude.
B. When a line chart uses direct labels.
C. When a scatterplot maps color to region.
D. When a plot uses facets with fixed axes.

Correct answer: A

Explanation: The lecture warns that truncated bar axes can exaggerate differences.

## Multiple-Choice Bank 04-B: Grammar of Graphics and Aesthetics

### MC04-B01

Prompt: In the grammar of graphics, what is an aesthetic mapping?

A. A connection between a data variable and a visible feature such as x-position, y-position, color, or label.
B. A fixed visual choice such as setting every point to the same color.
C. A theme setting that controls background and gridlines.
D. A summary value that appears in a plot caption.

Correct answer: A

Explanation: The lecture defines aesthetics as mappings from variables to visible features.

### MC04-B02

Prompt: What does this code do?

```r
geom_point(aes(color = region), size = 3)
```

A. It maps `region` to point color and sets every point size to 3.
B. It sets every point color to the word `"region"` and maps size to 3.
C. It creates one facet per region.
D. It changes the x-axis to a log scale.

Correct answer: A

Explanation: `color` is inside `aes()`, while `size` is outside.

### MC04-B03

Prompt: Why can a global mapping in `ggplot()` make code shorter?

A. Later layers can inherit the mapping.
B. It forces every layer to use different variables.
C. It prevents local mappings inside individual geoms.
D. It makes all settings behave like mapped variables.

Correct answer: A

Explanation: The lecture uses `p_murders` to show inherited global mappings.

### MC04-B04

Prompt: Which choice best describes a local mapping?

A. A mapping supplied inside one layer, such as `geom_point(aes(color = country))`.
B. A mapping supplied in `ggplot()` that every later layer inherits.
C. A constant setting such as `color = "steelblue"`.
D. A theme choice that changes only fonts and margins.

Correct answer: A

Explanation: Local mappings change one layer without changing all other layers.

### MC04-B05

Prompt: Why should background or reference layers usually be drawn before data layers?

A. Later layers are drawn on top, so the data remains visible.
B. Earlier layers automatically get larger point sizes.
C. Reference layers must use the same color as the data.
D. Data layers cannot use mappings if a reference line is drawn later.

Correct answer: A

Explanation: The layer-order section shows why data layers should remain visible.

## Multiple-Choice Bank 04-C: Geoms, Facets, and Scales

### MC04-C01

Prompt: Which geom is most appropriate for showing the relationship between two numeric variables as individual observations?

A. `geom_point()`
B. `geom_col()`
C. `geom_histogram()`
D. `geom_boxplot()`

Correct answer: A

Explanation: Scatterplots use points for two numeric variables.

### MC04-C02

Prompt: Which function repeats the same plot across panels for different groups?

A. `facet_wrap()`
B. `geom_text()`
C. `labs()`
D. `scale_color_manual()`

Correct answer: A

Explanation: Faceting repeats a plot across subsets of the data.

### MC04-C03

Prompt: Which code best matches the lecture's recommendation for a basic time series?

A. `ggplot(aes(x = year, y = fertility)) + geom_line()`
B. `ggplot(aes(x = fertility, y = year)) + geom_line()`
C. `ggplot(aes(x = year, y = fertility)) + geom_histogram()`
D. `ggplot(aes(x = country, y = fertility)) + geom_line()`

Correct answer: A

Explanation: The lecture places time on the x-axis and the outcome on the y-axis.

### MC04-C04

Prompt: What is the main purpose of `scale_x_log10()` or `scale_y_log10()` in the lecture examples?

A. To make skewed values easier to compare on a multiplicative scale.
B. To compute a new logged variable in the original data frame.
C. To force each facet to use a different axis range.
D. To replace color mappings with size mappings.

Correct answer: A

Explanation: The murders and income examples use log scales for skewed values.

### MC04-C05

Prompt: In a histogram, what does changing `binwidth` affect?

A. How values are grouped into bins and therefore the visible distribution.
B. Whether the histogram uses a log scale or a raw scale.
C. Which grouping variable is mapped to color.
D. Whether the histogram is faceted by year.

Correct answer: A

Explanation: The lecture shows that bin width is an analytic choice.

## Multiple-Choice Bank 04-D: Publication and Interpretation Choices

### MC04-D01

Prompt: Why might direct labels be preferable to a legend when only a few time series are shown?

A. They reduce back-and-forth eye movement between the plot and legend.
B. They are always better than legends, regardless of the number of lines.
C. They remove the need to choose colors carefully.
D. They make faceting unnecessary for all grouped plots.

Correct answer: A

Explanation: The lecture explicitly discusses direct labels for a small number of lines.

### MC04-D02

Prompt: Which choice is most consistent with the lecture's publication-graphics principles?

A. Use labels, scales, and ordering that support the intended comparison.
B. Use the same default labels for every plot to avoid editorial choices.
C. Use color mainly to decorate the background.
D. Prefer pseudo-3D effects when categories have similar values.

Correct answer: A

Explanation: Publication graphics should explain the comparison clearly.

### MC04-D03

Prompt: Why can encoding quantities by radius distort comparisons?

A. Viewers perceive area, so radius changes can make large values look too large.
B. Radius makes all values easier to compare than aligned length.
C. Radius avoids the need for a scale or legend.
D. Radius is equivalent to using a common x-axis.

Correct answer: A

Explanation: The principles section warns against misleading area/radius encodings.

### MC04-D04

Prompt: Which plot choice best supports color accessibility?

A. Use a palette whose groups remain distinguishable for common forms of color vision deficiency.
B. Use many close shades of the same hue to create a quieter plot.
C. Use color only for the largest group.
D. Use transparency instead of checking whether colors remain distinguishable.

Correct answer: A

Explanation: The lecture includes a color-accessibility principle.

### MC04-D05

Prompt: Why should excessive digits usually be avoided in labels or summaries?

A. They can imply more precision than the data or question supports.
B. They are useful when the intended comparison is approximate.
C. They make axis transformations unnecessary.
D. They improve legibility when labels are already crowded.

Correct answer: A

Explanation: The lecture warns that too many digits can overstate precision.

## Coding Question Bank

Canvas should draw 1 coding question from this bank. These are hard but limited to code patterns shown in the lecture and previous wrangling lectures. Each prompt tells students which function patterns to revise before solving.

### Code04-C1

Prompt: Use `dslabs::murders`. Revise `mutate()`, `slice_max()`, and `pull()` before solving. Create a murder rate per million residents using `total / population * 10^6`. Which state abbreviation has the highest murder rate?

Final answer format: a two-letter state abbreviation.

Correct answer: DC

Explanation: The highest murder rate per million residents in `murders` is for the District of Columbia.

### Code04-C2

Prompt: Use `dslabs::gapminder`. Revise `filter()`, `mutate()`, `group_by()`, `summarise()`, `slice_max()`, and `pull()` before solving. For year 2011, keep rows with nonmissing `gdp`, compute `dollars_per_day = gdp / population / 365`, then find which continent has the highest median `dollars_per_day`.

Final answer format: a continent name.

Correct answer: Europe

Explanation: In the available `gapminder` GDP data, Europe has the highest median dollars per day in 2011.

### Code04-C3

Prompt: Use `dslabs::heights`. Revise `group_by()`, `summarise()`, `median()`, `slice_max()`, and `pull()` before solving. Which `sex` group has the higher median height?

Final answer format: `Male` or `Female`.

Correct answer: Male

Explanation: The median height is higher for the male group in `heights`.

### Code04-C4

Prompt: Use `datasets::anscombe`. Revise `pivot_longer()`, `group_by()`, `summarise()`, and `slice_max()` before solving. Reshape Anscombe's quartet into a long table with `x`, `y`, and `set` as in the lecture. Which dataset has the largest maximum `y` value?

Final answer format: `Dataset 1`, `Dataset 2`, `Dataset 3`, or `Dataset 4`.

Correct answer: Dataset 3

Explanation: After reshaping, Dataset 3 contains the largest `y` value.

### Code04-C5

Prompt: Use `dslabs::gapminder`. Revise `filter()`, `group_by()`, `summarise()`, `slice_max()`, and `pull()` before solving. In year 1962, keep countries with nonmissing `fertility` and `life_expectancy`, then keep only rows where `fertility < 5`. Which continent has the highest average life expectancy?

Final answer format: a continent name.

Correct answer: Oceania

Explanation: Among 1962 rows with fertility below 5, Oceania has the highest average life expectancy.

### Code04-C6

Prompt: Use `dslabs::murders`. Revise `mutate()`, `group_by()`, `summarise()`, `slice_max()`, and `pull()` before solving. Compute each state's murder rate per million residents. Then compute the average state rate within each region. Which region has the highest average state murder rate?

Final answer format: one of the `region` values in `murders`.

Correct answer: South

Explanation: The South has the highest average state murder rate per million residents.

## Coding Review Script

Run:

```powershell
Rscript problem-sets/04-data-visualization-ggplot2/04-coding-bank-review.R
```

Expected output:

```text
04-C1 = DC
04-C2 = Europe
04-C3 = Male
04-C4 = Dataset 3
04-C5 = Oceania
04-C6 = South
```

## Instructor Audit Notes

- True/False items are easy to moderate and emphasize direct lecture concepts.
- Multiple-choice items are moderate and ask students to distinguish mappings, settings, geoms, facets, scales, and publication principles.
- Coding items are hard because they combine wrangling and visualization-data preparation, but each uses datasets and function patterns taught in Lectures 02-04.
- The coding prompts explicitly name functions students should revise before attempting each question.
- Do not assess font registration, detailed theme internals, exact palette hex values, or file-import mechanics from the hidden setup.
