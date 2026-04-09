# R Script: Introduction to the Use of Geospatial Data

# Installation and loading of main packages

# Install required packages (only if they are not already installed)
if (!require(sf)) install.packages("sf")
if (!require(terra)) install.packages("terra")
if (!require(tmap)) install.packages("tmap")
if (!require(raster)) install.packages("raster")
if (!require(dplyr)) install.packages("dplyr")
if (!require(viridis)) install.packages("viridis")

# Load libraries
library(sf)        # Work with vector data (shapefiles)
library(terra)     # Work with raster data
library(raster)    # Work with raster data
library(tmap)      # Interactive and static visualization
library(ggplot2)   # Static visualization
library(dplyr)     # Data manipulation
library(viridis)   # Color palette for plots

rm(list = ls())


# 1. Load shapefiles and raster data


# Shapefile 1: Load vector data included in the tmap package
?World

data("World")
world <- World

rm(World)

# Check the CRS (coordinate reference system) of the shapefile
st_crs(world)

# Shapefile 2: Level-1 administrative boundaries (provinces/states) from GADM
admin_boundaries <- st_read("data/raw/gadm36_1.shp")

st_crs(admin_boundaries)

# Check whether both datasets share the same CRS
identical(st_crs(world), st_crs(admin_boundaries))


# 2. Change CRS to match datasets


# Transform the CRS of the administrative boundaries shapefile to match 'world'
admin_boundaries_transformed <- st_transform(admin_boundaries, crs = st_crs(world))

# Confirm both datasets now share the same CRS
identical(st_crs(world), st_crs(admin_boundaries_transformed)) # Should return TRUE


# 3. Vector data visualization


# Filter datasets for a country of interest
world_subset <- world %>% 
  dplyr::filter(name == 'Venezuela')

admin_subset <- admin_boundaries_transformed %>% 
  dplyr::filter(NAME_0 == 'Venezuela')

# Use tmap to plot both shapefiles
tmap_mode("plot")

tm_shape(world_subset) +
  tm_borders() +
  tm_shape(admin_subset) +
  tm_borders(col = "red") +
  tm_fill(col = "NAME_1", title = "Provinces/States")


# 4. Compute and plot polygon centroids


# Compute centroids of administrative boundaries
centroides <- st_centroid(admin_subset)

# st_point_on_surface()

# Visualize polygons with their centroids
tm_shape(admin_subset) +
  tm_borders() +
  tm_shape(centroides) +
  tm_symbols(col = "blue", size = 0.5)


# 5. Basic spatial operations


admin_subset_2 <- admin_boundaries_transformed %>% 
  dplyr::filter(NAME_0 %in% c('Venezuela', 'China', 'Japan'))

# Example: Intersection between the two shapefiles
intersection <- st_intersection(world_subset, admin_subset_2)

# We see that the number of observations differs between admin_subset and intersection
nrow(admin_subset) == nrow(intersection)

# Identify which polygons in admin_subset do NOT intersect
# with the world_subset polygon
missing <- setdiff(admin_subset$NAME_1, intersection$NAME_1)

# Visualize world_subset shapefile
tm_shape(world_subset) +
  tm_borders()

# Visualize admin_subset shapefile
tm_shape(admin_subset) +
  tm_borders()


# 6. Use of raster data


# Load VIIRS night lights raster
# (available at https://eogdata.mines.edu/products/vnl/)
luces_nocturnas <- terra::rast("data/raw/F16_20190101_20191231.global.stable_lights.avg_vis.tif")

# Check the CRS of the raster
crs(luces_nocturnas) # Note that we use a different function

# Check CRS compatibility between raster and shapefile
identical(crs(luces_nocturnas), st_crs(admin_subset))

# Transform shapefile CRS to match raster CRS
admin_subset <- st_transform(admin_subset, crs = st_crs(luces_nocturnas))

# Verify the transformation
identical(st_crs(admin_subset), st_crs(luces_nocturnas))


# 7. Modify raster extent


# Crop the raster based on the extent of a specific shapefile
# In this case, admin_subset (Venezuela)
?crop
luces_clean <- terra::crop(luces_nocturnas,
                           extent(admin_subset))

# Mask raster values so that only cells inside the shapefile retain values
?mask
luces_clean <- terra::mask(luces_clean,
                           admin_subset)


# 8. Vector and raster data visualization


# Visualize raster using ggplot2
raster_df <- as.data.frame(luces_clean, xy = TRUE) %>%  # Convert raster to dataframe for ggplot
  dplyr::rename('layer' = 3)

# Plot the raster with ggplot
ggplot(raster_df, aes(x = x, y = y, fill = layer)) +
  geom_raster() +
  scale_fill_viridis_c() +
  theme_minimal() +
  labs(title = "Night Lights Map", fill = "Intensity")


# 9. Join raster information with shapefile

# Suppose we want to classify each raster grid cell
# in order to know which state it belongs to

# We already have the necessary inputs:
# night lights raster and GADM shapefiles
# We can perform a join — but a spatial join

# Convert raster_df into a spatial object
# (each grid cell corresponds to a longitude/latitude point)
raster_grids <- st_as_sf(raster_df, 
                         coords = c('x', 'y'), 
                         crs = st_crs(admin_subset))

# Now we can join each observation with admin_subset
# Subset raster_grids to make the operation faster
venezuela_grids <- st_intersection(
  raster_grids[c(145000:145100),], 
  admin_subset
)
