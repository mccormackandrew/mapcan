library(pacman)
p_load(tidyverse, rgdal, rgeos, rmapshaper, sp)

# Provinces and territories -------------------------------

# Read in shapefile
provinces_territories <- rgdal::readOGR("data-raw/shapefile_data/provinces_territories", "lpr_000b16a_e")

# Shapefile is unnecessarily large for creating plots, make smaller
provinces_territories <- rmapshaper::ms_simplify(provinces_territories, keep = 0.03, keep_shapes = T)

# Add projection
provinces_territories <- sp::spTransform(provinces_territories,
                                     CRS("+proj=lcc +lat_1=49 +lat_2=77 +lat_0=49 +lon_0=-95 +x_0=0 +y_0=0 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs"))

# Use zero-width buffer to clean up topology problems
provinces_territories <- rgeos::gBuffer(provinces_territories, byid=TRUE, width=0)

# Save data to merge
provinces_territories_data <- provinces_territories@data

# Fortify into dataset that can be used in ggplot
provinces_territories <- dplyr::fortify(provinces_territories,
                                 region = "PRNAME")

# Merge other data back in
provinces_territories <- dplyr::left_join(provinces_territories, provinces_territories_data, by = c("id" = "PRNAME"))

ggplot(provinces_territories, aes(long, lat, group = group)) +
  geom_polygon(fill = "beige", colour = "black", size = 0.3) +
  coord_fixed()

saveRDS(provinces_territories, "provinces_territories.Rdata")


# Federal ridings ----------------------------------------

# Read in shapefile
federal_ridings <- rgdal::readOGR("data-raw/shapefile_data/federal_ridings", "lfed000b16a_e")

# Shapefile is unnecessarily large for creating plots, make smaller
federal_ridings <- rmapshaper::ms_simplify(federal_ridings, keep = 0.05, keep_shapes = T)

federal_ridings_backup <- federal_ridings
# Add a projection
federal_ridings <- sp::spTransform(federal_ridings,
                               CRS("+proj=lcc +lat_1=49 +lat_2=77 +lat_0=49 +lon_0=-95 +x_0=0 +y_0=0 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs"))

# Use zero-width buffer to clean up topology problems
federal_ridings <- rgeos::gBuffer(federal_ridings, byid=TRUE, width=0)

# Save data to merge
federal_ridings_data <- federal_ridings@data

# Fortify into dataset that can be used in ggplot
federal_ridings <- ggplot2::fortify(federal_ridings,
                           region = "FEDUID")

# Merge other data back in
federal_ridings <- dplyr::left_join(federal_ridings, federal_ridings_data, by = c("id" = "FEDUID"))

# Save
saveRDS(federal_ridings, "federal_ridings.Rdata")


# Census divisions 2016 -------------------------------

# Read in shapefile
census_divisions_2016_original <- rgdal::readOGR("data-raw/shapefile_data/census_divisions_2016", "lcd_000b16a_e")

# Shapefile is unnecessarily large for creating plots, make smaller
census_divisions_2016 <- rmapshaper::ms_simplify(census_divisions_2016, keep = 0.02, keep_shapes = T)

# Add projection
census_divisions_2016 <- sp::spTransform(census_divisions_2016,
                                     CRS("+proj=lcc +lat_1=49 +lat_2=77 +lat_0=49 +lon_0=-95 +x_0=0 +y_0=0 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs"))

# Use zero-width buffer to clean up topology problems
census_divisions_2016 <- rgeos::gBuffer(census_divisions_2016, byid=TRUE, width=0)

# Save data to merge
census_divisions_2016_data <- census_divisions_2016@data

# Fortify into dataset that can be used in ggplot
census_divisions_2016 <- ggplot2::fortify(census_divisions_2016,
                                 region = "CDUID")

# Merge other data back in
census_divisions_2016 <- dplyr::left_join(census_divisions_2016, census_divisions_2016_data, by = c("id" = "CDUID"))

# Save
saveRDS(census_divisions_2016, "census_divisions_2016.Rdata")
