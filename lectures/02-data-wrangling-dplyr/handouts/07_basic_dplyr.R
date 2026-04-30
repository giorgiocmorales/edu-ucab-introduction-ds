# Lecture 02 - Introduction to Data Science
# Handout 07: basic dplyr functions

# PACKAGES ---------------------------------------------------------------

library(tidyverse)
library(dslabs)


# DATA -------------------------------------------------------------------

data(gapminder)
data(murders)


# THE PIPE ---------------------------------------------------------------

# Nested style
sqrt(sum(c(4, 9, 16)))

# Piped style
c(4, 9, 16) %>%
  sum() %>%
  sqrt()


# SELECT -----------------------------------------------------------------

gapminder %>%
  select(country, continent, year, life_expectancy, population) %>%
  head()


# FILTER -----------------------------------------------------------------

gapminder %>%
  filter(year == 2010, continent == "Asia") %>%
  select(country, year, life_expectancy, population) %>%
  head()


# MUTATE -----------------------------------------------------------------

gapminder %>%
  mutate(gdp_pc = round(gdp / population, 1)) %>%
  select(country, year, gdp, population, gdp_pc) %>%
  head()

gapminder %>%
  mutate(gdp = round(gdp / 10^9, 2)) %>%
  select(country, year, gdp) %>%
  head()

murders %>%
  mutate(rate = total / population * 100000) %>%
  select(state, region, total, population, rate) %>%
  head()


# RENAME -----------------------------------------------------------------

gapminder %>%
  rename(life_exp = life_expectancy, pop = population) %>%
  select(country, year, life_exp, pop) %>%
  head()


# ARRANGE ----------------------------------------------------------------

gapminder %>%
  arrange(life_expectancy) %>%
  select(country, year, life_expectancy) %>%
  head()

gapminder %>%
  arrange(desc(life_expectancy)) %>%
  select(country, year, life_expectancy) %>%
  head()

gapminder %>%
  arrange(continent, desc(life_expectancy)) %>%
  select(continent, country, year, life_expectancy) %>%
  head(10)


# SUMMARISE --------------------------------------------------------------

gapminder %>%
  filter(year == 2010) %>%
  summarise(avg_life_exp = mean(life_expectancy, na.rm = TRUE),
            total_population = sum(population, na.rm = TRUE))


# GROUP_BY + SUMMARISE ---------------------------------------------------

gapminder %>%
  filter(year == 2010) %>%
  group_by(continent) %>%
  summarise(avg_life_exp = mean(life_expectancy, na.rm = TRUE), .groups = "drop")

gapminder %>%
  filter(year == 2010) %>%
  mutate(gdp_pc = gdp / population) %>%
  group_by(continent) %>%
  summarise(n_countries = n(),
            avg_life_exp = round(mean(life_expectancy, na.rm = TRUE), 1),
            total_population = sum(population, na.rm = TRUE),
            avg_gdp_pc = round(mean(gdp_pc, na.rm = TRUE), 0),
            .groups = "drop")


# MURDERS AND WEIGHTED AVERAGES -----------------------------------------

murders %>%
  mutate(rate = total / population * 100000) %>%
  group_by(region) %>%
  summarise(avg_state_rate = mean(rate),
            weighted_rate = weighted.mean(rate, w = population),
            weighted_rate_alt = sum(total) / sum(population) * 100000,
            .groups = "drop")


# CHALLENGE SOLUTION -----------------------------------------------------

murders %>%
  mutate(rate = total / population * 100000) %>%
  group_by(region) %>%
  summarise(avg_state_rate = round(mean(rate), 2),
            weighted_rate = round(weighted.mean(rate, w = population), 2),
            gap = round(abs(weighted_rate - avg_state_rate), 2),
            highest_rate_state = state[which.max(rate)],
            highest_state_rate = round(max(rate), 2),
            total_population = sum(population),
            .groups = "drop") %>%
  arrange(desc(gap))
