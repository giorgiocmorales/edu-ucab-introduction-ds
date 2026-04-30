# Lecture 01 - Introduction to Data Science
# Handout 04: ordering vectors

# PACKAGES ---------------------------------------------------------------

library(dslabs)


# DATA -------------------------------------------------------------------

?murders
data(murders)


# sort() -----------------------------------------------------------------

sort(murders$total)
sort(murders$total, decreasing = TRUE)

?base::sort


# order() ----------------------------------------------------------------

?base::order

x <- c(31, 4, 15, 92, 65)
sort(x)

index <- order(x)
index
x[index]

order(x, decreasing = TRUE)


# APPLYING order() TO murders --------------------------------------------

index <- order(murders$total)
murders$state[index]


# which.max() AND which.min() --------------------------------------------

max(murders$total)
min(murders$total)

which.max(murders$total)
which.min(murders$total)

murders$state[which.max(murders$total)]
murders$state[which.min(murders$total)]


# rank() -----------------------------------------------------------------

x <- c(31, 4, 15, 92, 65)
rank(x)
