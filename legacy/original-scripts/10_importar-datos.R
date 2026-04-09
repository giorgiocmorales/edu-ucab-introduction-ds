# CLASE 6 - DATA SCIENCE UCAB 
# IMPORTAR DATOS A R  

# Emplearemos funciones de ciertos paquetes de R que nos permiten importar
# datasets a R

# PAQUETES ----------------------------------------------------------------
library(tidyverse)
library(dslabs)
library(readxl)

# OBTENER DIRECTORIO DE TRABAJO  ------------------------------------------


# Obten el directorio en el que te encuentras actualmente: el working directory
getwd()


# El paquete dslabs trae una base de datos en csv
# Corre las siguientes lineas de codigo para copiar esa base a tu working directory

dir <- system.file(package="dslabs") #extracts the location of package

filename <- file.path(dir,"extdata/murders.csv")

file.copy(filename, "murders.csv")


# Utiliza la funcion list.files() para obtener una lista de todos los archivos que tienes en el wd
list.files()


# READ CSV ----------------------------------------------------------------


# Utiliza la funcion read.csv para leer el archivo con los datos de homicidio
# Asignalo a un objeto llamado dat y visualiza la cabecera
dat <- read.csv("murders.csv")
head(dat)


# Importa todas las columnas como caracteres utilizando el argumento colClasses
dat <- read.csv("murders.csv", colClasses = "character")

# Verifica que todas las columnas sean de caracteres
str(dat)



# EXCEL -------------------------------------------------------------------


# Lee la base de datos del IPC
ipc <- read_excel("bcv_ipc_amc_1950.xls")


# Que hoja lee R automaticamente?


# Usa la funcion excel_sheets para ver los nombres de las hojas del libro de excel
excel_sheets("bcv_ipc_amc_1950.xls")


# Lee la hoja de base 1984
ipc <- read_excel("bcv_ipc_amc_1950.xls", sheet = "Base 1984")




# PRO TIP: USANDO FOR LOOPS  --------------------------------------------------

# Los for loops en R permiten repetir un bloque de código varias veces, facilitando 
# la iteración sobre secuencias, vectores o listas. 
# Por ejemplo, si queremos calcular el cuadrado de los números del 1 al 5, podemos usar un for loop así:

for (i in 1:5) {
  print(paste("El cuadrado de", i, "es", i^2, "\n"))
}

# Se imprimirá el cuadrado de cada número en el rango especificado. 
# Es una forma efectiva de automatizar tareas repetitivas.


## En el caso de importar datos, a veces queremos leer todas las pestanas
# de un libro de Excel. Los loops y listas nos pueden ayudar en esto 

# Lee todas las hojas
hojas_excel <- excel_sheets("bcv_ipc_amc_1950.xls")

# TIP: usa una lista vacia y un loop
lista_ipc <- list()

i <- 1
for(i in 1:length(hojas_excel)){
  
  lista_ipc[[i]] <- read_excel("bcv_ipc_amc_1950.xls",
                          sheet = hojas_excel[i])
  
  }

# Asignale los nombres adecuados a los elementos de la lista
names(lista_ipc) <- hojas_excel


# -------------------------------------------------------------------------






