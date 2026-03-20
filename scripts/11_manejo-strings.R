# CLASE 6 - DATA SCIENCE UCAB 
# MANEJO DE STRINGS 

# Los datos que importamos a R para procesar y analizar no siempre estan en un 
# formato tidy o amigable que nos permita manipularlo. A veces tambien puede
# tener inconsistencias o valores que dificultan llevar a cabo algunas tareas

# En este script cubriremos algunos aspectos basicos sobre el manejo de strings y  
# como lidiar con NAs en ciertos casos


# PAQUETES ----------------------------------------------------------------

# Instalen los siguientes paquetes si no los tienen instalados

# install.packages("htmlwidgets")
# install.packages("zoo")
# install.packages("rvest")

library(rvest)
library(dslabs)
library(tidyverse)
library(stringr)
library(zoo)
library(lubridate)
library(stringr)

rm(list = ls())


# DATOS -------------------------------------------------------------------

# Seguiremos trabajando con datos de homicidios en EEUU, pero esta vez importando 
# los mismos desde internet (Wikipedia)

url <- "https://en.wikipedia.org/wiki/Murder_in_the_United_States_by_state"
murders_raw <- read_html(url) %>%
  html_nodes("table") %>% 
  .[2] %>% 
  html_table %>% 
  .[[1]] %>%
  setNames(c("state", "population", "murder_manslaughter_total", 
             "murder_total", "gun_murder_total", "ownership", 
             "murder_manslaughter_rate", "murder_rate", "gun_rate"))

head(murders_raw)
View(murders_raw)

# Que tipo son las variables de poblacion, total de homicidios? 
# Queremos realmente que sean strings? 

murders_test <- murders_raw %>% 
  dplyr::mutate(population = as.numeric(population), 
                murder_manslaughter_total = as.numeric(murder_manslaughter_total), 
                murder_total = as.numeric(murder_total))

# Que pasa? Es correcto lo que acabamos de hacer? 


# PROBLEMA ----------------------------------------------------------------

# En el chunk de codigo previo vimos que al intentar cambiar el tipo de dato de 
# las columnas se generaban NAs. Esto se debe a que R no interpreta los separadores
# de miles manualmente tipeados (en este caso la coma ',') en los valores de tipo 
# numeric. Por tanto, R los reconoce como strings que no tienen una interpretacion 
# de tipo numerica

# Algo similar a cuando intentamos correr la siguiente linea
x <- c('1', 'carro', '7')
as.numeric(x) 

x <- c('1', '1,78', '7') # Tampoco reconoce separadores decimales de coma (se reconoce separador decimal de punto)
as.numeric(x) 



# MANEJO DE STRINGS: STRINGR ----------------------------------------------

# STRINGR 
# Tiene funciones que nos facilitan el trabajo de procesar y limpiar strings
# Nos sirve para procesar vectores de tipo character

# En el ejemplo de murders, vimos que el problema son los valores de las columnas
# de poblacion y homicidios para las que se especifica el separador de miles con 
# una coma. Stringr nos va a ayudar a corregir esto 


## DETECTAR patrones con str_detect()
# Nos permite identificar si los elementos de un vector tienen un patron que especificamos

?str_detect

str_detect(murders_raw$population, # Vector de string
           ",") # Patron que queremos evaluar. Se evalua condicion: si los elementos del vector tienen coma

# Cual es el output? Vector logical de si se cumple o no la condicion

# Agregando la funcion any() nos permite evaluar si alguno de los elementos 
# cumple la condicion 
any(str_detect(murders_raw$population, ",")) 

# Por que devuelve un solo valor si antes devolvia 52? 

# Probemos con la funcion all(), que nos devuelve ahora? Que evalua?
all(str_detect(murders_raw$population, ",")) 


## REEMPLAZAR patrones con str_replace() y str_replace_all()
# Nos permite reemplazar el primer match de un patron especifico en cada uno de los elementos de un vector

?str_replace

test_1 <- str_replace(murders_raw$population, ",", "")
test_1 <- as.numeric(test_1)

test_1 # Vector de valores corregidos 

murders_raw$population # Pero aun en la base original no esta corregido... 

# Modifica la base original, corrige el problema puntual
murders_raw <- murders_raw %>%
  mutate(population = str_replace(population,  ",", "")) # Quitamos las comas... Pero sigue siendo string


# Probemos de nuevo con el codigo arriba
test_1 <- str_replace(murders_raw$population, ",", "")
test_1 <- as.numeric(test_1)

class(test_1)


# FUNCIONES PARSE ---------------------------------------------------------

# Otra opcion de hacer algo similar a lo que hicimos, eliminar las comas de las 
# columnas de interes, es usar funciones de parse del paquete readr

# Una opcion es la funcion parse_number 

?parse_number

# Cargamos el dataset original de nuevo 
murders_raw <- read_html(url) %>%
  html_nodes("table") %>% 
  .[2] %>% 
  html_table %>% 
  .[[1]] %>%
  setNames(c("state", "population", "murder_manslaughter_total", 
             "murder_total", "gun_murder_total", "ownership", 
             "murder_manslaughter_rate", "murder_rate", "gun_rate"))

# Prueba con la funcion parse_number, asigna el resultado a test_2
test_2 <- parse_number(murders_raw$population)

# Comprueba que los resultados sean identicos
identical(test_1, test_2)

# Obtenemos el mismo resultado y esta vez el output final es numerico 
# Podemos aplicarlo usando dplyr a todas las columnas que queremos modificar

# Genera una nueva base, murders_new, corrige todas las columnas con la funcion parse_number
murders_new <- murders_raw %>%
  
  # La funcion across nos permite aplicar una misma funcion a varias columnas
  mutate(across(.cols = c("population","murder_manslaughter_total",
                          "murder_total"),
                .fns = parse_number))


# FUNCIONES DE UPPER Y LOWER CASE -----------------------------------------

# Tambien podemos cambiar si las palabras de un string son todas minusculas, mayusculas 
# Probamos con el vector de estados del dataset murders_new
murders_new$state

# Minusculas
str_to_lower(murders_new$state)

# Mayusculas
str_to_upper(murders_new$state)

# Titulo: Mayuscula de primera letra de todas las palabras del string 
str_to_title(murders_new$state)

# Oracion: Mayuscula solo en la primera letra de la primera palabra del string
str_to_sentence(murders_new$state)

# RETO 
# Crear un dataframe llamado murders_name donde los valores de la variable state 
# sean de mayusculas sostenidas



# REGULAR EXPRESSIONS -----------------------------------------------------

# A veces cuando hacemos manejo de strings, es mucho mas sencillo usar 
# regular expressions para poder detectar ciertos patrones

# Ahora queremos saber si los siguientes elementos tienen "cm"  o "inches"
yes <- c("180 cm", "70 inches")
no  <- c("180", "70''")
s   <- c(yes, no)
str_detect(s, "cm|inches")


# Para buscar digitos podemos usar un caracter especial
yes <- c("5", "6", "5'10", "5 feet", "4'11")
no  <- c("", ".", "Five", "six")
s   <- c(yes, no)
str_detect(s, "\\d")


# Utiliza la funcion str_view y str_view_all
str_view(s, "\\d")
str_view_all(s, "\\d")

# Para definir clases de caracteres se usan [] 
# Para detectar solo 5 y 6:
str_view(s, "[56]")


# Para definir rangos utilizamos "-"
# Numero entre 4 y 7
yes <- as.character(4:7)
no  <- as.character(1:3)
s   <- c(yes, no)
str_detect(s, "[4-7]")


# Alternativa para detectar numeros? Alternativa a \\d
str_detect(s, "[0-9]")


# Para detectar letras?

# Minusculas
str_detect(s, "[a-z]")

# Mayusculas
str_detect(s, "[A-Z]")


# Ambas
str_detect(s, "[a-zA-Z]")

