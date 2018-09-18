mapcan <- function(type, province = "all", territories = T) {
  # Determine map type and assign to an object
  if (type == "province") {
    mapcan_data <- mapcan::provinces_territories
  } else if (type == "census") {
    mapcan_data <- mapcan::census_divisions_2016
  } else if (type == "ridings") {
    mapcan_data <- mapcan::federal_ridings
  } else {
    stop("Not a valid map type.")
  }

  # Determine map type and assign to an object
  if (territories == FALSE)
    mapcan_data <- mapcan_data[!(mapcan_data$pr_alpha %in% c("YT", "NT", "NU")) , ]

  # Subset by province, if a province is specified
  if (province == "all") {
    return(mapcan_data)
  } else if (province %in% unique(mapcan_data$pr_english)) {
    return(mapcan_data[mapcan_data$pr_english == province, ])
  } else if (province %in% unique(mapcan_data$pr_french)) {
    return(mapcan_data[mapcan_data$pr_french == province, ])
  } else if (province %in% unique(mapcan_data$sgc_code)) {
    return(mapcan_data[mapcan_data$sgc_code == province, ])
  } else if (province %in% unique(mapcan_data$pr_alpha)) {
    return(mapcan_data[mapcan_data$pr_alpha == province, ])
  } else {
    stop("Not a valid province name.")
  }
}
