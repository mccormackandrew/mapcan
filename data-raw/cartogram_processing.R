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


# Compute area of each federal riding in km^2 area (unit: meters -> convert to square km)
provinces_territories$area <- gArea(provinces_territories, byid=TRUE) / (1000000)

# Generate cartogram
provinces_territories_carto <- getcartr::quick.carto(provinces_territories, provinces_territories$population, res = 256)

# Use buffer so fortify works
provinces_territories_carto <- gBuffer(provinces_territories_carto, byid=TRUE, width=0)

# Fortify into dataframe that ggplot can use
provinces_territories_carto <- fortify(provinces_territories_carto,
                                    region = "PRENAME")


provinces_territories_carto <- left_join(provinces_territories_carto,
                                            province_pop_annual[province_pop_annual$year == 2016, ],
                                            by = c("id" = "province"))

names(provinces_territories_carto) <- c("long", "lat", "order", "hole", "piece", "pr_english", "group", "year", "population")


provinces_territories_carto$pr_alpha <- dplyr::recode(provinces_territories_carto$pr_english,
                                                `Newfoundland and Labrador` = "NL",
                                                `Prince Edward Island` = "PE",
                                                `Nova Scotia` = "NS",
                                                `New Brunswick` = "NB",
                                                `Quebec` = "QC",
                                                `Ontario` = "ON",
                                                `Manitoba` = "MB",
                                                `Saskatchewan` = "SK",
                                                `Alberta` = "AB",
                                                `British Columbia` = "BC",
                                                `Yukon` = "YT",
                                                `Northwest Territories` = "NT",
                                                `Nunavut` = "NU")

provinces_territories_carto$pr_french <- dplyr::recode(provinces_territories_carto$pr_alpha,
                                               `NL` = "Terre-Neuve-et-Labrador",
                                               `PE` = "Île-du-Prince-Édouard",
                                               `NS` = "Nouvelle-Écosse",
                                               `NB` = "Nouveau-Brunswick",
                                               `QC` = "Québec",
                                               `ON` = "Ontario",
                                               `MB` = "Manitoba",
                                               `SK` = "Saskatchewan",
                                               `AB` = "Alberta",
                                               `BC` = "Colombie-Britannique",
                                               `YT` = "Yukon",
                                               `NT` = "Territoires du Nord-Ouest",
                                               `NU` = "Nunavut")

provinces_territories_carto$pr_sgc_code <- dplyr::recode(provinces_territories_carto$pr_alpha,
                                                 `NL` = 10L,
                                                 `PE` = 11L,
                                                 `NS` = 12L,
                                                 `NB` = 13L,
                                                 `QC` = 24L,
                                                 `ON` = 35L,
                                                 `MB` = 46L,
                                                 `SK` = 47L,
                                                 `AB` = 48L,
                                                 `BC` = 59L,
                                                 `YT` = 60L,
                                                 `NT` = 61L,
                                                 `NU` = 62L)

provinces_territories_carto <- provinces_territories_carto %>%
  dplyr::select(-year)

# CONVERT TO ASCII
provinces_territories_carto <- provinces_territories_carto %>%
  mutate_if(is.character, stringi::stri_enc_toascii)


# Save data
use_data(provinces_territories_carto, overwrite = T)




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


names(provinces_noterr_carto) <- c("long", "lat", "order", "hole", "piece", "pr_english", "group", "year", "population")


provinces_noterr_carto$pr_alpha <- dplyr::recode(provinces_noterr_carto$pr_english,
                                                      `Newfoundland and Labrador` = "NL",
                                                      `Prince Edward Island` = "PE",
                                                      `Nova Scotia` = "NS",
                                                      `New Brunswick` = "NB",
                                                      `Quebec` = "QC",
                                                      `Ontario` = "ON",
                                                      `Manitoba` = "MB",
                                                      `Saskatchewan` = "SK",
                                                      `Alberta` = "AB",
                                                      `British Columbia` = "BC",
                                                      `Yukon` = "YT",
                                                      `Northwest Territories` = "NT",
                                                      `Nunavut` = "NU")

provinces_noterr_carto$pr_french <- dplyr::recode(provinces_noterr_carto$pr_alpha,
                                                       `NL` = "Terre-Neuve-et-Labrador",
                                                       `PE` = "Île-du-Prince-Édouard",
                                                       `NS` = "Nouvelle-Écosse",
                                                       `NB` = "Nouveau-Brunswick",
                                                       `QC` = "Québec",
                                                       `ON` = "Ontario",
                                                       `MB` = "Manitoba",
                                                       `SK` = "Saskatchewan",
                                                       `AB` = "Alberta",
                                                       `BC` = "Colombie-Britannique",
                                                       `YT` = "Yukon",
                                                       `NT` = "Territoires du Nord-Ouest",
                                                       `NU` = "Nunavut")

provinces_noterr_carto$pr_sgc_code <- dplyr::recode(provinces_noterr_carto$pr_alpha,
                                                         `NL` = 10L,
                                                         `PE` = 11L,
                                                         `NS` = 12L,
                                                         `NB` = 13L,
                                                         `QC` = 24L,
                                                         `ON` = 35L,
                                                         `MB` = 46L,
                                                         `SK` = 47L,
                                                         `AB` = 48L,
                                                         `BC` = 59L,
                                                         `YT` = 60L,
                                                         `NT` = 61L,
                                                         `NU` = 62L)

provinces_noterr_carto <- provinces_noterr_carto %>%
  dplyr::select(-year)

# CONVERT TO ASCII
provinces_noterr_carto <- provinces_noterr_carto %>%
  mutate_if(is.character, stringi::stri_enc_toascii)

# Save data
use_data(provinces_noterr_carto, overwrite = TRUE)




## Make census divisions cartogram--------------------

# Import map data
load("data/census_divisions_2016_spdf.rda")
load("data/census_pop2016.rda")

# Merge in riding population and election data
census_divisions_2016 <- merge(census_divisions_2016_spdf,
                               census_pop2016,
                               by.x = "CDUID" , by.y = "census_division_code")

# Compute area of each federal riding in km^2 area (unit: meters -> convert to square km)
census_divisions_2016$area <- rgeos::gArea(census_divisions_2016, byid=TRUE) / (1000000)

# Generate cartogram
census_divisions_2016_carto <- getcartr::quick.carto(census_divisions_2016,
                                                     census_divisions_2016$population_2016,
                                                     res = 256)

# Use buffer so fortify works
census_divisions_2016_carto <- gBuffer(census_divisions_2016_carto, byid=TRUE, width=0)

# Fortify into dataframe that ggplot can use
census_divisions_2016_carto <- fortify(census_divisions_2016_carto,
                                          region = "CDUID")

census_divisions_2016_carto$id <- as.numeric(census_divisions_2016_carto$id)

census_divisions_2016_carto <- left_join(census_divisions_2016_carto,
                                            census_pop2016,
                                            by = c("id" = "census_division_code"))

## THESE VARIABLES IMPORTED FROM census_pop2016 IN left_join ABOVE. PROBABLY NOT NECESSARY.
#census_divisions_2016_carto$pr_alpha <- dplyr::recode(census_divisions_2016_carto$province_sgc_code,
#                                                `10` = "NL",
#                                                `11` = "PE",
#                                                `12` = "NS",
#                                                `13` = "NB",
#                                                `24` = "QC",
#                                                `35` = "ON",
#                                               `46` = "MB",
#                                               `47` = "SK",
#                                               `48` = "AB",
#                                               `59` = "BC",
#                                               `60` = "YT",
#                                               `61` = "NT",
#                                               `62` = "NU")

#census_divisions_2016_carto$pr_english <- dplyr::recode(census_divisions_2016_carto$province_sgc_code,
#                                                 `10` = "Newfoundland and Labrador",
#                                                 `11` = "Prince Edward Island",
#                                                 `12` = "Nova Scotia",
#                                                 `13` = "New Brunswick",
#                                                 `24` = "Quebec",
#                                                 `35` = "Ontario",
#                                                 `46` = "Manitoba",
#                                                 `47` = "Saskatchewan",
#                                                 `48` = "Alberta",
#                                                 `59` = "British Columbia",
#                                                 `60` = "Yukon",
#                                                 `61` = "Northwest Territories",
#                                                 `62` = "Nunavut")

#census_divisions_2016_carto$pr_french <- dplyr::recode(census_divisions_2016_carto$province_sgc_code,
#                                                `10` = "Terre-Neuve-et-Labrador",
#                                                `11` = "Île-du-Prince-Édouard",
#                                                `12` = "Nouvelle-Écosse",
#                                                `13` = "Nouveau-Brunswick",
#                                                `24` = "Québec",
#                                                `35` = "Ontario",
#                                                `46` = "Manitoba",
#                                                `47` = "Saskatchewan",
#                                                `48` = "Alberta",
#                                                `59` = "Colombie-Britannique",
#                                                `60` = "Yukon",
#                                                `61` = "Territoires du Nord-Ouest",
#                                                `62` = "Nunavut")

census_divisions_2016_carto <- census_divisions_2016_carto %>%
  mutate(census_code = id) %>%
  dplyr::select(-id)

census_divisions_2016_carto$census_division_code <- as.numeric(census_divisions_2016_carto$census_code)

census_divisions_2016_carto <- census_divisions_2016_carto %>%
  dplyr::select(-census_code)

# CONVERT TO ASCII
census_divisions_2016_carto <- census_divisions_2016_carto %>%
  mutate_if(is.character, stringi::stri_enc_toascii)

# Save data
use_data(census_divisions_2016_carto, overwrite = TRUE)

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
census_divisions_2016_noterr_carto <- fortify(census_divisions_2016_noterr_carto,
                                          region = "CDUID")

census_divisions_2016_noterr_carto$id <- as.numeric(census_divisions_2016_noterr_carto$id)
census_divisions_2016_noterr_carto <- left_join(census_divisions_2016_noterr_carto,
                                            census_pop2016,
                                            by = c("id" = "census_division_code"))



census_divisions_2016_noterr_carto <- census_divisions_2016_noterr_carto %>%
  mutate(census_code = id) %>%
  dplyr::select(-id)

# CONVERT TO ASCII
census_divisions_2016_noterr_carto <- census_divisions_2016_noterr_carto %>%
  mutate_if(is.character, stringi::stri_enc_toascii)

# Save data
use_data(census_divisions_2016_noterr_carto, overwrite = T)



## FEDERAL RIDING CARTOGRAM (FOR HEXAGON MAPS)
# Import map data
load("data/federal_ridings_spdf.rda")
load("data/federal_election_results.rda")


fed2016 <- federal_election_results[federal_election_results$election_year == 2015, ]
fed2016 <- fed2016[!(fed2016$pr_alpha %in% c("YK", "NT", "NU")), ]

fedridings <- federal_ridings_spdf[!(federal_ridings_spdf$PRNAME %in% c("Nunavut", "Yukon", "Northwest Territories / Territoires du Nord-Ouest")), ]



# Merge in riding population and election data
ridings_carto <- merge(fedridings,
                       fed2016,
                       by.x="FEDUID",by.y="riding_code")


# Compute area of each federal riding in km^2 area (unit: meters -> convert to square km)
ridings_carto$area <- gArea(ridings_carto, byid=TRUE) / (1000000)

# Generate cartogram
ridings_carto_noprov <- getcartr::quick.carto(ridings_carto, ridings_carto$population, res = 256)

saveRDS(ridings_carto_noprov, "data-raw/ridings_carto_noprov.RDS")

# Use buffer so fortify works
ridings_carto <- gBuffer(ridings_carto, byid=TRUE, width=0)
