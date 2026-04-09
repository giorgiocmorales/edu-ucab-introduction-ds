# LESSON 3 - DATA SCIENCE UCAB 
# Vector handling in R

# We are going to delve a little more into vector handling

# PACKAGES ----------------------------------------------------------------

library(dslabs)

rm(list = ls())

# VECTORS ----------------------------------------------------------------

# Reviewing: A vector is a data structure that contains several 
# elements. They can be numeric, string, logical, factor elements. 
# The only peculiarity is that a vector can only have one data type

# Create a vector called codes with the values 380, 124 and 818
codes <- c(380, 124, 818)
codes


# Create a vector with the names italy, canada, egypt
country <- c("italy", "canada", "egypt")


# Try creating the vector country without using quotes
country <- c(italy, canada, egypt)


# NAMING VECTORS --------------------------------------------------------
# We can generate vectors with names, assigning a name to each element

# To name the elements of a vector, run the following
codes <- c(italy = 380, canada = 124, egypt = 818)
codes

# Verify the type of codes
class(codes)

# Verify the names of the elements of the vector with the names() function
names(codes)


# You can also use quotes when you create the named vector
# to avoid confusion
codes <- c("italy" = 380, "canada" = 124, "egypt" = 818)
codes
class(codes)
names(codes)

# Another way to name, more commonly used, is using the
# independent vectors and the names() function
codes <- c(380, 124, 818)
country <- c("italy","canada","egypt")
names(codes) <- country
codes



# SEQUENCES --------------------------------------------------------------
# We can also generate sequences: we create numeric vectors that follow a
# determined sequence

# A useful way to create vectors is with the seq function (for sequence)
seq(1, 10)


# Verify the documentation of seq and generate a sequence that goes from 2 to 2
?seq
seq(1,10, by = 2)

# NOTE: note that it does not reach 10

# We can also generate consecutive sequences with this abbreviation
# It is very common 
1:10


# Verify the class of 1:10
class(1:10)


# Try with any value that is not an integer
class(seq(1, 10, 0.5))


# SUBSETTING --------------------------------------------------------------

# Single brackets are used to access or "reduce" the elements of a
# vector

# Access the second element of the codes vector
codes[2]


# You can access several elements at once
codes[c(1,3)]


# And you can do it using the names
codes["italy"]


# Generate a sequence from 1 to 100 and save it in my_seq
my_seq <- 1:100

## CHALLENGE 
# Get only the even elements of my_seq and save them in
# an object called my_seq_even

my_seq_even <- seq(2,100, by = 2)
  
# COERCION ----------------------------------------------------------------

# R automatically tries to guess the data type and lose the least
# possible information. Before throwing an error, it tries to guess what
# we wanted to do


# Try the following
x <- c(1, "canada", 3)
x
class(x)


# COERCION FUNCTIONS
# There are special functions to convert values
# these are as.numeric(), as.character(), as.factor()


# Create a sequence from 1 to 5 and assign it to x
x <- 1:5

# Convert the sequence to a character vector and assign it to y
y <- as.character(x)
y

# Reverse the change you made by converting y to a numeric vector
y <- as.numeric(y)



# NAs ---------------------------------------------------------------------

# Try converting a vector of words to numeric to see what happens,
# you can use the country vector. Assign it to a new object called country_num
country_num <- as.numeric(country)
country_num


# Try with a mixed vector, this time do not assign the coercion to any new object
x <- c("1", "b", "3")
as.numeric(x)