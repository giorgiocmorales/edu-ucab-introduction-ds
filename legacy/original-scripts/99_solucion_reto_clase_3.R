# LESON 3 CHALLENGE 


# PACKAGES ----------------------------------------------------------------
library(dslabs)

rm(list = ls())


# CHALLENGE --------------------------------------------------------------------

# Create with the murders dataset from script 04_order.R a concatenated string 
# by state that generates the following result: 

# “The state of XXX has a population of XXX and a number of firearm murders 
# of XXX for 2010”  



# SOLUTION  ---------------------------------------------------------------

paste('The state of', murders$state, 'has a population of', murders$population, 
      'and a number of firearm murders of', murders$total, 'for 2010.',
      sep = ' ')