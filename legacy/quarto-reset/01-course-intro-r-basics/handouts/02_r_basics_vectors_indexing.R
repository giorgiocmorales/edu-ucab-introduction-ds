# SESSION 01 - HANDOUT B
# Data types, vectors, ordering, and indexing

library(dslabs)
data(murders)


# DATA TYPES -------------------------------------------------------------

a <- 2
class(a)

a <- "2"
class(a)

z <- 3 == 2
z
class(z)


# DATA FRAME BASICS ------------------------------------------------------

class(murders)
str(murders)
head(murders)
names(murders)


# ACCESSOR ---------------------------------------------------------------

murders$population
pop <- murders$population
class(pop)
length(pop)


# VECTORS ----------------------------------------------------------------

vector_num <- c(5, 2, 10)
vector_num
mean(vector_num)
max(vector_num)
min(vector_num)

codes <- c("italy" = 380, "canada" = 124, "egypt" = 818)
codes
names(codes)

seq(1, 10)
1:10
seq(1, 10, by = 2)


# SUBSETTING -------------------------------------------------------------

codes[2]
codes[c(1, 3)]
codes["italy"]

my_seq <- 1:100
my_seq_even <- seq(2, 100, by = 2)
my_seq_even


# COERCION ---------------------------------------------------------------

x <- c(1, 2, "car")
x
class(x)

x <- 1:5
y <- as.character(x)
y
as.numeric(y)

country <- c("italy", "canada", "egypt")
as.numeric(country)


# ORDERING ---------------------------------------------------------------

sort(murders$total)
index <- order(murders$total)
murders$state[index]

which.max(murders$total)
which.min(murders$total)

murders$state[which.max(murders$total)]
murders$state[which.min(murders$total)]


# INDEXING WITH LOGICALS -------------------------------------------------

murder_rate <- murders$total / murders$population * 100000
ind <- murder_rate <= 1
murders$state[ind]

west <- murders$region == "West"
safe <- murder_rate <= 1
murders$state[west & safe]


# WHICH AND MATCH --------------------------------------------------------

ind <- which(murders$state == "California")
ind
murder_rate[ind]

match(c("New York", "Florida", "Texas"), murders$state)


# PRACTICE ---------------------------------------------------------------

# 1. What class is murders$state?
# 2. Which state has the largest population?
# 3. Which states have murder rates below 0.8?
# 4. Create a named vector with three countries and three codes of your choice.
