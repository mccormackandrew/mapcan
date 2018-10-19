#' Provinces and territories standard geographic data
#'
#' @description A data set with geographic information for Canadian provinces and territories
#'
#' @format A data.frame with 37111 rows and 12 variables:
#' \describe{
#'   \item{long}{Longitude}
#'   \item{lat}{Latitude}
#'   \item{order}{Order of layers}
#'   \item{hole}{Polygon hole (TRUE or FALSE)}
#'   \item{piece}{Piece}
#'   \item{pr}{Province or territory name (English and French).}
#'   \item{group}{Group}
#'   \item{pr_english}{Province or territory name (English).}
#'   \item{pr_french}{Province or territory name (French).}
#'   \item{pr_abbr_english}{English abbreviation of the province or territory name.}
#'   \item{pr_abbr_french}{French abbreviation of the province or territory name.}
#' }
#' @source \url{https://www12.statcan.gc.ca/census-recensement/2011/geo/bound-limit/bound-limit-2016-eng.cfm},
#' (under Statistics Canada Open Licence \url{https://www.statcan.gc.ca/eng/reference/licence})
"provinces_territories"

#' Provinces and territories cartogram data
#'
#' @description A data set with geographic information for Canadian provinces and territories, boundary divisions
#' distorted by population size
#'
#' @format A data.frame with 37111 rows and 12 variables:
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
"provinces_territories_carto_df"

#' Federal ridings
#'
#' @description A data set with geographic information for Canadian federal
#' ridings (2013 representation order)
#'
#' @format A data.frame with 209933 rows and 12 variables:
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
#'   \item{pr_english}{Province name (English)}
#'   \item{pr_french}{Province name (French)}
#'   \item{pr_alpha}{Province or territory 2-letter identifier}
#'   \item{province_sgc_code}{Province Standard Geographical Classification
#'                            (SGC) code}
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
