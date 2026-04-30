# Problem Set 04 - Coding bank review script
# Lecture 04: Data Visualization with ggplot2

# PACKAGES ---------------------------------------------------------------

library(tidyverse)
library(dslabs)


# DATA -------------------------------------------------------------------

data(murders)
data(gapminder)
data(heights)


# HELPERS ----------------------------------------------------------------

answer <- function(question, value) {
  cat(question, "=", as.character(value), "\n")
}


# CODING QUESTION 04-C1 --------------------------------------------------

q04_c1 <- murders %>%
  mutate(murder_rate = total / population * 10^6) %>%
  slice_max(murder_rate, n = 1, with_ties = FALSE) %>%
  pull(abb)

answer("04-C1", q04_c1)


# CODING QUESTION 04-C2 --------------------------------------------------

q04_c2 <- gapminder %>%
  filter(year == 2011, !is.na(gdp)) %>%
  mutate(dollars_per_day = gdp / population / 365) %>%
  group_by(continent) %>%
  summarise(median_income = median(dollars_per_day), .groups = "drop") %>%
  slice_max(median_income, n = 1, with_ties = FALSE) %>%
  pull(continent)

answer("04-C2", q04_c2)


# CODING QUESTION 04-C3 --------------------------------------------------

q04_c3 <- heights %>%
  group_by(sex) %>%
  summarise(median_height = median(height), .groups = "drop") %>%
  slice_max(median_height, n = 1, with_ties = FALSE) %>%
  pull(sex)

answer("04-C3", q04_c3)


# CODING QUESTION 04-C4 --------------------------------------------------

anscombe_long <- datasets::anscombe %>%
  as_tibble() %>%
  pivot_longer(
    cols = everything(),
    names_to = c(".value", "set"),
    names_pattern = "(.)(.)"
  ) %>%
  mutate(set = paste("Dataset", set))

q04_c4 <- anscombe_long %>%
  group_by(set) %>%
  summarise(max_y = max(y), .groups = "drop") %>%
  slice_max(max_y, n = 1, with_ties = FALSE) %>%
  pull(set)

answer("04-C4", q04_c4)


# CODING QUESTION 04-C5 --------------------------------------------------

q04_c5 <- gapminder %>%
  filter(year == 1962, !is.na(fertility), !is.na(life_expectancy)) %>%
  filter(fertility < 5) %>%
  group_by(continent) %>%
  summarise(avg_life_expectancy = mean(life_expectancy), .groups = "drop") %>%
  slice_max(avg_life_expectancy, n = 1, with_ties = FALSE) %>%
  pull(continent)

answer("04-C5", q04_c5)


# CODING QUESTION 04-C6 --------------------------------------------------

q04_c6 <- murders %>%
  mutate(murder_rate = total / population * 10^6) %>%
  group_by(region) %>%
  summarise(avg_state_rate = mean(murder_rate), .groups = "drop") %>%
  slice_max(avg_state_rate, n = 1, with_ties = FALSE) %>%
  pull(region)

answer("04-C6", q04_c6)
