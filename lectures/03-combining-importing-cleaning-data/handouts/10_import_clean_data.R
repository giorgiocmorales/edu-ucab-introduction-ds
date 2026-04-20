# Lecture 03 - Introduction to Data Science
# Handout 10: importing and cleaning data

# PACKAGES ---------------------------------------------------------------

library(tidyverse)
library(dslabs)


# IMPORT A CSV ------------------------------------------------------------

# Build a reproducible path to a package file
csv_path <- system.file("extdata", "murders.csv", package = "dslabs")

csv_path

# Read the CSV into R
imported_murders <- read_csv(csv_path, show_col_types = FALSE)

imported_murders %>%
  select(state, population, total) %>%
  head()

# Compare a few imported column classes
imported_murders %>%
  select(state, population, total) %>%
  summarise(across(everything(), ~ class(.x)[1]))


# MESSY TEXT VALUES -------------------------------------------------------

# A small example that mimics imported text
messy_counts <- tibble(
  state = c("California", "Texas", "Florida"),
  population_text = c("37,253,956 people", "25,145,561 people", "18,801,310 people"),
  murders_text = c("1,257", "805", "987")
)

messy_counts

# The population column is text, not numeric
class(messy_counts$population_text)


# DETECT PATTERNS ---------------------------------------------------------

# Which population values contain commas?
str_detect(messy_counts$population_text, ",")

# Do any values contain commas?
any(str_detect(messy_counts$population_text, ","))


# REPLACE OR PARSE --------------------------------------------------------

# Remove commas but keep the rest of the text
messy_counts %>%
  mutate(population_no_commas = str_replace_all(population_text, ",", ""))

# Extract usable numbers
clean_counts <- messy_counts %>%
  mutate(population = parse_number(population_text),
         total = parse_number(murders_text))

clean_counts

# The cleaned population is numeric
class(clean_counts$population)

# Now we can compute a rate
clean_counts %>%
  mutate(rate = total / population * 100000) %>%
  select(state, rate)


# CLEAN KEYS BEFORE JOINING -----------------------------------------------

# A lookup table with lower-case state names
region_lookup <- tibble(
  state = c("california", "texas", "florida"),
  short_region = c("West", "South", "South")
)

# Standardize the key before joining
region_lookup %>%
  mutate(state = str_to_title(state)) %>%
  left_join(clean_counts, by = "state")


# PRACTICE PIPELINE -------------------------------------------------------

# A compact example using the cleaned toy table
clean_counts %>%
  mutate(rate = total / population * 100000) %>%
  left_join(region_lookup %>% mutate(state = str_to_title(state)), by = "state") %>%
  group_by(short_region) %>%
  summarise(avg_rate = mean(rate), .groups = "drop")
