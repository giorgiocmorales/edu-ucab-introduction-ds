# CLASS 8 - DATA SCIENCE UCAB
# INTRODUCTION TO MICRODATA

# We will continue working with microdata, but this time with ENCOVI 2017 microdata.

# PACKAGES ----------------------------------------------------------------

library(haven)
library(data.table)
library(sjlabelled)
library(sjPlot)
library(mice)
library(survey)
library(tidyverse)
library(readxl)

rm(list = ls())

# DATA -------------------------------------------------------------------

getwd()

# Change the working directory if necessary to access the file
setwd()

# We usually find that for microdata, there are specific databases at the
# person and household levels, and even databases at the questionnaire section level.

# Person-level database
personas <- read_sav("PERSONAS_ENCOVI_2017.sav")

# Household-level database
hogares <- read_sav("HOGARES_ENCOVI_2017.sav")

# SET UP PERSONS ---------------------------------------------------------

# PERSONS
cols_personas <- c("ennumc", "LIN", "CMHP17", "CMHP18", "CMHP19",
                   "CMHP22", "EMHP28N", "EMHP28A", "EMHP28S",
                   "EMHP32", "TMHP36", "TMHP41", "TMHP43",
                   "TMHP44", "TMHP44BS", "TMHP48", "TMHP45BS",
                   "PMHP60BS",
                   "PESOPERSONA", "GRPEDAD", "AESTUDIO", "Tciudad_max")

# Filter by columns of interest
personas_reduc <- personas %>%
  select(all_of(cols_personas))

# SET UP HOUSEHOLDS ----------------------------------------------------------

cols_hogares <- c("ennumc","Tciudad", "FECHAENT",
                  "VSP4", "VSP5", "VSP8",
                  "DHP9", "DHP10", "DHP11", "DHP12", "DHP13",
                  "HP14N", "HP14L", "HP14S",
                  "MP65",
                  "QUINTIL", "POBREZA", "POBNBI", "POBREINT",
                  "PESOHOGAR")

hogares_reduc <- hogares %>%
  select(all_of(cols_hogares))

# ADDITIONAL MODIFICATIONS ----------------------------------------------

# Modifications to use reduced databases
personas <- personas_reduc
hogares <- hogares_reduc

# Clear environment
rm(personas_reduc, hogares_reduc, cols_personas, cols_hogares)

# SET UP -----------------------------------------------------------------

# PERSONS
new_names_pers <- c("id_hogar", "id_per", "parentesco", "edad", "sexo",
                    "sit_conyu", "nivel_edu", "edu_ano_aprobado", "edu_sem_aprobado",
                    "tipo_edu", "sit_econo", "sector_eco", "cat_ocupa",
                    "trab_remun", "ing_laboral", "horas_trab", "ing_otro",
                    "ing_pension",
                    "pesop", "grp_edad", "anos_edu", "tipo_ciudad")

# Rename
personas <- personas %>%
  setnames(old = colnames(.), new = new_names_pers) %>%
  
  # Convert identifiers to characters
  mutate(across(.cols = c("id_hogar", "id_per"),
                .fns = as.character))

# HOUSEHOLDS
new_names_hogs <- c("id_hogar", "tipo_ciudad", "fecha_ent",
                    "tipo_viv", "agua", "excretas",
                    "per_x_hog", "num_cuartos", "num_duchas", "num_banos", "num_carros",
                    "nevera", "lavadora", "secadora",
                    "clap",
                    "quintil", "pob_ing", "pob_nbi", "pob_integral",
                    "pesoh")

hogares <- hogares %>%
  setnames(old = colnames(.), new = new_names_hogs) %>%
  
  # Convert identifiers to characters
  mutate(id_hogar = as.character(id_hogar))

view_df(personas)
view_df(hogares)

# EXPLORE ----------------------------------------------------------------

# REMINDER: NAs 98 and 99
# For the variables in this particular survey, all values 98 and 99
# correspond to NS/NR (Not Specified/Not Reported) or Not applicable responses. We can assign NA to these values.
personas[personas == 98 | personas == 99] <- NA
hogares[hogares == 98 | hogares == 99] <- NA

# Calculate the household poverty rate
table(hogares$pob_ing)

view_df(hogares)

hogares %>%
  
  mutate(pob_ing = ifelse(pob_ing == 2, yes = 1, no = pob_ing)) %>%
  
  # Difference with the tidyverse if_else function
  # mutate(pob_ing = if_else(pob_ing == 2,
  #                          true = 1, false = as.numeric(pob_ing))) %>%
  
  summarise(pobreza = mean(pob_ing, na.rm = T))

# Consider sample weights
hogares %>%
  
  mutate(pob_ing = ifelse(pob_ing == 2, yes = 1, no = pob_ing)) %>%
  
  summarise(pobreza = weighted.mean(pob_ing, pesoh, na.rm = T))

# We have NA output because there are sample weight values that have an
# NA value.

which(is.na(hogares$pesoh)) # Identify the row number where there is NA in pesoh

# Clean up households without weight
hogares %>%
  
  filter(!is.na(pesoh)) %>%
  
  mutate(pob_ing = ifelse(pob_ing == 2, yes = 1, no = pob_ing)) %>%
  
  summarise(pobreza = weighted.mean(pob_ing, pesoh, na.rm = T))

# ADD PERSON VARIABLES -------------------------------------------

# Generate the age group variable. Use the cut() function.
# Call it grupo_edad. Generate 10 groups.
personas <- personas %>%
  mutate(grupo_edad = cut(edad,
                          breaks = c(seq(0, 75, by = 5), 100),
                          labels = 0:15))

personas_hog <- personas %>%
  
  # Convert variables to dichotomous
  mutate(across(.cols = c("sexo", "trab_remun"),
                .fns = function(x) ifelse(x == 2, yes = 0, no = x))) %>%
  
  # Group and summarize data
  group_by(id_hogar) %>%
  
  # Variables for which we are interested in the average
  summarise(across(.cols = c("edad", "anos_edu", "horas_trab", "sexo"),
                   .fns = function(x) mean(x, na.rm = T)),
            
            # Variables to sum
            across(.cols = c(starts_with("ing"), "trab_remun", "pesop"),
                   .fns = function(x) sum(x, na.rm = T)),
            nro_per = n())

# JOIN PERSON-HOUSEHOLD INFO ----------------------------------------------

# Add the summarized person information to the household database
hogares_tot <- hogares %>%
  left_join(personas_hog, by = "id_hogar") %>%
  
  # Verify that the number of people per household is consistent in both databases
  mutate(aux = per_x_hog - nro_per)

# Wait to show them that you cannot rely on just viewing the table manually
table(hogares_tot$aux)

# Calculate the person poverty rate
hogares_tot %>%
  mutate(pob_ing = ifelse(pob_ing == 2, yes = 1, no = pob_ing)) %>%
  summarise(pobreza_per = weighted.mean(pob_ing, nro_per, na.rm = T))

# Remember sample weights
hogares_tot %>%
  mutate(pob_ing = ifelse(pob_ing == 2, yes = 1, no = pob_ing)) %>%
  summarise(pobreza_per = weighted.mean(pob_ing, pesop, na.rm = T))


# IMPUTATIONS ------------------------------------------------------------

# How many NAs are there per column in the household database?
sapply(hogares, function(x) sum(is.na(x)))

# Check how many people declare working for pay but do not
# report valid income.

# Try this way
sum(personas$trab_remun == 1 & (personas$ing_laboral > 0 | is.na(personas$ing_laboral)))

# Correct
sum(!is.na(personas$trab_remun) & personas$trab_remun == 1 & (personas$ing_laboral <= 0 | is.na(personas$ing_laboral)))

# Alternative with dplyr
nas_ing <- personas %>%
  filter(trab_remun == 1 & !is.na(trab_remun) &
           (ing_laboral <= 0 | is.na(ing_laboral)))

# Let's look at the employment situation of this group
table(nas_ing$sit_econo)

# In these cases, imputations are often carried out, in which we will assign
# an average value of variables like labor income based on the characteristics
# of the observations (in this case, it can be gender, educational level, relationship status...).