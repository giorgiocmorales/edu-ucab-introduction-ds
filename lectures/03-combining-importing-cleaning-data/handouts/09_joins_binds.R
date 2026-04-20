# Lecture 03 - Introduction to Data Science
# Handout 09: joins, binds, and set operations

# PACKAGES ---------------------------------------------------------------

library(tidyverse)
library(dslabs)


# DATA -------------------------------------------------------------------

data(murders)


# KEYS -------------------------------------------------------------------

# Inspect the analysis table
murders %>%
  select(state, region, population, total) %>%
  head()

# Inspect the lookup table
results_us_election_2016 %>%
  select(state, electoral_votes) %>%
  head()

# Check whether state names appear in the same row order
identical(murders$state, results_us_election_2016$state)


# LEFT JOIN ---------------------------------------------------------------

# Add electoral votes to the murders table
murders_election <- murders %>%
  left_join(results_us_election_2016, by = "state")

# Keep only a few columns for inspection
murders_election %>%
  select(state, population, total, electoral_votes) %>%
  head()


# SMALL JOIN EXAMPLE ------------------------------------------------------

# Main table
tab1 <- murders %>%
  slice(1:6) %>%
  select(state, population)

tab1

# Lookup table with only some matching states
tab2 <- results_us_election_2016 %>%
  slice(c(1:3, 5, 14, 44)) %>%
  select(state, electoral_votes)

tab2


# MUTATING JOINS ----------------------------------------------------------

# Keep every row from tab1
left_join(tab1, tab2, by = "state")

# Keep every row from tab2
right_join(tab1, tab2, by = "state")

# Keep only states that appear in both tables
inner_join(tab1, tab2, by = "state")

# Keep states from either table
full_join(tab1, tab2, by = "state")


# FILTERING JOINS ---------------------------------------------------------

# Rows in tab1 that have a match in tab2
semi_join(tab1, tab2, by = "state")

# Rows in tab1 that do not have a match in tab2
anti_join(tab1, tab2, by = "state")


# BINDS ------------------------------------------------------------------

# Bind vectors as columns
bind_cols(a = 1:3, b = 4:6)

# Bind data frames as rows
bind_rows(
  tibble(state = c("Alabama", "Alaska"), group = "first"),
  tibble(state = c("Arizona", "Arkansas"), group = "second")
)


# SET OPERATIONS ----------------------------------------------------------

# Values in both vectors
intersect(1:10, 6:15)

# Values in the first vector but not the second
setdiff(1:10, 6:15)

# Same values, different order
setequal(1:5, 5:1)
identical(1:5, 5:1)
