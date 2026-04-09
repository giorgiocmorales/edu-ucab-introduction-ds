# CLASE 8 - DATA SCIENCE UCAB 
# INTRODUCCION A MICRODATOS 

# Usaremos los microdatos correspondientes a la Encuesta Permanente de Hogares
# Continua (EPHC) de Paraguay. Esta encuesta corresponde a un panel que se lleva
# a cabo de forma trimestral 

# Pueden revisar mas en este enlace:https://www.ine.gov.py/microdatos/Encuesta-Permanente-de-Hogares-Continua.php

# Trabajaremos con los datos para el 2do trimestre de 2024

# PAQUETES ----------------------------------------------------------------

# Instalen los siguientes paquetes si no los tienen instalados

# install.packages("survey")
# install.packages("haven")
# install.packages("janitor")

library(haven)
library(dplyr)
library(survey)
library(janitor)

rm(list = ls())

# DATOS -------------------------------------------------------------------

getwd()

# Cambiamos el directorio de trabajo en caso de ser necesario para acceder al archivo
setwd()

# Descargar y cargar datos
encuesta <- read_sav("209bb-0_REG02_EPHC_2º Trim 2024.SAV")



# INSPECCION INICIAL  -----------------------------------------------------

# Inspeccionar dataset 
glimpse(encuesta)

# Inspeccionar columnas y etiquetas de una variable: TRIMESTRE
encuesta$TRIMESTRE %>% class
encuesta$TRIMESTRE %>% attr('label')
encuesta$TRIMESTRE %>% attr('labels')

# Hay una funcion que nos permite identificar cuales son los labels y valores
# de todas las variables codificadas (en archivos .SAV)
sjPlot::view_df(encuesta)


# SUBSET VARIABLES --------------------------------------------------------

# Variables de interes en un vector
cols_encuesta <- c("UPM", "NVIVI", "NHOGA", "TRIMESTRE", "RONDA",
                   "ANIO", "AREA", "L02", "P02",
                   "P03", "P06", "P09", "PEAA","FEX.2022")

# Seleccionamos las columnas de interes
encuesta_reduc <- encuesta %>%
  
  # Funcion all_of() especifica que selecciona todos los elementos
  select(all_of(cols_encuesta)) %>% 
  
  # La funcion clean_names() nos permite hacer que nombres de variables sean tidy (snake_case)
  janitor::clean_names() %>% 
  
  # Creamos el ID de hogar y de persona usando las variables sugeridas por el 
  # diccionario de variables (https://www.ine.gov.py/Publicaciones/Biblioteca/documento/dataset/EPHC-2024/2024/Primer%20Trimestre/d62e0-Diccionario%20y%20uso%20base%20de%20datos_EPHC_1er%20Trim%202024.xls)
  dplyr::mutate(id_hogar = paste(upm, nvivi, nhoga, sep = '_'), 
                
                id_persona = paste(upm, nvivi, nhoga, l02, sep = '_')) %>% 
  
  # Cambiamos el orden de nuevas variables que creamos con funcion relocate()
  dplyr::relocate(c(id_hogar, id_persona), .before = upm)



# CAMBIO DE NOMBRES -------------------------------------------------------

# Vector de nombres nuevos
names <- c("id_hogar", "id_persona", "upm", "nvivi", "nhoga", "trimestre", "ronda",
           "anio", "area", "linea_persona", "edad", "parentesco", "sexo", "estado_civil",
           "pea", "fexp")

# Asignamos los nombres nuevos como nombres de columna del df (debemos asignarlos todos,
# respetando las dimensiones a nivel de numero de columnas)
colnames(encuesta_reduc) <- names

# Verificamos que se hayan implementado los cambios 
View(encuesta_reduc)

# EXPLORACION DE DATOS ----------------------------------------------------

# Numero de hogares
num_hog <- encuesta_reduc %>% 
  distinct(id_hogar, .keep_all = T) %>% 
  nrow()

num_hog

# Numero de personas 
num_pers <- encuesta_reduc %>% 
  distinct(id_persona, .keep_all = T) %>% 
  nrow()

num_pers

# Variable de parentesco
table(encuesta_reduc$parentesco)

sjPlot::view_df(encuesta_reduc)

# Cuantos hogares tienen pareja?
# Asegurate que no haya ningun error
parejas_tot <- encuesta_reduc %>%
  mutate(pareja = ifelse(parentesco == 2, yes = 1, no = 0)) %>%
  group_by(id_hogar) %>%
  summarise(pareja = sum(pareja, na.rm = T)) %>% # Sumamos y agregamos argumento na.rm 
  ungroup()

# Utiliza el dataframe creado para calcular la proporcion de hogares con pareja
sum(parejas_tot$pareja)
mean(parejas_tot$pareja)

# Acabamos de sacar el promedio del total de parejas... pero falta algo
# Que tipo de promedio deberiamos hacer con datos con factor de expansion? 

parejas_tot_pesado <- encuesta_reduc %>%
  mutate(pareja = ifelse(parentesco == 2, yes = 1, no = 0)) %>%
  group_by(id_hogar, fexp) %>%
  summarise(pareja = sum(pareja, na.rm = T)) %>% 
  ungroup() %>% 
  dplyr::mutate(hogs_pareja = pareja*fexp) %>% 
  dplyr::summarise(suma_hogs_pareja = sum(hogs_pareja), 
                   prom_hogs_pareja = weighted.mean(pareja, fexp))

parejas_tot_pesado


# PROPORCION DE OCUPADOS, DESOCUPADOS E INACTIVOS -------------------------


df_pea <- encuesta_reduc %>% 
  dplyr::mutate(pea = case_when(pea == 1 ~ 1,
                                pea == 2 ~ 2,
                                pea == 3 ~ 3,
                                pea == 9 ~ NA), 
                
                # Hacer binarias en base a los valores de pea
                ocupados = ifelse(pea == 1, yes = 1, no = 0),
                desocupados = ifelse(pea == 2, yes = 1, no = 0),
                inactivos = ifelse(pea == 3, yes = 1, no = 0))

# Promedios de binarias: nos permiten obtener proporciones
mean(df_pea$ocupados, na.rm = T)
mean(df_pea$desocupados, na.rm = T)
mean(df_pea$inactivos, na.rm = T)


# Ponderados! 
weighted.mean(df_pea$ocupados, w = df_pea$fexp, na.rm = T)
weighted.mean(df_pea$desocupados, w = df_pea$fexp, na.rm = T)
weighted.mean(df_pea$inactivos, w = df_pea$fexp, na.rm = T)

# AGREGAR VARIABLES DE PERSONAS -------------------------------------------

# Genera la variable de grupo de edad. Utiliza la funcion cut(). 
# Llamala grupo_edad. Que se generen 10 grupos
encuesta_reduc <- encuesta_reduc %>%
  mutate(grupo_edad = cut(edad, breaks = 10))


# Modificala para replicar la variable de grupo de edad ya creada
# Revisa los argumentos right, labels 
?cut
encuesta_reduc <- encuesta_reduc %>%
  mutate(grupo_edad = cut(edad, 
                          breaks = c(seq(0, 75, by = 5), 100),
                          labels = 0:15))
