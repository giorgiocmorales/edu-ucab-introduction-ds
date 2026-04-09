# CLASS 10 - DATA SCIENCE UCAB  
# CONTINUATION OF GGPLOT  

# In this script we will continue practicing the use of ggplot and its functions,
# emphasizing visualization principles.

# PACKAGES ----------------------------------------------------------------
library(tidyverse)
library(gridExtra)
library(dslabs)
library(ggthemes)
library(scales)

rm(list = ls())

# GEOMETRY ---------------------------------------------------------------

# We create a table of major browsers and their usage rates between 2000 and 2015
browsers <- data.frame(Browser = rep(c("Opera","Safari","Firefox","IE","Chrome"), 2),
                       Year = rep(c(2000, 2015), each = 5),
                       Percentage = c(3,21,23,28,26, 
                                      2,22,21,27,29)) %>%
  mutate(Browser = reorder(Browser, Percentage))

browsers

# Using a Pie chart
p1 <- browsers %>% 
  ggplot(aes(x = "",y = Percentage, fill = Browser)) +
  geom_bar(width = 1, stat = "identity", col = "black")  + 
  coord_polar(theta = "y") +
  theme_excel() + 
  xlab("") + ylab("") +
  theme(axis.text=element_blank(), 
        axis.ticks = element_blank(), 
        panel.grid  = element_blank()) +
  facet_grid(.~Year)

p1


# Donut chart
browsers %>% 
  ggplot(aes(x = 2, y = Percentage, fill = Browser)) +
  geom_bar(width = 1, stat = "identity", col = "black")  + 
  scale_x_continuous(limits=c(0.5,2.5)) + 
  coord_polar(theta = "y") +
  theme_excel() + xlab("") + ylab("") +
  theme(axis.text=element_blank(), 
        axis.ticks = element_blank(), 
        panel.grid  = element_blank()) +
  facet_grid(.~Year)

# Showing the table can sometimes be clearer than making pie or donut charts
# This way you can print tables in Markdown
browsers %>% 
  spread(Year, Percentage) %>% 
  knitr::kable()

# Bar chart
p2 <-browsers %>%
  ggplot(aes(Browser, Percentage)) + 
  geom_bar(stat = "identity", width=0.5, fill=4, col = 1) +
  ylab("Percent using the Browser") +
  facet_grid(.~Year)

p2

# Comparison between pie chart and bar chart
grid.arrange(p1, p2, nrow = 2)


# Pie chart with labels

browsers <- filter(browsers, Year == 2015)

at <- with(browsers, 100 - cumsum(c(0,Percentage[-length(Percentage)])) - 0.5*Percentage)  

label <- percent(browsers$Percentage/100)

browsers %>% 
  ggplot(aes(x = "", y = Percentage, fill = Browser)) +
  geom_bar(width = 1, stat = "identity", col = "black")  + 
  coord_polar(theta = "y") +
  theme_excel() + 
  xlab("") + ylab("") + 
  ggtitle("2015") +
  theme(axis.text=element_blank(), 
        axis.ticks = element_blank(), 
        panel.grid  = element_blank()) +
  annotate(geom = "text",
           x = 1.62, 
           y =  at, 
           label = label, size=4)



# DO NOT DISTORT VALUES -------------------------------------------------

# https://rafalab.dfci.harvard.edu/dslibro/principios-de-visualizaci%C3%B3n-de-datos.html

# Distorted column chart
data.frame(Year = as.character(c(2011, 2012, 2013)),
           Southwest_Border_Apprehensions = c(165244,170223,192298)) %>%
  ggplot(aes(Year, Southwest_Border_Apprehensions)) +
  geom_col(fill = "dark green", col = "black", width = 0.65) + 
  scale_y_continuous(limits=c(155000,NA),oob = rescale_none)

# Corrected
data.frame(Year = as.character(c(2011, 2012, 2013)),
           Southwest_Border_Apprehensions = c(165244,170223,192298)) %>%
  ggplot(aes(Year, Southwest_Border_Apprehensions )) +
  geom_col(fill = "dark green", col = "black", width = 0.65) 


# Distorted column chart
data.frame(date = c("Now", "Jan 1, 2013"), 
           tax_rate = c(35, 39.6)) %>%
  mutate(date = reorder(date, tax_rate)) %>%
  ggplot(aes(date, tax_rate)) + 
  ylab("") + xlab("") +
  geom_col(fill = "dark blue", col = "black", width = 0.5) + 
  ggtitle("Top Tax Rate If Bush Tax Cut Expires") + 
  scale_y_continuous(limits=c(34, NA),oob = rescale_none)

# Corrected
data.frame(date = c("Now", "Jan 1, 2013"), 
           tax_rate = c(35, 39.6)) %>%
  mutate(date = reorder(date, tax_rate)) %>%
  ggplot(aes(date, tax_rate)) + 
  ylab("") + xlab("") +
  geom_col(fill = "dark blue", col = "black", width = 0.5) + 
  ggtitle("Top Tax Rate If Bush Tax Cut Expires")

# Sometimes excluding zero can be useful to appreciate differences between groups
# relative to the variability within a group
p1 <- gapminder %>% 
  filter(year == 2012) %>%
  ggplot(aes(continent, life_expectancy)) +
  geom_point()

p2 <- p1 +
  scale_y_continuous(limits = c(0, 84))
grid.arrange(p2, p1, ncol = 2)


# Distorted relationship
gdp <- c(14.6, 5.7, 5.3, 3.3, 2.5)
gdp_data <- data.frame(Country = rep(c("United States", "China", 
                                       "Japan", "Germany", "France"), 2),
                       
                       y = factor(rep(c("Radius","Area"), each = 5), 
                                  levels = c("Radius", "Area")),
                       
                       GDP= c(gdp^2/min(gdp^2), gdp/min(gdp))) %>%
  
  mutate(Country = reorder(Country, GDP))

# Distorted vs. non-distorted dot chart
gdp_data %>% 
  ggplot(aes(Country, y, size = GDP)) + 
  geom_point(show.legend = FALSE, color = "blue") + 
  scale_size(range = c(2,30)) +
  coord_flip() + ylab("") + xlab("")

# Same chart but using bars
gdp_data %>% 
  filter(y == "Area") %>%
  ggplot(aes(Country, GDP)) + 
  geom_col(fill = "midnight blue") + 
  ylab("GDP in trillions of US dollars")



# SORT BY AN IMPORTANT VALUE ------------------------------------------

data(murders)

# Unsorted
p1 <- murders %>% mutate(murder_rate = total / population * 100000) %>%
  ggplot(aes(state, murder_rate)) +
  geom_bar(stat="identity") +
  coord_flip() +
  xlab("")

# Sorted
p2 <- murders %>% mutate(murder_rate = total / population * 100000) %>%
  mutate(state = reorder(state, murder_rate)) %>%
  ggplot(aes(state, murder_rate)) +
  geom_bar(stat="identity") +
  coord_flip() +
  xlab("")

grid.arrange(p1, p2, ncol = 2)

# Gapminder
past_year <- 1970

# Unsorted
p1 <- gapminder %>% 
  mutate(dollars_per_day = gdp/population/365) %>%
  filter(year == past_year & !is.na(gdp)) %>%
  ggplot(aes(region, dollars_per_day, fill = continent)) +
  geom_boxplot() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  xlab("")

# Sorted
p2 <- gapminder %>% 
  mutate(dollars_per_day = gdp/population/365) %>%
  filter(year == past_year & !is.na(gdp)) %>%
  mutate(region = reorder(region, dollars_per_day, FUN = median)) %>%
  ggplot(aes(region, dollars_per_day, fill = continent)) +
  geom_boxplot() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  xlab("")
grid.arrange(p1, p2, ncol=2)



# SHOW THE DATA -----------------------------------------------------------

# Plot
heights %>% 
  ggplot(aes(sex, height)) + geom_point() 

# Add extra details to make it more informative
heights %>% 
  ggplot(aes(sex, height)) + 
  geom_jitter(width = 0.1, alpha = 0.2) 



# MAKE COMPARISONS EASIER: USE COMMON AXES ----------------------------

# Compare distributions with free x-axis
heights %>% 
  ggplot(aes(height, after_stat(density), fill = sex)) +
  geom_histogram(binwidth = 1, color = "#808080") +
  facet_grid(.~sex, scales = "free_x")

# Fixed x-axis
heights %>% 
  ggplot(aes(height, after_stat(density), fill = sex)) +
  geom_histogram(binwidth = 1, color="#808080") +
  facet_grid(.~sex)

# ALIGN BASED ON THE COMPARISON YOU WANT TO SEE
# Assign it to an object p1
# Comparison of horizontally aligned distributions
p1 <- heights %>% 
  ggplot(aes(height, after_stat(density), fill = sex)) +
  geom_histogram(binwidth = 1, color="black") +
  facet_grid(sex~.)
p1


# For a more compact summary, use boxplots
heights %>% 
  ggplot(aes(sex, height)) + 
  # coef modifies whisker length to determine outliers
  geom_boxplot(coef=3) + 
  ylab("Height in inches")

# Follows the principle of SHOW THE DATA
# Assign it to an object p2
p2 <- heights %>% 
  ggplot(aes(sex, height)) + 
  geom_boxplot(coef=3) + 
  geom_jitter(width = 0.1, alpha = 0.2) +
  ylab("Height in inches")
p2

# Combine both plots in one figure
grid.arrange(p1, p2, ncol = 2)



# MAKE COMPARISONS EASIER: USE COLOR --------------------------------------

# Any issues with the axes?
gapminder %>% 
  filter(year %in% c(1970, 2010) & !is.na(gdp)) %>%
  mutate(dollars_per_day = gdp/population/365) %>%
  mutate(labels = paste(year, continent)) %>%
  
  ggplot(aes(labels, dollars_per_day)) +
  geom_boxplot() + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  scale_y_continuous(trans = "log2") + 
  ylab("Income in dollars per day")

# Fix the labels
gapminder %>% 
  filter(year %in% c(1970, 2010) & !is.na(gdp)) %>%
  mutate(dollars_per_day = gdp/population/365) %>%
  mutate(labels = paste(continent, year)) %>%
  ggplot(aes(labels, dollars_per_day)) +
  geom_boxplot() + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  scale_y_continuous(trans = "log2") + 
  ylab("Income in dollars per day")


# Agreguemos color y facilitemos la comparacion y la estetica de los ejes
gapminder %>%
  filter(year %in% c(1970, 2010) & !is.na(gdp)) %>%
  mutate(dollars_per_day = gdp/population/365, year = factor(year)) %>%
  ggplot(aes(continent, dollars_per_day, fill = year)) +
  geom_boxplot() + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  scale_y_continuous(trans = "log2") + 
  ylab("Income in dollars per day")


# EXTRA -------------------------------------------------------------------

# Think of the color blind
color_blind_friendly <- c("#999999", "#E69F00", "#56B4E9",
                          "#009E73", "#F0E442", "#0072B2", 
                          "#D55E00", "#CC79A7")
p1 <- data.frame(x=1:8, y=1:8, col = as.character(1:8)) %>% 
  
  ggplot(aes(x, y, color = col)) + 
  geom_point(size=5)

# Assign a color palette manually
p1 + scale_color_manual(values=color_blind_friendly)
