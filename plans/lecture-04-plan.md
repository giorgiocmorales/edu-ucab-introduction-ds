# Lecture 04 Plan: Data Visualization with ggplot2

## Purpose

Lecture 04 should introduce data visualization as the next step after students
have learned R basics, tidy tables, wrangling, joins, importing, and cleaning.
The lecture should teach students to build `ggplot2` graphics incrementally and
to judge whether a plot supports a fair comparison.

Central takeaway:

> A plot is built from data, mappings, geoms, scales, and layers. Once data is
> tidy enough to analyze, this grammar lets us explore relationships,
> distributions, comparisons, and change over time without rewriting the whole
> analysis for every new question.

The current Lecture 04 folder already exists:

- `lectures/04-data-visualization-ggplot2/assets/`
- `lectures/04-data-visualization-ggplot2/handouts/11_ggplot2_basics.R`

There is no `slides.qmd` yet. The build should create `slides.qmd` and revise
the handout only as needed so it exactly mirrors the final slide examples.

## Alignment With Lectures 01, 02, and 03

Lecture 04 should feel like a continuation of the first three lectures, not a
separate visualization module.

- Lecture 01 introduced RStudio, functions, objects, vectors, data frames,
  packages, `murders`, sorting, indexing, and rates. Lecture 04 should reuse
  `dslabs::murders`, plot objects, function arguments, and rates.
- Lecture 02 introduced the `tidyverse`, pipes, `dplyr`, `gapminder`,
  `filter()`, `mutate()`, `summarise()`, `group_by()`, and reshaping. Lecture
  04 should pipe prepared tables into `ggplot()` and use tidy data as the
  reason `ggplot2` mappings work naturally.
- Lecture 03 introduced multi-table data, importing, cleaning text, parsing
  numbers, and fixing keys. Lecture 04 should explicitly say: after the table is
  usable, plots are how we inspect patterns, detect misleading summaries, and
  decide the next question.

Keep the same scaffold used by Lectures 02 and 03:

- begin and end with `## Main Message {.main-message}`;
- use `#` for major sections and `##` for slides;
- include regular `## Intervention Space {.intervention-slide}` checks with
  hidden answers;
- introduce concepts in prose before code;
- show code in short, progressive blocks;
- mirror all runnable examples in handout `11_ggplot2_basics.R`;
- avoid local styling overrides.

## Source Materials Reviewed

### Irizarry, Introduction to Data Science

Relevant PDF sections:

- Chapter 7, introduction to data visualization;
- Chapter 8, `ggplot2`;
- Chapter 9, visualizing data distributions;
- Chapter 10, data visualization in practice;
- Chapter 11, data visualization principles.

Useful content:

- visualization as exploratory analysis after data preparation;
- `ggplot()` objects;
- geometries;
- aesthetic mappings with `aes()`;
- layers with `+`;
- global versus local mappings;
- scales and labels;
- annotations and reference lines;
- the `murders` plot built layer by layer;
- `gapminder` scatterplots, faceting, time series, and labels;
- distributions with histograms, densities, boxplots, and jittered data;
- principles: include zero for bars when length encodes magnitude, avoid
  distorted quantities, order categories by meaning, show the data, use common
  axes, and think about color accessibility.

Use Irizarry as the main conceptual and sequencing reference. Do not try to
cover all of Chapters 9 to 11 in depth; keep this lecture introductory.

### Lambert Grammar Transcript

Relevant file:

- `references/lambert_grammar of graphics.txt`

Useful content:

- grammar of graphics as a flexible framework for rich data;
- `ggplot2` syntax can feel indirect at first, but the structure pays off when
  grouping, layering, and faceting;
- traditional plotting often requires repeated commands and wide data for
  grouped displays;
- `ggplot2` works naturally with long data by mapping variables to aesthetics;
- aesthetics are row-wise mappings from data values to visual features;
- geoms decide how those mappings become marks;
- layers inherit global aesthetics unless overridden locally;
- facets are another way to add dimensions without manually repeating plots;
- visual exploration is iterative: many intermediate plots are imperfect, but
  small changes can quickly improve the display.

Use the transcript as explanatory support, especially for the early grammar
section and for why tidy data from Lecture 02 matters.

### Legacy Script 14: Intro to ggplot2

Relevant file:

- `legacy/original-scripts/14_intro-ggplot2.R`

Treat this as the main procedural source for the first half of Lecture 04.

Coverage to preserve in essence:

- load `tidyverse`, `dslabs`, `ggplot2`;
- load `murders`;
- introduce the components of a `ggplot2` plot: data, aesthetic mapping, and
  geoms;
- create an empty plot with `ggplot(data = murders)`;
- pipe data into `ggplot()`;
- store a plot object and inspect its class;
- add `geom_point()` for population versus total murders;
- add `geom_text()` with state abbreviations;
- adjust constants such as `size` and `nudge_x`;
- move repeated mappings into a global `aes()`;
- demonstrate local mappings overriding global mappings;
- transform skewed scales with `scale_x_log10()` and `scale_y_log10()`;
- add labels and a title with `labs()` or equivalent;
- distinguish fixed color outside `aes()` from mapped color inside `aes()`;
- compute the national murder rate and add a reference line with
  `geom_abline()`;
- modify legend title;
- optionally add one `geom_smooth()` trend line.

Adaptation:

- Avoid adding `ggthemes` as a new required dependency unless already required
  by setup. Use `theme_minimal()` or shared defaults instead of
  `theme_economist()`.
- Prefer `labs()` over older `xlab()`, `ylab()`, and `ggtitle()` once the
  concept is clear.

### Legacy Script 14_lambert: Grammar Lesson

Relevant file:

- `legacy/original-scripts/14_lambert_lesson.R`

Coverage to preserve in essence:

- compare base plotting and `ggplot2`;
- show why grouped color is easier with long/tidy data;
- map color by a grouping variable;
- map shape by a grouping variable;
- compare group-specific regression lines with an overall regression line;
- use a tiny toy dataset to show how the same `aes(x, y, label)` can produce
  different visuals through different geoms;
- demonstrate `geom_point()`, `geom_text()`, `geom_col()`, `geom_line()`,
  `geom_jitter()`, and `geom_smooth()`;
- show that layer order affects visibility;
- show axis transformations such as square-root scales.

Adaptation:

- Do not depend on the original local suicide CSV. Recreate the Lambert logic
  with course-safe data:
  - use `murders` for the base-versus-ggplot comparison;
  - use a small `toy_geom` tibble for geoms;
  - use filtered `gapminder` for grouped color, shape, and smooths.

### Legacy Script 16: Gapminder Visualization

Relevant file:

- `legacy/original-scripts/16_viz-gapminder.R`

Coverage to preserve in essence:

- use `gapminder`;
- begin with a misconception or prior-belief prompt;
- compare infant mortality for selected country pairs;
- build a small comparison table;
- plot fertility versus life expectancy;
- add threshold lines;
- map continent to color;
- compare years with `facet_grid()` and `facet_wrap()`;
- keep axes common when comparison depends on position;
- show time series for one country with points and lines;
- show multiple countries and explain grouping;
- use color to group lines automatically;
- replace legends with direct labels where feasible;
- compute dollars per day from GDP and population;
- compare raw versus log-transformed income distributions;
- transform a scale rather than permanently transforming the displayed
  variable when audience interpretation matters.

Adaptation:

- Keep the Rosling/worldview case study focused. It should teach faceting,
  time series, labels, and transformations rather than becoming a full global
  development lecture.
- Prefer current years used in the legacy script only where available in
  `dslabs::gapminder`; confirm exact years while drafting.

### Legacy Script 17: Visualization Principles

Relevant file:

- `legacy/original-scripts/17_principles-dataviz.R`

Coverage to preserve in essence:

- compare pie/donut charts against tables or bar charts;
- show why bar charts should generally start at zero;
- show how truncated axes distort visual differences;
- show area or size distortion;
- sort categories by a meaningful value with `reorder()`;
- use `coord_flip()` for long category labels;
- show raw data with jitter rather than only summaries;
- use common axes across facets when comparing distributions;
- align plots according to the comparison being made;
- use boxplots as compact summaries but retain awareness of hidden data;
- use color to make comparisons easier;
- include color-blind-friendly palette guidance.

Adaptation:

- Use this twice: first as a conceptual principles section before syntax, then
  as a shorter return-to-principles section after students can read the
  `ggplot2` code. Keep examples short because the lecture's main goal is first
  `ggplot2` fluency.
- Do not overuse `gridExtra`; prefer facets and single-plot examples for first
  exposure.

### Existing Lecture 04 Assets and Handout

Existing assets:

- `facet_grid_wrap.png`
- `bg_runrunes_1.jpg`
- `bg_talcual_1.jpeg`
- `bg_talcual_2.jpeg`
- `gg_nyc.jpg`
- `gg_te_1.png`
- `gg_te_2.png`
- `gg_te_3.png`
- `gg_vc_hubble.png`
- `gg_vc_nukes.png`
- `gg_vc_traffic.png`

The `bg_*` files should be treated as bad-graph examples and the `gg_*` files
as good-graph examples unless visual inspection during drafting shows a
different use. They should be used for short visual diagnosis prompts: what is
hard to compare, what cue is being distorted, what changed in the improved
version, and which principle explains the improvement. `facet_grid_wrap.png`
can support the first conceptual explanation of faceting.

Existing handout:

- `lectures/04-data-visualization-ggplot2/handouts/11_ggplot2_basics.R`

The handout already covers most of the requested material: Anscombe, grammar
of graphics, Lambert-style geoms and grouped mappings, a polished `murders`
plot, `gapminder` facets/time series/distributions, and visualization
principles. When drafting slides, use the handout as a starting implementation,
but revise it after the slides so it remains an exact runnable mirror.

## Proposed Lecture Arc

Preferred flow:

1. principles of data visualization;
2. logic of the grammar of graphics;
3. the full `ggplot2` build sequence;
4. facets, time, and transformations.

This order matters pedagogically. Students should first see why visual design
choices matter, then learn why a grammar helps control those choices, and only
then walk through the full `ggplot2` tool suite.

### 1. Main Message

Goal:

- position visualization as the bridge from prepared data to insight.

Slides:

- opening `## Main Message {.main-message}`;
- why a table is not enough;
- how Lecture 04 connects to wrangling and cleaning.

Core message:

- wrangling makes data usable;
- visualization makes structure visible;
- `ggplot2` gives a grammar for changing plots one layer at a time.

### 2. Principles Before Syntax

Goal:

- motivate plotting and visual judgment before teaching syntax.

Slides:

- visual summaries can mislead when the visual cue does not match the
  comparison;
- position and aligned length are usually easier to compare than angle, area,
  or volume;
- bars need a meaningful baseline when length encodes magnitude;
- categories should be ordered by a meaningful value when order carries the
  message;
- common axes are part of the comparison, not decoration;
- show the underlying data when summaries hide important structure;
- use color to encode a useful distinction, not as decoration;
- use the existing `bg_*` and `gg_*` assets as short diagnosis prompts;
- what a plot can reveal: relationship, distribution, comparison, time,
  outliers, and possible data problems.

The principles should be taught conceptually first. Do not start this section
with `ggplot2` syntax.

Asset prompts:

- show one `bg_*` image and ask what comparison the graph makes difficult;
- show the paired or related `gg_*` image and ask which change improves the
  comparison;
- use the answer to name the principle before any code appears.

Anscombe sequence:

1. Create Anscombe's quartet from `datasets::anscombe` in R.
2. Compute and display the summary statistics for each dataset:
   - mean of `x`;
   - mean of `y`;
   - standard deviation of `x`;
   - standard deviation of `y`;
   - correlation between `x` and `y`;
   - simple regression intercept and slope.
3. Add an intervention slide: "If these summaries are almost the same, should
   we expect the data patterns to be the same?"
4. Then show the plots created in R with `ggplot2`, using facets.
5. Use the reveal as the conceptual reason for the lecture: summaries are not a
   substitute for seeing structure.

Code:

- `datasets::anscombe`;
- `pivot_longer()`;
- `group_by()` and `summarise()` for summary statistics;
- `cor()`;
- `lm()` or a compact helper for slope/intercept;
- `geom_point()`;
- `geom_smooth(method = "lm", se = FALSE)`;
- `facet_wrap(~ set)`.

Intervention:

- ask what a table of means/correlations would miss.

### 3. The Logic of Grammar of Graphics

Goal:

- teach the mental model before expanding the code.

Slides:

- data, mapping, geom, scale, layer;
- base `plot()` versus `ggplot2`;
- tidy/long data makes grouped plots easier;
- `aes()` maps variables to visual features;
- constants outside `aes()` set a visual feature for every mark;
- grammar of graphics lets us change one design decision at a time:
  the data, the mapping, the geom, the scale, or the facet.

Code sequence:

- base `plot(murders$population, murders$total)`;
- `ggplot(data = murders)`;
- `murders %>% ggplot()`;
- store `p_blank <- ggplot(data = murders)`;
- `class(p_blank)`;
- add `geom_point(aes(x = population / 10^6, y = total))`.

Intervention:

- ask whether `color = "steelblue"` belongs inside or outside `aes()`.

### 4. Build One Plot Layer by Layer

Goal:

- reproduce the core Lecture 14 and Irizarry Chapter 8 progression.
- end with a polished, modern, aesthetically pleasant plot in the spirit of
  The Economist, without adding a fragile dependency unless the project already
  supports it.

Slides:

- scatter plot of population and total murders;
- add labels with `geom_text()`;
- adjust `size` and `nudge_x`;
- use global mappings;
- local mapping/data for one annotation;
- log scales for skewed variables;
- labels with `labs()`;
- mapped color by region;
- national murder-rate reference line;
- final readable plot.

Layout rule:

- use two-column slides for `ggplot2` examples whenever code produces a plot:
  the left column shows short code, the right column shows the rendered plot;
- keep code fragments small enough that the plot remains visible;
- if a function appears for the first time, add one short explanatory sentence
  before the code.

First-use explanations:

- `ggplot()` initializes a plot object linked to a data frame.
- `aes()` maps variables in the data to visual features such as position,
  color, shape, or labels.
- `geom_point()` draws one point for each row after the x and y mappings are
  known.
- `geom_text()` draws text labels from a mapped label variable.
- `scale_x_log10()` and `scale_y_log10()` change how positions are displayed on
  skewed axes.
- `labs()` writes audience-facing labels for titles, subtitles, axes, legends,
  and captions.
- `geom_abline()` adds a straight reference line, useful for benchmarks.
- `geom_smooth()` adds a fitted trend line.

Code sequence:

- `p_murders <- murders %>% ggplot(aes(...))`;
- `geom_point()`;
- `geom_text()`;
- `scale_x_log10()`;
- `scale_y_log10()`;
- `labs()`;
- `geom_abline(intercept = log10(national_rate), slope = 1)`;
- `scale_color_manual()` only if a stable palette is needed.

Polish target:

- final plot should use restrained colors, readable labels, a subtitle, a
  caption/source note, a clear legend title, and minimal chart clutter;
- aim for a modern Economist-like presentation using `theme_minimal()` plus
  local theme tweaks or a hand-coded palette;
- avoid `ggthemes::theme_economist()` unless setup already includes `ggthemes`
  or the lecture deliberately adds that package to `scripts/setup_project.R`.

Intervention:

- ask why the reference line needs a log-scale intercept.

### 5. Aesthetics and Geoms as Separate Choices

Goal:

- preserve the Lambert lesson's core insight that mappings and geoms are
  different decisions.

Slides:

- same data, different geoms;
- point, text, column, line, jitter;
- layer order;
- grouped versus overall smooths.

Code:

- `toy_geom` with `x`, `y`, `label`;
- `geom_point()`;
- `geom_text()`;
- `geom_col()`;
- `geom_line() + geom_point()`;
- `geom_jitter()`;
- filtered `gapminder` for `geom_smooth()` by country versus one overall
  smooth.

Intervention:

- ask which geom fits a relationship, a category total, and a time trend.

### 6. Facets, Time, and Transformations With Gapminder

Goal:

- move from one polished scatter plot to exploratory comparisons over groups
  and time.
- introduce facets after students understand mappings, geoms, layers, and
  scales.

Slides:

- use `facet_grid_wrap.png` or a simple R-created diagram to explain that
  faceting splits one data frame into repeated panels;
- misconception prompt inspired by Rosling;
- small infant mortality comparison table;
- fertility versus life expectancy in one year;
- add threshold lines;
- color by continent;
- compare years with `facet_grid()`;
- compare many years with `facet_wrap()`;
- why fixed axes matter;
- time series for one country;
- multiple countries, grouping, and color;
- direct labels instead of a legend;
- income distributions and log scales.

Code:

- `data(gapminder)`;
- `filter(year == ...)`;
- `select()`, `inner_join()`, `arrange()` for the comparison table;
- `geom_point()`;
- `geom_vline()` and `geom_hline()`;
- `facet_grid(continent ~ year)`;
- `facet_wrap(~ year)`;
- `geom_line()`;
- `geom_text(data = labels, ...)`;
- `mutate(dollars_per_day = gdp / population / 365)`;
- `geom_histogram()`;
- `scale_x_continuous(trans = "log2")`.

Intervention:

- ask why free axes across facets could hide the size of a change.

### 7. Return To Applied Visualization Principles

Goal:

- revisit the opening principles now that students can read and write the
  `ggplot2` code that implements them.

Slides:

- pie/donut versus bar or table;
- bars and zero;
- truncated axes;
- sorting categories;
- size/area distortion;
- show the data with jitter;
- common axes for distribution comparisons;
- color as a comparison tool, not decoration;
- color accessibility.
- include selected `bg_*` and `gg_*` assets again as diagnosis checks after
  the code examples, so students connect principle, code, and visual result.

Code:

- `browsers` toy data with `geom_col()` and optional `coord_polar()`;
- `tax_rates` or `border_apprehensions` with truncated and corrected axes;
- `murders %>% mutate(murder_rate = total / population * 100000)`;
- `reorder(state, murder_rate)`;
- `coord_flip()`;
- `heights` with `geom_boxplot()` and `geom_jitter()`;
- `facet_grid(. ~ sex)` with fixed axes;
- manual color-blind-friendly palette.

Intervention:

- ask which chart is misleading and what visual cue causes the problem.

### 8. Practice and Closing Message

Goal:

- end with a compact synthesis and one runnable student task.

Practice prompt:

- using `gapminder`, make a boxplot of 2015 income in dollars per day by
  continent, use a log2 y-scale, and order continents by median income.

Closing `## Main Message {.main-message}`:

- data visualization is an iterative conversation with the data;
- in `ggplot2`, changing the question usually means changing a mapping, geom,
  scale, layer, or facet, not starting over.

## Source-Coverage Checklist

Required for the first draft:

- [ ] Start and end with `Main Message`.
- [ ] Include a transition from Lectures 01 to 03.
- [ ] Use `murders` for the first `ggplot2` build.
- [ ] Include `ggplot(data = ...)`, piped `ggplot()`, plot objects, and
  `class()`.
- [ ] Explain `aes()` before using several aesthetics.
- [ ] Distinguish mapped aesthetics inside `aes()` from constants outside
  `aes()`.
- [ ] Include `geom_point()`, `geom_text()`, `geom_col()`, `geom_line()`,
  `geom_jitter()`, `geom_smooth()`, and `geom_abline()`.
- [ ] Include global and local mappings.
- [ ] Include layer order.
- [ ] Include log scale transformations.
- [ ] Include labels with `labs()`.
- [ ] Include color by region or continent.
- [ ] Include a national-rate reference line for `murders`.
- [ ] Include the Lambert toy-geom example.
- [ ] Include group-specific versus overall smooths.
- [ ] Include `gapminder` fertility/life-expectancy scatterplots.
- [ ] Include `facet_grid()` and `facet_wrap()`.
- [ ] Include a time-series line example.
- [ ] Include direct labels for a multi-line time series.
- [ ] Include income distributions with log transformation.
- [ ] Include visualization principles from legacy script 17.
- [ ] Include at least four intervention slides.
- [ ] Ensure handout `11_ggplot2_basics.R` mirrors the final slide examples.
- [ ] Render `lectures/04-data-visualization-ggplot2/slides.qmd`.

Optional or deferred:

- [ ] Use existing Lecture 04 images if they directly support a principle.
- [ ] Include `coord_polar()` only as a brief critique example.
- [ ] Defer geospatial visualization.
- [ ] Defer `qplot()`.
- [ ] Defer `ggrepel`, `ggthemes`, `gridExtra`, and other add-on packages
  unless they are already required elsewhere.
- [ ] Defer deep visual-perception theory and advanced statistical graphics.

## Implementation Notes

Suggested file work:

1. Create `lectures/04-data-visualization-ggplot2/slides.qmd` from
   `lectures/_templates/lecture-slides.qmd`.
2. Use the existing `handouts/11_ggplot2_basics.R` as the initial code source.
3. As slides are drafted, delete or move any handout code that is not shown in
   slides unless it is needed only for setup.
4. Keep hidden setup chunks short and use `#| include: false`.
5. If no new packages beyond `tidyverse` and `dslabs` are used, do not change
   `scripts/setup_project.R`.
6. If a new package becomes necessary, update `scripts/setup_project.R` in the
   same pass and document why.

Render check:

```powershell
quarto render lectures/04-data-visualization-ggplot2/slides.qmd
```

Expected output:

- normal Quarto output remains `slides.html`;
- no rendered files, cache folders, or `slides_files/` should remain inside
  the lecture source folder if they are not part of source.

## Review Risks

- The topic can become too large. Keep Lecture 04 focused on introductory
  `ggplot2` fluency and immediate design judgment.
- The existing handout is long. The final handout should mirror the lecture
  flow, but the slide deck should not become a script dump.
- Lambert's original suicide-data example depends on unavailable local data.
  Adapt the lesson to `murders`, `gapminder`, and toy data.
- Legacy script 17 contains several principles examples. Select only the ones
  that reinforce the first visualization lecture.
- Avoid adding packages for polish if base `ggplot2` and existing course
  dependencies can teach the same idea.
