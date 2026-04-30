# Lecture 01 - Introduction to Data Science
# Handout 05: vectors and subsetting

# VECTORS ----------------------------------------------------------------

codes <- c(380, 124, 818)
codes

country <- c("italy", "canada", "egypt")
country


# NAMED VECTORS ----------------------------------------------------------

codes <- c(italy = 380, canada = 124, egypt = 818)
codes

class(codes)
names(codes)

codes <- c(380, 124, 818)
names(codes) <- country
codes


# SEQUENCES --------------------------------------------------------------

seq(1, 10)

?seq
seq(1, 10, by = 2)

1:10

class(1:10)
class(seq(1, 10, by = 0.5))


# SUBSETTING VECTORS -----------------------------------------------------

codes[2]
codes[c(1, 3)]
codes["italy"]
codes[[2]]

my_seq <- 1:100
my_seq[c(2, 4, 6)]
my_seq[7:10]

my_seq_even <- seq(2, 100, by = 2)
my_seq_even
my_seq_even[3]


# SUBSETTING LISTS -------------------------------------------------------

record <- list(name = "John Doe", student_id = 1234, grades = c(95, 82, 91))

record["name"]
class(record["name"])

record[["name"]]
class(record[["name"]])


# COERCION ---------------------------------------------------------------

x <- c(1, "canada", 3)
x
class(x)

x <- 1:5
y <- as.character(x)
y

y <- as.numeric(y)
y


# NA VALUES --------------------------------------------------------------

country_num <- as.numeric(country)
country_num

x <- c("1", "b", "3")
as.numeric(x)
