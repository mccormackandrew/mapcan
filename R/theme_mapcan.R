#' Mapcan theme
#'
#' A ggplot theme that removes unnecessary components of map plots. Builds on \code{theme_bw()}.
#'
#' @param legend_position Position of legend, default is "bottom"
#' @param base_size Base font size (default is 12)
#' @param base_family Base font family
#'
#' @export
theme_mapcan <- function(legend_position="bottom",
                            base_size = 12,
                            base_family = "") {

  gg <- ggplot2::theme_bw(base_size = base_size, base_family = base_family)
  gg <- gg + ggplot2::theme(
    axis.line = ggplot2::element_blank(),
    axis.text = ggplot2::element_blank(),
    axis.title.x = ggplot2::element_blank(),
    axis.title.y = ggplot2::element_blank(),
    axis.ticks = ggplot2::element_blank(),
    panel.background = ggplot2::element_blank(),
    panel.border = ggplot2::element_blank(),
    panel.grid = ggplot2::element_blank(),
    panel.spacing = ggplot2::unit(0, "lines"),
    plot.background = ggplot2::element_blank(),
    legend.justification = c(0, 0),
    legend.position = legend_position
  )
  gg <- gg + ggplot2::theme(strip.background = ggplot2::element_rect(color="#2b2b2b", fill="white"))
  gg <- gg + ggplot2::theme(plot.title = ggplot2::element_text(hjust=0.5, angle=0))
  #gg <- gg + theme(axis.title.x=element_text(hjust=0.5, angle=0))
  gg <- gg + ggplot2::theme(legend.position = legend_position)
  gg <- gg + ggplot2::theme(plot.title = ggplot2::element_text(size=15, hjust=0))
  gg <- gg + ggplot2::theme(plot.margin = ggplot2::margin(0.5,0.5,0.5,0.5, "cm"))
}
