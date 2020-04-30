globalVariables("extreme_points")

#' The extreme points of Japan
#'
#' @description A list of the east, west, south and north ends of
#' Japan's territory (including remote islands).
#' The northernmost position is what the government claims.
#' @format A four length list consisting of [st_point][sf::st_point]
#' @seealso [https://www.gsi.go.jp/KOKUJYOHO/center.htm](https://www.gsi.go.jp/KOKUJYOHO/center.htm)
#' @examples
#' extreme_points
#'
#' require("purrr")
#' extreme_points %>%
#' map(
#'   ~ sf::st_sfc(.x, crs = 4326)) %>%
#' reduce(c)
"extreme_points"
