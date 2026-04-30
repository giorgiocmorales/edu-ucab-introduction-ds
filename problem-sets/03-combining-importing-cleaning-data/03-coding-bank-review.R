# Problem Set 03 - Coding bank review script
# Lecture 03: Combining, Importing, and Cleaning Data

# PACKAGES ---------------------------------------------------------------

library(tidyverse)


# HELPERS ----------------------------------------------------------------

answer <- function(question, value) {
  cat(question, "=", as.character(value), "\n")
}


# CODING QUESTION 03-C1 --------------------------------------------------

month_lookup <- tibble(
  Month = c(5, 6, 7, 8, 9),
  month_name = c("May", "June", "July", "August", "September")
)

q03_c1 <- as_tibble(airquality) %>%
  left_join(month_lookup, by = "Month") %>%
  group_by(month_name) %>%
  summarise(avg_temp = mean(Temp, na.rm = TRUE), .groups = "drop") %>%
  arrange(desc(avg_temp)) %>%
  slice(1) %>%
  pull(month_name)

answer("03-C1", q03_c1)


# CODING QUESTION 03-C2 --------------------------------------------------

treatment_lookup <- tibble(
  Treatment = c("nonchilled", "chilled"),
  treatment_label = c("Not chilled", "Chilled")
)

q03_c2 <- as_tibble(CO2) %>%
  left_join(treatment_lookup, by = "Treatment") %>%
  group_by(treatment_label) %>%
  summarise(avg_uptake = mean(uptake), .groups = "drop") %>%
  arrange(desc(avg_uptake)) %>%
  slice(1) %>%
  pull(treatment_label)

answer("03-C2", q03_c2)


# CODING QUESTION 03-C3 --------------------------------------------------

tree_lookup <- tibble(
  Tree = factor(c(1, 2, 3, 4, 5), levels = levels(Orange$Tree), ordered = TRUE),
  tree_label = c("Tree 1", "Tree 2", "Tree 3", "Tree 4", "Tree 5")
)

q03_c3 <- as_tibble(Orange) %>%
  left_join(tree_lookup, by = "Tree") %>%
  group_by(tree_label) %>%
  summarise(avg_circumference = mean(circumference), .groups = "drop") %>%
  arrange(desc(avg_circumference)) %>%
  slice(1) %>%
  pull(tree_label)

answer("03-C3", q03_c3)


# CODING QUESTION 03-C4 --------------------------------------------------

spray_lookup <- tibble(
  spray = LETTERS[1:6],
  spray_label = paste("Spray", LETTERS[1:6])
)

q03_c4 <- as_tibble(InsectSprays) %>%
  left_join(spray_lookup, by = "spray") %>%
  group_by(spray_label) %>%
  summarise(avg_count = mean(count), .groups = "drop") %>%
  arrange(desc(avg_count)) %>%
  slice(1) %>%
  pull(spray_label)

answer("03-C4", q03_c4)


# CODING QUESTION 03-C5 --------------------------------------------------

tension_lookup <- tibble(
  tension = c("L", "M", "H"),
  tension_label = c("Low tension", "Medium tension", "High tension")
)

q03_c5 <- as_tibble(warpbreaks) %>%
  left_join(tension_lookup, by = "tension") %>%
  group_by(tension_label) %>%
  summarise(avg_breaks = mean(breaks), .groups = "drop") %>%
  arrange(desc(avg_breaks)) %>%
  slice(1) %>%
  pull(tension_label)

answer("03-C5", q03_c5)


# CODING QUESTION 03-C6 --------------------------------------------------

group_lookup <- tibble(
  group = factor(c(1, 2), levels = levels(sleep$group)),
  group_label = c("Group 1", "Group 2")
)

q03_c6 <- as_tibble(sleep) %>%
  left_join(group_lookup, by = "group") %>%
  group_by(group_label) %>%
  summarise(avg_extra = mean(extra), .groups = "drop") %>%
  arrange(desc(avg_extra)) %>%
  slice(1) %>%
  pull(group_label)

answer("03-C6", q03_c6)
