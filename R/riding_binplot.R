#' Canadian federal ridings tile plot function
#'
#' A function that returns a data frame with map data, for use in ggplot.
#'
#' @param riding_data A dataframe with a continuous or categorical riding-level characteristic and a riding code variable.
#' @param riding_col An unquoted character expression specifying the riding code variable from the dataframe
#' provided in \code{riding_data}.
#' @param value_col An unquoted character expression specifying the column or categorical riding level characteristic
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
#' @param shape Unquoted character expression specifying shape of tiles. Options are square and hexagon, default is square.
#' @param legend_name Quoted chacter expression specifying the title of the legend. The variable name will be used as a default
#' if no value is supplied.
#' @examples
#' election_2015 <- federal_election_results[federal_election_results$election_year == 2015, ]
#'
#' riding_binplot(riding_data = election_2015, riding_col = riding_code,
#' value_col = party, continuous = FALSE, arrange = TRUE)
#'
#' @export
riding_binplot <- function(riding_data, riding_col = riding_code, value_col, continuous = TRUE,
          arrange = FALSE, riding_border_col = "white",
          year = 2015, riding_border_size = 1, provincial = FALSE,
          shape = "square", province, legend_name = "default")
{


  if (is.symbol(substitute(riding_col))) {
    riding.col <- deparse(substitute(riding_col))
  } else {
    riding.col <- riding_col
  }

  if (legend_name == "default") {
    legend.name <- deparse(substitute(value_col))
  } else {
    legend.name <- legend_name
  }

  if (is.symbol(substitute(value_col))) {
    value.col <- deparse(substitute(value_col))
  } else {
    value.col <- value_col
  }

  if (is.symbol(substitute(province))) {
    province_chr <- deparse(substitute(province))
  } else {
    province_chr <- province
  }

  if (is.symbol(substitute(shape))) {
    shape_chr <- deparse(substitute(shape))
  } else {
    shape_chr <- shape
  }

  riding.df <- riding_data
  riding.df$riding_code <- riding_data[, riding.col]
  riding.df$value.col <- riding_data[, value.col]
  riding.df <- riding.df[, c("riding_code", "value.col")]


  # SQUARE TILE PLOTS
  if (shape_chr == "square") {
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
      if (province_chr == "QC") {
        riding_coords <- mapcan::quebec_riding_bins
      }
      else {
        stop("Province (2-letter code) not valid, or provincial election boundaries for this province not supported yet.")
      }
    }

    # MERGE RIDING DATA WITH RIDING COORDINATES ON riding_code
    riding.merged.dat <- base::merge(riding_coords, riding.df,
                                     by = "riding_code", all.y = TRUE, sort = TRUE)
    riding.merged.dat$riding_code <- as.numeric(riding.merged.dat$riding_code)

    # ARRANGE
    if (arrange == TRUE) {
      ## ARRANGE BY PROVINCE, THEN BY VALUES (SO ARRANGE VALUES WITHIN PROVINCES)
      riding.merged.dat.arranged_a <- riding.merged.dat[order(riding.merged.dat$pr_alpha, riding.merged.dat$value.col), ]
      ## SELECT JUST THE VALUE COL
      riding.merged.dat.arranged_a <- riding.merged.dat.arranged_a[ , "value.col"]

      riding.merged.dat.arranged_a <- data.frame(riding.merged.dat.arranged_a)
      names(riding.merged.dat.arranged_a) <- "value.col"

      ## SELECT EVERYTHING BUT THE VALUE COL
      riding.merged.dat.arranged_b <- riding.merged.dat[ , !(colnames(riding.merged.dat) == "value.col")]
      ## ARRANGE BY PROVINCE AND RIDING CODE
      riding.merged.dat.arranged_b <- riding.merged.dat.arranged_b[order(riding.merged.dat.arranged_b$pr_alpha,
                                                                         riding.merged.dat.arranged_b$riding_code), ]
      # BIND VALUES TOGETHER
      riding.merged.dat <- cbind(riding.merged.dat.arranged_a, riding.merged.dat.arranged_b)
    }

    gg <- ggplot2::ggplot()
    gg <- gg + ggplot2::scale_y_reverse()
    gg <- gg + ggplot2::geom_tile(data = riding.merged.dat,
                                  ggplot2::aes_string(x = "y", y = "x", fill = "value.col"),
                                  color = riding_border_col, size = riding_border_size)
    if (continuous == T) {
      gg <- gg + ggplot2::scale_fill_viridis_c(name = legend.name)
    }
    else if (continuous == F) {
      gg <- gg + ggplot2::scale_fill_viridis_d(name = legend.name)
    }
    gg <- gg + ggplot2::coord_equal()
    gg <- gg + ggplot2::labs(x = NULL, y = NULL)
  }

  # HEXAGONAL TILE PLOTS
  if (shape_chr == "hexagon") {
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
      if (province_chr == "QC") {
        riding_coords <- mapcan::quebec_riding_hexagons
      }
      else {
        stop("Province (2-letter code) not valid, or provincial election boundaries for this province not supported yet.")
      }
    }
    riding.df$riding_code <- as.numeric(riding.df$riding_code)
    riding_coords$riding_code <- as.numeric(riding_coords$riding_code)
    riding.merged.dat <- base::merge(riding_coords, riding.df,
                                     by = "riding_code", all.y = TRUE, sort = TRUE)
    riding.merged.dat$riding_code <- as.numeric(riding.merged.dat$riding_code)

    # ARRANGE
    if (arrange == TRUE) {
      ## ARRANGE BY PROVINCE, THEN BY VALUES (SO ARRANGE VALUES WITHIN PROVINCES)
      riding.merged.dat.arranged_a <- riding.merged.dat[order(riding.merged.dat$pr_alpha, riding.merged.dat$value.col), ]
      ## SELECT JUST THE VALUE COL
      riding.merged.dat.arranged_a <- riding.merged.dat.arranged_a[ , "value.col"]

      riding.merged.dat.arranged_a <- data.frame(riding.merged.dat.arranged_a)
      names(riding.merged.dat.arranged_a) <- "value.col"

      ## SELECT EVERYTHING BUT THE VALUE COL
      riding.merged.dat.arranged_b <- riding.merged.dat[ , !(colnames(riding.merged.dat) == "value.col")]
      ## ARRANGE BY PROVINCE AND RIDING CODE
      riding.merged.dat.arranged_b <- riding.merged.dat.arranged_b[order(riding.merged.dat.arranged_b$pr_alpha,
                                                                         riding.merged.dat.arranged_b$riding_code), ]
      # BIND VALUES TOGETHER
      riding.merged.dat <- cbind(riding.merged.dat.arranged_a, riding.merged.dat.arranged_b)

    }
    gg <- ggplot2::ggplot()
    gg <- gg + ggplot2::scale_y_reverse()
    gg <- gg + ggplot2::geom_polygon(data = riding.merged.dat,
                                     ggplot2::aes_string(x = "long", y = "lat", group = "group",
                                                fill = "value.col"))
    if (continuous == T) {
      gg <- gg + ggplot2::scale_fill_viridis_c(name = legend.name)
    }
    else if (continuous == F) {
      gg <- gg + ggplot2::scale_fill_viridis_d(name = legend.name)
    }
    gg <- gg + ggplot2::coord_equal()
    gg <- gg + ggplot2::labs(x = NULL, y = NULL)
  }
  return(gg)
}

