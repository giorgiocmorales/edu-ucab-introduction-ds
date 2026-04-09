# CLASS 6 - DATA SCIENCE UCAB  
# STRING HANDLING  

# The data we import into R for processing and analysis are not always in a tidy 
# or friendly format that allows for easy manipulation. Sometimes they can also 
# contain inconsistencies or values that make certain tasks difficult.

# In this script we’ll cover some basic aspects of string handling and  
# how to deal with NAs in certain cases.


# PACKAGES ----------------------------------------------------------------

# Install the following packages if you don’t have them installed:

# install.packages("htmlwidgets")
# install.packages("zoo")
# install.packages("rvest")

library(rvest)
library(dslabs)
library(tidyverse)
library(stringr)
library(zoo)
library(lubridate)
library(stringr)

rm(list = ls())


# DATA --------------------------------------------------------------------

# We will continue working with U.S. homicide data, but this time importing it 
# directly from the internet (Wikipedia).

url <- "https://en.wikipedia.org/wiki/Murder_in_the_United_States_by_state"
murders_raw <- read_html(url) %>%
  html_nodes("table") %>% 
  .[2] %>% 
  html_table() %>% 
  .[[1]] %>%
  setNames(c("state", "population", "murder_manslaughter_total", 
             "murder_total", "gun_murder_total", "ownership", 
             "murder_manslaughter_rate", "murder_rate", "gun_rate"))

head(murders_raw)
View(murders_raw)

# What type are the population and total homicide variables?  
# Do we really want them to be strings?  

murders_test <- murders_raw %>% 
  dplyr::mutate(population = as.numeric(population), 
                murder_manslaughter_total = as.numeric(murder_manslaughter_total), 
                murder_total = as.numeric(murder_total))

# What happens? Is what we just did correct? 


# PROBLEM -----------------------------------------------------------------

# In the previous code chunk, when we tried to change the data type of the 
# columns, NAs were generated. This happens because R doesn’t automatically 
# interpret manually typed thousand separators (in this case commas “,”) 
# in numeric values. Therefore, R recognizes them as strings that cannot be 
# interpreted as numbers.

# Similar to when we run the following line:
x <- c('1', 'car', '7')
as.numeric(x)

x <- c('1', '1,78', '7') # R also doesn’t recognize commas as decimal separators (it expects periods)
as.numeric(x) 



# STRING HANDLING: STRINGR ------------------------------------------------

# STRINGR 
# This package provides functions that make it easier to process and clean strings.  
# It’s useful for working with character vectors.

# In the murders example, we saw that the problem lies in the column values for 
# population and homicides that include thousand separators with commas.  
# Stringr will help us fix that.


## DETECT patterns with str_detect()
# Allows us to identify whether elements of a vector contain a pattern we specify.

?str_detect

str_detect(murders_raw$population,  # Character vector
           ",")                     # Pattern to evaluate (checks if vector elements contain commas)

# What’s the output? A logical vector indicating whether the condition is met.

# Adding the function any() lets us check if *any* of the elements 
# meet the condition.
any(str_detect(murders_raw$population, ",")) 

# Why does it return a single value now when before it returned 52?  

# Let’s try with the function all(). What does it return now? What does it evaluate?
all(str_detect(murders_raw$population, ",")) 


## REPLACE patterns with str_replace() and str_replace_all()
# Allows us to replace the first match of a specific pattern in each element of a vector.

?str_replace

test_1 <- str_replace(murders_raw$population, ",", "")
test_1 <- as.numeric(test_1)

test_1 # Corrected vector of values  

murders_raw$population # But in the original dataset it’s still uncorrected...

# Modify the original dataset to fix the issue directly
murders_raw <- murders_raw %>%
  mutate(population = str_replace(population, ",", ""))  # Remove commas... but it’s still a string

# Try again with the code above
test_1 <- str_replace(murders_raw$population, ",", "")
test_1 <- as.numeric(test_1)

class(test_1)


# PARSE FUNCTIONS ---------------------------------------------------------

# Another option to achieve the same result — removing commas from the 
# relevant columns — is to use parse functions from the readr package.

# One such function is parse_number()

?parse_number

# Reload the original dataset
murders_raw <- read_html(url) %>%
  html_nodes("table") %>% 
  .[2] %>% 
  html_table() %>% 
  .[[1]] %>%
  setNames(c("state", "population", "murder_manslaughter_total", 
             "murder_total", "gun_murder_total", "ownership", 
             "murder_manslaughter_rate", "murder_rate", "gun_rate"))

# Try the parse_number function and assign the result to test_2
test_2 <- parse_number(murders_raw$population)

# Check that the results are identical
identical(test_1, test_2)

# We get the same result, and this time the final output is numeric.  
# We can apply this using dplyr to all columns we want to modify.

# Generate a new dataset, murders_new, correcting all columns using parse_number
murders_new <- murders_raw %>%
  
  # The across function lets us apply the same function to multiple columns
  mutate(across(.cols = c("population", "murder_manslaughter_total",
                          "murder_total"),
                .fns = parse_number))


# UPPER AND LOWER CASE FUNCTIONS ------------------------------------------

# We can also change whether the words in a string are all lowercase or uppercase.  
# Let’s try it with the “state” variable from the murders_new dataset.
murders_new$state

# Lowercase
str_to_lower(murders_new$state)

# Uppercase
str_to_upper(murders_new$state)

# Title case: first letter of every word in uppercase
str_to_title(murders_new$state)

# Sentence case: only the first letter of the first word in uppercase
str_to_sentence(murders_new$state)

# CHALLENGE  
# Create a dataframe called murders_name where the values of the variable “state”  
# are all in uppercase letters.



# REGULAR EXPRESSIONS -----------------------------------------------------

# Sometimes when handling strings, it’s easier to use regular expressions  
# to detect specific patterns.

# Now we want to know if the following elements contain “cm” or “inches”.
yes <- c("180 cm", "70 inches")
no  <- c("180", "70''")
s   <- c(yes, no)
str_detect(s, "cm|inches")

# To detect digits we can use a special character
yes <- c("5", "6", "5'10", "5 feet", "4'11")
no  <- c("", ".", "Five", "six")
s   <- c(yes, no)
str_detect(s, "\\d")

# Use str_view and str_view_all
str_view(s, "\\d")
str_view_all(s, "\\d")

# To define character classes, use []
# To detect only 5 and 6:
str_view(s, "[56]")

# To define ranges, use "-"
# Numbers between 4 and 7
yes <- as.character(4:7)
no  <- as.character(1:3)
s   <- c(yes, no)
str_detect(s, "[4-7]")

# Alternative way to detect numbers? Alternative to \\d
str_detect(s, "[0-9]")

# To detect letters?

# Lowercase
str_detect(s, "[a-z]")

# Uppercase
str_detect(s, "[A-Z]")

# Both
str_detect(s, "[a-zA-Z]")
