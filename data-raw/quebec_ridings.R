library(sf)
library(sp)
library(tidyverse)

# Import geojson data
qc_ridings <- sf::st_read("data-raw/quebec-ridings.geojson", quiet = TRUE, stringsAsFactors = FALSE)

# Convert to spatial
qc_ridings <- sf::as_Spatial(qc_ridings)

# Get centroids
qc_riding_centroids <- coordinates(qc_ridings) %>%
  as.data.frame()
# Merge centroids with ridings
qc_riding_centroids <- data.frame(qc_riding_centroids, qc_ridings@data$riding)
# Merge centroid/riding data with rest of data
qc_ridings_vars <- left_join(qc_ridings@data, qc_riding_centroids, by = c("riding" = "qc_ridings.data.riding"))
# Clean up
qc_ridings_vars <- qc_ridings_vars %>%
  mutate(centroid_long = V1,
         centroid_lat = V2) %>%
  dplyr::select(centroid_long, centroid_lat, region, regionname, CO_CEP, riding, NM_CEP)

head(qc_ridings_vars)

## Get hexagon shapefile into ggplot friendly DF
qc_ridings <- qc_ridings %>%
  fortify(region = "CO_CEP") %>%
  mutate(CO_CEP = id)

## Merge with centroid data
qc_ridings <- left_join(qc_ridings, qc_ridings_vars)

# GGPLOT AS GUIDE TO EXCEL SQUARES
#ggplot(qc_ridings_vars, aes(x = centroid_long, y = centroid_lat, group = CO_CEP, label = CO_CEP)) +
#  geom_point(colour = "orange", size = 7) +
#  geom_text()

# MAKE THE BINS

quebec_riding_bins <- readxl::read_excel("data-raw/canada_squares.xls", sheet = "quebec_provincial_ridings")

binsfun <- function(data, year) {
  rows <- data
  for(i in 1:nrow(rows)) {
    rows[i, ] <- seq(1, ncol(rows), 1)
  }
  cols <- data
  for(i in 1:ncol(cols)) {
    cols[ , i] <- seq(1, nrow(cols), 1)
  }
  bins_df <- data.frame(x = gather(rows)[,2],
                        y = gather(cols)[,2],
                        vals = gather(data)[,2])
  return(na.omit(bins_df))
}

quebec_riding_bins <- binsfun(quebec_riding_bins)

names(quebec_riding_bins) <- c("y", "x", "riding_code")

quebec_riding_bins$riding_code <- as.character(quebec_riding_bins$riding_code)

quebec_riding_bins <- left_join(quebec_riding_bins, qc_ridings_vars[ , c("regionname", "CO_CEP", "riding", "NM_CEP")], by = c("riding_code" = "CO_CEP"))

names(quebec_riding_bins) <- c("y", "x", "riding_code", "region", "riding_simplified", "riding_name")

quebec_riding_bins$riding_code <- as.numeric(quebec_riding_bins$riding_code)

use_data(quebec_riding_bins, overwrite = T)


