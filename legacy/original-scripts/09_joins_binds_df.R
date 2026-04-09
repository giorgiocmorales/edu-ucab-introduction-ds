# CLASS 6 - DATA SCIENCE UCAB
# JOINS AND BINDS OF DATAFRAMES

# We will use the join and bind functions, whose objective is to combine
# two or more datasets.

# Recall that joins and binds require that the dimensions by which
# a join is made are respected. But joins combine by a key column and binds
# simply "paste" both datasets, regardless of whether there are common
# variables or not.

# Today we will use two datasets:
library(dslabs)

# The murders dataset
?murders
data(murders)
View(murders)

# A new dataset of the results of the 2016 U.S. presidential elections
?polls_us_election_2016
data(results_us_election_2016)
View(results_us_election_2016)

# We remove the electoral poll results dataset, we won't use it
rm(polls_us_election_2016)

# PACKAGES ----------------------------------------------------------------

library(tidyverse)
library(dslabs)


# DATA INSPECTION -----------------------------------------------------

# Both datasets have columns in common that might interest us to combine: state

# However, upon inspecting the columns of both datasets:

head(murders)

head(results_us_election_2016)

# We realize that we cannot simply paste one table onto the other
# Why?

identical(results_us_election_2016$state, murders$state)


# JOINS -------------------------------------------------------------------

# To be able to combine both tables correctly, we need them to respect
# the union according to the variable of interest. Therefore, we will use joins

# Use the left_join function to combine both tables by "state"
tab <- left_join(murders, results_us_election_2016, by = "state")

# We want to keep only the state, population, and electoral_votes columns
# We also want to see only the first 6 observations: How do we do it?


# What happens when we don't have the same data in each table?

# EXAMPLE
# With the following function we create subsets of the tables
tab1 <- slice(murders, 1:6) %>%
  select(state, population)

tab1


tab2 <- slice(results_us_election_2016, c(1:3, 5, 14, 44)) %>%
  select(state, electoral_votes)
tab2

## MUTATING JOINS

# Perform a left_join of tab1 and tab2
left_join(tab1, tab2)


# Now try with a right_join
right_join(tab1, tab2)


# inner_join
inner_join(tab1, tab2)


# full_join
full_join(tab1, tab2)


## FILTERING JOINS

# semi_join
semi_join(tab1, tab2)


# anti_join
anti_join(tab1, tab2)


# BINDING -----------------------------------------------------------------

# COLUMNS

# To "paste" datasets by columns, we can use the bind_cols() or
# cbind() functions

# bind_cols() FUNCTION

# If we paste vectors of the same dimension, it generates a dataframe
bind_cols(a = 1:3, b = 4:6)

# Works with dataframes too:

# Separate tab into tab1 and tab2 with 4 and 5 columns
# Combine them with the function into a new_tab object

tab1 <- tab[, 1:4]
tab1

tab2 <- tab[, 5:9]
tab2

# We use the function to combine both dfs into the new_tab object
new_tab <- bind_cols(tab1, tab2)

# cbind() FUNCTION
class(cbind(a = 1:3, b = 4:6))
class(new_tab)

# ROWS

# To "paste" datasets by rows, we can use the bind_rows() or
# rbind() functions (Correction: The original text says bind_cols/cbind for rows, which is incorrect based on context and typical R usage. It should be bind_rows/rbind.)

# Separate tab into tab1 and tab2, each with two rows
# Then combine them with bind_rows
tab1 <- tab[1:2,]
tab1

tab2 <- tab[3:4,]
tab2

bind_rows(tab1, tab2)


# rbind() FUNCTION
# How do we use it?


# SET OPERATORS -----------------------------------------------------------

# INTERSECT
# Use the intersect() function to find the intersection
# between a sequence from 1 to 10 and one from 6 to 15
intersect(1:10, 6:15)


# With the dplyr package loaded, it can also be applied to tables
tab1 <- tab[1:5,]
tab1

tab2 <- tab[3:7,]
tab2

intersect(tab1, tab2)


# UNION
# Use the union() function to find the union
# between a sequence from 1 to 10 and one from 6 to 15
union(1:10, 6:15)

tab1 <- tab[1:5,]
tab1

tab2 <- tab[3:7,]
tab2

union(tab1, tab2)


# SET DIFFERENCE
setdiff(1:10, 6:15)

# What does the function do?


# Also applicable to tables
tab1 <- tab[1:5,]
tab1

tab2 <- tab[3:7,]
tab2

setdiff(tab1, tab2)


# SET EQUAL: this function tells us if two objects are equal
# regardless of their order
setequal(1:5, 5:1)

# Contrast its result with that of the identical() function
identical(1:5, 5:1)

# Why are the results different? What does setequal evaluate vs identical?