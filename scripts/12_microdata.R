# CLASS 8 - DATA SCIENCE UCAB
# INTRODUCTION TO MICRODATA

# We will use microdata from the Continuous Household Survey (EPHC) of Paraguay.
# This survey is a quarterly panel.

# You can find more information at this link: https://www.ine.gov.py/microdatos/Encuesta-Permanente-de-Hogares-Continua.php

# We will work with data for the 2nd quarter of 2024

# PACKAGES ----------------------------------------------------------------

# Install the following packages if you don't have them installed

# install.packages("survey")
# install.packages("haven")
# install.packages("janitor")

library(haven)
library(dplyr)
library(survey)
library(janitor)

rm(list = ls())

# DATA -------------------------------------------------------------------

getwd()

# Change the working directory if necessary to access the file
setwd()

# Download and load data
encuesta <- read_sav("209bb-0_REG02_EPHC_2º Trim 2024.SAV")

# INITIAL INSPECTION -----------------------------------------------------

# Inspect dataset
glimpse(encuesta)

# Inspect columns and labels of a variable: TRIMESTRE
encuesta$TRIMESTRE %>% class
encuesta$TRIMESTRE %>% attr('label')
encuesta$TRIMESTRE %>% attr('labels')

# There is a function that allows us to identify the labels and values
# of all coded variables (in .SAV files)
sjPlot::view_df(encuesta)

# SUBSET VARIABLES --------------------------------------------------------

# Variables of interest in a vector
cols_encuesta <- c("UPM", "NVIVI", "NHOGA", "TRIMESTRE", "RONDA",
                   "ANIO", "AREA", "L02", "P02",
                   "P03", "P06", "P09", "PEAA","FEX.2022")

# Select the columns of interest
encuesta_reduc <- encuesta %>%
  
  # The all_of() function specifies that it selects all elements
  select(all_of(cols_encuesta)) %>%
  
  # The clean_names() function allows us to make variable names tidy (snake_case)
  janitor::clean_names() %>%
  
  # Create household and person IDs using the variables suggested by the
  # variable dictionary (https://www.ine.gov.py/Publicaciones/Biblioteca/documento/dataset/EPHC-2024/2024/Primer%20Trimestre/d62e0-Diccionario%20y%20uso%20base%20de%20datos_EPHC_1er%20Trim%202024.xls)
  dplyr::mutate(id_hogar = paste(upm, nvivi, nhoga, sep = '_'),
                
                id_persona = paste(upm, nvivi, nhoga, l02, sep = '_')) %>%
  
  # Change the order of new variables we created with the relocate() function
  dplyr::relocate(c(id_hogar, id_persona), .before = upm)

# RENAME COLUMNS -------------------------------------------------------

# Vector of new names
names <- c("id_hogar", "id_persona", "upm", "nvivi", "nhoga", "trimestre", "ronda",
           "anio", "area", "linea_persona", "edad", "parentesco", "sexo", "estado_civil",
           "pea", "fexp")

# Assign the new names as column names of the df (we must assign all of them,
# respecting the dimensions at the column count level)
colnames(encuesta_reduc) <- names

# Verify that the changes have been implemented
View(encuesta_reduc)

# DATA EXPLORATION ----------------------------------------------------

# Number of households
num_hog <- encuesta_reduc %>%
  distinct(id_hogar, .keep_all = T) %>%
  nrow()

num_hog

# Number of people
num_pers <- encuesta_reduc %>%
  distinct(id_persona, .keep_all = T) %>%
  nrow()

num_pers

# Relationship variable
table(encuesta_reduc$parentesco)

sjPlot::view_df(encuesta_reduc)

# How many households have a partner?
# Make sure there are no errors
parejas_tot <- encuesta_reduc %>%
  mutate(pareja = ifelse(parentesco == 2, yes = 1, no = 0)) %>%
  group_by(id_hogar) %>%
  summarise(pareja = sum(pareja, na.rm = T)) %>% # Sum and add na.rm argument
  ungroup()

# Use the created dataframe to calculate the proportion of households with a partner
sum(parejas_tot$pareja)
mean(parejas_tot$pareja)

# We just got the average of the total number of partners... but something is missing
# What type of average should we use with data with an expansion factor?

parejas_tot_pesado <- encuesta_reduc %>%
  mutate(pareja = ifelse(parentesco == 2, yes = 1, no = 0)) %>%
  group_by(id_hogar, fexp) %>%
  summarise(pareja = sum(pareja, na.rm = T)) %>%
  ungroup() %>%
  dplyr::mutate(hogs_pareja = pareja * fexp) %>%
  dplyr::summarise(suma_hogs_pareja = sum(hogs_pareja),
                   prom_hogs_pareja = weighted.mean(pareja, fexp))

parejas_tot_pesado

# PROPORTION OF EMPLOYED, UNEMPLOYED, AND INACTIVE -------------------------

df_pea <- encuesta_reduc %>%
  dplyr::mutate(pea = case_when(pea == 1 ~ 1,
                                pea == 2 ~ 2,
                                pea == 3 ~ 3,
                                pea == 9 ~ NA),
                
                # Make binaries based on pea values
                ocupados = ifelse(pea == 1, yes = 1, no = 0),
                desocupados = ifelse(pea == 2, yes = 1, no = 0),
                inactivos = ifelse(pea == 3, yes = 1, no = 0))

# Averages of binary variables: allow us to obtain proportions
mean(df_pea$ocupados, na.rm = T)
mean(df_pea$desocupados, na.rm = T)
mean(df_pea$inactivos, na.rm = T)

# Weighted!
weighted.mean(df_pea$ocupados, w = df_pea$fexp, na.rm = T)
weighted.mean(df_pea$desocupados, w = df_pea$fexp, na.rm = T)
weighted.mean(df_pea$inactivos, w = df_pea$fexp, na.rm = T)

# ADD PERSON VARIABLES -------------------------------------------

# Generate the age group variable. Use the cut() function.
# Call it grupo_edad. Generate 10 groups.
encuesta_reduc <- encuesta_reduc %>%
  mutate(grupo_edad = cut(edad, breaks = 10))

# Modify it to replicate the already created age group variable
# Check the arguments right, labels
?cut
encuesta_reduc <- encuesta_reduc %>%
  mutate(grupo_edad = cut(edad,
                          breaks = c(seq(0, 75, by = 5), 100),
                          labels = 0:15))