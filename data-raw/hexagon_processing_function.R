library(mapcan)

qc <- quebec_riding_bins

coords_to_spdf <- function(coordinate_data, hex_size, xval, yval, value, bin_num) {
  # Create empty list to fill with polygon coordinate data frames
  polylist <- list()

  # Create polygon coordinate data frames
  for(i in 1:nrow(coordinate_data)) {
    x <- coordinate_data[ , xval][i]
    y <- coordinate_data[ , yval][i]
    hx <- c(0.5, 1, sqrt(3)/2.1)
    hex_coords <- hx/hex_size
    xym <- cbind(c(x - hex_coords[1], x + hex_coords[1], x + hex_coords[2],
                   x + hex_coords[1], x - hex_coords[1], x - hex_coords[2]),
                 c(y + hex_coords[3], y + hex_coords[3], y,
                   y - hex_coords[3], y - hex_coords[3], y))
    xym <- data.frame(xym)
    xym$x_orig <- x
    xym$y_orig <- y
    names(xym) <- c("x", "y", "x_orig", "y_orig")
    polylist[[i]] <- xym
  }

  # Offset every second column so the hexagons snuggle up together
  polylist_offset <- list()

  for(i in 1:length(polylist)) {
    if(polylist[[i]]$x_orig[1] %% 2 == 0) {
      polylist_offset[[i]] <- polylist[[i]] %>%
        mutate(y = y + 0.5)
    } else {
      polylist_offset[[i]] <- polylist[[i]]
    }
  }

  # Keep only x and y
  polylist_offset <- lapply(polylist_offset, function(x) {
    x %>% dplyr::select(x, y)})

  # Turn dataframes into matrices (for the Polygons function)
  polylist_offset <- lapply(polylist_offset, as.matrix)

  # Turn each polygon data frame into a polygon object
  polylist_offset <- lapply(polylist_offset, Polygon)

  # Combine them
  #polylist_combined <- Polygons(polylist_offset, 1)

  polygon_objects <- list()

  for(i in 1:length(polylist_offset)) {
    polygon_objects[[i]] <- Polygons(list(polylist_offset[[i]]), coordinate_data[ , value][i])

  }

  # Convert into an SpatialPolygons
  polygon_sp <- SpatialPolygons(polygon_objects, 1:bin_num)

  # Create data for
  spdf_data <- data.frame(coordinate_data, row.names = coordinate_data[, value])

  #Convert into an SpatialPolygonsDataFrame
  polygon_spdf <- SpatialPolygonsDataFrame(polygon_sp, spdf_data)

  return(polygon_spdf)
}

spdf_to_df <- function(spdf, data, value) {
  spdf %>%
    ggplot2::fortify(region = value) %>%
    mutate(id = as.numeric(id)) %>%
    left_join(data, by = c("id" = value)) %>%
    left_join(data) %>%
    mutate(value = id) %>%
    dplyr::select(-id)
}

##### IMPLEMENTING THE FUNCTION ####

## Quebec ridings
qc_spdf <- coords_to_spdf(qc, hex_size = 2, xval = "y", yval = "x", bin_num = 125, value = "riding_code")

quebec_riding_hexagons <- spdf_to_df(qc_spdf, qc, "riding_code")

#ggplot(quebec_riding_hex, aes(long, lat, group = group)) +
#  geom_polygon() +
#  scale_y_reverse()

use_data(quebec_riding_hexagons)

## Federal ridings
fed2013 <- mapcan::federal_riding_bins[mapcan::federal_riding_bins$representation_order == 2013, ]
fed2003 <- mapcan::federal_riding_bins[mapcan::federal_riding_bins$representation_order == 2003, ]
fed1996 <- mapcan::federal_riding_bins[mapcan::federal_riding_bins$representation_order == 1996, ]

fed2013$riding_code2 <- paste0(fed2013$riding_code, seq(1, 338, 1))
fed2003$riding_code2 <- paste0(fed2003$riding_code, seq(1, 308, 1))
fed1996$riding_code2 <- paste0(fed1996$riding_code, seq(1, 301, 1))

fed2013_spdf <- coords_to_spdf(fed2013,
               hex_size = 2,
               xval = "y",
               yval = "x",
               value = "riding_code2",
               bin_num = 338)

fed2003_spdf <- coords_to_spdf(fed2003,
                               hex_size = 2,
                               xval = "y",
                               yval = "x",
                               value = "riding_code2",
                               bin_num = 308)

fed1996_spdf <- coords_to_spdf(fed1996,
                               hex_size = 2,
                               xval = "y",
                               yval = "x",
                               value = "riding_code2",
                               bin_num = 301)

fed2013_hex <- spdf_to_df(fed2013_spdf, fed2013, "riding_code")
fed2003_hex <- spdf_to_df(fed2003_spdf, fed2003, "riding_code")
fed1996_hex <- spdf_to_df(fed1996_spdf, fed1996, "riding_code")


federal_riding_hexagons <- rbind(fed2013_hex, fed2003_hex, fed1996_hex)

federal_riding_hexagons <- federal_riding_hexagons %>%
  select(-riding_code2)

use_data(federal_riding_hexagons)
