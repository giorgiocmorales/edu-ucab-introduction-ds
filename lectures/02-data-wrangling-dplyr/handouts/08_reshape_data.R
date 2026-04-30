# Lecture 02 - Introduction to Data Science
# Handout 08: reshaping data with tidyr

# PACKAGES ---------------------------------------------------------------

library(tidyverse)
library(dslabs)


# TOY WIDE TABLE ---------------------------------------------------------

wide_demo <- tibble::tribble(
  ~cause, ~Female_1990, ~Female_2017, ~Male_1990, ~Male_2017,
  "Diabetes", 120, 180, 90, 140,
  "Stroke", 210, 240, 180, 205
)

wide_demo


# PIVOT_LONGER -----------------------------------------------------------

wide_demo %>%
  pivot_longer(cols = -cause, names_to = c("sex", "year"),
               names_sep = "_", values_to = "deaths")

wide_demo %>%
  pivot_longer(cols = -cause, names_to = c("sex", "year"),
               names_sep = "_", values_to = "deaths") %>%
  filter(year == "2017") %>%
  group_by(sex) %>%
  summarise(total_deaths = sum(deaths), .groups = "drop")


# PIVOT_WIDER ------------------------------------------------------------

wide_demo %>%
  pivot_longer(cols = -cause, names_to = c("sex", "year"),
               names_sep = "_", values_to = "deaths") %>%
  pivot_wider(names_from = c(sex, year), values_from = deaths,
              names_sep = "_")


# LOAD WIDE DATA ---------------------------------------------------------

path <- system.file("extdata", package = "dslabs")
filename <- file.path(path, "fertility-two-countries-example.csv")

wide_data <- read_csv(filename, show_col_types = FALSE)

head(wide_data)
colnames(wide_data)


# PIVOT_LONGER ON THE FERTILITY TABLE -----------------------------------

tidy_data <- wide_data %>%
  pivot_longer(cols = -country, names_to = "year", values_to = "fertility")

head(tidy_data)

data(gapminder)
class(gapminder$year)
class(tidy_data$year)

tidy_data <- wide_data %>%
  pivot_longer(cols = -country, names_to = "year", values_to = "fertility",
               names_transform = list(year = as.integer))

class(tidy_data$year)


# PIVOT_WIDER ON THE FERTILITY TABLE ------------------------------------

new_wide_data <- tidy_data %>%
  pivot_wider(names_from = year, values_from = fertility)

head(new_wide_data)


# LOAD SECOND EXAMPLE ----------------------------------------------------

filename <- file.path(path, "life-expectancy-and-fertility-two-countries-example.csv")
raw_dat <- read_csv(filename, show_col_types = FALSE)

select(raw_dat, 1:5)


# BUILD A KEY-VALUE TABLE ------------------------------------------------

dat <- raw_dat %>%
  pivot_longer(cols = -country, names_to = "key", values_to = "value")

head(dat)


# SEPARATE ---------------------------------------------------------------

dat %>%
  separate(key, into = c("year", "var_name"), sep = "_") %>%
  head()

dat %>%
  separate(key, into = c("year", "first_part", "second_part")) %>%
  head()

dat %>%
  separate(key, into = c("year", "var_name"), extra = "merge") %>%
  head()

dat %>%
  separate(key, into = c("year", "var_name"), extra = "merge") %>%
  pivot_wider(names_from = var_name, values_from = value) %>%
  head()


# UNITE ------------------------------------------------------------------

wide_demo %>%
  pivot_longer(cols = -cause, names_to = "sex_year", values_to = "deaths") %>%
  separate(sex_year, into = c("sex", "year"), sep = "_") %>%
  unite(sex_year_again, sex, year, sep = "_")
