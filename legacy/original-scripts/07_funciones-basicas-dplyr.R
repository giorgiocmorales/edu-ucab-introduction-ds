# CLASE 5 - DATA SCIENCE UCAB 
# FUNCIONES BASICAS DE DPLYR 

# Para poner en practica lo que vimos en clase, empezaremos a usar las funciones 
# de dplyr que empezamos a ver hoy: select, filter, mutate, group_by, summarize, 
# rename y el pipe (%>%). Tambien aprenderemos a usar funciones como arrange, 
# table, unique, round, head

# Es importante entender que estas funciones nos permiten editar o hacer subsets 
# de dataframes

# Seguiremos trabajando con nuestro dataset de murders
# Murders: datos de homicidios por armas de fuego en EEUU para 2010, por estado 
library(dslabs)
?murders


# PAQUETES ----------------------------------------------------------------

library(dslabs)
library(dplyr)

rm(list = ls())


# DATA --------------------------------------------------------------------

# Cargamos el dataset murders
data(murders)


# FUNCION MUTATE  ---------------------------------------------------------

# La funcion mutate() nos permite crear nuevas variables o reescribir variables 
# previamente existentes. 

# Podemos crear variables que sean constantes: 

murders <- mutate(murders, constante_num = 1)

murders <- mutate(murders, constante_char = 'Dataset murders')

murders <- mutate(murders, constante_num = 23)

# Tambien podemos crear variables numericas de secuencia: 

murders <- mutate(murders, seq_num = 1:n()) # Funcion de n() se usa para generar el numero de observ

# Adicionalmente, podemos generar transformaciones de variables: 

# Generamos con las variables total y population la tasa de homicidios por cada 100mil habitantes
murders <- mutate(murders, murder_rate = total / population * 100000)

# Podemos generar un paste para generar un texto, usando la variable que creamos 
murders <- mutate(murders, murder_rate_text = paste('El estado de', state, 'tiene una tasa de homicidio de', murder_rate, 'por cada 100.000 habitantes.', sep = ' '))

# Si queremos reescribir murder_rate_text porque quiero redondear la tasa de homicidios en la variable murder_rate_text: 

# Funcion round() nos permite redondear digitos. Pasamos argumento de 2 para 
# especificar 2 decimales
murders <- mutate(murders, murder_rate_text = paste('El estado de', state, 'tiene una tasa de homicidio de', round(murder_rate,2), 'por cada 100.000 habitantes.', sep = ' '))

# Nota que sobreescribimos el objeto original murders al asignarlo de nuevo
# al mismo objeto. R lee de derecha a izquierda


# FUNCION HEAD ------------------------------------------------------------

# La funcion head nos permite, por default, visualizar las primeras 
# 6 observaciones de un dataframe 
head(murders)


# FUNCION SELECT  ---------------------------------------------------------

# La funcion select() nos permite seleccionar columnas de un dataframe para hacer
# un subset a nivel de COLUMNAS o VARIABLES 

# Digamos que me interesa mantener unicamente 3 columnas del dataframe murders:

murders_subset <- select(murders, state, region, murder_rate)

# Select tambien nos permite renombrar variables al mismo tiempo que las seleccionamos 

murders_subset <- select(murders, state, region, 'tasa_homicidio' = murder_rate)



# FUNCION FILTER  ---------------------------------------------------------

# La funcion filter() nos permite restringir un dataset a grupos especificos, en 
# base al cumplimiento de una condicion. Esto permite hacer un subset del dataset
# a nivel de FILAS u OBSERVACIONES 

# Podemos usar la funcion filter para observar la tabla cuyos estados tengan
# tasas menores o iguales a 0.71

murders_filas <- filter(murders, murder_rate <= 0.71)


# OPERADOR PIPE %>% -------------------------------------------------------

# El pipe %>% es una funcion operacional especial incluida en dplyr. Nos permite 
# hacer el codigo legible y eficiente, asi como poder usar mas de una funcion a 
# para un mismo dataset. 

# Si queremos crear columnas, filtrar y seleccionar variables del dataset murders,
# podemos hacerlo todo usando el pipe 

# SHORTCUT: CTRL + SHIFT + M

data(murders) # Se vuelve a cargar el dataset para revertir los cambios que hemos hecho

murders_final <- murders %>% 
  dplyr::mutate(murder_rate = total / population * 100000) %>% 
  dplyr::filter(murder_rate <= 0.71) %>% 
  dplyr::select(state, region, murder_rate)



# RETO MINI  --------------------------------------------------------------
View(murders)

# Tengo el dataset de murders y quiero hacer lo siguiente: 

# PASO 1: Quiero seleccionar las variables state, total, region y population (EN ESTE ORDEN)
# PASO 2: Quiero cambiar el nombre de las columnas a estado, total, region y poblacion 
# PASO 3: Quiero filtrar los estados cuyo total sea menor a 500 
# PASO 4: Quiero calcular una tasa de homicidio simple de esas observaciones filtradas 
# PASO 5: Quiero que estos pasos se almacenen en un objeto o df llamado murders_req 


murders_req <- murders %>% 
  dplyr::select("estado" = state, 
         total, 
         region,
         "poblacion" = population) %>% 
  dplyr::filter(total < 500) %>% 
  dplyr::mutate('total_homicidios' = total/poblacion)

# FUNCION RENAME  ---------------------------------------------------------

# La funcion rename nos permite cambiar el nombre de una o mas variables:

murders_final <- murders %>% 
  dplyr::mutate(murder_rate = total / population * 100000) %>% 
  dplyr::filter(murder_rate <= 0.71) %>% 
  dplyr::select(state, region, murder_rate) %>% 
  
  # Se cambian los nombres de las variables de interes
  dplyr::rename('estado' = state, 
                'tasa_homicidio' = murder_rate)

# ORDERNAR DATA FRAMES ----------------------------------------------------

# La funcion arrange nos permite ordenar un dataframe en base a la columna o columnas
# que le pasemos a dicha funcion.

# Ascendente en funcion de la variable tasa_homicidio
murders_final %>% 
  arrange(tasa_homicidio) %>% 
  head()


# Ordena de manera descendente por la tasa usando la funcion desc() y visualiza
# la cabecera
murders_final %>% 
  arrange(desc(tasa_homicidio)) %>% 
  head()


# Ordena primero por region y luego por tasa de homicidio
murders_final %>% 
  arrange(region, tasa_homicidio) %>% 
  head()

# FUNCION GROUP_BY Y SUMMARIZE --------------------------------------------

# La funcion group_by() nos permite agrupar variables de un dataframe para generar
# calculos dentro de un dataframe. 

# La funcion summarize() nos permite obtener montos totales, promedio o medidas 
# agregadas

# Usualmente usamos group_by() conjunto a summarize() cuando queremos generar calculos 
# agregados de medidas agrupadas. 

# Por ejemplo: 

# Queremos generar una tabla resumen de tasa de homicidio promedio por 
# region 

murders_table <- murders %>% 
  dplyr::mutate(murder_rate = total / population * 100000) %>% 
  group_by(region) %>% 
  dplyr::summarise('avg_murder_rate' = mean(murder_rate)) %>% 
  ungroup()

# Como los estados dentro de cada region no son de igual tamanio, usamos media ponderada

murders_table <- murders %>% 
  dplyr::mutate(murder_rate = total / population * 100000) %>% 
  group_by(region) %>% 
  dplyr::summarise('avg_murder_rate' = weighted.mean(murder_rate, w = population)) %>% 
  ungroup()

murders_table <- murders %>% 
  dplyr::mutate(murder_rate = total / population * 100000) %>% 
  dplyr::summarise('avg_murder_rate' = weighted.mean(murder_rate, w = population))

# RETO  -------------------------------------------------------------------

# Genera el chunk de codigo compleot mediante el cual obtengamos para el dataset
# murders las siguientes medidas: 

# Tasa de homicidio promedio por region (ponderada por poblacion) LISTO
# La mayor tasa de homicidio por region LISTO
# Numero de observaciones por region (Southeast 9 observaciones por region) LISTO
# Poblacion total (suma) por region LISTO

murders_reto <- murders %>% 
  dplyr::mutate('tasa_homicidio' = total/population*100000) %>% 
  group_by(region) %>% 
  dplyr::summarise('Tasa de homicidio promedio' = weighted.mean(tasa_homicidio, w = population),
                   'Mayor tasa de homicidio' = max(tasa_homicidio),
                   'Numero de observaciones' = n(), 
                   'Poblacion total' = sum(population)) %>% 
  ungroup()








