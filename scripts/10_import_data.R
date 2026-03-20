# CLASS 6 - DATA SCIENCE UCAB  
# IMPORTING DATA INTO R  

# We will use functions from certain R packages that allow us to import
# datasets into R.

# PACKAGES ----------------------------------------------------------------
library(tidyverse)
library(dslabs)
library(readxl)

# GET WORKING DIRECTORY ---------------------------------------------------

# Get the directory where you are currently located: the working directory
getwd()

# The dslabs package includes a CSV dataset.
# Run the following lines of code to copy that dataset into your working directory.

dir <- system.file(package = "dslabs")  # extracts the package location

filename <- file.path(dir, "extdata/murders.csv")

file.copy(filename, "murders.csv")

# Use the list.files() function to get a list of all files in your working directory
list.files()

# READ CSV ----------------------------------------------------------------

# Use the read.csv function to read the file with homicide data.
# Assign it to an object called dat and display the header.
dat <- read.csv("murders.csv")
head(dat)

# Import all columns as character type using the argument colClasses
dat <- read.csv("murders.csv", colClasses = "character")

# Verify that all columns are of character type
str(dat)

# EXCEL -------------------------------------------------------------------

# Read the CPI (Consumer Price Index) dataset
ipc <- read_excel("bcv_ipc_amc_1950.xls")

# Which sheet does R read automatically?

# Use the excel_sheets function to view the sheet names in the Excel workbook
excel_sheets("bcv_ipc_amc_1950.xls")

# Read the sheet named "Base 1984"
ipc <- read_excel("bcv_ipc_amc_1950.xls", sheet = "Base 1984")

# PRO TIP: USING FOR LOOPS ------------------------------------------------

# For loops in R allow you to repeat a block of code multiple times,
# making it easier to iterate over sequences, vectors, or lists.
# For example, if we want to calculate the square of the numbers 1 to 5, we can use a for loop like this:

for (i in 1:5) {
  print(paste("The square of", i, "is", i^2, "\n"))
}

# This will print the square of each number in the specified range.
# It’s an effective way to automate repetitive tasks.

## In the case of importing data, sometimes we want to read all the sheets
# of an Excel workbook. Loops and lists can help us do this.

# Read all sheets
hojas_excel <- excel_sheets("bcv_ipc_amc_1950.xls")

# TIP: use an empty list and a loop
lista_ipc <- list()

i <- 1
for (i in 1:length(hojas_excel)) {
  lista_ipc[[i]] <- read_excel("bcv_ipc_amc_1950.xls",
                               sheet = hojas_excel[i])
}

# Assign the appropriate names to the list elements
names(lista_ipc) <- hojas_excel