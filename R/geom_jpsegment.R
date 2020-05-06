#' Drawing a segment line segment that shows the boundary
#'
#' @import ggplot2
#' @param ... other arguments passed on to [geom_segment][ggplot2::geom_segment].
#' @rdname geom_jpsegment
#' @format NULL
#' @usage NULL
GeomJpSegment <- ggplot2::ggproto("GeomJpSegment", ggplot2::Geom,
                           default_aes = ggplot2::aes(colour = "black", size = 0.5, linetype = 1,
                                             alpha = NA),
                           draw_group = function(data, panel_scales, coord) {
                             coords <- coord$transform(data, panel_scales)
                             grid::gList(
                               grid::segmentsGrob(x0 = c(0.040, 0.450, 0.64, 0.64),
                                                  x1 = c(0.450, 0.450, 0.75, 0.64),
                                                  y0 = c(0.56, 0.56, 0.34, 0.34),
                                                  y1 = c(0.56, 0.88, 0.34, 0.09),
                                                  default.units = "native",
                                                  gp = grid::gpar(lty = coords$linetype,
                                                                  fill = scales::alpha(coords$colour, coords$alpha),
                                                                  lwd = coords$size * .pt,
                                                                  col = coords$colour)))
                           }
)

#' @import ggplot2
#' @rdname geom_jpsegment
#' @examples
#' require("ggplot2")
#' require("sf")
#' move_jpn_rs(jgd2011_bbox) %>%
#'   ggplot() +
#'   geom_sf() +
#'   geom_jpsegment()
#' @seealso [move_jpn_rs][move_jpn_rs]
#' @return ggplot object and plot
#' @export
geom_jpsegment <- function(...) {
  layer(
    geom = GeomJpSegment, mapping = NULL, data = NULL, stat = "identity",
    position = "identity", show.legend = NA, inherit.aes = TRUE,
    params = list(na.rm = FALSE, ...)
  )
}
