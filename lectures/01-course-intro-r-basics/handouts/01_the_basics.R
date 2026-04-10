# CLASS 2 - DATA SCIENCE UCAB
# Basic exploration in R

# BASIC SHORTCUTS -------------------------------------------------------

# Ctrl+Enter: run line/selection of code
# Ctrl+Shift+Enter: run complete code
# Ctrl+Shift+C: insert comment
# Ctrl+Shift+R: insert section
# Alt+O: collapse all sections
# Alt+Shift+O: Open all sections


# BASIC OPERATIONS -----------------------------------------------------

# Addition
5+2

# Subtraction
5-2

# Multiplication


# Division


# Power
2^2
2**2

# Square root
sqrt(16)


# Absolute value
abs(-10)


# VARIABLES AND VECTORS ----------------------------------------------------

# Assign a certain value to a variable (unitary vector)
x <- 5

# Overwrite variable
x <- 5+2

# Create vector of numeric values
vector_num <- c(5, 2, 10)


# BASIC OPERATIONS WITH VECTORS ----------------------------------------


# Calculate the absolute value of each of the elements of the vector vector_num
abs(vector_num)

# Add 5 to each element of the vector vector_num
vector_num + 5

# Minimum and maximum value of vector_num
min(vector_num)
max(vector_num)

# Average of elements of the vector vector_num
mean(vector_num)

# Calculate square root of each element of vector_num



# VARIABLES AND TEXT VECTORS -------------------------------------------

# Assign text to a variable
var_text <- "UCAB"

# Create vector of text variables and visualize
vector_text <- c("Course", "data", "science")
print(vector_text)


# Combine two text variables

# Note that although the year is a number, for these purposes it is placed as a
# text variable
var_text2 <- "2025"
paste(var_text, var_text2)


# Join all the elements of a vector in a single string
paste(vector_text, collapse = " ")


# Combine the two previous exercises to obtain
# a single string that says "Course data science UCAB 2022" and
# assign it to an object/variable called course

combined <- paste(c(vector_text, var_text, var_text2), collapse = " ")


# INSTALL AND USE PACKAGES --------------------------------------------

# Install packages
install.packages("dslabs")

# To open and access the package
library(dslabs)



# EXPLORE PREDEFINED DATABASES ---------------------------------

# See list of predefined databases
data()


# Use a predefined database

base <- USArrests

# We inspect the pre-installed USArrests database
# The help panel allows us to read the documentation of functions or datasets
# preloaded, to understand more about the arguments or utility.

?USArrests


# Click on the "base" object in the upper right to view the table
# or run the following command
View(base)


# -------------------------------------------------------------------------