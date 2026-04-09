# CLASS 9 - DATA SCIENCE UCAB
# INTRODUCTION TO GGPLOT

# In this script, we'll practice using basic functions from the ggplot2 package.
# We'll explore a basic plot type: the scatter plot and how to modify it to
# our requirements.

# PACKAGES ----------------------------------------------------------------

library(tidyverse)
library(dslabs)
library(ggplot2)

rm(list = ls())


# DATA -------------------------------------------------------------------

data(murders)
head(murders)


# Let's see how to summarize table info in a single plot.

# Components of a ggplot plot:

# DATA, COMPONENTS, AESTHETIC MAPPING

# Define an empty plot with the murders table data.
ggplot(data = murders)


# The first argument will always be the data, so we can...
murders %>% ggplot()

# Assign it to an object 'p'. What type of object is it?
p <- ggplot(data = murders)
class(p)

print(p)
p


## SCATTER PLOT
# Use the geom_point geometry to create a scatter plot
# of population in millions and total homicides.
murders %>% ggplot() +
  geom_point(aes(x = population/10^6, y = total))


# We can also add layers to the 'p' object defined earlier.
# Let's add the abbreviation labels with geom_text.
p + geom_point(aes(population/10^6, total)) +
  geom_text(aes(population/10^6, total, label = abb))


# Try the following. Do you notice the difference?
p_test <- p + geom_text(aes(population/10^6, total), label = abb)



# Increase the size of the points with the 'size' argument.
p + geom_point(aes(population/10^6, total), size = 3) +
  geom_text(aes(population/10^6, total, label = abb))


# Now we can't read the labels. Can we move them a bit?
?geom_text

p + geom_point(aes(population/10^6, total), size = 3) +
  geom_text(aes(population/10^6, total, label = abb), nudge_x = 3)


# Do you see anything we can improve? Anything that looks unnecessary?
# We can avoid defining the same aes() over and over in each function.
# Define them in ggplot().
p <- murders %>%
  ggplot(aes(x = population/10^6, y = total, label = abb))

# Go back to the previous point (size and nudge_x).
p + geom_point(size = 3) +
  geom_text(nudge_x = 1.5)




# We can "play around" a bit.
# Local mapping definitions override the global one.
p + geom_point(size = 3) +
  geom_text(aes(x = 10, y = 800, label = "Hello"))





# SCALES -----------------------------------------------------------------


# Use the scale_x_continuous and scale_y_continuous functions.
p + geom_point(size = 3) +
  geom_text(nudge_x = 0.05) +
  scale_x_continuous(trans = "log10") +
  scale_y_continuous(trans = "log10")


# There are predefined functions to do the same thing.
p + geom_point(size = 3) +
  geom_text(nudge_x = 0.05) +
  scale_x_log10() +
  scale_y_log10()



# Example of logarithmic scales.
a <- c(100, 200, 400, 800, 1600)
b <- c(1:5)

plot(b, a)
plot(b, log(a))



# LABELS AND TITLE ------------------------------------------------------

# Use the xlab, ylab, ggtitle, and theme arguments.
p + geom_point(size = 3) +
  geom_text(nudge_x = 0.05) +
  scale_x_log10() +
  scale_y_log10() +
  xlab("Populations in millions (log scale)") +
  ylab("Total number of murders (log scale)") +
  ggtitle("US Gun Murders in 2010") +
  theme(plot.title = element_text(hjust = 0.5))




# COLORS -----------------------------------------------------------------


# Let's save what we have so far, except for geom_point.
# Rewrite 'p'.
p <-  murders %>%
  ggplot(aes(population/10^6, total, label = abb)) +
  geom_text(nudge_x = 0.05) +
  scale_x_log10() +
  scale_y_log10() +
  xlab("Populations in millions (log scale)") +
  ylab("Total number of murders (log scale)") +
  ggtitle("US Gun Murders in 2010")



# Add color to all points using the 'color' argument.
p + geom_point(size = 3, color ="midnightblue")


# We want to add color based on the region. So, we need to map
# the color.
p + geom_point(aes(color = region), size = 3)



# EXTRAS ------------------------------------------------------------------



# Add a line representing the national rate.
# Calculate the national rate per million inhabitants.
r <- murders %>%
  summarise(murder_rate = sum(total)/sum(population)*10^6) %>%
  .$murder_rate
r

# Add a line with geom_abline.
# We need to specify the intercept; by default, the slope is 1.
p + geom_point(aes(col=region), size = 3) +
  geom_abline(intercept = log10(r))

# We can modify the line type.
p <- p +
  geom_abline(intercept = log10(r), lty = 2, color = "darkgrey") +
  geom_point(aes(color = region), size = 3)
p


# Others
# Modify legend title.
p <- p +
  scale_color_discrete(name = "Region")
p


# Add The Economist theme.
library(ggthemes)
p + theme_economist()


# EXTRA -------------------------------------------------------------------


# Add a regression line.
p + geom_point(aes(color = region), size = 3) +
  geom_smooth(method='lm', formula= y~x) +
  theme_economist()





