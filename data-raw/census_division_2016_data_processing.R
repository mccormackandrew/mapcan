library(tidyverse)

# Source: https://www12.statcan.gc.ca/census-recensement/2016/dp-pd/hlt-fst/pd-pl/comprehensive.cfm

census_pop2016 <- read.csv("data-raw/census_divisions_2016_rawdata.csv")

census_pop2016 <- census_pop2016[1:which(census_pop2016$Geographic.code == "Note:") - 1, ]

census_pop2016 <- census_pop2016 %>% dplyr::select("Geographic.code",
                                                   "Geographic.name..english",
                                                   "Geographic.type..english",
                                                   "Geographic.code..Province...territory",
                                                   "Province...territory..english",
                                                   "Population..2016",
                                                   "Population.density.per.square.kilometre..2016",
                                                   "Land.area.in.square.kilometres..2016",
                                                   "Population..2011")

names(census_pop2016) <- c("census_division_code",
                           "census_division_name",
                           "census_division_type",
                           "province_sgc_code",
                           "province",
                           "population_2016",
                           "population_density_2016",
                           "land_area_2016",
                           "population_2011")

use_data(census_pop2016)
