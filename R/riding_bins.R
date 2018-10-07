riding_binplot <- function (riding_data,
                         riding_col = "riding_code",
                         value_col,
                         continuous = TRUE,
                         arrange = FALSE,
                         palette = "Greens",
                         riding_border_col = "white",
                         year = 2015,
                         riding_border_size = 1)
  {

  riding.df <- riding_data
  riding.df$riding_code <- riding_data[ , riding_col]
  riding.df$value_col <- riding_data[ , value_col]
  riding.df <- riding.df[ , c("riding_code", "value_col")]

  if(year == 2015) {
      riding_coords <- federal_riding_bins[federal_riding_bins$representation_order == 2013, ]
  } else if (year %in% c(2004, 2006, 2008, 2011)) {
    riding_coords <- federal_riding_bins[federal_riding_bins$representation_order == 2003, ]
  } else if (year %in% c(1997, 2000)) {
    riding_coords <- federal_riding_bins[federal_riding_bins$representation_order == 1996, ]
  } else {
    stop("Not a valid election year.")
  }

  # Merge riding coordinates and riding data together
  riding.merged.dat <- merge(riding_coords,
                      riding.df,
                      by.x = "riding_code",
                      by.y = riding_col,
                      all.y = TRUE,
                      sort = TRUE)


  if(arrange == TRUE) {
    riding.merged.dat.arranged_a <- riding.merged.dat %>%
      arrange(pr_alpha, value_col) %>%
      dplyr::select(value_col)
    riding.merged.dat.arranged_b <- dplyr::select(riding.merged.dat, -value_col) %>%
        arrange(pr_alpha, riding_code)
    riding.merged.dat <- cbind(riding.merged.dat.arranged_a, riding.merged.dat.arranged_b)
  }

  gg <- ggplot()
  gg <- gg + scale_y_reverse()
  gg <- gg + geom_tile(data = riding.merged.dat,
                       aes_string(x = "y",
                                  y = "x",
                                  fill = "value_col"),
                      color = riding_border_col,
                      size = riding_border_size)

  if(continuous == T) {
    gg <- gg + scale_fill_distiller(palette = palette)
  } else if (continuous == F) {
    gg <- gg + scale_fill_brewer(palette = palette)
    }
  gg <- gg + coord_equal()
  gg <- gg + labs(x = NULL, y = NULL)
  gg
}
