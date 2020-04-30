globalVariables("extreme_points")

#' The extreme points of Japan
#'
#' @description A list of the east, west, south and north ends of
#' Japan's territory (including remote islands).
#' The northernmost position is what the government claims.
#' @format A four length list consisting of [sfc][sf::st_sfc]
#' @seealso [https://www.gsi.go.jp/KOKUJYOHO/center.htm](https://www.gsi.go.jp/KOKUJYOHO/center.htm)
#' @examples
#' extreme_points
#'
#' extreme_points$east
#'
#' require("purrr")
#' extreme_points %>%
#' reduce(c)
"extreme_points"
