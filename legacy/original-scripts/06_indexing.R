# LESSON 3 - DATA SCIENCE UCAB 
# Indexing in R 

# We have already seen a bit about indexing in R using vectors and lists
# In this script we will continue to delve into the use of indexing in vectors

# We will continue working with our murders dataset
# Murders: data on firearm homicides in the US for 2010, by state 
?murders

# In previous scripts we sought to answer the question of number of homicides 
# maximums and minimums by state and we achieved this using ordering functions 
# of vectors, as well as basic indexing (script 04_order)

# PACKAGES ----------------------------------------------------------------

library(dslabs)

rm(list = ls())

# DATA  ------------------------------------------------------------------

data(murders)

# Calculate the homicide rate per 100,000 inhabitants
murder_rate <- murders$total / murders$population * 100000 


# SUBSET WITH LOGICALS -----------------------------------------------------

# As we saw in the operations with vectors, we can apply
# a single operation to each element of the vector
ind <- murder_rate <= 0.71
ind # Vector of logicals (TRUE or FALSE values) corresponding to whether the condition is met


# Which are the states that meet this condition? Print their names
murders$state[ind]

# To know how many states meet this condition we can sum the vector of 
# logical values. TRUE = 1, FALSE = 0


# LOGICAL OPERATORS ------------------------------------------------------

# To add conditions we use & (AND)
# To provide condition options we use | (OR)

# We can generate two conditions and join them

# Create the condition that the state is in the "West" region 
# assign it to the object west
west <- murders$region == "West"

# Create the condition that the state has a maximum rate equal to 1
# assign it to the object safe
safe <- murder_rate <= 1


# Join both conditions in the object ind and get the names of the states
# that satisfy both conditions
ind <- safe & west
murders$state[ind]



# WHICH -------------------------------------------------------------------

# The which function gives us the index of the entry that meets the 
# condition instead of returning a vector of logical values
ind <- which(murders$state == "California")
ind

# Homicide rate of California
murder_rate[ind]


# Check that it would be equivalent to directly use the vector of values
# logical. Do it in a single line
murder_rate[murders$state == "California"]



# MATCH -------------------------------------------------------------------

# To see the indices of several elements that match we use the match() function
# The function tells us which elements of a second vector match the 
# elements of a first vector
ind <- match(c("New York", "Florida", "Texas"), murders$state)
ind

# Homicide rates of New York, Florida and Texas
murder_rate[ind]



# %in% --------------------------------------------------------------------


# If we want a vector of logical values that tells us which elements of a
# first vector are in a second vector, we use the %in% function
# Example 

a <- c(1:10)

b <- c(3,15,7)

b %in% a  # What do we see that it is evaluating?


## CHALLENGE
# Use the %in% function to find out if Boston, Dakota and Washington are states