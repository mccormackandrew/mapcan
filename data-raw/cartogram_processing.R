## First run shapefile_processing.R, these cartograms will work with the
## compressed shapefiles created in that script

## To install Rcartogram and getcartr ----------------------
# First `brew install fftw` in command line, then:
# devtools::install_github("omegahat/Rcartogram")
# devtools::install_github('chrisbrunsdon/getcartr',subdir='getcartr')

library(pacman)
p_load(tidyverse, rgdal, rgeos, rmapshaper,
       mapproj, sf, sp, RColorBrewer,
       Rcartogram, getcartr, devtools)

## Make the cartogram--------------------

# Import map data
load("data/provinces_territories_spdf.rda")

mapcan::province_pop_annual
# Merge in riding population and election data
federal_ridings_spdf <- merge(provinces_territories_spdf, riding_info, by.x="FEDUID",by.y="riding_code")

# Compute area of each federal riding in km^2 area (unit: meters -> convert to square km)
federal_ridings_spdf$area <- gArea(federal_ridings_spdf, byid=TRUE) / (1000000)

# Generate cartogram
federal_ridings_carto <- getcartr::quick.carto(federal_ridings_spdf, federal_ridings_spdf$population_2016, res = 256)

# Use buffer so fortify works
federal_ridings_carto <- gBuffer(federal_ridings_carto, byid=TRUE, width=0)

# Fortify into dataframe that ggplot can use
federal_ridings_carto_df <- fortify(federal_ridings_carto,
                                    region = "FEDUID")

federal_ridings_carto_df <- left_join(federal_ridings_carto_df, riding_info, by = c("id" = "riding_code"))

# Save data
use_data(federal_ridings_carto_df, overwrite = T)
