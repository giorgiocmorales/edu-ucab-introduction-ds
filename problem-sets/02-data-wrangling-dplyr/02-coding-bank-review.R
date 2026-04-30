# Problem Set 02 - Coding bank review script
# Lecture 02: Data Wrangling with dplyr and Tidy Data

# PACKAGES ---------------------------------------------------------------

library(tidyverse)


# HELPERS ----------------------------------------------------------------

answer <- function(question, value) {
  cat(question, "=", as.character(value), "\n")
}


# CODING QUESTION 02-C1 --------------------------------------------------

q02_c1 <- as_tibble(mtcars, rownames = "model") %>%
  group_by(cyl) %>%
  summarise(avg_mpg = mean(mpg), .groups = "drop") %>%
  arrange(desc(avg_mpg)) %>%
  slice(1) %>%
  pull(cyl)

answer("02-C1", q02_c1)


# CODING QUESTION 02-C2 --------------------------------------------------

q02_c2 <- as_tibble(iris) %>%
  group_by(Species) %>%
  summarise(avg_sepal_length = mean(Sepal.Length), .groups = "drop") %>%
  arrange(desc(avg_sepal_length)) %>%
  slice(1) %>%
  pull(Species)

answer("02-C2", q02_c2)


# CODING QUESTION 02-C3 --------------------------------------------------

q02_c3 <- as_tibble(ToothGrowth) %>%
  group_by(supp) %>%
  summarise(avg_len = mean(len), .groups = "drop") %>%
  arrange(desc(avg_len)) %>%
  slice(1) %>%
  pull(supp)

answer("02-C3", q02_c3)


# CODING QUESTION 02-C4 --------------------------------------------------

q02_c4 <- as_tibble(ChickWeight) %>%
  filter(Time == 21) %>%
  group_by(Diet) %>%
  summarise(avg_weight = mean(weight), .groups = "drop") %>%
  arrange(desc(avg_weight)) %>%
  slice(1) %>%
  pull(Diet)

answer("02-C4", q02_c4)


# CODING QUESTION 02-C5 --------------------------------------------------

q02_c5 <- as_tibble(PlantGrowth) %>%
  group_by(group) %>%
  summarise(avg_weight = mean(weight), .groups = "drop") %>%
  arrange(desc(avg_weight)) %>%
  slice(1) %>%
  pull(group)

answer("02-C5", q02_c5)


# CODING QUESTION 02-C6 --------------------------------------------------

usarrests_tbl <- as_tibble(USArrests)
usarrests_tbl$state <- rownames(USArrests)

q02_c6 <- usarrests_tbl %>%
  mutate(violent_total = Murder + Assault) %>%
  arrange(desc(violent_total)) %>%
  slice(1) %>%
  pull(state)

answer("02-C6", q02_c6)
