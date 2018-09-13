library(pacman)
p_load(tidyverse, rgdal, rgeos, rmapshaper, sp)

# Provinces and territories -------------------------------

# Read in shapefile
provinces_territories <- rgdal::readOGR("data-raw/shapefile_data/provinces_territories", "lpr_000b16a_e")

# Shapefile is unnecessarily large for creating plots, make smaller
provinces_territories <- rmapshaper::ms_simplify(provinces_territories, keep = 0.01, keep_shapes = T)

# Add projection
provinces_territories <- sp::spTransform(provinces_territories,
                                     CRS("+proj=lcc +lat_1=49 +lat_2=77 +lat_0=49 +lon_0=-95 +x_0=0 +y_0=0 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs"))

# Use zero-width buffer to clean up topology problems
provinces_territories <- rgeos::gBuffer(provinces_territories, byid=TRUE, width=0)

# Save spdf
provinces_territories_spdf <- provinces_territories
use_data(provinces_territories_spdf)

# Save data to merge
provinces_territories_data <- provinces_territories@data

# Fortify into dataset that can be used in ggplot
provinces_territories <- ggplot2::fortify(provinces_territories,
                                 region = "PRNAME")

# Merge other data back in
provinces_territories <- dplyr::left_join(provinces_territories, provinces_territories_data, by = c("id" = "PRNAME"))

names(provinces_territories) <- c("long", "lat", "order", "hole",
                                  "piece", "pr", "group", "sgc_code",
                                  "pr_english", "pr_french",
                                  "pr_abbr_english", "pr_abbr_french")

# Save R data object into data/
use_data(provinces_territories, overwrite = T)


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

# Save spdf
federal_ridings_spdf <- federal_ridings
use_data(federal_ridings_spdf)

# Save data to merge
federal_ridings_data <- federal_ridings@data

# Fortify into dataset that can be used in ggplot
federal_ridings <- ggplot2::fortify(federal_ridings,
                           region = "FEDUID")

# Merge other data back in
federal_ridings <- dplyr::left_join(federal_ridings, federal_ridings_data, by = c("id" = "FEDUID"))



names(federal_ridings) <- c("long", "lat", "order", "hole",
                            "piece", "code", "group", "riding_name",
                            "riding_name_english", "riding_name_french",
                            "province_sgc_code", "province")

# Save federal_ridings R data object into data/
use_data(federal_ridings)




# Census divisions 2016 -------------------------------

# Read in shapefile
census_divisions_2016 <- rgdal::readOGR("data-raw/shapefile_data/census_divisions_2016", "lcd_000b16a_e")

# Shapefile is unnecessarily large for creating plots, make smaller
census_divisions_2016 <- rmapshaper::ms_simplify(census_divisions_2016, keep = 0.02, keep_shapes = T)

# Add projection
census_divisions_2016 <- sp::spTransform(census_divisions_2016,
                                     CRS("+proj=lcc +lat_1=49 +lat_2=77 +lat_0=49 +lon_0=-95 +x_0=0 +y_0=0 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs"))

# Use zero-width buffer to clean up topology problems
census_divisions_2016 <- rgeos::gBuffer(census_divisions_2016, byid=TRUE, width=0)

# Save spdf
census_divisions_2016_spdf <- census_divisions_2016
use_data(census_divisions_2016_spdf)

# Save data to merge
census_divisions_2016_data <- census_divisions_2016@data

# Fortify into dataset that can be used in ggplot
census_divisions_2016 <- ggplot2::fortify(census_divisions_2016,
                                 region = "CDUID")

# Merge other data back in
census_divisions_2016 <- dplyr::left_join(census_divisions_2016, census_divisions_2016_data, by = c("id" = "CDUID"))


names(census_divisions_2016) <- c("long", "lat", "order", "hole", "piece", "id", "group", "census_division_name",
                                  "census_division_type", "province_sgc_code", "province")

# Save census_divisions_2016 R data object into data/
use_data(census_divisions_2016)


