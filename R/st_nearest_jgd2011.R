#' Identify the Japan plane rectangular CS
#'
#' @description Returns the value when the coordinates of ESPG:4326 given to the input
#' are replaced with those of the Japan Plane Rectangular CS.
#' @details
#'
#' * `st_nearest_jgd2011()`: It returns the coordinate system closest to
#' the given ground object. This is valid even when the coordinates are at sea.
#' * `st_detect_jgd2011()`: Identify the coordinate system in which
#' the given object is located.
#' @param geometry geometry (POINT, EPSG:4326)
#' @examples
#' require("sf")
#' p <-
#'   st_sfc(sf::st_point(c(140.77, 36.8)), crs = 4326)
#' st_nearest_jgd2011(p)
#'
#' st_detect_jgd2011(p)
#' st_detect_jgd2011(st_sfc(sf::st_point(c(140.73, 36.8)), crs = 4326))
#' @return *numeric* vector
#' @seealso [https://www.gsi.go.jp/LAW/heimencho.html](https://www.gsi.go.jp/LAW/heimencho.html)
#' @export
st_nearest_jgd2011 <- function(geometry) {
  purrr::map_dbl(
    sf::st_nearest_feature(geometry,
                           jgd2011_bbox4326),
    ~ as.numeric(as.character(jgd2011_bbox4326[[.x,
                                            "epsg"]])))
}

#' @rdname st_nearest_jgd2011
#' @export
st_detect_jgd2011 <- function(geometry) {
  check <-
    as.numeric(sf::st_within(geometry,
                         jgd2011_bbox4326,
                         sparse = TRUE))
  purrr::map_dbl(check,
                 function(.x) {
                   if (is.na(.x)) {
                     NA_real_
                   } else {
                     as.numeric(as.character(jgd2011_bbox4326[[.x, "epsg"]]))
                   }
                 })
}
