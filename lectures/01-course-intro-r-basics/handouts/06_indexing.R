# Lecture 01 - Introduction to Data Science
# Handout 06: indexing with logicals, which(), match(), and %in%

# PACKAGES ---------------------------------------------------------------

library(dslabs)


# DATA -------------------------------------------------------------------

?murders
data(murders)

murder_rate <- murders$total / murders$population * 100000


# LOGICAL INDEXING -------------------------------------------------------

ind <- murder_rate <= 0.71
ind

murders$state[ind]
sum(ind)


# COMBINING CONDITIONS ---------------------------------------------------

west <- murders$region == "West"
safe <- murder_rate <= 1

ind <- safe & west
murders$state[ind]


# which() ----------------------------------------------------------------

ind <- which(murders$state == "California")
ind
murder_rate[ind]

murder_rate[murders$state == "California"]


# match() ----------------------------------------------------------------

ind <- match(c("New York", "Florida", "Texas"), murders$state)
ind

murder_rate[ind]


# %in% -------------------------------------------------------------------

a <- 1:10
b <- c(3, 15, 7)

b %in% a

c("Boston", "Dakota", "Washington") %in% murders$state


# PRACTICE ---------------------------------------------------------------

# Try to find the positions of all states in the West region.
# Try to recover the homicide rates of California and Texas in one line.
