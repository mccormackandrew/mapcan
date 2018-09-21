library(tidyverse)

# Data source:
# https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=1710000501

province_populations <- read.csv("data-raw/17100005.csv")

province_populations <- province_populations %>%
  dplyr::select(REF_DATE, GEO, Sex, Age.group, VALUE)

province_pop_annual <- province_populations %>%
  filter(Age.group == "All ages" & Sex == "Both sexes")


province_pop_annual <- province_pop_annual %>%
  dplyr::select(REF_DATE, GEO, VALUE)

names(province_pop_annual) <- c("year", "province", "population")

use_data(province_pop_annual)
