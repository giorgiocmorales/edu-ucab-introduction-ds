# CLASS 10 - DATA SCIENCE UCAB  
# CONTINUATION OF GGPLOT  

# In this script we’ll continue practicing the use of ggplot and its functions, 
# placing particular emphasis on the facet_wrap and facet_grid functions.  


# PACKAGES ----------------------------------------------------------------

library(dslabs)
library(tidyverse)
library(ggplot2)
library(gridExtra)

rm(list = ls())

# DATA --------------------------------------------------------------------

# Load the gapminder dataset
data(gapminder)
head(gapminder)



# INTRODUCTION  -----------------------------------------------------------

gapminder %>%
  slice(1) %>% 
  ggplot(aes(x = 1, y = 1, label = "Journalists and lobbyists tell dramatic stories. That’s their job.
  They tell stories about extraordinary events and unusual people.
  The piles of dramatic stories pile up in peoples’ minds into 
  an over-dramatic worldview and strong negative stress feelings:
  “The world is getting worse!”, “It’s we vs. them!”, “Other people are strange!”,
  “The population just keeps growing!” and “Nobody cares!”"))+
  geom_text(size = 10) + 
  xlim(0, 2) + ylim(0, 2) + theme_void()
# We will try to answer two questions:

# 1. Should we still say that the world is divided between rich countries 
# and developing countries in Africa, Asia, and Latin America?

# 2. Has income inequality between countries worsened over the last 40 years?

# INITIAL EXPLORATION  ----------------------------------------------------

# Check the infant mortality rates for Sri Lanka and Turkey
gapminder %>% filter(year == 2015 & country %in% c("Sri Lanka","Turkey")) %>% 
              select(country, infant_mortality)


## CLASS EXERCISE: Which countries have the highest infant mortality rates? 
# Compare the infant mortality rates of:
# "Sri Lanka", "Turkey"
# "Poland", "South Korea"
# "Malaysia", "Russia"
# "Pakistan","Vietnam"
# "Thailand","South Africa"

comp_table <- tibble(comparison = rep(1:5, each = 2),
              country = c("Sri Lanka", "Turkey", "Poland", "South Korea", "Malaysia", "Russia", "Pakistan","Vietnam","Thailand","South Africa"))

tmp <- gapminder %>% filter(year == 2015) %>% 
                     select(country, infant_mortality) %>% 
                     mutate(country = as.character(country))

tab <- inner_join(comp_table, tmp, by = "country") %>% 
  select(-comparison)
  
# Create a simple table to compare at a glance
bind_cols(slice(tab,seq(1,9,2)), slice(tab,seq(2,10,2)))


# When answering these questions without data, non-European countries are usually 
# assumed to have higher child mortality rates: Sri Lanka over Turkey, South Korea over 
# Poland, and Malaysia over Russia. It’s also common to assume that countries considered 
# to be part of the developing world — Pakistan, Vietnam, Thailand, and South Africa — 
# have similarly high mortality rates.

# However, we see that the European countries on this list actually have higher child mortality rates: 
# Poland has a higher rate than South Korea, and Russia has a higher rate than Malaysia. 
# We also see that Pakistan’s rate is much higher than Vietnam’s, and South Africa’s 
# is much higher than Thailand’s. When Hans Rosling gave this quiz to educated audiences, 
# the average score was below 2.5 out of 5 — worse than random guessing. 
# This suggests that we are not simply ignorant but misinformed. In this lesson, we’ll see 
# how data visualization helps correct such misconceptions.

# LIFE EXPECTANCY AND FERTILITY -------------------------------------------

# The misconception described above comes from the idea that the world is divided 
# into two groups: the western world (Western Europe and North America), characterized 
# by long life spans and small families, versus the developing world (Africa, Asia, and 
# Latin America), characterized by short life spans and large families. But do the data 
# support this binary view?

# Create a simple scatter plot of fertility vs life expectancy in 1962.
# We can see that most points fall into two groups:
# 1. Life expectancy around 70 years and 3 or fewer children per family
# 2. Life expectancy below 65 years and more than 5 children per family

gapminder %>% 
  filter(year == 1962) %>%
  ggplot(aes(fertility, life_expectancy)) +
  geom_point()

gapminder %>% 
  filter(year == 1962) %>%
  ggplot(aes(fertility, life_expectancy)) +
  geom_point() + 
  geom_vline(aes(xintercept = 5)) +
  geom_hline(aes(yintercept = 55))

# Add color by continent to identify if the countries belong to the regions we assume

filter(gapminder, year == 1962) %>%
  ggplot(aes(fertility, life_expectancy, color = continent)) +
  geom_point() 

# We see that in 1962 this “developed vs. developing world” vision 
# was indeed reflected in reality. But does it hold decades later?

# FACETING  ---------------------------------------------------------------
# We want to compare plots between 1960 and 2015. We could 
# make two separate plots, but ggplot offers a solution through faceting. 

# This means stratifying the data by a variable and creating the same plot 
# for each category of that stratification variable. 

# facet_grid lets us stratify by up to two variables (for rows and columns,
# separated by ~)

gapminder %>% 
  filter(year %in% c(1960, 2015)) %>%
  ggplot(aes(fertility, life_expectancy, color = continent)) +
  geom_point() +
  facet_grid(continent~year)


# Reverse the row/column division of the grid and invert the order of the years
gapminder %>% 
  filter(year %in% c(1960, 2015)) %>%
  ggplot(aes(fertility, life_expectancy, color = continent)) +
  geom_point() +
  facet_grid(desc(year)~continent)


# Make a simpler plot — don’t divide the grid by continent, just compare the years
filter(gapminder, year %in% c(1960, 2015)) %>%
  ggplot(aes(fertility, life_expectancy, color = continent)) +
  geom_point() +
  facet_grid(. ~ year)

# FACET WRAP  -------------------------------------------------------------

# facet_wrap lets us create plots that aren’t arranged in a single row (the default for facet_grid)

# Compare Europe and Asia and observe their evolution every 10 years.
# Define a vector of years and a vector of continents, filter the data, and make the plot.
years <- c(1960, 1970, 1980, 1990, 2000, 2015)
continents <- c("Europe", "Asia")
gapminder %>% 
  filter(year %in% years & continent %in% continents) %>%
  ggplot(aes(fertility, life_expectancy, color = continent)) +
  geom_point() +
  facet_wrap(. ~ year) 


# A poor comparison:

p1 <- filter(gapminder, year == 1962) %>%
  ggplot(aes(fertility, life_expectancy, color = continent)) +
  geom_point() 

p2 <- filter(gapminder, year == 2012) %>%
  ggplot(aes(fertility, life_expectancy, color = continent)) +
  geom_point() 

grid.arrange(p1, p2, ncol = 2)


# Why is the previous comparison poor?


# TIME SERIES -------------------------------------------------------------

# Create a scatter plot of years vs fertility for the U.S.
gapminder %>% 
  filter(country == "United States") %>% 
  ggplot(aes(year, fertility)) +
  geom_point()

# Add a line connecting the points
gapminder %>% filter(country == "United States") %>% 
  ggplot(aes(year,fertility)) +
  geom_point() +
  geom_line()

# Compare Germany and South Korea with line charts — done incorrectly
countries <- c("South Korea", "Germany")
gapminder %>% 
  filter(country %in% countries) %>% 
  ggplot(aes(year,fertility)) +
  geom_line()

# Correct version — we must specify how to group
gapminder %>% filter(country %in% countries) %>% 
  ggplot(aes(year, fertility, group = country)) +
  geom_line()

# If you use the color argument, it groups automatically
gapminder %>% filter(country %in% countries) %>% 
  ggplot(aes(year,fertility, color = country)) +
  geom_line()

# LABELS VS LEGEND ----------------------------------------------------

# Create a table with label information
labels <- data.frame(country = countries, 
                     x = c(1975, 1965), y = c(60, 72))
labels

# Repeat the previous plot removing the legend and adding text labels
gapminder %>% 
  filter(country %in% countries) %>% 
  ggplot(aes(year, life_expectancy, color = country)) +
  geom_line() +
  geom_text(data = labels, aes(x, y, label = country), size = 5) +
  theme(legend.position = "none")

# INCOME DISTRIBUTION -------------------------------------------------

# Create a new variable — dollars per day — equal to GDP divided by population and then divided by the number of days in a year
gapminder <- gapminder %>% 
  mutate(dollars_per_day = gdp/population/365)

# Create a histogram of the distribution of the dollars_per_day variable for 1970
past_year <- 1970
gapminder %>% 
  filter(year == past_year & !is.na(gdp)) %>%
  ggplot(aes(dollars_per_day)) + 
  geom_histogram(binwidth = 1, color = "black", fill = "midnight blue")

# We can add a transformation that might be more informative:
# Apply a base-2 logarithm to the variable
gapminder %>% 
  filter(year == past_year & !is.na(gdp)) %>%
  ggplot(aes(log2(dollars_per_day))) + 
  geom_histogram(binwidth = 1, color = "midnight blue", fill = "light blue")

# Create a histogram of the population variable
# For population, using a log10 transformation makes more sense
gapminder %>% filter(year == past_year) %>%
  ggplot(aes(log10(population))) +
  geom_histogram(binwidth = 0.5, color = "black", fill = "midnight blue")


# TRANSFORMING SCALES OR VALUES -------------------------------------------

# Create the histogram of dollars per day but this time use scale_x_continuous to transform the x-axis to a log2 scale
gapminder %>% 
  filter(year == past_year & !is.na(gdp)) %>%
  ggplot(aes(dollars_per_day)) + 
  geom_histogram(binwidth = 1, color = "midnight blue", fill = "light blue") +
  scale_x_continuous(trans = "log2")

