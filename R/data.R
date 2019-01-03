#' Provinces and territories standard geographic data
#'
#' @description A data set with geographic information for Canadian provinces and territories
#'
#' @format A data.frame with 37111 rows and 10 variables:
#' \describe{
#'   \item{long}{Longitude}
#'   \item{lat}{Latitude}
#'   \item{order}{Order of layers}
#'   \item{hole}{Polygon hole (TRUE or FALSE)}
#'   \item{piece}{Piece}
#'   \item{province_sgc_code}{Province Standard Geographical Classification
#'                            (SGC) code}
#'   \item{group}{Group}
#'   \item{pr_english}{Province or territory name (English).}
#'   \item{pr_french}{Province or territory name (French).}
#'   \item{pr_alpha}{Province or territory 2-letter identifier}
#' }
#' @source \url{https://www12.statcan.gc.ca/census-recensement/2011/geo/bound-limit/bound-limit-2016-eng.cfm},
#' (under Statistics Canada Open Licence \url{https://www.statcan.gc.ca/eng/reference/licence})
"provinces_territories"

#' Provinces and territories cartogram data (territories included)
#'
#' @description A data set with geographic information for Canadian provinces and territories, boundary divisions
#' distorted by population size. Territories included.
#'
#' @format A data.frame with 40064 rows and 12 variables:
#' \describe{
#'   \item{long}{Longitude}
#'   \item{lat}{Latitude}
#'   \item{order}{Order of layers}
#'   \item{hole}{Polygon hole (TRUE or FALSE)}
#'   \item{piece}{Piece}
#'   \item{pr_english}{Province or territory name (English).}
#'   \item{group}{Group}
#'   \item{population}{2016 Population of Province}
#'   \item{pr_alpha}{Province or territory 2-letter identifier}
#'   \item{pr_french}{Province or territory name (French).}
#'   \item{province_sgc_code}{Province Standard Geographical Classification
#'                            (SGC) code}
#'                            }
#' @source \url{https://www12.statcan.gc.ca/census-recensement/2011/geo/bound-limit/bound-limit-2016-eng.cfm},
#' (under Statistics Canada Open Licence \url{https://www.statcan.gc.ca/eng/reference/licence})
"provinces_territories_carto"

#' Provinces and territories cartogram data (territories excluded)
#'
#' @description A data set with geographic information for Canadian provinces and territories, boundary divisions
#' distorted by population size. Territories excluded.
#'
#' @format A data.frame with 16797 rows and 11 variables:
#' \describe{
#'   \item{long}{Longitude}
#'   \item{lat}{Latitude}
#'   \item{order}{Order of layers}
#'   \item{hole}{Polygon hole (TRUE or FALSE)}
#'   \item{piece}{Piece}
#'   \item{pr_english}{Province or territory name (English).}
#'   \item{group}{Group}
#'   \item{population}{2016 Population of Province}
#'   \item{pr_alpha}{Province or territory 2-letter identifier}
#'   \item{pr_french}{Province or territory name (French).}
#'   \item{province_sgc_code}{Province Standard Geographical Classification
#'                            (SGC) code}
#'                            }
#' @source \url{https://www12.statcan.gc.ca/census-recensement/2011/geo/bound-limit/bound-limit-2016-eng.cfm},
#' (under Statistics Canada Open Licence \url{https://www.statcan.gc.ca/eng/reference/licence})
"provinces_noterr_carto"

#' Federal ridings
#'
#' @description A data set with geographic information for Canadian federal
#' ridings (2013 representation order)
#'
#' @format A data.frame with 46830 rows and 15 variables:
#' \describe{
#'   \item{long}{Longitude}
#'   \item{lat}{Latitude}
#'   \item{order}{Order of layers}
#'   \item{hole}{Polygon hole (TRUE or FALSE)}
#'   \item{piece}{Piece}
#'   \item{riding_code}{Uniquely identifies a federal electoral district (composed of the
#'               2-digit province/territory unique identifier followed by the
#'               3-digit federal electoral district code).}
#'   \item{group}{Group}
#'   \item{riding_name_english}{Federal electoral district name in English.}
#'   \item{riding_name_french}{Federal electoral district name in French.}
#'   \item{province_sgc_code}{Province Standard Geographical Classification
#'                            (SGC) code}
#'   \item{pr_english}{Province name (English)}
#'   \item{pr_french}{Province name (French)}
#'   \item{pr_alpha}{Province or territory 2-letter identifier}
#' }
#' @source \url{https://www12.statcan.gc.ca/census-recensement/2011/geo/bound-limit/bound-limit-2016-eng.cfm},
#' (under Statistics Canada Open Licence \url{https://www.statcan.gc.ca/eng/reference/licence})
"federal_ridings"

#' Census divisions (2016)
#'
#' @description A data set with geographic information for Canadian census divisions
#'
#' @format A data.frame with 91430 rows and 13 variables:
#' \describe{
#'   \item{long}{Longitude}
#'   \item{lat}{Latitude}
#'   \item{order}{Order of layers}
#'   \item{hole}{Polygon hole (TRUE or FALSE)}
#'   \item{piece}{Piece}
#'   \item{id}{Uniquely identifies a census division (composed of the 2-digit
#'             province/territory unique identifier followed by the 2-digit
#'             census division code).}
#'   \item{group}{Group}
#'   \item{census_division_name}{Census division name}
#'   \item{census_divison_type}{Census division type}
#'   \item{pr_alpha}{Province or territory 2-letter identifier}
#'   \item{pr_sgc_code}{Province Standard Geographical Classification
#'                            (SGC) code.}
#'   \item{pr_english}{Province name (English)}
#'   \item{pr_french}{Province name (French)}
#' }
#' @source \url{https://www12.statcan.gc.ca/census-recensement/2011/geo/bound-limit/bound-limit-2016-eng.cfm}
#' (under Statistics Canada Open Licence \url{https://www.statcan.gc.ca/eng/reference/licence})
"census_divisions_2016"

#' Census divisions cartogram data frame (territories excluded)  (2016)
#'
#' @description A data set with geographic information for Canadian census divisions, census boundary divisions
#' distorted by population size, territories excluded
#'
#' @format A data.frame with 35410 rows and 18 variables:
#' \describe{
#'   \item{long}{Longitude}
#'   \item{lat}{Latitude}
#'   \item{order}{Order of layers}
#'   \item{hole}{Polygon hole (TRUE or FALSE)}
#'   \item{piece}{Piece}
#'   \item{census_code}{Uniquely identifies a census division (composed of the 2-digit
#'             province/territory unique identifier followed by the 2-digit
#'             census division code).}
#'   \item{group}{Group}
#'   \item{census_division_name}{Census division name}
#'   \item{census_divison_type}{Census division type}
#'   \item{pr_sgc_code}{Province Standard Geographical Classification
#'                            (SGC) code.}
#'   \item{population_2016}{Population of census division in 2016}
#'   \item{population_2016}{Population density (individuals per square kilometer) in 2016}
#'   \item{land_area_2016}{Land area of census division}
#'   \item{population_2011}{Population of census division in 2011}
#'   \item{pr_alpha}{Province or territory 2-letter identifier}
#'   \item{pr_english}{Province name (English)}
#'   \item{pr_french}{Province name (French)}
#' }
#' @source \url{https://www12.statcan.gc.ca/census-recensement/2011/geo/bound-limit/bound-limit-2016-eng.cfm}
#' (under Statistics Canada Open Licence \url{https://www.statcan.gc.ca/eng/reference/licence})
"census_divisions_2016_noterr_carto"

#' Census divisions cartogram data frame (territories included)  (2016)
#'
#' @description A data set with geographic information for Canadian census divisions, census boundary divisions
#' distorted by population size, territories included
#'
#' @format A data.frame with 57513 rows and 18 variables:
#' \describe{
#'   \item{long}{Longitude}
#'   \item{lat}{Latitude}
#'   \item{order}{Order of layers}
#'   \item{hole}{Polygon hole (TRUE or FALSE)}
#'   \item{piece}{Piece}
#'   \item{census_code}{Uniquely identifies a census division (composed of the 2-digit
#'             province/territory unique identifier followed by the 2-digit
#'             census division code).}
#'   \item{group}{Group}
#'   \item{census_division_name}{Census division name}
#'   \item{census_divison_type}{Census division type}
#'   \item{pr_sgc_code}{Province Standard Geographical Classification
#'                            (SGC) code.}
#'   \item{population_2016}{Population of census division in 2016}
#'   \item{population_density_2016}{Population density (individuals per square kilometer) in 2016}
#'   \item{land_area_2016}{Land area of census division}
#'   \item{population_2011}{Population of census division in 2011}
#'   \item{pr_alpha}{Province or territory 2-letter identifier}
#'   \item{pr_english}{Province name (English)}
#'   \item{pr_french}{Province name (French)}
#' }
#' @source \url{https://www12.statcan.gc.ca/census-recensement/2011/geo/bound-limit/bound-limit-2016-eng.cfm}
#' (under Statistics Canada Open Licence \url{https://www.statcan.gc.ca/eng/reference/licence})
"census_divisions_2016_carto"

#' Census division population data for 2011 and 2016
#'
#' @description A data set with population data at the census level for 2011 and 2016
#'
#' @format A data.frame with 293 rows and 11 variables:
#' \describe{
#'   \item{census_division_code}{Uniquely identifies a census division (composed of the 2-digit
#'             province/territory unique identifier followed by the 2-digit
#'             census division code).}
#'   \item{census_division_name}{Census division name}
#'   \item{census_divison_type}{Census division type}
#'   \item{pr_sgc_code}{Province Standard Geographical Classification
#'                            (SGC) code.}
#'   \item{pr_english}{Province or territory name (English).}
#'   \item{population_2016}{2016 Population of Province}
#'   \item{population_density_2016}{Population density (individuals per square kilometer) in 2016}
#'   \item{land_area_2016}{Land area of census division}
#'   \item{population_2011}{2011 Population of Province}
#'   \item{pr_alpha}{Province or territory 2-letter identifier}
#'   \item{pr_french}{Province or territory name (French).}
#'   }
#' @source \url{https://www12.statcan.gc.ca/census-recensement/2016/dp-pd/hlt-fst/pd-pl/comprehensive.cfm},
#' (under Statistics Canada Open Licence \url{https://www.statcan.gc.ca/eng/reference/licence})
"census_pop2016"

#' Canadian federal election results data
#'
#' @description A data set with information on Canadian federal election results, dating back to 1997
#'
#' @format A data.frame with 37111 rows and 12 variables:
#' \describe{
#'   \item{riding_name_english}{Federal electoral district name in English.}
#'   \item{riding_name_french}{Federal electoral district name in French.}
#'   \item{riding_code}{Uniquely identifies a federal electoral district (composed of the
#'               2-digit province/territory unique identifier followed by the
#'               3-digit federal electoral district code).}
#'   \item{pr}{Province or territory name (English and French).}
#'   \item{population}{Population of federal riding.}
#'   \item{voter_turnout}{Voter turnout}
#'   \item{candidate}{Name of winning candidate}
#'   \item{election_year}{Year of election (1997, 2000, 2004, 2006, 2008, 2011, and 2015 election included.)}
#'   \item{party}{Winning party in riding}
#'   \item{pr_alpha}{Province or territory 2-letter identifier}
#'   \item{pr_french}{Province or territory name (French).}
#'   \item{pr_english}{Province or territory name (English).}
#'   \item{pr_sgc_code}{Province Standard Geographical Classification
#'                            (SGC) code.}
#' }
#' @source \url{http://www.elections.ca/content.aspx?section=ele&dir=pas&document=index&lang=e},
#' (under Open Government Licence \url{https://open.canada.ca/en/open-government-licence-canada})
"federal_election_results"

#' Canadian federal riding bins (used for tile plots)
#'
#' @description A data set with coordinates for the \code{mapcan::riding_binplot()} function.
#'
#' @format A data.frame with 944 rows and 8 variables:
#' \describe{
#'   \item{y}{y-axis of riding bins (corresponds to longitude)}
#'   \item{x}{x-axis of riding bins (corresponds to latitude)}
#'   \item{pr_alpha}{Province or territory 2-letter identifier}
#'   \item{representation_order}{Representation order. Specifies boundaries/number of seats for a given election
#'   (e.g. the 2015 election used the 2013 representation order, with 338 seats).}
#'   \item{pr_french}{Province or territory name (French).}
#'   \item{pr_english}{Province or territory name (English).}
#'   \item{pr_sgc_code}{Province Standard Geographical Classification
#'                            (SGC) code.}
#'   \item{riding_code}{Uniquely identifies a federal electoral district (composed of the
#'               2-digit province/territory unique identifier followed by the
#'               3-digit federal electoral district code).}
#' }
"federal_riding_bins"


#' Annual provincial populations data frame dating back to 1971
#'
#' @description A data set with annual information on provincial and territorial populations dating back to 1971.
#'
#' @format A data.frame with 638 rows and 3 variables:
#' \describe{
#'   \item{province}{English name of province}
#'   \item{population}{Population of province}
#'   \item{year}{Year}
#' }
"province_pop_annual"

#' Canadian federal riding hexagons (used for hexagonal tile plots)
#'
#' @description A data set with coordinates for the \code{mapcan::riding_binplot()} function.
#'
#' @format A data.frame with 6629 rows and 15 variables:
#' \describe{
#'   \item{long}{y-axis of riding hexagons}
#'   \item{lat}{x-axis of riding hexagons}
#'   \item{order}{Order of layers}
#'   \item{hole}{Polygon hole (TRUE or FALSE)}
#'   \item{piece}{Piece}
#'   \item{group}{Group}
#'   \item{representation_order}{Representation order. Specifies boundaries/seats for a given election
#'   (e.g. the 2015 election used the 2013 representation order, with 338 seats).}
#'   \item{pr_french}{Province or territory name (French).}
#'   \item{pr_english}{Province or territory name (English).}
#'   \item{pr_sgc_code}{Province Standard Geographical Classification
#'                            (SGC) code.}
#'   \item{riding_code}{Uniquely identifies a federal electoral district (composed of the
#'               2-digit province/territory unique identifier followed by the
#'               3-digit federal electoral district code).}
#' }
"federal_riding_hexagons"

#' Quebec provincial ridings geographic data
#'
#' @description A data set with geographic information for Quebec provincial ridings
#'
#' @format A data.frame with 23995 rows and 11 variables:
#' \describe{
#'   \item{long}{y-axis of riding hexagons}
#'   \item{lat}{x-axis of riding hexagons}
#'   \item{order}{Order of layers}
#'   \item{hole}{Polygon hole (TRUE or FALSE)}
#'   \item{piece}{Piece}
#'   \item{riding_code}{Uniquely identifies a provincial electoral district}
#'   \item{group}{Group}
#'   \item{riding_name}{Riding name (lowercase)}
#'   \item{riding_name}{Riding name (uppercase)}
#'   \item{centroid_long}{Longitude for riding centroids (useful for labeling)}
#'   \item{centroid_lat}{Latitude for riding centroids (useful for labeling)}
#' }
"quebec_prov_ridings2018"

#' Quebec provincial election results data
#'
#' @description A data set with information on 2018 Quebec provincial election results
#'
#' @format A data.frame with 125 rows and 6 variables:
#' \describe{
#'   \item{party}{Winning party of riding.}
#'   \item{vote_share}{Percentage of vote won by winning candidate.}
#'   \item{riding_code}{Uniquely identifies a provincial electoral district}
#'   \item{riding_name}{Riding name (lowercase)}
#'   \item{riding_name}{Riding name (uppercase)}
#' }
"quebec_provincial_results"

#' Quebec provincial riding bins (used for tile plots)
#'
#' @description A data set with coordinates for the \code{mapcan::riding_binplot()} function.
#'
#' @format A data.frame with 125 rows and 6 variables:
#' \describe{
#'   \item{y}{y-axis of riding bins (corresponds to longitude)}
#'   \item{x}{x-axis of riding bins (corresponds to latitude)}
#'   \item{riding_code}{Riding code}
#'   \item{region}{Region}
#'   \item{riding_simplified}{Simplified riding name}
#'   \item{riding_name}{Riding name}
#' }
"quebec_riding_bins"


#' Quebec provincial riding hexagons (used for hexagonal tile plots)
#'
#' @description A data set with coordinates for the \code{mapcan::riding_binplot()} function.
#'
#' @format A data.frame with 6629 rows and 15 variables:
#' \describe{
#'   \item{long}{y-axis of riding hexagons}
#'   \item{lat}{x-axis of riding hexagons}
#'   \item{order}{Order of layers}
#'   \item{hole}{Polygon hole (TRUE or FALSE)}
#'   \item{piece}{Piece}
#'   \item{group}{Group}
#'   \item{y}{y-axis of riding hexagon center}
#'   \item{x}{x-axis of riding hexagon center}
#'   \item{region}{Region}
#'   \item{riding_simplified}{Simplified riding name}
#'   \item{riding_name}{Riding name}
#'   \item{riding_code}{Riding code}
#' }
"quebec_riding_hexagons"

#' Canadian federal riding population information
#'
#' @description A data set with information on Canadian federal election results, dating back to 1997
#'
#' @format A data.frame with 37111 rows and 12 variables:
#' \describe{
#'   \item{party}{Winning party in riding}
#'   \item{riding_code}{Riding code}
#'   \item{population_2011}{Population of riding in 2011}
#'   \item{population_2016}{Population of riding in 2016}
#'}
#' @source \url{http://www.elections.ca/content.aspx?section=ele&dir=pas&document=index&lang=e},
#' (under Open Government Licence \url{https://open.canada.ca/en/open-government-licence-canada})
"riding_info"
