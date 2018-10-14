library(pacman)
p_load(tidyverse, devtools)

representation_1996_provinces <- readxl::read_excel("data-raw/canada_squares.xls", sheet = "representation_1996_provinces")
representation_2003_provinces <- readxl::read_excel("data-raw/canada_squares.xls", sheet = "representation_2003_provinces")
representation_2013_provinces <- readxl::read_excel("data-raw/canada_squares.xls", sheet = "representation_2013_provinces")



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
  bins_df$year <- rep(year, nrow(bins_df))
  return(na.omit(bins_df))
}

federal_riding_bins <- rbind(binsfun(representation_1996_provinces, 1996),
      binsfun(representation_2003_provinces, 2003),
      binsfun(representation_2013_provinces, 2013))

names(federal_riding_bins) <- c("y", "x", "pr_alpha", "representation_order")

federal_riding_bins$pr_english <- dplyr::recode(federal_riding_bins$pr_alpha,
                                            `NL` = "Newfoundland and Labrador",
                                            `PE` = "Prince Edward Island",
                                            `NS` = "Nova Scotia",
                                            `NB` = "New Brunswick",
                                            `QC` = "Quebec",
                                            `ON` = "Ontario",
                                            `MB` = "Manitoba",
                                            `SK` = "Saskatchewan",
                                            `AB` = "Alberta",
                                            `BC` = "British Columbia",
                                            `YT` = "Yukon",
                                            `NT` = "Northwest Territories",
                                            `NU` = "Nunavut")

federal_riding_bins$pr_french <- dplyr::recode(federal_riding_bins$pr_alpha,
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

federal_riding_bins$pr_sgc_code <- dplyr::recode(federal_riding_bins$pr_alpha,
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

federal_riding_bins$y <- as.numeric(federal_riding_bins$y)

table(federal_riding_bins[federal_riding_bins$representation_order == 2013, ]$pr_alpha)





## NOT A FINAL SOLUTION HERE
## RIDING CODES FOR OTHER REPRESENTATION ORDERS MUST ALSO BE ADDED

representation_2013_ridings <- readxl::read_excel("data-raw/canada_squares.xls", sheet = "representation_2013_ridings")

representation_2013_ridings <- binsfun(representation_2013_ridings, "2013")

federal_riding_bins$riding_code <- c(rep(NA, nrow(federal_riding_bins) - nrow(representation_2013_ridings)),
                                     representation_2013_ridings$value.2)


use_data(federal_riding_bins)

