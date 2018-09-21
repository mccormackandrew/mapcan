mapcan <- function(boundaries,
                   # type = standard, carto, cubes
                   province = all,
                   # subset =
                   territories = TRUE) {

  # Capture expression (with substitute) and convert to a character string (deparse)
  boundaries_chr <- deparse(substitute(boundaries))

  # Determine map type and assign to an object
  if (boundaries_chr == "province") {
    mapcan_data <- mapcan::provinces_territories
  } else if (boundaries_chr == "census") {
    mapcan_data <- mapcan::census_divisions_2016
  } else if (boundaries_chr == "ridings") {
    mapcan_data <- mapcan::federal_ridings
  } else {
    stop("Not a valid map boundary.")
  }

  province_chr <- deparse(substitute(province))

  # Determine map type and assign to an object
  if (territories == FALSE)
    mapcan_data <- mapcan_data[!(mapcan_data$pr_alpha %in% c("YT", "NT", "NU")) , ]

  # Subset by province, if a province is specified
  if (province_chr == "all") {
    return(mapcan_data)
  } else if (province_chr %in% unique(mapcan_data$sgc_code)) {
    return(mapcan_data[mapcan_data$sgc_code == province_chr, ])
  } else if (province_chr %in% unique(mapcan_data$pr_alpha)) {
    return(mapcan_data[mapcan_data$pr_alpha == province_chr, ])
  } else {
    stop("Not a valid province name.")
  }
}
