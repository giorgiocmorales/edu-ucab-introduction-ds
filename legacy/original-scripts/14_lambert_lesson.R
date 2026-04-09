## Load packages

library(tidyverse)
library(ggplot2)

#Import data 

df <- read.csv("data/raw/master.csv")

# Structure
str(df)

# Comparison ------

# Standard way
plot(df$population, df$suicides_no)

# ggplot

ggplot(df, aes(x = population, y = suicides_no)) + 
  geom_point()

# How to colour points ------

# Traditional requieres wide data
df_wide <- df %>%
  select(country, year, age, sex, population, suicides_no) %>%
  pivot_wider(names_from = sex,
              values_from = c(population, suicides_no),
              names_sep = "_")

plot(df_wide$population_male, df_wide$suicides_no_male, col = "red")
points(df_wide$population_female, df_wide$suicides_no_female, col = "blue")

# With ggplot
ggplot(df, aes(x = population, y = suicides_no, colour = sex)) +
  geom_point()

# Aesthetics and Geoms ------

# Color by country
df %>% 
  filter(country == c("Bahrain", "Lithuania", "Sri Lanka", "United Kingdom", "Uzbekistan")) %>%
ggplot(aes(x = population, y = suicides_no, colour = country)) +
  geom_point()

df %>% 
  filter(country == c("Bahrain", "Lithuania", "Sri Lanka", "United Kingdom", "Uzbekistan")) %>%
  ggplot(aes(x = population, y = suicides_no, colour = country)) +
  geom_point()

# Shape by country
df %>% 
  filter(country == c("Bahrain", "Lithuania", "Sri Lanka", "United Kingdom", "Uzbekistan")) %>%
  ggplot(aes(x = population, y = suicides_no, shape = country)) +
  geom_point()

# Regression by country
df %>%
  filter(country == c("Bahrain", "Lithuania", "Sri Lanka", "United Kingdom", "Uzbekistan")) %>%
  ggplot(aes(x = population, y = suicides_no, colour = country)) +
  geom_point(alpha = 0.3) + 
  geom_smooth(method  = "lm", se = FALSE)

# Regression for all data
df %>%
  filter(country == c("Bahrain", "Lithuania", "Sri Lanka", "United Kingdom", "Uzbekistan")) %>%
  ggplot(aes(x = population, y = suicides_no)) +
  geom_smooth(method = "lm", se = FALSE, colour = "black") +
  geom_point(alpha = 0.3, aes(colour = country))

# Playing with geoms
x <- c(1,2,3)
y <- c(2,4,10)
label <- c("a", "b", "c")

data_df <- tibble(y, x, label)

# Illustrating geoms
ggplot(data_df, aes(x, y, label = label)) +
  theme(text = element_text(size = 14)) +
  geom_point()

ggplot(data_df, aes(x, y, label = label)) +
  theme(text = element_text(size = 10)) +
  geom_text(size = 12)

ggplot(data_df, aes(x, y, label = label)) +
  theme(text = element_text(size = 14)) +
  geom_col() # Column

ggplot(data_df, aes(x, y, label = label)) +
  theme(text = element_text(size = 14)) +
  geom_line()

ggplot(data_df, aes(x, y, label = label)) +
  theme(text = element_text(size = 14)) +
  geom_line() + 
  geom_point()

ggplot(data_df, aes(x, y, label = label)) +
  theme(text = element_text(size = 14)) +
  geom_line() + 
  geom_jitter()

# Combine geoms
ggplot(data_df, aes(x, y, label = label)) +
  theme(text = element_text(size = 14)) +
  geom_smooth(method = "lm", se = F, formula = y~x) + 
  geom_jitter()

ggplot(data_df, aes(x, y, label = label)) +
  theme(text = element_text(size = 14)) +
  geom_polygon()

# The order of layering matters

# Regression for all data
df %>%
  filter(country == c("Bahrain", "Lithuania", "Sri Lanka", "United Kingdom", "Uzbekistan")) %>%
  ggplot(aes(x = population, y = suicides_no)) +
  geom_point(alpha = 1, aes(colour = country)) + 
  geom_smooth(method = "lm", se = FALSE, colour = "black")

df %>%
  filter(country == c("Bahrain", "Lithuania", "Sri Lanka", "United Kingdom", "Uzbekistan")) %>%
  ggplot(aes(x = population, y = suicides_no)) +
  geom_smooth(method = "lm", se = FALSE, colour = "black") +
  geom_point(alpha = 1, aes(colour = country))

# Change Axis Scales

df %>%
  filter(country == c("Bahrain", "Lithuania", "Sri Lanka", "United Kingdom", "Uzbekistan")) %>%
  ggplot(aes(x = population, y = suicides_no)) +
  geom_point(alpha = 0.3, aes(colour = country)) +
  scale_x_sqrt() +
  scale_y_sqrt()

  



