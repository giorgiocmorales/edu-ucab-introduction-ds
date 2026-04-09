# CLASE 9 - DATA SCIENCE UCAB 
# INTRODUCCION A GGPLOT 


# PAQUETES ----------------------------------------------------------------

library(ggplot2)
library(readxl)
library(tidyverse)
library(openxlsx)

# DATOS -------------------------------------------------------------------

datos_m7 <- read_excel("datos-basicos-curso-dsucab.xlsx")

# Haz un histograma de los datos de altura
hist(datos_m7$altura)

# Haz las modificaciones necesarias y grafica
datos_m7 %>%
  ggplot(aes(as.numeric(altura))) + 
  geom_histogram(color="darkblue", fill="lightblue") +
  labs(title="Distribucion altura (cm)",x="Altura (cm)", y = "Cuenta")+
  theme_classic()

# Alternativa para modificar la columna
# datos_m7$altura <- as.numeric(datos_m7$altura)


# LIMPIEZA ----------------------------------------------------------------


# Arregla la columna de altura y grafica de nuevo
datos_new <- datos_m7 %>%
  
  mutate(altura = parse_number(altura)) %>%
  mutate(altura = ifelse(altura < 10,
                         yes = altura*100, no = altura))


# Veamos un resumen sencillo de la variable corregida
summary(datos_new$altura)


# GRAFICOS ----------------------------------------------------------------


# Agrega etiqueta a los ejes, titulo, color
datos_new %>%
  ggplot(aes(altura)) +
  geom_histogram(color="darkblue", fill="lightblue", binwidth = 5) +
  labs(title="Distribucion altura (cm)", x="Altura (cm)", y = "Cuenta") +
  theme_classic()


# Realiza un grafico de densidad
datos_new %>%
  ggplot(aes(altura)) +
  geom_density(color="darkblue", fill="lightblue") +
  labs(title="Distribucion altura (cm)", x="Altura (cm)", y = "Cuenta") +
  theme_classic()


# Agrega una linea con la media
datos_new %>%
  ggplot(aes(altura)) +
  geom_density(color="darkblue", fill="lightblue") +
  geom_vline(aes(xintercept = mean(altura)),
             color="black", linetype="dashed", size=1) +
  labs(title="Distribucion altura (cm)", x="Altura (cm)", y = "Cuenta") +
  theme_classic()




# Agrega una linea con la mediana
datos_new %>%
  ggplot(aes(altura)) +
  geom_density(color="darkblue", fill="lightblue") +
  
  geom_vline(aes(xintercept = mean(altura)),
             color="black", linetype="dashed", size=1) +
  
  geom_vline(aes(xintercept = median(altura)),
             color="red", linetype="dashed", size=1) +
  
  labs(title="Distribucion altura (cm)", x="Altura (cm)", y = "Cuenta") +
  theme_classic()



# Agrega una comparacion con una distribucion normal
datos_new %>%
  ggplot(aes(altura)) +
  geom_density(color="darkblue", fill="lightblue") +
  
  geom_vline(aes(xintercept = mean(altura)),
             color="black", linetype="dashed", size=1) +
  
  geom_vline(aes(xintercept = median(altura)),
             color="red", linetype="dashed", size=1) +
  
  stat_function(fun = dnorm, args = list(mean = mean(datos_new$altura), sd = sd(datos_new$altura)))+
  
  labs(title="Distribucion altura (cm)", x="Altura (cm)", y = "Cuenta") +
  theme_classic()



# -------------------------------------------------------------------------

