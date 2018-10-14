#' Canadian maps function
#'
#' A function that returns a data frame with map data, for use in ggplot.
#'
#' @param boundaries Unquoted expression specifying boundary divisions. Options are \code{province}, \code{census}, and \code{ridings}.
#' @param type Unquoted expression specifying type of map. Options are \code{standard} (for a standard geographic map),
#' \code{cartogram} (for a map that alters the geography of the map based on population size at the province or census
#' division level), and \code{bins} (for a binned map of federal electoral districts).
#' @param province An unquoted expression specifying province to plot. Acceptable input is French or English province
#' names, or two-letter provincial abbreviations. Default is to plot all provinces.
#' @param territories A logical value indicating whether or not to include territories in the the returned data frame,
#' default is \code{FALSE}
#'
#'
#' @examples
#' mapcan(boundaries = provinces, type = standard, ...)
#'
#' @export
mapcan <- function(boundaries,
                   type,
                   province = all,
                   territories = TRUE
                   #year = election year (only relevant for ridings data)
                     ) {

  # Capture expression (with substitute) and convert to a character string (deparse)
  type_chr <- deparse(substitute(type))
  boundaries_chr <- deparse(substitute(boundaries))

  ## PROVINCE
  if (boundaries_chr %in% c("province", "provinces", "provincial")) {
    if (type_chr == "standard") {
      mapcan_data <- mapcan::provinces_territories
    }
    if (type_chr == "carto" & territories == TRUE) {
      mapcan_data <- mapcan::provinces_territories_carto_df
    }
    if (type_chr == "carto" & territories == FALSE) {
      mapcan_data <- mapcan::census_divisions_2016_noterr_carto_df
    }
    if (type_chr == "bins") {
      stop("Binned maps only for electoral district boundaries")
    }
  }

  ## FEDERAL RIDINGS
  if (boundaries_chr == "ridings") {
    if (type_chr == "standard") {
      mapcan_data <- mapcan::federal_ridings
    }
    if (type_chr == "standard" & territories == FALSE) {
      mapcan_data <- mapcan::federal_ridings
      mapcan_data <- mapcan_data[!(mapcan_data$pr_alpha %in% c("YT", "NT", "NU")) , ]
    }
    if (type_chr == "carto" & territories == TRUE) {
      stop("Cartograms only for province and census divisions.")
    }
    if (type_chr == "bins") {
      mapcan_data <- mapcan::federal_riding_bins
    }
  }

  ## CENSUS REGIONS (2016)
  if (boundaries_chr == "census") {
    if (type_chr == "standard") {
      mapcan_data <- mapcan::census_divisions_2016
    }
    if (type_chr == "standard" & territories == FALSE) {
      mapcan_data <- mapcan::census_divisions_2016
      mapcan_data <- mapcan_data[!(mapcan_data$pr_alpha %in% c("YT", "NT", "NU")) , ]
    }
    if (type_chr == "carto" & territories == TRUE) {
      stop("Cartograms only for province and census divisions.")
    }
    if (type_chr == "bins") {
      stop("Binned maps only for electoral district boundaries")
    }
  }
  return(mapcan_data)
}
?mapcan
