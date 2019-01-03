library(tidyverse)
library(devtools)

# Creating a Dataset of Canadian federal election results by riding ---------------------------

## Canadian election results by riding for the 1997, 200, 2004, 2006, 2008, 2011, and 2015 elections.
## These data were obtained from the Elections Canada
## website: http://www.elections.ca/content.aspx?section=ele&dir=pas&document=index&lang=e.



# 1997 and 2000 election results --------------------------------------------------------------------------------------------

## Elections Canada provides 1997 and 2000 elections results by riding in tab-delimited format. The file is called `edsum.txt`
## though I rename is `1997_2000_election_results.txt`
## http://www.elections.ca/content.aspx?section=res&document=edsumexe&dir=rep/off/37p&lang=e.

election1997_2000 <- read.delim("data-raw/election_results/1997_2000_election_results.txt", stringsAsFactors = F)

election1997_2000 <- election1997_2000 %>%
  mutate(election_year = case_when(event_english_name == "Thirty-sixth General Election 1997" ~ 1997,
                                   event_english_name == "Thirty-seventh general election 2000" ~ 2000)) %>%
  dplyr::select(-event_english_name, -event_french_name)
election1997_2000$ed_english_name
election1997_2000 <- election1997_2000 %>%
  mutate(candidate = paste0(election1997_2000$elected_last_name, ", ",
                            election1997_2000$elected_first_name, " ",
                            election1997_2000$elected_middle_name)) %>%
  mutate(candidate = trimws(candidate),
         riding_code  = ed_code) %>%
  mutate(population = population_cnt,
         voter_turnout = voter_participation_percentage,
         party = elected_party_english_name,
         province = province_name_english,
         riding_name_english = ed_english_name,
         riding_name_french = ed_french_name) %>%
  dplyr::select(province, riding_name_english, riding_name_french, riding_code,
                population, voter_turnout, candidate, election_year, party)



# 2004 to 2015 election results ----------------------------------------------------------------------------

### 2004
# File downloaded: "Table 11: Voting results, by electoral district", renamed to `2004_election_results.csv`.
# Source: http://www.elections.ca/content.aspx?section=res&dir=rep/off/38gedata&document=summary&lang=e

### 2006
# File downloaded: "Table 11: Voting results, by electoral district", renamed to `2006_election_results.csv`.
# Source: http://www.elections.ca/content.aspx?section=res&dir=rep/off/39gedata&document=summary&lang=e

### 2008
# File downloaded: "Table 11: Voting results, by electoral district", renamed to `2008_election_results.csv`.
# Source: http://www.elections.ca/content.aspx?section=res&dir=rep/off/40gedata&document=summary&lang=e

### 2011
# File downloaded: "Table 11: Voting results, by electoral district", renamed to `2011_election_results.csv`.
# Source: http://www.elections.ca/content.aspx?section=res&dir=rep/off/41gedata&document=summary&lang=e

### 2015
# File downloaded: "Table 11: Voting results, by electoral district", renamed to `2015_election_results.csv`.
# Source: http://www.elections.ca/content.aspx?section=res&dir=rep/off/42gedata&document=summary&lang=e




## Because of some minor inconsistencies in naming and variables,
## it takes a some wrangling to make these files consistent enough to be merged together.

## Get all the file names with attached path
election_file_names <- paste0("data-raw/election_results/",
                              list.files(path = "data-raw/election_results/", pattern = "*.csv"))

## Read in all the files to a list
election_files <- lapply(election_file_names, function(x) read.csv(x, fileEncoding="latin1", stringsAsFactors = F))

## Create a vector to give unique election_year column to each dataframe in the list
election_years <- c(2004, 2006, 2008, 2011, 2015)

## Assign unique election_year column to each dataframe in the list
for(i in 1:length(election_files)) {
  election_files[[i]]$election_year <- election_years[i]
}

## Naming is inconsistent, but variables all mean the same thing
## 2004 and 2006 do not have election district number, just names

names(election_files[[1]]) <- c("province", "riding", "population", "electors",
                                "total_polls", "valid_ballots", "valid_ballots_pct", "rejected_ballots",
                                "rejected_ballots_pct", "total_ballots", "voter_turnout", "candidate", "election_year")

# Create empty "riding_code" variable to enable merging with 08/11/15 data frames (which do have riding_code)
election_files[[1]]$riding_code <- rep(NA, nrow(election_files[[1]]))

names(election_files[[2]]) <- c("province", "riding", "population", "electors",
                                "total_polls", "valid_ballots", "valid_ballots_pct", "rejected_ballots",
                                "rejected_ballots_pct", "total_ballots", "voter_turnout", "candidate", "election_year")

# Create empty "riding_code" variable to enable merging with 08/11/15 data frames (which do have riding_code)
election_files[[2]]$riding_code <- rep(NA, nrow(election_files[[2]]))

names(election_files[[3]]) <- c("province", "riding", "riding_code", "population", "electors",
                                "total_polls", "valid_ballots", "valid_ballots_pct", "rejected_ballots",
                                "rejected_ballots_pct", "total_ballots", "voter_turnout", "candidate", "election_year")

names(election_files[[4]]) <- c("province", "riding", "riding_code", "population", "electors",
                                "total_polls", "valid_ballots", "valid_ballots_pct", "rejected_ballots",
                                "rejected_ballots_pct", "total_ballots", "voter_turnout", "candidate", "election_year")

names(election_files[[5]]) <- c("province", "riding", "riding_code", "population", "electors",
                                "total_polls", "valid_ballots", "valid_ballots_pct", "rejected_ballots",
                                "rejected_ballots_pct", "total_ballots", "voter_turnout", "candidate", "election_year")

## Select and order variables of interest
for(i in 1:length(election_files)) {
  election_files[[i]] <- election_files[[i]] %>%
    dplyr::select(province, riding, riding_code, population, voter_turnout, candidate, election_year)
}

## Merge the dataframes together!
elections_2004_2015 <- do.call("rbind", election_files)

elections_2004_2015$party <- rep(NA, nrow(elections_2004_2015))

## Create a party variable
for(i in 1:nrow(elections_2004_2015)) {
  if (grepl("Liberal", elections_2004_2015$candidate[i]) == T) {
    elections_2004_2015$party[i] <- "Liberal"
  } else if (grepl("Conservative", elections_2004_2015$candidate[i]) == T) {
    elections_2004_2015$party[i] <- "Conservative"
  } else if (grepl("N.D.P.|NDP|New Democratic Party", elections_2004_2015$candidate[i]) == T) {
    elections_2004_2015$party[i] <- "NDP"
  } else if (grepl("Bloc Québécois|Bloc QuÃ©bÃ©cois", elections_2004_2015$candidate[i]) == T) {
    elections_2004_2015$party[i] <- "Bloc"
  } else if (grepl("Green", elections_2004_2015$candidate[i]) == T) {
    elections_2004_2015$party[i] <- "Green"
  } else if (grepl("Independent|No Affiliation", elections_2004_2015$candidate[i]) == T) {
    elections_2004_2015$party[i] <- "Independent"
  } else {
    elections_2004_2015$party[i] <-  elections_2004_2015$party[i]
  }
}


elections_2004_2015$candidate <- gsub("Conservative/conservateur|Conservative/Conservateur|Liberal/Libéral|N.D.P./N.P.D.|
     |Bloc Québécois/Bloc Québécois|No Affiliation/Aucune appartenance|Independent/Indépendant|
     |NDP-New Democratic Party/NPD-Nouveau Parti démocratique", "", elections_2004_2015$candidate)

elections_2004_2015$candidate <- trimws(elections_2004_2015$candidate)

elections_2004_2015 <- elections_2004_2015 %>%
  separate(riding, c("riding_name_english", "riding_name_french"), sep = "/")

for(i in 1:nrow(elections_2004_2015)) {
  if (is.na(elections_2004_2015$riding_name_french[i])) {
    elections_2004_2015$riding_name_french[i] <- elections_2004_2015$riding_name_english[i]
  } else {
    elections_2004_2015$riding_name_french[i] <- elections_2004_2015$riding_name_english[i]
  }
}



elections_2004_2015$province[elections_2004_2015$province ==
                               "Newfoundland and Labrador/Terre-Neuve-et-Labrador"] <- "Newfoundland and Labrador"
elections_2004_2015$province[elections_2004_2015$province ==
                               "Prince Edward Island/Île-du-Prince-Édouard"] <- "Prince Edward Island"
elections_2004_2015$province[elections_2004_2015$province %in%
                               c("Nova Scotia/Nouvelle-Écosse",
                                 "Nova Scotia/Nouvelle-Ã\u0089cosse")] <- "Nova Scotia"
elections_2004_2015$province[elections_2004_2015$province ==
                               "New Brunswick/Nouveau-Brunswick"] <- "New Brunswick"
elections_2004_2015$province[elections_2004_2015$province ==
                               "British Columbia/Colombie-Britannique"] <- "British Columbia"
elections_2004_2015$province[elections_2004_2015$province ==
                               "Northwest Territories/Territoires du Nord-Ouest"] <- "Northwest Territories"
elections_2004_2015$province[elections_2004_2015$province ==
                               "Prince Edward Island/Ã\u008ele-du-Prince-Ã\u0089douard"] <- "Prince Edward Island"
elections_2004_2015$province[elections_2004_2015$province %in%
                               c("Quebec/Québec", "Quebec/QuÃ©bec")] <- "Quebec"

# Merging all the elections together -----------------------------------

federal_election_results <- rbind(election1997_2000, elections_2004_2015)



# Add additional province identifiers -----------------------------------


federal_election_results$province[federal_election_results$province == "Newfoundland"] <- "Newfoundland and Labrador"
federal_election_results$province[federal_election_results$province == "Yukon Territory"] <- "Yukon"


federal_election_results$pr_alpha <- dplyr::recode(federal_election_results$province,
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
                                                   `Yukon` = "YK",
                                                   `Northwest Territories` = "NT",
                                                   `Nunavut` = "NU")

federal_election_results$pr_french <- dplyr::recode(federal_election_results$pr_alpha,
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
                                               `YK` = "Yukon",
                                               `NT` = "Territoires du Nord-Ouest",
                                               `NU` = "Nunavut")

federal_election_results$pr_sgc_code <- dplyr::recode(federal_election_results$pr_alpha,
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
                                                 `YK` = 60L,
                                                 `NT` = 61L,
                                                 `NU` = 62L)

federal_election_results <- federal_election_results %>%
  mutate(pr_english = province) %>%
  dplyr::select(-province)


# Make riding_code consistent (i.e. just numbers)
federal_election_results$riding_code <- gsub("ED", "", federal_election_results$riding_code) %>%
  gsub("-", "", .)

federal_election_results$riding_code <- as.numeric(federal_election_results$riding_code)

federal_election_results <- federal_election_results %>%
  mutate_if(is.character, stringi::stri_enc_toascii)

use_data(federal_election_results, overwrite = T)

