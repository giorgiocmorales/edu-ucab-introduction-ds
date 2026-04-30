# Lecture 04 - Introduction to Data Science
# Handout 11: data visualization with ggplot2

# PACKAGES ---------------------------------------------------------------

library(tidyverse)
library(dslabs)

roboto_regular <- file.path(
  Sys.getenv("LOCALAPPDATA"),
  "Microsoft/Windows/Fonts/RobotoCondensed-Regular.ttf"
)

roboto_bold <- file.path(
  Sys.getenv("LOCALAPPDATA"),
  "Microsoft/Windows/Fonts/RobotoCondensed-Bold.ttf"
)

if (file.exists(roboto_regular) &&
    requireNamespace("sysfonts", quietly = TRUE) &&
    requireNamespace("showtext", quietly = TRUE)) {
  sysfonts::font_add(
    family = "Roboto Condensed",
    regular = roboto_regular,
    bold = if (file.exists(roboto_bold)) roboto_bold else roboto_regular
  )
  showtext::showtext_auto()
}

# DATA -------------------------------------------------------------------

data(murders)
data(gapminder)
data(heights)


# SEEING BEFORE SUMMARIZING ---------------------------------------------

anscombe_long <- datasets::anscombe %>%
  as_tibble() %>%
  pivot_longer(
    cols = everything(),
    names_to = c(".value", "set"),
    names_pattern = "(.)(.)"
  ) %>%
  mutate(set = paste("Dataset", set))

head(anscombe_long)

anscombe_summary <- anscombe_long %>%
  group_by(set) %>%
  summarise(
    mean_x = mean(x),
    mean_y = mean(y),
    sd_x = sd(x),
    sd_y = sd(y),
    correlation = cor(x, y),
    intercept = coef(lm(y ~ x))[1],
    slope = coef(lm(y ~ x))[2],
    .groups = "drop"
  ) %>%
  mutate(across(.cols = where(is.numeric), .fns = \(x) round(x, 2)))

anscombe_summary

suicide_master <- read_csv(
  file = here::here("data/raw/master.csv"),
  show_col_types = FALSE
) %>%
  rename(suicides_per_100k = `suicides/100k pop`) %>%
  mutate(
    age = fct_relevel(
      .f = age,
      "5-14 years",
      "15-24 years",
      "25-34 years",
      "35-54 years",
      "55-74 years",
      "75+ years"
    )
  )

suicide_master %>%
  select(country, year, sex, age, suicides_no, population, suicides_per_100k) %>%
  head(8)

suicide_country_rates <- suicide_master %>%
  group_by(country) %>%
  summarise(
    suicides_per_100k = mean(suicides_per_100k, na.rm = TRUE),
    .groups = "drop"
  ) %>%
  arrange(suicides_per_100k) %>%
  filter(suicides_per_100k > 0)

selected_lambert_countries <- suicide_country_rates[c(10, 40, 41, 98, 99), ] %>%
  pull(country)

selected_lambert_countries

lambert_suicide <- suicide_master %>%
  filter(country %in% selected_lambert_countries) %>%
  select(country, year, age, sex, suicides_no, population, suicides_per_100k)

lambert_suicide_wide <- lambert_suicide %>%
  select(country, year, age, sex, suicides_no, population) %>%
  pivot_wider(
    values_from = c(population, suicides_no),
    names_from = sex,
    id_cols = c(country, year, age)
  )

head(lambert_suicide_wide)

anscombe_long %>%
  ggplot(aes(x = x, y = y)) +
  geom_point(color = "steelblue", size = 2.5) +
  geom_smooth(method = "lm", se = FALSE, color = "gray35") +
  facet_wrap(~ set) +
  labs(x = "x", y = "y")


# GRAMMAR OF GRAPHICS ----------------------------------------------------

# Traditional plotting draws one group, then overlays another
plot(
  lambert_suicide_wide$population_male,
  lambert_suicide_wide$suicides_no_male,
  col = "red",
  pch = 19,
  xlab = "Population",
  ylab = "Suicides"
)

points(
  lambert_suicide_wide$population_female,
  lambert_suicide_wide$suicides_no_female,
  col = "blue",
  pch = 19
)

# Grammar of graphics maps the group directly
ggplot(
  lambert_suicide,
  aes(x = population,
      y = suicides_no,
      colour = sex)
) +
  geom_point() +
  labs(x = "Population",
       y = "Suicides",
       colour = "Sex")

p_blank <- ggplot(data = murders)
class(p_blank)


# GEOMS AND MAPPINGS -----------------------------------------------------

p_blank +
  geom_point(
    aes(population / 10^6, total),
    size = 3,
    color = "steelblue"
  ) +
  labs(x = "Population",
       y = "Total murders")

# Colour by country
lambert_suicide %>%
  ggplot(aes(x = population,
             y = suicides_no,
             colour = country)) +
  geom_point(alpha = 0.7) +
  labs(x = "Population",
       y = "Suicides",
       colour = "Country")

# Shape by country
lambert_suicide %>%
  ggplot(aes(x = population,
             y = suicides_no,
             shape = country)) +
  geom_point(size = 2.5, alpha = 0.7) +
  labs(x = "Population",
       y = "Suicides",
       shape = "Country")

# Toy data used for geom examples
toy_geom <- tibble(
  x = c(1, 2, 3),
  y = c(2, 4, 10),
  label = c("a", "b", "c")
)

toy_geom

ggplot(data = toy_geom, mapping = aes(x = x, y = y, label = label)) +
  geom_point(mapping = NULL, size = 3)

ggplot(data = toy_geom, mapping = aes(x = x, y = y, label = label)) +
  geom_text(mapping = NULL, size = 8)

ggplot(data = toy_geom, mapping = aes(x = x, y = y, label = label)) +
  geom_col(mapping = NULL, fill = "steelblue") +
  labs(x = "x", y = "y")

ggplot(data = toy_geom, mapping = aes(x = x, y = y, label = label)) +
  geom_line(mapping = NULL, color = "gray35") +
  geom_point(size = 3, color = "steelblue")

ggplot(data = toy_geom, mapping = aes(x = x, y = y, label = label)) +
  geom_smooth(method = "lm", formula = y ~ x, se = FALSE) +
  geom_jitter(mapping = NULL, width = 0.08, height = 0, size = 3)

lambert_suicide %>%
  ggplot(aes(x = population,
             y = suicides_no,
             color = country)) +
  geom_point(alpha = 0.3) +
  geom_smooth(method = "lm",
              formula = y ~ x,
              se = FALSE) +
  labs(x = "Population",
       y = "Suicides")

lambert_suicide %>%
  ggplot(aes(x = population,
             y = suicides_no)) +
  geom_smooth(method = "lm",
              formula = y ~ x,
              se = FALSE,
              color = "black") +
  geom_point(aes(color = country), alpha = 0.35) +
  labs(x = "Population",
       y = "Suicides")

# Layer order matters
lambert_suicide %>%
  ggplot(aes(x = population,
             y = suicides_no)) +
  geom_point(aes(colour = country), alpha = 1) +
  geom_smooth(method = "lm", se = FALSE, colour = "black")

lambert_suicide %>%
  ggplot(aes(x = population,
             y = suicides_no)) +
  geom_smooth(method = "lm", se = FALSE, colour = "black") +
  geom_point(aes(colour = country), alpha = 1)

# Axis scale transformations
lambert_suicide %>%
  ggplot(aes(x = population,
             y = suicides_no,
             colour = country)) +
  geom_point(alpha = 0.3) +
  scale_x_sqrt() +
  scale_y_sqrt()


# BUILDING A PLOT --------------------------------------------------------

murders %>%
  select(state, abb, region, population, total) %>%
  head(8)

p_blank +
  geom_point(
    aes(population / 10^6, total),
    color = "steelblue"
  ) +
  geom_text(
    aes(population / 10^6, total, label = abb),
    size = 3
  ) +
  labs(x = "Population in millions",
       y = "Total murders")

p_murders <- murders %>%
  ggplot(aes(x = population / 10^6, y = total, label = abb))

p_murders +
  geom_point(size = 3, color = "steelblue") +
  geom_text(nudge_x = 1.5, size = 3) +
  labs(x = "Population in millions",
       y = "Total murders")

p_murders +
  geom_point(size = 3, color = "steelblue") +
  geom_text(nudge_x = 0.05, size = 3) +
  scale_x_log10() +
  scale_y_log10() +
  labs(x = "Population in millions",
       y = "Total murders")

p_murders +
  geom_point(aes(color = region), size = 3) +
  geom_text(nudge_x = 0.05, size = 3) +
  scale_x_log10() +
  scale_y_log10() +
  labs(
    title = "US gun murders in 2010",
    x = "Population in millions (log scale)",
    y = "Total murders (log scale)",
    color = "Region"
  )

national_rate <- murders %>%
  summarise(murder_rate = sum(total) / sum(population) * 10^6) %>%
  pull(murder_rate)

p_murders +
  geom_abline(
    intercept = log10(national_rate),
    slope = 1,
    linetype = "dashed",
    color = "gray45"
  ) +
  geom_point(aes(color = region), size = 3) +
  geom_text(nudge_x = 0.05, size = 3) +
  scale_x_log10() +
  scale_y_log10() +
  labs(x = "Population in millions (log scale)",
       y = "Total murders (log scale)",
       color = "Region")

p_economist_base <- p_murders +
  geom_abline(
    intercept = log10(national_rate),
    slope = 1,
    linetype = "dashed",
    color = "#5f6468",
    linewidth = 0.8
  ) +
  geom_point(
    mapping = aes(color = region),
    size = 4,
    alpha = 0.9
  ) +
  geom_text(
    nudge_x = 0.045,
    size = 3.8,
    color = "gray8"
  )

p_economist_base +
  scale_x_log10() +
  scale_y_log10() +
  labs(x = "Population in millions (log scale)",
       y = "Total murders (log scale)",
       color = "Region")

p_economist_base

economist_colors <- c(
  "Northeast" = "#17648d",
  "South" = "#51bec7",
  "North Central" = "#008c8f",
  "West" = "#d6ab63"
)

p_economist_scaled <- p_economist_base +
  scale_x_log10(
    breaks = c(0.5, 1, 2, 5, 10, 20, 40),
    labels = function(x) paste0(x, "M")
  ) +
  scale_y_log10(
    breaks = c(1, 10, 100, 1000),
    labels = c("1", "10", "100", "1,000"),
    position = "right"
  )

p_economist_scaled

p_economist_palette <- p_economist_scaled +
  scale_color_manual(
    values = economist_colors,
    name = NULL
  )

p_economist_palette

bg_col_beige <- "#f1f0e9"

p_economist <- p_economist_palette +
  labs(
    title = "Population explains much of the count, but not all of it",
    subtitle = "US firearm homicides by state, 2010; log scales",
    x = "Population in millions, log scale",
    y = "Total murders, log scale",
    caption = "Source: dslabs::murders."
  ) +
  theme_minimal(base_family = "Roboto Condensed") +
  theme(
    aspect.ratio = 4.1 / 7,
    plot.margin = margin(t = 0, r = 0.5, b = 0, l = 0.5, unit = "cm"),
    plot.background = element_rect(fill = bg_col_beige, color = NA),
    panel.background = element_rect(fill = bg_col_beige, color = NA),
    panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank(),
    panel.grid.major.y = element_line(color = "#dcdbd8"),
    panel.grid.minor.y = element_blank(),
    legend.text = element_text(margin = margin(l = 3)),
    legend.position = c(0.22, 0.80),
    legend.title = element_blank(),
    legend.key.width = unit(32, "pt"),
    legend.key.height = unit(20, "pt"),
    legend.key = element_rect(fill = bg_col_beige, color = NA),
    axis.text = element_text(color = "gray8"),
    axis.title = element_text(color = "gray8"),
    axis.line.x = element_line(color = "gray8"),
    axis.ticks.y = element_blank(),
    plot.title = element_text(hjust = 0, face = "bold"),
    plot.subtitle = element_text(colour = "#4B4B4B"),
    plot.caption = element_text(hjust = 0, colour = "#4B4B4B")
  )

p_economist


# FACETS, TIME, AND TRANSFORMATIONS --------------------------------------

gapminder %>%
  select(country, year, continent, population, fertility, life_expectancy, gdp) %>%
  head(8)

gap_1962 <- gapminder %>%
  filter(year == 1962, !is.na(fertility), !is.na(life_expectancy))

gap_facet <- gapminder %>%
  filter(!is.na(fertility), !is.na(life_expectancy))

gap_years <- c(1960, 2015)
facet_years <- c(1960, 1970, 1980, 1990, 2000, 2015)
facet_continents <- c("Europe", "Asia")
line_countries <- c("South Korea", "Germany")

line_labels <- tibble(
  country = line_countries,
  x = c(1975, 1965),
  y = c(60, 72)
)

income_gap <- gapminder %>%
  mutate(dollars_per_day = gdp / population / 365)

comp_table <- tibble(
  comparison = rep(1:5, each = 2),
  country = c(
    "Sri Lanka", "Turkey", "Poland", "South Korea", "Malaysia",
    "Russia", "Pakistan", "Vietnam", "Thailand", "South Africa"
  )
)

infant_table <- gapminder %>%
  filter(year == 2015) %>%
  select(country, infant_mortality) %>%
  mutate(country = as.character(country)) %>%
  inner_join(comp_table, by = "country") %>%
  arrange(comparison, country) %>%
  select(comparison, country, infant_mortality)

infant_table

gap_1962 %>%
  ggplot(aes(x = fertility,
             y = life_expectancy)) +
  geom_point(color = "steelblue") +
  labs(x = "Fertility",
       y = "Life expectancy")

gap_1962 %>%
  ggplot(aes(x = fertility,
             y = life_expectancy,
             color = continent)) +
  geom_point(alpha = 0.8) +
  geom_vline(xintercept = 5,
             linetype = "dashed",
             color = "gray40") +
  geom_hline(yintercept = 55,
             linetype = "dashed",
             color = "gray40") +
  labs(x = "Fertility",
       y = "Life expectancy",
       color = "Continent")

gap_facet %>%
  filter(year %in% gap_years) %>%
  ggplot(aes(x = fertility,
             y = life_expectancy,
             color = continent)) +
  geom_point(alpha = 0.65,
             show.legend = FALSE,
             size = 1.4) +
  facet_grid(continent ~ year) +
  labs(x = "Fertility",
       y = "Life expectancy")

gap_facet %>%
  filter(year %in% facet_years,
         continent %in% facet_continents) %>%
  ggplot(aes(x = fertility,
             y = life_expectancy,
             color = continent)) +
  geom_point(alpha = 0.7) +
  facet_wrap(~ year) +
  labs(x = "Fertility",
       y = "Life expectancy")

gapminder %>%
  filter(country == "United States",
         !is.na(fertility)) %>%
  ggplot(aes(x = year, y = fertility)) +
  geom_point(color = "steelblue") +
  geom_line(color = "steelblue") +
  labs(x = "Year", y = "Fertility")

gapminder %>%
  filter(country %in% line_countries,
         !is.na(fertility)) %>%
  ggplot(aes(x = year,
             y = fertility,
             color = country)) +
  geom_line(linewidth = 1) +
  labs(x = "Year",
       y = "Fertility",
       color = "Country")

gapminder %>%
  filter(country %in% line_countries,
         !is.na(life_expectancy)) %>%
  ggplot(aes(x = year,
             y = life_expectancy,
             color = country)) +
  geom_line(linewidth = 1) +
  geom_text(data = line_labels,
            aes(x = x, y = y, label = country),
            size = 4,
            show.legend = FALSE) +
  theme(legend.position = "none") +
  labs(x = "Year", y = "Life expectancy")

# Raw scale
income_gap %>%
  filter(year == 1970, !is.na(gdp)) %>%
  ggplot(aes(x = dollars_per_day)) +
  geom_histogram(binwidth = 1,
                 color = "white",
                 fill = "gray55") +
  labs(x = "Dollars per day",
       y = "Countries") +
  theme_minimal()

# Log2 scale transformation
income_gap %>%
  filter(year == 1970, !is.na(gdp)) %>%
  ggplot(aes(x = dollars_per_day)) +
  geom_histogram(binwidth = 1,
                 color = "midnightblue",
                 fill = "lightblue") +
  scale_x_continuous(trans = "log2") +
  labs(x = "Dollars per day (log2 scale)",
       y = "Countries") +
  theme_minimal()

# Smaller histogram bins
income_gap %>%
  filter(year == 1970, !is.na(gdp)) %>%
  ggplot(aes(x = dollars_per_day)) +
  geom_histogram(binwidth = 0.5,
                 color = "white",
                 fill = "steelblue") +
  scale_x_continuous(trans = "log2") +
  labs(x = "Dollars per day (log2 scale)",
       y = "Countries")

# Larger histogram bins
income_gap %>%
  filter(year == 1970, !is.na(gdp)) %>%
  ggplot(aes(x = dollars_per_day)) +
  geom_histogram(binwidth = 4,
                 color = "white",
                 fill = "steelblue") +
  scale_x_continuous(trans = "log2") +
  labs(x = "Dollars per day (log2 scale)",
       y = "Countries")


# APPLYING THE PRINCIPLES ------------------------------------------------

browsers <- tibble(
  Browser = rep(c("Opera", "Safari", "Firefox", "IE", "Chrome"), 2),
  Year = rep(c(2000, 2015), each = 5),
  Percentage = c(3, 21, 23, 28, 26, 2, 22, 21, 27, 29)
) %>%
  mutate(Browser = reorder(Browser, Percentage))

tax_rates <- tibble(
  date = c("Now", "Jan 1, 2013"),
  tax_rate = c(35, 39.6)
) %>%
  mutate(date = reorder(date, tax_rate))

bad_order_rates <- murders %>%
  mutate(murder_rate = total / population * 100000) %>%
  slice_max(murder_rate, n = 12)

gdp <- c(14.6, 5.7, 5.3, 3.3, 2.5)

gdp_data <- tibble(
  country = rep(c("United States", "China", "Japan", "Germany", "France"), 2),
  encoding = factor(
    rep(c("Radius", "Area"), each = 5),
    levels = c("Radius", "Area")
  ),
  gdp_index = c(gdp^2 / min(gdp^2), gdp / min(gdp))
) %>%
  mutate(country = reorder(country, gdp_index))

color_blind_friendly <- c(
  "#999999", "#E69F00", "#56B4E9", "#009E73",
  "#F0E442", "#0072B2", "#D55E00", "#CC79A7"
)

palette_demo <- tibble(
  x = 1:8,
  y = 1,
  col = factor(1:8)
)

principle_fill <- "#17648d"
principle_fill_alt <- "#51bec7"
principle_border <- "#333333"

principle_theme <- theme_minimal() +
  theme(
    panel.grid.minor = element_blank(),
    legend.position = "bottom"
  )

browsers %>%
  ggplot(aes(x = "",
             y = Percentage,
             fill = Browser)) +
  geom_col(color = "black") +
  coord_polar(theta = "y") +
  facet_grid(. ~ Year) +
  theme_void() +
  theme(legend.position = "bottom")

browsers %>%
  ggplot(aes(x = Browser,
             y = Percentage)) +
  geom_col(width = 0.55,
           fill = principle_fill,
           color = principle_border) +
  facet_grid(. ~ Year) +
  labs(x = "",
       y = "Percent using the browser") +
  principle_theme

tax_rates %>%
  ggplot(aes(x = date, y = tax_rate)) +
  geom_col(fill = principle_fill,
           color = principle_border,
           width = 0.55) +
  coord_cartesian(ylim = c(34, 40)) +
  labs(title = "Top Tax Rate If Bush Tax Cut Expires",
       x = "", y = "Top tax rate") +
  principle_theme

tax_rates %>%
  ggplot(aes(x = date, y = tax_rate)) +
  geom_col(fill = principle_fill,
           color = principle_border,
           width = 0.55) +
  labs(title = "Top Tax Rate If Bush Tax Cut Expires",
       x = "", y = "Top tax rate") +
  principle_theme

bad_order_rates %>%
  mutate(state = reorder(state, murder_rate)) %>%
  ggplot(aes(x = state, y = murder_rate)) +
  geom_col(mapping = NULL, fill = principle_fill, color = principle_border) +
  coord_flip() +
  labs(x = "",
       y = "Murders per 100,000 people") +
  principle_theme

gdp_data %>%
  ggplot(aes(x = country,
             y = encoding,
             size = gdp_index)) +
  geom_point(show.legend = FALSE,
             color = principle_fill,
             alpha = 0.75) +
  scale_size(range = c(2, 30)) +
  coord_flip() +
  labs(x = "", y = "") +
  principle_theme

heights %>%
  select(sex, height) %>%
  head(8)

heights %>%
  ggplot(aes(x = sex,
             y = height,
             color = sex)) +
  geom_boxplot(coef = 3,
               outlier.shape = NA,
               show.legend = FALSE) +
  geom_jitter(width = 0.1,
              alpha = 0.2,
              show.legend = FALSE) +
  labs(x = "", y = "Height in inches") +
  principle_theme

palette_demo %>%
  ggplot(aes(x = x, y = y, color = col)) +
  geom_point(size = 7) +
  scale_color_manual(values = color_blind_friendly) +
  principle_theme +
  theme(legend.position = "none")


# PRACTICE ---------------------------------------------------------------

gapminder %>%
  filter(year == 2011, !is.na(gdp)) %>%
  mutate(
    dollars_per_day = gdp / population / 365,
    continent = reorder(continent, dollars_per_day, FUN = median)
  ) %>%
  ggplot(aes(x = continent, y = dollars_per_day, fill = continent)) +
  geom_boxplot(show.legend = FALSE) +
  scale_y_continuous(trans = "log2") +
  labs(x = "", y = "Income in dollars per day") +
  principle_theme
