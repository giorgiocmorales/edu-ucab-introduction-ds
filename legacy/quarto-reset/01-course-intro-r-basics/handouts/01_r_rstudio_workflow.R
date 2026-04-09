# SESSION 01 - HANDOUT A
# R and RStudio workflow

# SHORTCUTS --------------------------------------------------------------

# Ctrl + Enter: run line or selection
# Ctrl + Shift + Enter: run the full script
# Ctrl + Shift + C: comment or uncomment
# Ctrl + Shift + R: insert section
# Alt + O: collapse all sections


# BASIC OPERATIONS -------------------------------------------------------

5 + 2
5 - 2
5 * 2
5 / 2
2 ^ 2
sqrt(16)
abs(-10)


# OBJECTS ----------------------------------------------------------------

x <- 5
x

x <- 5 + 2
x

var_text <- "UCAB"
var_text

vector_text <- c("Introduction", "to", "Data Science")
vector_text
paste(vector_text, collapse = " ")


# WHY SCRIPTS MATTER -----------------------------------------------------

# Write important work in scripts, not only in the console.
# Good scripts are readable, sequential, and reproducible.


# PACKAGES ---------------------------------------------------------------

# Install once if needed
# install.packages("dslabs")

# Load in every new session
library(dslabs)


# PREINSTALLED DATA ------------------------------------------------------

data()

base <- USArrests
?USArrests
head(base)


# FIRST LOOK AT RSTUDIO WORKFLOW -----------------------------------------

# 1. Write code in the script.
# 2. Run selected lines in the console.
# 3. Save useful outputs as objects.
# 4. Keep comments that explain the logic.
