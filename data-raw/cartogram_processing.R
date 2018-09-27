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

## Make provinces and territories cartogram--------------------

# Import map data
load("data/provinces_territories_spdf.rda")
load("data/province_pop_annual.rda")

# Merge in riding population and election data
provinces_territories <- merge(provinces_territories_spdf,
                              province_pop_annual[province_pop_annual$year == 2016, ],
                              by.x="PRENAME",by.y="province")

provinces_territories
# Compute area of each federal riding in km^2 area (unit: meters -> convert to square km)
provinces_territories$area <- gArea(provinces_territories, byid=TRUE) / (1000000)

# Generate cartogram
provinces_territories_carto <- getcartr::quick.carto(provinces_territories, provinces_territories$population, res = 256)

# Use buffer so fortify works
provinces_territories_carto <- gBuffer(provinces_territories_carto, byid=TRUE, width=0)

# Fortify into dataframe that ggplot can use
provinces_territories_carto_df <- fortify(provinces_territories_carto,
                                    region = "PRENAME")


provinces_territories_carto_df <- left_join(provinces_territories_carto_df,
                                            province_pop_annual[province_pop_annual$year == 2016, ],
                                            by = c("id" = "province"))

# Save data
use_data(provinces_territories_carto_df, overwrite = T)

## Make provinces (no territories) cartogram--------------------

# Merge in riding population and election data
provinces_noterr <- merge(provinces_territories_spdf[!(provinces_territories_spdf$PREABBR %in% c("Y.T.", "Nvt.", "N.W.T.")), ],
                               province_pop_annual[province_pop_annual$year == 2016, ],
                               by.x="PRENAME",by.y="province")


# Compute area of each federal riding in km^2 area (unit: meters -> convert to square km)
provinces_noterr$area <- gArea(provinces_noterr, byid=TRUE) / (1000000)

# Generate cartogram
provinces_noterr_carto <- getcartr::quick.carto(provinces_noterr, provinces_noterr$population, res = 256)

# Use buffer so fortify works
provinces_noterr_carto <- gBuffer(provinces_noterr_carto, byid=TRUE, width=0)

# Fortify into dataframe that ggplot can use
provinces_noterr_carto <- fortify(provinces_noterr_carto,
                                          region = "PRENAME")


provinces_noterr_carto <- left_join(provinces_noterr_carto,
                                            province_pop_annual[province_pop_annual$year == 2016, ],
                                            by = c("id" = "province"))

# Save data
use_data(provinces_noterr_carto_df, overwrite = T)




## Make census divisions cartogram--------------------

# Import map data
census_divisions_2016_spdf <- readRDS("data/census_divisions_2016_spdf.Rdata")
load("data/census_pop2016.rda")
census_divisions_2016_spdf$CDUID

# Merge in riding population and election data
census_divisions_2016 <- merge(census_divisions_2016_spdf,
                               census_pop2016,
                               by.x = "CDUID" , by.y = "census_division_code")

# Compute area of each federal riding in km^2 area (unit: meters -> convert to square km)
census_divisions_2016$area <- gArea(census_divisions_2016, byid=TRUE) / (1000000)

# Generate cartogram
census_divisions_2016_carto <- getcartr::quick.carto(census_divisions_2016,
                                                     census_divisions_2016$population_2016,
                                                     res = 256)

# Use buffer so fortify works
census_divisions_2016_carto <- gBuffer(census_divisions_2016_carto, byid=TRUE, width=0)

# Fortify into dataframe that ggplot can use
census_divisions_2016_carto_df <- fortify(census_divisions_2016_carto,
                                          region = "CDUID")


census_divisions_2016_carto_df <- left_join(census_divisions_2016_carto_df,
                                            census_pop2016,
                                            by = c("id" = "census_division_code"))

# Save data
use_data(census_divisions_2016_carto_df)

## Make census divisions (no terroritories) cartogram--------------------

# Merge in riding population and election data
census_divisions_2016_noterr <- merge(census_divisions_2016_spdf[!(census_divisions_2016_spdf$PRNAME %in%
                                                                     c("Northwest Territories / Territoires du Nord-Ouest",
                                                                       "Nunavut",
                                                                       "Yukon")), ],
                               census_pop2016,
                               by.x = "CDUID" , by.y = "census_division_code")


# Compute area of each federal riding in km^2 area (unit: meters -> convert to square km)
census_divisions_2016_noterr$area <- gArea(census_divisions_2016_noterr, byid=TRUE) / (1000000)

# Generate cartogram
census_divisions_2016_noterr_carto <- getcartr::quick.carto(census_divisions_2016_noterr,
                                                            census_divisions_2016_noterr$population_2016,
                                                     res = 256)

# Use buffer so fortify works
census_divisions_2016_noterr_carto <- gBuffer(census_divisions_2016_noterr_carto, byid=TRUE, width=0)

# Fortify into dataframe that ggplot can use
census_divisions_2016_noterr_carto_df <- fortify(census_divisions_2016_noterr_carto,
                                          region = "CDUID")


census_divisions_2016_noterr_carto_df <- left_join(census_divisions_2016_noterr_carto_df,
                                            census_pop2016,
                                            by = c("id" = "census_division_code"))

# Save data
use_data(census_divisions_2016_noterr_carto_df)

