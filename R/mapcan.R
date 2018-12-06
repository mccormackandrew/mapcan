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
#' mapcan(boundaries = census, type = standard)
#'
#' @export
mapcan <- function(boundaries,
                   type,
                   province = all,
                   territories = TRUE
                   #year = election year (only relevant for ridings data)
                     ) {

  # Capture expression (with substitute) and convert to a character string (deparse)

  if (is.symbol(substitute(type))) {
    type_chr <- deparse(substitute(type))
  } else {
    type_chr <- type
  }

  if (is.symbol(substitute(province))) {
    province_chr <- deparse(substitute(province))
  } else {
    province_chr <- province
  }

  if (is.symbol(substitute(boundaries))) {
    boundaries_chr <- deparse(substitute(boundaries))
  } else {
    boundaries_chr <- boundaries
  }

  ## PROVINCE
  if (boundaries_chr %in% c("province", "provinces", "provincial")) {
    if (type_chr == "standard") {
      mapcan_data <- mapcan::provinces_territories
    }
    if (type_chr == "cartogram" & territories == TRUE) {
      mapcan_data <- mapcan::provinces_territories_carto
    }
    if (type_chr == "cartogram" & territories == FALSE) {
      mapcan_data <- mapcan::provinces_noterr_carto
    }
    if (type_chr == "bins") {
      stop("Binned maps only for electoral district boundaries")
    }
    if (missing(type)) {
      stop("type argument is empty, please specify type of map (options are standard, cartogram, and bins)")
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
    if (type_chr == "cartogram" & territories == TRUE) {
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
    if (type_chr == "cartogram") {
      mapcan_data <- mapcan::census_divisions_2016_carto
    }
    if (type_chr == "cartogram" & territories == FALSE) {
      mapcan_data <- mapcan::census_divisions_2016_noterr_carto
    }
    if (type_chr == "bins") {
      stop("Binned maps only for electoral district boundaries")
    }
  }

  ## PLOTTING ONE (OR MORE THAN ONE, BUT NOT ALL) PROVINCE
  if (province_chr != "all") {
    mapcan_data <- mapcan_data[mapcan_data$pr_alpha == province_chr, ]
  }

  return(mapcan_data)
}
