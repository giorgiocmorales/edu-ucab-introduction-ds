# Script en R: Introducción al Uso de Datos Geoespaciales

# Instalación e importación de paquetes principales
#-----------------------------------------------
# Instalar paquetes necesarios (solo si no están instalados)
if (!require(sf)) install.packages("sf")
if (!require(terra)) install.packages("terra")
if (!require(tmap)) install.packages("tmap")
if (!require(raster)) install.packages("raster")
if (!require(dplyr)) install.packages("dplyr")
if (!require(viridis)) install.packages("viridis")

# Cargar librerías
library(sf)       # Trabajar con datos vectoriales (shapefiles)
library(terra)   # Trabajar con datos raster
library(raster)   # Trabajar con datos raster
library(tmap)     # Visualización interactiva y estática
library(ggplot2)  # Visualización estática
library(dplyr)    # Manipulación de datos
library(viridis)  # Paleta de colores para gráficos

rm(list = ls())

#-----------------------------------------------
# 1. Cargar shapefiles y datos raster
#-----------------------------------------------

# Shapefile 1: Cargar datos vectoriales precargados en el paquete tmap
?World

data("World")
world <- World

rm(World)

# Revisar el CRS (sistema de referencia de coordenadas) del shapefile
st_crs(world)

# Shapefile 2: límites administrativos de nivel 1 (provincias/estados) de GADM
admin_boundaries <- st_read("H:/.shortcut-targets-by-id/1l7b-ANAazav4Dt_vgBnHLtDLebcW_-Ql/Data Science/UCAB/Sept 24 - Ene 25/Material Clases/Clase 14/Dataset/gadm36_1.shp")

st_crs(admin_boundaries)

# Revisar el CRS (sistema de referencia de coordenadas) de ambos datasets
identical(st_crs(world), st_crs(admin_boundaries))

#-----------------------------------------------
# 2. Cambiar el CRS para hacer coincidir datasets
#-----------------------------------------------

# Transformar el CRS del shapefile de límites administrativos al CRS de 'world'
admin_boundaries_transformed <- st_transform(admin_boundaries, crs = st_crs(world))

# Confirmar que ambos datasets tienen el mismo CRS
identical(st_crs(world), st_crs(admin_boundaries_transformed)) # Debe devolver TRUE


#-----------------------------------------------
# 3. Visualización de datos vectoriales
#-----------------------------------------------

# Filtramos los datasets por un pais de interes 
world_subset <- world %>% 
  dplyr::filter(name == 'Venezuela')

admin_subset <- admin_boundaries_transformed %>% 
  dplyr::filter(NAME_0 == 'Venezuela')

# Usar tmap para graficar ambos shapefiles
tmap_mode("plot")

tm_shape(world_subset) +
  tm_borders() +
  tm_shape(admin_subset) +
  tm_borders(col = "red") +
  tm_fill(col = "NAME_1", title = "Provincias/Estados") 

#-----------------------------------------------
# 4. Calcular y graficar centroides de polígonos
#-----------------------------------------------

# Calcular los centroides de los límites administrativos
centroides <- st_centroid(admin_subset)

# st_point_on_surface()

# Visualizar los polígonos con sus centroides
tm_shape(admin_subset) +
  tm_borders() +
  tm_shape(centroides) +
  tm_symbols(col = "blue", size = 0.5)

#-----------------------------------------------
# 5. Operaciones espaciales básicas
#-----------------------------------------------

admin_subset_2 <-  admin_boundaries_transformed %>% 
  dplyr::filter(NAME_0 %in% c('Venezuela', 'China', 'Japan'))

# Ejemplo: Intersección entre los dos shapefiles
intersection <- st_intersection(world_subset, admin_subset_2)

# Vemos que difieren el nro de obs de admin_subset e intersection 
nrow(admin_subset) == nrow(intersection)

# Veamos cuales son los poligonos de admin_subset que NO hacen interseccion 
# con el poligono de world_subset 
faltantes <- setdiff(admin_subset$NAME_1, intersection$NAME_1)

# Veamos como se ve el shapefile de world_subset 
tm_shape(world_subset) +
  tm_borders()

# Veamos como se ve el de admin_subset
tm_shape(admin_subset) +
  tm_borders()

#-----------------------------------------------
# 6. Uso de datos raster
#-----------------------------------------------

# Cargar raster de luces nocturnas de VIIRS (disponible en https://eogdata.mines.edu/products/vnl/)
luces_nocturnas <- terra::rast("H:/.shortcut-targets-by-id/1l7b-ANAazav4Dt_vgBnHLtDLebcW_-Ql/Data Science/UCAB/Sept 24 - Ene 25/Material Clases/Clase 14/Dataset/F16_20190101_20191231.global.stable_lights.avg_vis.tif")

# Revisar el CRS (sistema de referencia de coordenadas) del raster
crs(luces_nocturnas) # Noten que usamos una funcion distinta 

# Revisar el CRS (sistema de referencia de coordenadas) de ambos datasets
identical(crs(luces_nocturnas), st_crs(admin_subset))

# Transformar el CRS del shapefile de límites administrativos al CRS del raster
admin_subset <- st_transform(admin_subset, crs = st_crs(luces_nocturnas))

# Verify the transformation
identical(st_crs(admin_subset), st_crs(luces_nocturnas)) 

#-----------------------------------------------
# 7. Modificar extent raster
#-----------------------------------------------

# Hacemos un crop del raster en base al extent o dimensiones de algun shapefile 
# en particular, por ejemplo admin_subset que es de Venezuela
?crop
luces_clean <- terra::crop(luces_nocturnas,
                           extent(admin_subset))

# Hacemos un mask de los valores del raster, haciendo que solo las celdas que 
# se encuentren en las dimensiones del shapefile tomen un valor 
?mask
luces_clean <- terra::mask(luces_clean,
                           admin_subset)

#-----------------------------------------------
# 8. Visualización de datos vectoriales y raster
#-----------------------------------------------

# Visualizar el raster usando ggplot2
raster_df <- as.data.frame(luces_clean, xy = TRUE) %>%  # Convertir raster a dataframe para ggplot
dplyr::rename('layer' = 3)

# Graficar el raster con ggplot
ggplot(raster_df, aes(x = x, y = y, fill = layer)) +
  geom_raster() +
  scale_fill_viridis_c() +
  theme_minimal() +
  labs(title = "Mapa de Luces Nocturnas", fill = "Intensidad")

#-----------------------------------------------
# 9. Unir informacion raster con shapefile 
#-----------------------------------------------
# Digamos que queremos que cada uno de los grids que obtenemos en raster_df 
# quisieramos clasificarlos de forma que podamos saber a que estado pertenecen 

# Tenemos los insumos necesarios: los rasters de luces y shapefiles de GADM
# Pudiesemos hacer un join, pero uno espacial

# Transformamos el df de raster_df a un objeto de shp (cada grid corresponde a 
# un punto de coordenadas longitud y latitud) 

raster_grids <- st_as_sf(raster_df, 
                         coords = c('x', 'y'), 
                         crs = st_crs(admin_subset))


# Ahora si podemos unir cada una de las observaciones con admin_subset 
# Hacemos un subset de raster_grids para que sea mas rapido
venezuela_grids <- st_intersection(raster_grids[c(145000:145100),], admin_subset)
