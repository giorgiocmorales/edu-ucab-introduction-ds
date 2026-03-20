# LESSON 5 - DATA SCIENCE UCAB
# RESHAPING DATA WITH DPLYR


# We will use the reshaping functions (pivot_wider and pivot_longer)
# to reorder our dataframe

# Unlike the last scripts, we will start working with data from
# GAPMINDER.

# This is data on health outcomes and income for 184 countries between 1960 and 2016
?gapminder

# We will use a specific dataset, associated with fertility data for two countries


# PACKAGES ----------------------------------------------------------------

library(tidyverse)
library(dslabs)

rm(list = ls())

# DATA --------------------------------------------------------------------

# Run the following lines to import the wide fertility data
path <- system.file("extdata", package="dslabs")

filename <- file.path(path, "fertility-two-countries-example.csv")

wide_data <- read_csv(filename)

# Inspection of columns and observations
head(wide_data)

# Column names
colnames(wide_data)

# What do we see in this dataset? Is it a tidy dataset? Why?


# PIVOT_LONGER ------------------------------------------------------------

# Use the pivot_longer function to convert the wide_data table
# to a table with a "year" column and a "fertility" column. Just like the
# gapminder table that has already been processed
tidy_data <- wide_data %>%
  
  # We use pivot_longer to transform a wide dataset into a long one
  pivot_longer(cols = `1960`:`2015`, # Columns we want to transform to long
               names_to = "year", # Name of the new column created, stores the colnames to transform
               values_to = "fertility") # Name of the new column created, stores the values

head(tidy_data)

# With the table() function we get a frequency summary of the levels or values
# of a variable
table(tidy_data$country)

# Alternative to using pivot_longer for this case: specify the column that will not be changed
tidy_data <- wide_data %>%
  pivot_longer(cols = -country,
               names_to = "year",
               values_to = "fertility")

head(tidy_data)
table(tidy_data$country)



# Any difference with gapminder data
data(gapminder)
class(gapminder$year) # Class of the original dataset
class(tidy_data$year) # Class of the dataset we did pivot_longer on


# We can use the names_transform argument to specify with a coercion function
# the data type of the colnames
tidy_data <- wide_data %>%
  pivot_longer(cols = `1960`:`2015`,
               names_to = "year",
               values_to = "fertility",
               names_transform = as.integer)

class(tidy_data$year)

# We could have also used mutate: How do you think it would be?
tidy_data <- wide_data %>%
  pivot_longer(cols = `1960`:`2015`,
               names_to = "year",
               values_to = "fertility") %>% 
  dplyr::mutate(year = as.integer(year))

# PIVOT WIDER ------------------------------------------------------

# Use the pivot_wider function to convert the tidy_data table
# to a new table called new_wide_data

new_wide_data <- tidy_data %>%
  
  # We use pivot_wider to transform a long dataset into a wide one.
  # In this case it is not necessary to specify the columns to transform
  pivot_wider(names_from = year, # Variable from which column names are taken
              values_from = fertility) # Variable from which values to assign to the new columns are taken


# SEPARATE ----------------------------------------------------------------

# Run the following lines
path <- system.file("extdata", package = "dslabs")
filename <- file.path(path, "life-expectancy-and-fertility-two-countries-example.csv")

raw_dat <- read_csv(filename)

# What do we see from this subset? Is it a tidy dataset? Why?
select(raw_dat, 1:5)


# What should we do first?

# Pivot the table to long format
# Assign it to an object dat
dat <- raw_dat %>%
  pivot_longer(cols = -country,
               names_to = "key",
               values_to = "value")

# To separate the column into two we use the separate() function
dat %>%
  separate(key, # Column we want to separate
           into = c("year", "var_name"), # Names of variables into which we want to separate the columns
           sep = "_") # Separation pattern between elements

# Is this output entirely correct? Why?


# To avoid losing the last row:
dat %>% separate(key,
                 c("year", "first_var_name", "second_var_name"))


# But if we read the documentation better we see that we can keep the last two
# columns that are generated together
?separate
dat %>% separate(key,
                 c("year", "var_name"),
                 extra = "merge")



# We are not finished. Now generate a column for each variable
dat %>% separate(key,
                 c("year", "var_name"),
                 extra = "merge") %>%
  pivot_wider(names_from = "var_name",
              values_from = "value")



# UNITE -------------------------------------------------------------------


# We can achieve the same result by another route, a little more work

# Separate the key column into 3 columns and then use the unite function to
# unite the last two with a "_"
dat %>%
  
  separate(key, c("year", "first_var_name", "second_var_name")) %>%
  
  unite('var_name', # Name of the new column that will contain the pasted values
        first_var_name, # First element to paste
        second_var_name, # Second element to paste
        sep = "_") # Separator for elements to paste


# Pivot the table to separate the variables of interest into columns
dat %>%
  separate(key, c("year", "first_var_name", "second_var_name")) %>%
  
  unite('var_name', first_var_name, second_var_name, sep = "_") %>%
  
  pivot_wider(names_from = "var_name",
              values_from = "value")


# We have an additional problem. Correct it
# Correct the column names
dat %>%
  
  separate(key, c("year", "first_var_name", "second_var_name")) %>%
  
  unite(var_name, first_var_name, second_var_name, sep = "_") %>%
  
  pivot_wider(names_from = "var_name",
              values_from = "value") %>%
  
  rename("fertility" = "fertility_NA")


# -------------------------------------------------------------------------
