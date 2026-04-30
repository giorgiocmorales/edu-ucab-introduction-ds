# Lecture 01 - Introduction to Data Science
# Handout 01: R basics and first objects

# BASIC SHORTCUTS -------------------------------------------------------

# Ctrl + Enter: run current line or selection
# Ctrl + Shift + Enter: run full script
# Ctrl + Shift + C: comment or uncomment selection
# Ctrl + Shift + R: insert section
# Alt + O: collapse sections
# Alt + Shift + O: expand sections


# BASIC OPERATIONS ------------------------------------------------------

5 + 2
5 - 2
5 * 2
10 / 2

2 ^ 2
sqrt(16)
abs(-10)

round(3.14159)
round(3.14159, digits = 2)

seq(1, 10)
seq(1, 10, by = 2)


# OBJECTS AND VECTORS ---------------------------------------------------

x <- 5
x

x <- x + 2
print(x)

vector_num <- c(5, 2, 10)
vector_num


# VECTORIZED OPERATIONS -------------------------------------------------

abs(vector_num)
vector_num + 5

min(vector_num)
max(vector_num)
mean(vector_num)
sqrt(vector_num)


# TEXT OBJECTS ----------------------------------------------------------

var_text <- "UCAB"
vector_text <- c("Course", "data", "science")
print(vector_text)

var_text2 <- "2025"
paste(var_text, var_text2)
paste(vector_text, collapse = " ")

course <- paste(c(vector_text, var_text, var_text2), collapse = " ")
course


# PACKAGES AND BUILT-IN DATA --------------------------------------------

# Run once if the package is not installed yet.
# install.packages("dslabs")

library(dslabs)

data()

base <- USArrests
?USArrests

# In RStudio you can inspect the dataset in the data viewer.
View(base)
