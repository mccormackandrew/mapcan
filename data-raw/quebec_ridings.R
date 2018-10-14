library(sf)
library(sp)
library(tidyverse)


qc_ridings <- sf::st_read("data-raw/quebec-ridings.geojson", quiet = TRUE, stringsAsFactors = FALSE)

qc_ridings <- sf::as_Spatial(qc_ridings)

qc_riding_cnt <- coordinates(qc_ridings)
  as.data.frame()

qc_ridings_cnt <- data.frame(qc_riding_cnt, qc_ridings@data$riding)


merge(sf::as_Spatial(qc_ridings))

qc_ridings_df <- qc_ridings %>%
  data.frame() %>%
  dplyr::select(region, regionname, CO_CEP, riding, NM_CEP)

qc_ridings <- sf::as_Spatial(qc_ridings) %>%
  fortify(region = "CO_CEP") %>%
  mutate(CO_CEP = id)

qc_ridings <- left_join(qc_ridings, qc_ridings_df)




