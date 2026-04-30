# Lecture 01 - Introduction to Data Science
# Handout 03: data types and basic structures

# PACKAGES ---------------------------------------------------------------

library(dslabs)


# DATA TYPES -------------------------------------------------------------

a <- 2
class(a)

a <- "2"
class(a)


# THE murders DATASET ----------------------------------------------------

?murders
data(murders)

class(murders)
str(murders)
head(murders)


# ACCESSING COLUMNS ------------------------------------------------------

murders$population
View(murders)

names(murders)
colnames(murders)

pop <- murders$population
class(pop)
length(pop)


# COERCION ---------------------------------------------------------------

vector <- c(1, 2, "car")
vector
class(vector)

class(murders$state)


# LOGICAL VALUES ---------------------------------------------------------

3 == 2
z <- 3 == 2
z

?Comparison

boolean_vector <- c(TRUE, FALSE, TRUE)
boolean_vector


# FACTORS ----------------------------------------------------------------

class(murders$region)
levels(murders$region)


# LISTS ------------------------------------------------------------------

record <- list(
  name = "John Doe",
  student_id = 1234,
  grades = c(95, 82, 91, 97, 93),
  final_grade = "A"
)

record
class(record)

record$student_id
record[["student_id"]]
