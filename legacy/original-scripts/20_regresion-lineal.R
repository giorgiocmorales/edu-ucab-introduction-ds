
library(tidyverse)
library(dslabs)
library(HistData)
library(ggrepel)
library(ggthemes)
library(gridExtra)


# CASO DE ESTUDIO: la altura es hereditaria?

data("GaltonFamilies")

set.seed(1983)
galton_heights <- GaltonFamilies %>%
  filter(gender == "male") %>%
  group_by(family) %>%
  sample_n(1) %>%
  ungroup() %>%
  select(father, childHeight) %>%
  rename(son = childHeight)

# Para ver el promedio y la desviacion estandar
galton_heights %>%
  summarise(mean(father), sd(father), mean(son), sd(son))


# CORRELACION -------------------------------------------------------------


# Hacemos un grafico para ver la correlacion
galton_heights %>% 
  ggplot(aes(father, son)) +
  geom_point(alpha = 0.5)

# Calcular coeficiente de correlacion
galton_heights %>% 
  summarise(r = cor(father, son)) %>% 
  pull(r)



# EXPLICAR FORMULA DE CORRELACION



# EXPECTATIVAS CONDICIONALES ----------------------------------------------


# Predecir altura de un hijo al azar
mean(galton_heights$son)
mean(galton_heights$father)

# Que pasa si condicionamos basado en la altura del padre?

# Suponga que el padre mide 72 pulgadas
sum(galton_heights$father == 72)

# Si mide 72.5
sum(galton_heights$father == 72.5)



# Calculemos la media suponiendo que el padre mide 72 pulgadas
conditional_avg <- galton_heights %>%
  
  # Redondeamos la altura del padre para tener mas valores
  filter(round(father) == 72) %>%
  summarize(avg = mean(son)) %>%
  pull(avg)

conditional_avg


# Cuantas desviaciones estandar mas alto es un padre que mide 72
(72-mean(galton_heights$father))/sd(galton_heights$father)

# Cuantas desviaciones estandar mas alto es un hijo cuyo padre mide 72
(conditional_avg-mean(galton_heights$son))/sd(galton_heights$son)


# Estratificamos cada pulgada y calculamos medias condicionales
# Agregamos un boxplot y todos los puntos
galton_heights %>% 
  mutate(father_strata = factor(round(father))) %>%
  ggplot(aes(father_strata, son)) +
  geom_boxplot() +
  geom_point()

# Grafica nada mas la variable estartificada de padre vs 
# las medias condicionales de los hijos
galton_heights %>% 
  mutate(father_strata = factor(round(father))) %>%
  group_by(father_strata) %>%
  summarise(son_avg = mean(son, na.rm = T)) %>%
  ggplot(aes(father_strata, son_avg)) +
  geom_point() 



# REGRESION ---------------------------------------------------------------

# Agregar linea de regresion a grafico original
mu_x <- mean(galton_heights$father)
mu_y <- mean(galton_heights$son)
s_x <- sd(galton_heights$father)
s_y <- sd(galton_heights$son)
r <- cor(galton_heights$father, galton_heights$son)

galton_heights %>%
  ggplot(aes(father, son)) +
  geom_point(alpha = 0.5) +
  geom_abline(slope = r * s_y/s_x, intercept = mu_y - r * s_y/s_x * mu_x)

# Alternativa
galton_heights %>%
  ggplot(aes(father, son)) +
  geom_point(alpha = 0.5) +
  geom_smooth(formula = y~x, method = "lm", color = "black")



# EJEMPLO ANSCOMBE --------------------------------------------------------


tab_anscombe <- anscombe


# Reordenar tabla
tab_anscombe <- tibble(group = rep(1:4, each = 11),
                       x = c(anscombe$x1, anscombe$x2, anscombe$x3, anscombe$x4),
                       y = c(anscombe$y1, anscombe$y2, anscombe$y3, anscombe$y4))

# Correlacion
tab_anscombe %>%
  group_by(group) %>%
  summarise(r = cor(x, y))
  
# Plot
tab_anscombe %>%
  ggplot(aes(x, y)) +
  geom_point() + 
  facet_wrap(group~.)


# -------------------------------------------------------------------------

