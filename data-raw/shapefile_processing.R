library(pacman)
p_load(tidyverse, rgdal, rgeos, rmapshaper, sp)

## Province codes are available in 4 formats:
# pr_sgc_code
# pr_english
# pr_french
# pr_alpha


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
                                 region = "PRUID")

# Merge other data back in
provinces_territories <- dplyr::left_join(provinces_territories,
                                          provinces_territories_data[ , c("PRUID", "PRENAME", "PRFNAME")],
                                          by = c("id" = "PRUID"))

names(provinces_territories) <- c("long", "lat", "order", "hole",
                                  "piece", "pr_sgc_code", "group",
                                  "pr_english", "pr_french")


provinces_territories$pr_alpha <- dplyr::recode(provinces_territories$pr_sgc_code,
       `10` = "NL",
       `11` = "PE",
       `12` = "NS",
       `13` = "NB",
       `24` = "QC",
       `35` = "ON",
       `46` = "MB",
       `47` = "SK",
       `48` = "AB",
       `59` = "BC",
       `60` = "YT",
       `61` = "NT",
       `62` = "NU")

# Save R data object into data/
use_data(provinces_territories)






# Federal ridings ----------------------------------------

# Read in shapefile
federal_ridings <- rgdal::readOGR("data-raw/shapefile_data/federal_ridings", "lfed000b16a_e")

# Shapefile is unnecessarily large for creating plots, make smaller
federal_ridings <- rmapshaper::ms_simplify(federal_ridings, keep = 0.01, keep_shapes = T)


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

# Remove english-french riding and province names

federal_ridings <- federal_ridings %>%
  dplyr::select(-PRNAME, -FEDNAME)

names(federal_ridings) <- c("long", "lat", "order", "hole",
                            "piece", "riding_code", "group",
                            "riding_name_english", "riding_name_french",
                            "pr_sgc_code")

# Create pr_english variable
federal_ridings$pr_english <- dplyr::recode(federal_ridings$pr_sgc_code,
              `10` = "Newfoundland and Labrador",
              `11` = "Prince Edward Island",
              `12` = "Nova Scotia",
              `13` = "New Brunswick",
              `24` = "Quebec",
              `35` = "Ontario",
              `46` = "Manitoba",
              `47` = "Saskatchewan",
              `48` = "Alberta",
              `59` = "British Columbia",
              `60` = "Yukon",
              `61` = "Northwest Territories",
              `62` = "Nunavut")

# Create pr_french variable
federal_ridings$pr_french <- dplyr::recode(federal_ridings$pr_sgc_code,
                                            `10` = "Terre-Neuve-et-Labrador",
                                            `11` = "Île-du-Prince-Édouard",
                                            `12` = "Nouvelle-Écosse",
                                            `13` = "Nouveau-Brunswick",
                                            `24` = "Québec",
                                            `35` = "Ontario",
                                            `46` = "Manitoba",
                                            `47` = "Saskatchewan",
                                            `48` = "Alberta",
                                            `59` = "Colombie-Britannique",
                                            `60` = "Yukon",
                                            `61` = "Territoires du Nord-Ouest",
                                            `62` = "Nunavut")


# Create pr_alpha variable
federal_ridings$pr_alpha <- dplyr::recode(federal_ridings$pr_sgc_code,
                                                `10` = "NL",
                                                `11` = "PE",
                                                `12` = "NS",
                                                `13` = "NB",
                                                `24` = "QC",
                                                `35` = "ON",
                                                `46` = "MB",
                                                `47` = "SK",
                                                `48` = "AB",
                                                `59` = "BC",
                                                `60` = "YT",
                                                `61` = "NT",
                                                `62` = "NU")


# Add centroids (for labelling)

federal_ridings_shp <- rgdal::readOGR("data-raw/shapefile_data/federal_ridings", "lfed000b16a_e")

federal_ridings_shp <- sp::spTransform(federal_ridings_shp,
                                   CRS("+proj=lcc +lat_1=49 +lat_2=77 +lat_0=49 +lon_0=-95 +x_0=0 +y_0=0 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs"))

## Determining centroids of each polygon for plotting labels
fed_riding_centroid_data <- federal_ridings_shp %>%
  coordinates() %>%
  as.data.frame()

# Merge with ridings ID
fed_riding_labels <- data.frame(fed_riding_centroid_data, federal_ridings_shp@data$FEDUID)

# Get rid of shapefile
rm(federal_ridings_shp)

names(fed_riding_labels) <- c("centroid_long", "centroid_lat", "riding_code")

federal_ridings <- left_join(federal_ridings, fed_riding_labels)

federal_ridings$centroid_long[duplicated(federal_ridings$centroid_long)] <- NA
federal_ridings$centroid_lat[duplicated(federal_ridings$centroid_lat)] <- NA

# Save federal_ridings R data object into data/
use_data(federal_ridings)




# Census divisions 2016 -------------------------------

# Read in shapefile
census_divisions_2016 <- rgdal::readOGR("data-raw/shapefile_data/census_divisions_2016", "lcd_000b16a_e")

# Shapefile is unnecessarily large for creating plots, make smaller
census_divisions_2016 <- rmapshaper::ms_simplify(census_divisions_2016, keep = 0.01, keep_shapes = T)

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
                                  "census_division_type", "pr_sgc_code", "province")

# Remove English and French province variable
census_divisions_2016 <- census_divisions_2016 %>% dplyr::select(-province)

census_divisions_2016$pr_alpha <- dplyr::recode(census_divisions_2016$pr_sgc_code,
                                                `10` = "NL",
                                                `11` = "PE",
                                                `12` = "NS",
                                                `13` = "NB",
                                                `24` = "QC",
                                                `35` = "ON",
                                                `46` = "MB",
                                                `47` = "SK",
                                                `48` = "AB",
                                                `59` = "BC",
                                                `60` = "YT",
                                                `61` = "NT",
                                                `62` = "NU")

census_divisions_2016$pr_english <- dplyr::recode(census_divisions_2016$pr_sgc_code,
                                                  `10` = "Newfoundland and Labrador",
                                                  `11` = "Prince Edward Island",
                                                  `12` = "Nova Scotia",
                                                  `13` = "New Brunswick",
                                                  `24` = "Quebec",
                                                  `35` = "Ontario",
                                                  `46` = "Manitoba",
                                                  `47` = "Saskatchewan",
                                                  `48` = "Alberta",
                                                  `59` = "British Columbia",
                                                  `60` = "Yukon",
                                                  `61` = "Northwest Territories",
                                                  `62` = "Nunavut")

census_divisions_2016$pr_french <- dplyr::recode(census_divisions_2016$pr_sgc_code,
                                           `10` = "Terre-Neuve-et-Labrador",
                                           `11` = "Île-du-Prince-Édouard",
                                           `12` = "Nouvelle-Écosse",
                                           `13` = "Nouveau-Brunswick",
                                           `24` = "Québec",
                                           `35` = "Ontario",
                                           `46` = "Manitoba",
                                           `47` = "Saskatchewan",
                                           `48` = "Alberta",
                                           `59` = "Colombie-Britannique",
                                           `60` = "Yukon",
                                           `61` = "Territoires du Nord-Ouest",
                                           `62` = "Nunavut")

# Save census_divisions_2016 R data object into data/
use_data(census_divisions_2016)


