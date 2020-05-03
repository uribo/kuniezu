globalVariables("extreme_points")
globalVariables("jp47prefectural_offices")

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
#'   reduce(c)
"extreme_points"

#' Japan Prefectural Goverment Offices
#'
#' @description Locations of 47 government offices in Japan's prefectures.
#' @details The original file was downloaded from
#' [https://www.gsi.go.jp/KOKUJYOHO/center.htm](https://www.gsi.go.jp/KOKUJYOHO/center.htm),
#' which parses the PDF data and organizes the coordinates of the prefectural hall.
#' @format A [sf][sf::st_sf] contains 2 column and 47 rows.
#' @examples
#' require("sf")
#' jp47prefectural_offices
"jp47prefectural_offices"
