# LESSON 5 - DATA SCIENCE UCAB
# BASIC DPLYR FUNCTIONS

# To put into practice what we saw in class, we will start using the functions
# of dplyr that we started seeing today: select, filter, mutate, group_by, summarize,
# rename and the pipe (%>%). We will also learn to use functions like arrange,
# table, unique, round, head

# It is important to understand that these functions allow us to edit or subset
# dataframes

# We will continue working with our murders dataset
# Murders: data on firearm homicides in the US for 2010, by state
library(dslabs)
?murders


# PACKAGES ----------------------------------------------------------------

library(dslabs)
library(dplyr)

rm(list = ls())


# DATA --------------------------------------------------------------------

# Load the murders dataset
data(murders)


# MUTATE FUNCTION ---------------------------------------------------------

# The mutate() function allows us to create new variables or rewrite previously
# existing variables.

# We can create variables that are constants:

murders <- mutate(murders, constante_num = 1)

murders <- mutate(murders, constante_char = 'Dataset murders')

# We can also create numeric sequence variables:

murders <- mutate(murders, seq_num = 1:n()) # n() function is used to generate the number of observations

# Additionally, we can generate variable transformations:

# Generate the homicide rate per 100,000 inhabitants using the total and population variables
murders <- mutate(murders, murder_rate = total / population * 100000)

# We can generate a paste to generate text, using the variable we created
murders <- mutate(murders, murder_rate_text = paste('The state of', state, 'has a homicide rate of', murder_rate, 'per 100,000 inhabitants.', sep = ' '))

# If we want to rewrite murder_rate_text because I want to round the homicide rate in the murder_rate_text variable:

# round() function allows us to round digits. We pass argument 2 to
# specify 2 decimal places
murders <- mutate(murders, murder_rate_text = paste('The state of', state, 'has a homicide rate of', round(murder_rate,2), 'per 100,000 inhabitants.', sep = ' '))

# Note that we overwrite the original murders object by assigning it back
# to the same object. R reads from right to left


# HEAD FUNCTION ------------------------------------------------------------

# The head function allows us, by default, to view the first
# 6 observations of a dataframe
head(murders)


# SELECT FUNCTION ---------------------------------------------------------

# The select() function allows us to select columns from a dataframe to make
# a subset at the COLUMN or VARIABLE level

# Let's say I'm interested in keeping only 3 columns from the murders dataframe:

murders_subset <- select(murders, state, region, murder_rate)

# Select also allows us to rename variables at the same time we select them

murders_subset <- select(murders, state, region, "tasa_homicidio" = murder_rate)



# FILTER FUNCTION ---------------------------------------------------------

# The filter() function allows us to restrict a dataset to specific groups, based
# on meeting a condition. This allows us to subset the dataset
# at the ROW or OBSERVATION level

# We can use the filter function to observe the table whose states have
# rates less than or equal to 0.71

murders_filas <- filter(murders, murder_rate <= 0.71)


# PIPE OPERATOR %>% -------------------------------------------------------

# The pipe %>% is a special operational function included in dplyr. It allows us to
# make the code readable and efficient, as well as being able to use more than one function on
# the same dataset.

# If we want to create columns, filter and select variables from the murders dataset,
# we can do it all using the pipe

# SHORTCUT: CTRL + SHIFT + M

data(murders) # The dataset is reloaded to revert the changes we have made

murders_final <- murders %>%
  dplyr::mutate(murder_rate = total / population * 100000) %>%
  dplyr::filter(murder_rate <= 0.71) %>%
  dplyr::select(state, region, murder_rate)


# RENAME FUNCTION ---------------------------------------------------------

# The rename function allows us to change the name of one or more variables:

murders_final <- murders %>%
  dplyr::mutate(murder_rate = total / population * 100000) %>%
  dplyr::filter(murder_rate <= 0.71) %>%
  dplyr::select(state, region, murder_rate) %>%
  
  # The names of the variables of interest are changed
  dplyr::rename('estado' = state,
                'tasa_homicidio' = murder_rate)

# ORDER DATA FRAMES ----------------------------------------------------

# The arrange function allows us to order a dataframe based on the column or columns
# that we pass to that function.

# Ascending based on the murder_rate variable
murders_final %>%
  arrange(tasa_homicidio) %>%
  head()


# Order in descending order by the rate using the desc() function and view
# the header
murders_final %>%
  arrange(desc(tasa_homicidio)) %>%
  head()


# Order first by region and then by murder rate
murders_final %>%
  arrange(region, tasa_homicidio) %>%
  head()

# GROUP_BY AND SUMMARIZE FUNCTION --------------------------------------------

# The group_by() function allows us to group variables in a dataframe to generate
# calculations within a dataframe.

# The summarize() function allows us to obtain total amounts, averages, or
# aggregated measures

# We usually use group_by() together with summarize() when we want to generate
# aggregated calculations of grouped measures.

# For example:

# We want to generate a summary table of the average murder rate by
# region

murders_table1 <- murders %>%
  dplyr::mutate(murder_rate = total / population * 100000) %>%
  group_by(region) %>%
  dplyr::summarise('avg_murder_rate' = mean(murder_rate)) %>%
  ungroup()

# Since the states within each region are not of equal size, we use a weighted average

murders_table <- murders %>%
  dplyr::mutate(murder_rate = total / population * 100000) %>%
  group_by(region) %>%
  dplyr::summarise('avg_murder_rate' = weighted.mean(murder_rate, w = population)) %>%
  ungroup()



# CHALLENGE -------------------------------------------------------------------

# Generate the complete code chunk by which we obtain the following measures for the
# murders dataset:

# Average murder rate (weighted)
# The highest murder rate by region
# The name of the state with that highest murder rate by region

# The final dataframe should be named murders_reto and the columns it should have are:
# region, avg_rate, max_rate, state_max_rate
