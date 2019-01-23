library(tidyverse)

# Source: https://www12.statcan.gc.ca/census-recensement/2016/dp-pd/hlt-fst/pd-pl/comprehensive.cfm

census_pop2016 <- read.csv("data-raw/census_divisions_2016_rawdata.csv", stringsAsFactors = FALSE)

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

names(census_pop2016) <- c("census_code",
                           "census_division_name",
                           "census_division_type",
                           "pr_sgc_code",
                           "pr_english",
                           "population_2016",
                           "population_density_2016",
                           "land_area_2016",
                           "population_2011")

# Create pr_french variable
census_pop2016$pr_french <- dplyr::recode(census_pop2016$pr_sgc_code,
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
census_pop2016$pr_alpha <- dplyr::recode(census_pop2016$pr_sgc_code,
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

census_pop2016$census_code <- as.numeric(census_pop2016$census_code)

# Load in born outside Canada data
load(file = "data-raw/riding_characteristics/census_divisions_immigrants.Rdata")
census_divisions_immigrants
census_pop2016 <- inner_join(census_pop2016, census_divisions_immigrants, by = c("census_code" = "census_division_code")) %>%
  mutate(census_division_name = census_division_name.y) %>%
  select(-c(census_division_name.x, census_division_name.y)) %>%
  mutate(born_outside_canada_share = born_outside_canada/population_2016)

# Convert to ASCII
census_pop2016 <- census_pop2016 %>%
  mutate_if(is.character, stringi::stri_enc_toascii)

usethis::use_data(census_pop2016, overwrite = TRUE)
