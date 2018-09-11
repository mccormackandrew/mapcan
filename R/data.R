#' Provinces and territories
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
#' @source \url{https://www12.statcan.gc.ca/census-recensement/2011/geo/bound-limit/bound-limit-2016-eng.cfm}
"provinces_territories"

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
#'   \item{code}{Uniquely identifies a federal electoral district (composed of the
#'               2-digit province/territory unique identifier followed by the
#'               3-digit federal electoral district code).}
#'   \item{group}{Group}
#'   \item{riding_name}{Federal electoral district name.}
#'   \item{riding_name_english}{Federal electoral district name in English.}
#'   \item{riding_name_french}{Federal electoral district name in French.}
#'   \item{province_sgc_code}{Province Standard Geographical Classification
#'                            (SGC) code}
#'   \item{province}{Province or territory name (English and French)}
#' }
#' @source \url{https://www12.statcan.gc.ca/census-recensement/2011/geo/bound-limit/bound-limit-2016-eng.cfm}
"federal_ridings"

#' Census divisions (2016)
#'
#' @description A data set with geographic information for Canadian census divisions
#'
#' @format A data.frame with 91430 rows and 11 variables:
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
#'   \item{province_sgc_code}{Province Standard Geographical Classification
#'                            (SGC) code.}
#'   \item{province}{Province or territory name (English and French)}
#' }
#' @source \url{https://www12.statcan.gc.ca/census-recensement/2011/geo/bound-limit/bound-limit-2016-eng.cfm}
"census_divisions_2016"
