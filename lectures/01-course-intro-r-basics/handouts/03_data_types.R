# CLASS 2 - DATA SCIENCE UCAB
# Data types and structures in R


# PACKAGES ----------------------------------------------------------------

library(dslabs)


# DATA TYPES ----------------------------------------------------------

# Assign the value 2 to the variable a
a <- 2

# Use the class() function to get the class/type of object of a
class(a)


# Overwrite a and assign 2 but this time as a text value
# and get the class of the object a again
a <- "2"
class(a)


# NOTE: from now on we are going to talk in these terms numeric, strings,
# character, integer


# MURDERS CASE STUDY -------------------------------------------------

# To continue inspecting data types and structures we will be
# working with the pre-installed "murders" dataset from the dslabs package

# Firearm murders in the US for 2010, by state
?murders


# DATA STRUCTURE - DATAFRAMES ----------------------------------------

# The most common way data is stored is in tables (data frames)
# Let's load the murders dataframe into our environment
data(murders)

# What type of object is murders
class(murders)

# To know more about the structure of an object we use the str() function
# It allows us to do a quick inspection of the class of each variable
# within the dataframe, as well as the number of observations and variables
str(murders)

# To see the head of the table we use the head() function
# It allows us to see the first 6 observations (by default) of any
# dataframe. We can change the number of observations using the n argument
head(murders)


# THE ACCESOR -------------------------------------------------------------

# To access different variables, columns in the data frame,
# we use the $ operator

# NOTE: notice that when you place the accessor, a
# list of all the elements of the object is displayed
# You can use the Tab key to autocomplete
murders$population

# NOTE: It is important to keep in mind that the column maintains the order
# of the rows of the data frame. Let's review manually to
# verify

# Display the murder object in RStudio
View(murders)

# NOTE: What if we don't know the names of the columns?

# We can get the name of the columns using the names() function
# or more specifically colnames()
names(murders)
colnames(murders)


# VECTORS ----------------------------------------------------------------


# NOTE: what is murders$population? what does it look like to us? We have already dealt
# with this type of information

# Assign the population column of the murders table to an object called pop
pop <- murders$population

# Type of pop object and to know how long it is we use the length() function
class(pop)
length(pop)


# NOTE: for the vector to be numeric, all values must be numeric
# otherwise it converts them to strings (coerce)

# Coercion test
vector <- c(1, 2, "car")
print(vector)

# In a single line of code, get the type/class of the states column of the
# murders table


# LOGICAL VALUES ---------------------------------------------------------

# Logical values are TRUE or FALSE
# The main operators are ==, >, <, <=, >=, !=
# NOTE: remember that = is only used to assign, not as a logical operator

3 == 2
z <- 3 == 2
z


# To see more relational operators
?Comparison


# Complete the code so that boolean_vector contains 3 elements: TRUE, FALSE and TRUE
boolean_vector <- c()


# FACTORS ----------------------------------------------------------------

# Factors are used to categorize data

# Check the variable type of the region column
class(murders$region)


# NOTE: factors have levels, to see them
# Observe the levels of the region variable using the levels() function
levels(murders$region)

# NOTE: later we will continue seeing factors but for the moment
# this is what we need to know

# LISTS ------------------------------------------------------------------

# A list in R can contain many different data types, unlike
# matrices and vectors.
# A list is a collection of ordered and modifiable data.

# Here we have an example of a list
record <- list(name = "John Doe",
               student_id = 1234,
               grades = c(95, 82, 91, 97, 93),
               final_grade = "A")

# Let's see the list
record
class(record)

# NOTE: like data frames we can use the accessor
# to access components or elements of the list

# Access the student_id vector
record$student_id


# Another way to access is with double brackets
record[["student_id"]]

# NOTE: in R there are different ways of doing the same things
# sometimes. We will see the usefulness of each with use