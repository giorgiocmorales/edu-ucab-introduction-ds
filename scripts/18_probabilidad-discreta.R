
library(dslabs)
library(tidyverse)


# Definimos un vector
metras <- rep(c("red", "blue"), times = c(2,3))
metras

# Sacamos una muestra de 1
sample(metras, 1)

# Veces que se repetira el experimento 
N <- 10000
events <- replicate(N, sample(metras, 1))

# Hacemos una tabla de frecuencias
tab <- table(events)
tab

# Para ver las proporciones
prop.table(tab)



# MUESTRAS SIN/CON REEMPLAZAMIENTO ----------------------------------------


sample(metras, 5)
sample(metras, 5)
sample(metras, 5)

# Que hizo?

# Probemos con una muestra mayor que la poblacion
sample(metras, 6)

# Especifiquemos muestra con reemplazamiento y N veces
events <- sample(metras, N, replace = TRUE)
prop.table(table(events))

# Especificamos la semilla (seed) para que, aunque sea random el experimento,
# obtengamos el mismo resultado siempre que lo hagamos
# Muy bueno para reproducir resultados
set.seed(1)
x <- sample(metras, 5)
x


# COMBINACIONES Y PERMUTACIONES -------------------------------------------

# Creamos un mazo de cartas
# Define dos objetos: pintas y numeros
pintas   <- c("Diamantes", "Trebol", "Corazones", "Espadas")
numeros <- c("As", "Dos", "Tres", "Cuatro", "Cinco", "Seis", "Siete", 
             "Ocho", "Nueve", "Diez", "J", "Q", "K")

# Ahora utiliza la funcion expand.grid para crear una tabla con todos las combinaciones
# Asignala a un objeto llamado deck
deck <- expand.grid(numero = numeros, pinta = pintas)

# Convierte deck en un vector que sea un concatenado de numero y pinta
deck <- paste(deck$numero, deck$pinta)

# Veamos cual es la probabilidad de sacar una K
kings <- paste("K", pintas)
mean(deck %in% kings)
sum(deck %in% kings)

# Alternativa usando str_detect
mean(str_detect(deck, "K"))


# Permutaciones
library(gtools)
permutations(3, 2)


# Asigna a un objeto "pares" todas las posibles combinaciones de dos cartas
pares <- permutations(52, 2, v = deck)

# Guardemos en los siguientes objetos las primeras y segundas cartas
first_card  <- pares[,1]
second_card <- pares[,2]

# Cuantos reyes se sacaron como primera carta
sum(str_detect(first_card, "K"))

# Probabilidad condicional: segunda carta K dado que la primera fue una K
# Usa str_detect
sum(str_detect(first_card, "K") & str_detect(second_card, "K"))/sum(str_detect(first_card, "K"))

# Alternativa
mean(first_card %in% kings & second_card %in% kings) / mean(first_card %in% kings)


# Cual es la diferencia?
permutations(3,2)
combinations(3,2)


# OBJETIVO: queremos sacar la probabilidad de obtener un 21 natural


# Define un objeto con todos los ases posibles
as <- paste("As", pintas)

# Asigna a "facecard" todas las cartas que valen 10
facecard <- c("K", "Q", "J", "Diez")
facecard <- expand.grid(numero = facecard, pinta = pintas)
facecard <- paste(facecard$numero, facecard$pinta)

# Alternativa mas directa. 
# Asignalo a facecard2 y comprueba que tienen los mismos elementos
facecard2 <- deck[str_detect(deck, "K|Q|J|Diez")]
setdiff(facecard, facecard2)


# Sobreescribe el objeto pares para que solo muestre las combinaciones posibles
# sin importar el orden
pares <- combinations(52, 2, v = deck)

# Calcula la probabilidad del 21 natural, recuerda la forma como se ordena el vector pares
prob21 <- mean(pares[,1] %in% as & pares[,2] %in% facecard)
prob21

# Alternativa extensa, mas rigurosa
mean((pares[,1] %in% as & pares[,2] %in% facecard) | 
       (pares[,2] %in% as & pares[,1] %in% facecard))



# MONTECARLO SIMULATION ---------------------------------------------------


hand <- sample(deck, 2)
hand

# El par extraido es un blackjack?
(hand[1] %in% as & hand[2] %in% facecard) | (hand[2] %in% as & hand[1] %in% facecard)

# No hace falta definir los argumentos porque la funcion usara objetos que existen en el
# environment
blackjack <- function(){
  
  hand <- sample(deck, 2)
  
  return((hand[1] %in% as & hand[2] %in% facecard) |
           (hand[2] %in% as & hand[1] %in% facecard))
   }

blackjack()

# Repetimos el experimento
N <- 100
results <- replicate(N, blackjack())
mean(results)

# Como se compara con la probabilidad que calculamos antes del blackjack?
prob21

# Propuesto: prueba el experimento aumentando la N
N <- 10000
results <- replicate(N, blackjack())
mean(results)
prob21



# MONTY HALL PROBLEM ------------------------------------------------------

N <- 10000

# Mantener
stick <- replicate(N, {
  doors <- as.character(1:3)
  prize <- sample(c("car","goat","goat"))
  prize_door <- doors[prize == "car"]
  my_pick  <- sample(doors, 1)
  show <- sample(doors[!doors %in% c(my_pick, prize_door)],1)
  stick <- my_pick
  return(stick == prize_door)
  
})
mean(stick)

# Cambiar
switch <- replicate(N, {
  doors <- as.character(1:3)
  prize <- sample(c("car","goat","goat"))
  prize_door <- doors[prize == "car"]
  my_pick  <- sample(doors, 1)
  show <- sample(doors[!doors %in% c(my_pick, prize_door)], 1)
  stick <- my_pick
  switch <- doors[!doors %in% c(my_pick, show)]
  switch == prize_door
})
mean(switch)


# EJERCICIO PROPUESTO -----------------------------------------------------


# Ejemplo numeros de telefono al azar
# Crea un vector con todos lo numeros posibles
all_phone_numbers <- permutations(10, 7, v = 0:9)

# Extrae una muestra aleatoria de 5 numeros. Utiliza los indices de las filas
# para elegir los numeros extraidos al azar
n <- nrow(all_phone_numbers)
index <- sample(n, 5)
all_phone_numbers[index,]



# -------------------------------------------------------------------------
