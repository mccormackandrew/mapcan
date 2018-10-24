#' Canadian federal ridings tile plot function
#'
#' A function that returns a data frame with map data, for use in ggplot.
#'
#' @param riding_data A dataframe with a continuous or categorical riding-level characteristic and a riding code variable.
#' @param riding_col An unquoted character expression specifying the continous or categorical riding level characteristic
#' you would like to visualize.
#' @param continuous logical. Specify as \code{FALSE} if the variable is categorical (e.g. for winning party) and \code{TRUE}
#' if the variable is continuous.
#' @param arrange logical. Specify as \code{TRUE} if variable should be ranked according to value within provinces and \code{FALSE}
#' to plot values according to riding coordinates. Because the binned ridings are only a rough approximation of their actual location,
#' \code{arrange = TRUE} is often preferable.
#' @param riding_border_col To ensure the appearance of stand alone tiles, set `riding_border_col`
#' to be the same as the background colour of the plot. Default is \code{"white"}.
#' @param year Election year. Options are \code{1997}, \code{2000}, \code{2004}, \code{2006}, \code{2008}, \code{2011} and
#' \code{2015}. This will change the number of tiles to correspond to the number of ridings in the election of the specified year.
#' Default is \code{2015}
#' @param riding_border_size Change the size of tiles. Larger values make smaller tiles. Default is \code{1}.
#' @param provincial logical. Specify as FALSE for provincial (not federal) ridings of a single province.
#' If \code{provincial = TRUE}, specify a 2-letter provincial abbreviation for the province in the \code{province} argument.
#' Default is \code{FALSE} (i.e. the default is to provide federal electoral boundaries).
#' (Note: this argument is still in development, only Quebec provincial boundaries are available at the moment.)
#' @param province An unquoted character expression specifying the 2-letter provincial abbreviation of the province
#' for which provincial electoral boundaries are desired. (Note: this argument is still in development, only Quebec provincial
#' boundaries are available at the moment.)
#' @examples
#' election_2015 <- federal_election_results[federal_election_results$election_year == 2015, ]
#'
#' riding_binplot(riding_data = election_2015, riding code = riding_code, value_col = party, continuous = TRUE, arrange = TRUE)
#'
#' @export
riding_binplot <- function(riding_data, riding_col = riding_code, value_col, continuous = TRUE,
          arrange = FALSE, palette = "Greens", riding_border_col = "white",
          year = 2015, riding_border_size = 1, provincial = FALSE,
          shape = "square", province)
{
  riding.col <- deparse(substitute(riding_col))
  value.col <- deparse(substitute(value_col))
  riding.df <- riding_data
  riding.df$riding_code <- riding_data[, riding.col]
  riding.df$value.col <- riding_data[, value.col]
  riding.df <- riding.df[, c("riding_code", "value.col")]
  if (shape == "square") {
    if (provincial == FALSE) {
      if (year == 2015) {
        riding_coords <- mapcan::federal_riding_bins[mapcan::federal_riding_bins$representation_order ==
                                                       2013, ]
      }
      else if (year %in% c(2004, 2006, 2008, 2011)) {
        riding_coords <- mapcan::federal_riding_bins[mapcan::federal_riding_bins$representation_order ==
                                                       2003, ]
      }
      else if (year %in% c(1997, 2000)) {
        riding_coords <- mapcan::federal_riding_bins[mapcan::federal_riding_bins$representation_order ==
                                                       1996, ]
      }
      else {
        stop("Not a valid election year.")
      }
    }
    if (provincial == TRUE) {
      province_char <- deparse(substitute(province))
      if (province_char == "QC") {
        riding_coords <- quebec_riding_bins
      }
      else {
        stop("Province (2-letter code) not valid, or provincial election boundaries for this province not supported yet.")
      }
    }
    riding.merged.dat <- base::merge(riding_coords, riding.df,
                                     by = "riding_code", all.y = TRUE, sort = TRUE)
    riding.merged.dat$riding_code <- as.numeric(riding.merged.dat$riding_code)
    if (arrange == TRUE) {
      riding.merged.dat.arranged_a <- riding.merged.dat %>%
        dplyr::arrange(pr_alpha, value.col) %>% dplyr::select(value.col)
      riding.merged.dat.arranged_b <- dplyr::select(riding.merged.dat,
                                                    -value.col) %>% dplyr::arrange(pr_alpha, riding_code)
      riding.merged.dat <- cbind(riding.merged.dat.arranged_a,
                                 riding.merged.dat.arranged_b)
    }
    gg <- ggplot2::ggplot()
    gg <- gg + scale_y_reverse()
    gg <- gg + ggplot2::geom_tile(data = riding.merged.dat,
                                  aes_string(x = "y", y = "x", fill = "value.col"),
                                  color = riding_border_col, size = riding_border_size)
    if (continuous == T) {
      gg <- gg + ggplot2::scale_fill_viridis_c(riding.col)
    }
    else if (continuous == F) {
      gg <- gg + ggplot2::scale_fill_viridis_d(riding.col)
    }
    gg <- gg + ggplot2::coord_equal()
    gg <- gg + ggplot2::labs(x = NULL, y = NULL)
  }
  if (shape == "hexagon") {
    if (provincial == FALSE) {
      if (year == 2015) {
        riding_coords <- mapcan::federal_riding_hexagons[mapcan::federal_riding_hexagons$representation_order ==
                                                           2013, ]
      }
      else if (year %in% c(2004, 2006, 2008, 2011)) {
        riding_coords <- mapcan::federal_riding_hexagons[mapcan::federal_riding_hexagons$representation_order ==
                                                           2003, ]
      }
      else if (year %in% c(1997, 2000)) {
        riding_coords <- mapcan::federal_riding_hexagons[mapcan::federal_riding_hexagons$representation_order ==
                                                           1996, ]
      }
      else {
        stop("Not a valid election year.")
      }
    }
    if (provincial == TRUE) {
      province_char <- deparse(substitute(province))
      if (province_char == "QC") {
        riding_coords <- quebec_riding_hexagons
      }
      else {
        stop("Province (2-letter code) not valid, or provincial election boundaries for this province not supported yet.")
      }
    }
    riding.df$riding_code <- as.numeric(riding.df$riding_code)
    riding_coords$riding_code <- as.numeric(riding_coords$riding_code)
    riding.merged.dat <- inner_join(riding_coords, riding.df)
    riding.merged.dat$riding_code <- as.numeric(riding.merged.dat$riding_code)
    if (arrange == TRUE) {
      riding.merged.dat.arranged_a <- riding.merged.dat %>%
        dplyr::arrange(pr_alpha, value.col) %>% dplyr::select(value.col)
      riding.merged.dat.arranged_b <- dplyr::select(riding.merged.dat,
                                                    -value.col) %>% dplyr::arrange(pr_alpha, riding_code)
      riding.merged.dat <- cbind(riding.merged.dat.arranged_a,
                                 riding.merged.dat.arranged_b)
    }
    gg <- ggplot2::ggplot()
    gg <- gg + ggplot2::scale_y_reverse()
    gg <- gg + ggplot2::geom_polygon(data = riding.merged.dat,
                                     aes_string(x = "long", y = "lat", group = "group",
                                                fill = "value.col"))
    if (continuous == T) {
      gg <- gg + ggplot2::scale_fill_viridis_c(riding.col)
    }
    else if (continuous == F) {
      gg <- gg + ggplot2::scale_fill_viridis_d(riding.col)
    }
    gg <- gg + ggplot2::coord_equal()
    gg <- gg + ggplot2::labs(x = NULL, y = NULL)
  }
  return(gg)
}

