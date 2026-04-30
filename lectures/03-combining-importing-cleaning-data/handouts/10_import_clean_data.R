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

# Compare a few imported column classes one at a time
class(imported_murders$state)
class(imported_murders$population)
class(imported_murders$total)


# BASE R IMPORT OPTIONS ---------------------------------------------------

# Base R CSV import
base_murders <- read.csv(csv_path)

head(base_murders)

# Force every imported column to arrive as text
base_murders_text <- read.csv(csv_path, colClasses = "character")

str(base_murders_text)


# MESSY TEXT VALUES -------------------------------------------------------

# tibble() creates a tidyverse data frame.

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

# Do all values contain commas?
all(str_detect(messy_counts$population_text, ","))


# FIRST MATCH VERSUS EVERY MATCH -----------------------------------------

# One value has two commas
many_commas <- "37,253,956 people"

str_replace(many_commas, ",", "")
str_replace_all(many_commas, ",", "")


# REPLACE OR PARSE --------------------------------------------------------

# Remove commas but keep the rest of the text
messy_counts %>%
  mutate(population_no_commas = str_replace_all(population_text, ",", ""))

# Extract usable numbers
clean_counts <- messy_counts %>%
  mutate(population = parse_number(population_text),
         total = parse_number(murders_text))

clean_counts


# PARSE SEVERAL COLUMNS ---------------------------------------------------

# Apply parse_number() to several text columns
messy_counts %>%
  mutate(across(
    .cols = c(population_text, murders_text),
    .fns = parse_number,
    .names = "{.col}_number"
  ))

# The cleaned population is numeric
class(clean_counts$population)

# Now we can compute a rate
clean_counts %>%
  mutate(rate = total / population * 100000) %>%
  select(state, rate)


# CASE FUNCTIONS ----------------------------------------------------------

# Compare common case transformations
case_examples <- tibble(
  state = c("california", "TEXAS", "new york")
)

case_examples %>%
  mutate(lower = str_to_lower(state),
         upper = str_to_upper(state),
         title = str_to_title(state),
         sentence = str_to_sentence(state))


# CLEAN KEYS BEFORE JOINING -----------------------------------------------

# str_to_title() converts text to title case so key values can match.

# A lookup table with lower-case state names
region_lookup <- tibble(
  state = c("california", "texas", "florida"),
  short_region = c("West", "South", "South")
)

# Standardize the key before joining
region_lookup %>%
  mutate(state = str_to_title(state)) %>%
  left_join(clean_counts, by = "state")


# SIMPLE REGULAR EXPRESSIONS ----------------------------------------------

# Does the entry contain a unit?
height_entries <- c("180 cm", "70 inches", "180", "70''")
str_detect(height_entries, "cm|inches")

# Does the entry contain digits or letters?
mixed_entries <- c("5", "6", "5'10", "5 feet", "Five", "")

str_detect(mixed_entries, "\\d")
str_detect(mixed_entries, "[a-zA-Z]")


# PRACTICE PIPELINE -------------------------------------------------------

# A compact example using the cleaned toy table
clean_counts %>%
  mutate(rate = total / population * 100000) %>%
  left_join(region_lookup %>% mutate(state = str_to_title(state)), by = "state") %>%
  group_by(short_region) %>%
  summarise(avg_rate = mean(rate), .groups = "drop")
