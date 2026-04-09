
library(tidyverse)
library(dslabs)
library(readxl)

# ESTUDIO DE CASO: RULETA CASINO

# Composicion de un ruleta
color <- rep(c("Black", "Red", "Green"), c(18, 18, 2))

# Lancemos 1000 veces
n <- 1000
X <- sample(ifelse(color == "Red", -1, 1),  n, replace = TRUE)
X[1:10]

# Saquemos una muestra respetando las probabilidades de salir de cada una
set.seed(10)
X <- sample(c(-1,1), n, replace = TRUE, prob = c(9/19, 10/19))
S <- sum(X)
S



# SIMULACION MONTE CARLO --------------------------------------------------

# Numero de personas
n <- 1000

# Numero de veces que repetimos el experimento
B <- 10000

# Definimos una funcion que calcula las ganancias del casino cada
# vez que juegan n personas
roulette_winnings <- function(n){
  
  X <- sample(c(-1,1), n, replace = TRUE, prob = c(9/19, 10/19))
  sum(X)

}

# Replicamos el experimento B veces
S <- replicate(B, roulette_winnings(n))


# Veamos como se distribuyen las ganancias del casino
data.frame(S) %>% 
  ggplot(aes(S, ..density..)) + 
  geom_histogram(color = "black") + 
  ylab("Probability")

# Cual es la probabilidad de que no haya perdidas
mean(S < 0)

# Cuanto gana el casino en promedio cada vez que juegan n personas
mean(S)
sd(S)



# TEOREMA DEL LIMITE CENTRAL ----------------------------------------------


# Valor esperado como el promedio
mean(20-18)/38


# Confirmamos con simulacion Monte Carlo
B <- 10^6
X <- sample(c(-1,1), B, replace = TRUE, prob=c(9/19, 10/19))
mean(X)

# Ganancia esperada sera numero de lances*valor esperado
n <- 1000
n*mean(X)

# Error estandar
2 * sqrt(90)/19
sd(X)

# Si usamos la formula de arriba y calculamos el error estandar
n <- 1000
sqrt(n) * 2 * sqrt(90)/19


# Comparando los resultados usando el CTL con la simulacion Monte Carlo inicial
n * (20-18)/38 
sqrt(n) * 2 * sqrt(90)/19 

mean(S)
sd(S)

# La probabilidad de perder dinero usando el CTL sera entonces 
# mu = expected value
mu <- n * (20-18)/38
# se = standard error
se <-  sqrt(n) * 2 * sqrt(90)/19 

pnorm(0, mu, se)

# Comparado con la Monte Carlo
mean(S < 0)


# -------------------------------------------------------------------------



