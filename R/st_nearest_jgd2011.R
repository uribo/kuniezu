#' Identify the coordinate system of the coordinates
#' 
#' @description Returns the value when the coordinates of ESPG:4326 given to the input 
#' are replaced with those of the Japan Plane Rectangular CS.
#' @param geometry geometry (POINT)
#' @examples
#' library(sf)
#' st_nearest_jgd2011(st_sfc(sf::st_point(c(140.778, 36.8)), crs = 4326))
#' @export
st_nearest_jgd2011 <- function(geometry) {
  purrr::map_dbl(
    sf::st_nearest_feature(geometry, 
                           jgd2011_bbox),
    ~ as.numeric(as.character(jgd2011_bbox[[.x,
                                            "epsg"]])))
}