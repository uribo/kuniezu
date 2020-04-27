#' Parse longitude and latitude values in DMS
#'
#' @param longitude longitude values
#' @param latitude latitude values
#' @examples
#' x <- "\u6771\u7d4c139\u5ea644\u520628\u79d28869"
#' parse_lon_dohunbyo(x)
#' y <- "\u5317\u7def35\u5ea639\u520629\u79d21572"
#' parse_lat_dohunbyo(y)
#' @rdname parse_dohunbyo
#' @export
parse_lon_dohunbyo <- function(longitude) {
  parzer::parse_lon(replace_dohunbyo_kanji(longitude))
}

#' @rdname parse_dohunbyo
#' @export
parse_lat_dohunbyo <- function(latitude) {
  parzer::parse_lat(replace_dohunbyo_kanji(latitude))
}

#' Replace Kanji in degrees, minutes, and seconds with symbols
#'
#' @param x character
#' @examples
#' x <- "\u6771\u7d4c139\u5ea644\u520628\u79d28869"
#' replace_dohunbyo_kanji(x)
#' y <- "\u5317\u7def35\u5ea639\u520629\u79d21572"
#' replace_dohunbyo_kanji(y)
#' @rdname replace_dohunbyo_kanji
#' @export
replace_dohunbyo_kanji <- function(x) {
  chartr(stringr::str_replace_all(x,
                                  c("\u6771\u7d4c" = "E",
                                    "\u897f\u7d4c"= "W",
                                    "\u5317\u7def" = "N",
                                    "\u5357\u7def" = "S")),
         old = "\u5ea6\u5206\u79d2",
         new = "\u00b0\u2019.")
}
