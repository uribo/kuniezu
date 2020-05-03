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

#' Add a tile layer from GSI
#'
#' @description Add a tile layer from Geospatial Information Authority of Japan (GSI).
#' @details Stores map tiles that can be used with leaflets.
#' Please follow the terms and conditions of use for the applicable tile at
#' [http://maps.gsi.go.jp/development/ichiran.html](http://maps.gsi.go.jp/development/ichiran.html)
#' when using it.
#' It contains tiles that can be used as base maps for interactive maps based on leaflet.
#' See example section its use in leaflet. To use a mapview,
#' a tile name is given to `mapview::mapview(map = )`.
#' @format A 48 length, [leaflet][leaflet::leaflet] objects.
#' @examples
#' names(gsi_tiles)
#' require("leaflet")
#' gsi_tiles[[1]]
#'
#' gsi_tiles[[1]] %>%
#'   addCircles(
#'     data = sf::st_transform(extreme_points %>%
#'       purrr::reduce(c),
#'       crs = 4326))
"gsi_tiles"

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
