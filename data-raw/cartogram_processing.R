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



## Import riding population data--------------------

# https://www12.statcan.gc.ca/census-recensement/2016/dp-pd/hlt-fst/pd-pl/index-eng.cfm

riding_data <- read.csv("data-raw/riding_data.csv")

# Remove note rows at end of .csv file
riding_data <- riding_data[1:which(riding_data$Geographic.code == "Note:") - 1, ]

# Select just riding and population data
riding_data <- riding_data %>% dplyr::select(`Geographic.code`, `Population..2011`, `Population..2016`)

# Give df non-ridiculous column names
names(riding_data) <- c("riding_code", "population_2011", "population_2016")

# Convert to character for mergins purposes
riding_data$riding_code <- as.character(riding_data$riding_code)

if(nrow(riding_data) == 338) {
  print("338 rows (ridings) in the dataset. This is the right amount.")
} else {
  stop("Riding number is off.")
}


## Import riding election results data-----------------

election_results <- read.csv("data-raw/canada_election_2015.csv")

# Factor to character
election_results$party <- as.character(election_results$Elected.Candidate.Candidat.élu)

# Get rid of MP's names (sorry MPs) and replace with just name of party
election_results[grepl("Conservative", election_results$party), "party"] <- "Conservative"
election_results[grepl("Liberal", election_results$party), "party"] <- "Liberal"
election_results[grepl("New Democratic Party", election_results$party), "party"] <- "NDP"
election_results[grepl("Bloc Québécois", election_results$party), "party"] <- "Bloc Québécois"
election_results[grepl("Green", election_results$party), "party"] <- "Green"

# Give df non-ridiculous column names
election_results <- election_results %>% dplyr::select(Electoral.District.Number.Numéro.de.circonscription, party) %>%
  mutate(riding_code = Electoral.District.Number.Numéro.de.circonscription) %>%
  dplyr::select(-Electoral.District.Number.Numéro.de.circonscription)

# Riding code in shapefile data is character, change this to character so it will merge
election_results$riding_code <- as.character(election_results$riding_code)

## Merge these bad boys together----------------------
riding_info <- left_join(election_results, riding_data)




## Make the cartogram--------------------

# Import map data
federal_ridings_spdf <- readRDS("data/federal_ridings_spdf.Rdata")

# Merge in riding population and election data
federal_ridings_spdf <- merge(federal_ridings_spdf, riding_info, by.x="FEDUID",by.y="riding_code")

# Compute area of each federal riding in km^2 area (unit: meters -> convert to square km)
federal_ridings_spdf$area <- gArea(federal_ridings_spdf, byid=TRUE) / (1000000)

# Generate cartogram
federal_ridings_carto <- getcartr::quick.carto(federal_ridings_spdf, federal_ridings_spdf$population_2016, res = 256)

# Use buffer so fortify works
federal_ridings_carto <- gBuffer(federal_ridings_carto, byid=TRUE, width=0)

# Fortify into dataframe that ggplot can use
federal_ridings_carto_df <- fortify(federal_ridings_carto,
                                    region = "FEDUID")

# Save data
use_data(federal_ridings_carto_df)
