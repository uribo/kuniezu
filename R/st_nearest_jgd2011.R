#' Identify the Japan plane rectangular CS
#'
#' @description Returns the value when the coordinates of ESPG:4326 given to the input
#' are replaced with those of the Japan Plane Rectangular CS.
#' @param geometry geometry (POINT)
#' @examples
#' require("sf")
#' st_nearest_jgd2011(st_sfc(sf::st_point(c(140.778, 36.8)), crs = 4326))
#' @seealso [https://www.gsi.go.jp/LAW/heimencho.html](https://www.gsi.go.jp/LAW/heimencho.html)
#' @export
st_nearest_jgd2011 <- function(geometry) {
  purrr::map_dbl(
    sf::st_nearest_feature(geometry,
                           jgd2011_bbox4326),
    ~ as.numeric(as.character(jgd2011_bbox4326[[.x,
                                            "epsg"]])))
}
