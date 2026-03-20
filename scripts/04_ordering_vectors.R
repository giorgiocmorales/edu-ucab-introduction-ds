# LESSON 3 - DATA SCIENCE UCAB
# Ordering vectors in R

# There are functions in R that allow us to order vectors.
# Using the murders dataset that we saw last week, we will learn
# to use vector ordering functions

# Murders: data on firearm homicides in the US for 2010, by state
?murders

# In general terms, we want to answer the following question:
# Which is the state with the highest number of homicides in the US for 2010?
# Which is the state with the lowest number of homicides in the US for 2010?

# PACKAGES ----------------------------------------------------------------

library(dslabs)

# DATA  ------------------------------------------------------------------

data(murders)

# SORT --------------------------------------------------------------------

# Use the sort() function to order the "total" column
sort(murders$total)

# With sort, we order the values of the total column in ascending order (default).
# This allows us to obtain an ordered vector (from lowest to highest) of the values
# of the total column

# We can see the specifications and arguments of the function
?base::sort

# NOTE: note that it is not very useful to answer our question.
# We don't know which states correspond to each value.


# ORDER -------------------------------------------------------------------

# The order() function may be closer to what we are looking for
?base::order

# Example
# Let's evaluate the order() function to see if it is closer to what we are looking for
x <- c(31, 4, 15, 92, 65)
sort(x)


# The order function gives us the indices of the order of the values
# Use the order() function and assign the result to the object index
index <- order(x)
index

# Now try the following
x[index]

# The order function returns a permutation that orders a vector in ascending order (default).
# It returns a vector that assigns the order to the input
# Basically what we do in line 56 is tell R to take the ordered elements from the vector X,
# according to the order in the index vector

# NOTE: we get the same result as with sort(x)


## Applying to our case study

# Assign the order of the total column to the index object and then use that
# object to print the list of state names ordered by
# total homicides
index <- order(murders$total)
murders$state[index]

# We can answer the two questions:

# Which is the state with the highest number of homicides in the US for 2010?
# Which is the state with the lowest number of homicides in the US for 2010?

# However, if we only want 2 state names, this way is a bit long.
# Let's explore another way to obtain the same results, in a more direct way

# WHICH. ------------------------------------------------------------------

# MAX function
# Verifies the maximum value of homicides per state
max(murders$total)

# MIN function
# Verifies the minimum value of homicides per state
min(murders$total)

# Now, there are the functions which.max and which.min, which return
# the corresponding positions within a vector of the maximum or minimum value

which.max(murders$total)

which.min(murders$total)

# It is quite similar to the way order works. It returns positions
# or indices within the vector

## CHALLENGE
# If we want to get the names of states with the highest and lowest number of murders
# using the which.max() and which.min() functions, how can we do it?

# Which is the state with the highest number of homicides in the US for 2010?
index <- which.max(murders$total)

murders$state[index]

# Which is the state with the lowest number of homicides in the US for 2010?
index <- which.min(murders$total)

murders$state[index]

# RANK --------------------------------------------------------------------


# Although less useful, the rank function is also related to ordering
x <- c(31, 4, 15, 92, 65)
index <- rank(x)


# What is the function doing?