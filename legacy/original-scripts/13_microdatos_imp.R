
# CLASE 8 - DATA SCIENCE UCAB 
# INTRODUCCION A MICRODATOS 

# Seguiremos trabajando con microdatos, pero esta vez con microdatos de ENCOVI 2017

# PAQUETES ----------------------------------------------------------------

library(haven)
library(data.table)
library(sjlabelled)
library(sjPlot)
library(mice)
library(survey)
library(tidyverse)
library(readxl)

rm(list = ls())

# DATOS -------------------------------------------------------------------

getwd()

# Cambiamos el directorio de trabajo en caso de ser necesario para acceder al archivo
setwd()

# Usualmente nos conseguimos que para microdatos hay bases especificas a nivel
# de personas y hogares, e incluso bases a nivel de secciones del cuestionario

# Base a nivel de personas
personas <- read_sav("PERSONAS_ENCOVI_2017.sav") 

# Base a nivel de hogares
hogares <- read_sav("HOGARES_ENCOVI_2017.sav")


# SET UP PERSONAS ---------------------------------------------------------

# PERSONAS
cols_personas <- c("ennumc", "LIN", "CMHP17", "CMHP18", "CMHP19",
                   "CMHP22", "EMHP28N", "EMHP28A", "EMHP28S",
                   "EMHP32", "TMHP36", "TMHP41", "TMHP43",
                   "TMHP44", "TMHP44BS", "TMHP48", "TMHP45BS",
                   "PMHP60BS", 
                   "PESOPERSONA", "GRPEDAD", "AESTUDIO", "Tciudad_max")

# Filtro por las columnas de interes
personas_reduc <- personas %>%
  select(all_of(cols_personas))

# SET UP HOGARES ----------------------------------------------------------

cols_hogares <- c("ennumc","Tciudad", "FECHAENT", 
                  "VSP4", "VSP5", "VSP8", 
                  "DHP9", "DHP10", "DHP11", "DHP12", "DHP13",
                  "HP14N", "HP14L", "HP14S",
                  "MP65",
                  "QUINTIL", "POBREZA", "POBNBI", "POBREINT",
                  "PESOHOGAR")

hogares_reduc <- hogares %>%
  select(all_of(cols_hogares))

# MODIFICACIONES ADICIONALES ----------------------------------------------

# Modificaciones para usar bases reducidas
personas <- personas_reduc
hogares <- hogares_reduc

# Limpiamos environment
rm(personas_reduc, hogares_reduc, cols_personas, cols_hogares)

# SET  UP -----------------------------------------------------------------

# PERSONAS
new_names_pers <- c("id_hogar", "id_per", "parentesco", "edad", "sexo", 
                    "sit_conyu", "nivel_edu", "edu_ano_aprobado", "edu_sem_aprobado",
                    "tipo_edu", "sit_econo", "sector_eco", "cat_ocupa",
                    "trab_remun", "ing_laboral", "horas_trab", "ing_otro",
                    "ing_pension",
                    "pesop", "grp_edad", "anos_edu", "tipo_ciudad")

# Renombrar
personas <- personas %>%
  setnames(old = colnames(.), new = new_names_pers) %>%
  
  # Convierte los identificadores a caracteres
  mutate(across(.cols = c("id_hogar", "id_per"),
                .fns = as.character))


# HOGARES
new_names_hogs <- c("id_hogar", "tipo_ciudad", "fecha_ent",
                    "tipo_viv", "agua", "excretas", 
                    "per_x_hog", "num_cuartos", "num_duchas", "num_banos", "num_carros",
                    "nevera", "lavadora", "secadora",
                    "clap",
                    "quintil", "pob_ing", "pob_nbi", "pob_integral",
                    "pesoh")

hogares <- hogares %>%
  setnames(old = colnames(.), new = new_names_hogs) %>%
  
  # Convierte los identificadores a caracteres
  mutate(id_hogar = as.character(id_hogar))


view_df(personas)
view_df(hogares)

# EXPLORAR ----------------------------------------------------------------

# RECORDATORIO: NAs 98 y 99
# Para las variables de esta encuesta particular, todos los valores 98 y 99 
# corresponden a respuestas de NS/NR o No aplica. Podemos asignarle NA a estos valores
personas[personas == 98 | personas == 99] <- NA
hogares[hogares == 98 | hogares == 99] <- NA


# Calcula la tasa de pobreza de hogares
table(hogares$pob_ing)

view_df(hogares)

hogares %>%
  
  mutate(pob_ing = ifelse(pob_ing == 2, yes = 1, no = pob_ing)) %>%
 
  # Diferencia con la funcion if_else de tidyverse
  # mutate(pob_ing = if_else(pob_ing == 2,
  #                          true = 1, false = as.numeric(pob_ing))) %>%
  
  summarise(pobreza = mean(pob_ing, na.rm = T))


# Considera los pesos muestrales
hogares %>%
  
  mutate(pob_ing = ifelse(pob_ing == 2, yes = 1, no = pob_ing)) %>%
  
  summarise(pobreza = weighted.mean(pob_ing, pesoh, na.rm = T))

# Tenemos output de NA porque hay valores de pesos muestrales que tienen un 
# valor na 

which(is.na(hogares$pesoh)) # Identificamos el numero de fila donde hay NA en pesoh

# Limpiemos los hogares sin peso
hogares %>%
  
  filter(!is.na(pesoh)) %>%
  
  mutate(pob_ing = ifelse(pob_ing == 2, yes = 1, no = pob_ing)) %>%
  
  summarise(pobreza = weighted.mean(pob_ing, pesoh, na.rm = T))


# AGREGAR VARIABLES DE PERSONAS -------------------------------------------


# Genera la variable de grupo de edad. Utiliza la funcion cut(). 
# Llamala grupo_edad. Que se generen 10 grupos
personas <- personas %>%
  mutate(grupo_edad = cut(edad, 
                          breaks = c(seq(0, 75, by = 5), 100),
                          labels = 0:15))

personas_hog <- personas %>%
  
  # Convertimos las variables a dicotomicas
  mutate(across(.cols = c("sexo", "trab_remun"),
                .fns = function(x) ifelse(x == 2, yes = 0, no = x))) %>%
  
  # Agrupamos y resumimos los datos
  group_by(id_hogar) %>%
  
  # Variables de las que nos interesa el promedio
  summarise(across(.cols = c("edad", "anos_edu", "horas_trab", "sexo"),
                   .fns = function(x) mean(x, na.rm = T)),
            
            # Variables a sumar
            across(.cols = c(starts_with("ing"), "trab_remun", "pesop"),
                   .fns = function(x) sum(x, na.rm = T)),
            nro_per = n())


# UNIR INFO PERSONAS-HOGARES ----------------------------------------------


# Agrega la informacion de personas resumida a la base de hogares
hogares_tot <- hogares %>%
  left_join(personas_hog, by = "id_hogar") %>%
  
  # Verifica que el numero de personas por hogar es consistente en ambas bases
  mutate(aux = per_x_hog - nro_per)

# Esperar para mostrarles que no pueden confiar en solo ver la tabla manualmente
table(hogares_tot$aux)


# Calcula la tasa de pobreza de personas
hogares_tot %>%
  mutate(pob_ing = ifelse(pob_ing == 2, yes = 1, no = pob_ing)) %>%
  summarise(pobreza_per = weighted.mean(pob_ing, nro_per, na.rm = T))

# Recuerda los pesos muestrales
hogares_tot %>%
  mutate(pob_ing = ifelse(pob_ing == 2, yes = 1, no = pob_ing)) %>%
  summarise(pobreza_per = weighted.mean(pob_ing, pesop, na.rm = T))
  

# IMPUTACIONES ------------------------------------------------------------


# Cuantos NA hay por columna en la base de hogares
sapply(hogares, function(x) sum(is.na(x)))


# Revisar cuantas personas declaran trabajar de forma remunerada pero no
# reportan ingresos validos

# Probar asi
sum(personas$trab_remun == 1 & (personas$ing_laboral > 0 | is.na(personas$ing_laboral)))

# Corregir
sum(!is.na(personas$trab_remun) & personas$trab_remun == 1 & (personas$ing_laboral <= 0 | is.na(personas$ing_laboral)))

# Alternativa con dplyr
nas_ing <- personas %>%
  filter(trab_remun == 1 & !is.na(trab_remun) &
           (ing_laboral <= 0 | is.na(ing_laboral)))

# Veamos la situacion laboral de este grupo
table(nas_ing$sit_econo)

# En estos casos, se suelen llevar a cabo imputaciones, en las que asignaremos 
# un valor promedio de variables como la de ingreso laboral basado en caracteristicas 
# de las observaciones (en este caso puede ser el sexo, nivel educativo, parentesco...)

