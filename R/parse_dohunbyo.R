#' Parse longitude and latitude values in DMS
#'
#' @param longitude longitude values
#' @param latitude latitude values
#' @examples
#' x <- "\u6771\u7d4c139\u5ea644\u520628\u79d28869"
#' parse_lon_dohunbyo(x)
#' y <- "\u5317\u7def35\u5ea639\u520629\u79d21572"
#' parse_lat_dohunbyo(y)
#' @return *numeric* vector
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
#' @return *character* vector
#' @rdname replace_dohunbyo_kanji
#' @export
replace_dohunbyo_kanji <- function(x) {
  if (!is_dohunbyo_kanji(x))
    stop("The string given to x must be a kanji notation of longitude or latitude.")
  chartr(
    chartr(
      stringr::str_remove_all(
        chartr(x,
               old = intToUtf8(c(26481, 35199, 21335, 21271)),
               new = c("EWSN")),
        pattern = paste0(intToUtf8(c(32239, 32076), multiple = TRUE), collapse = "|")),
           old = intToUtf8(c(24230, 20998, 31186)),
           new = intToUtf8(c(176, 8217, 46))),
    old = intToUtf8(c(176, 8242, 8243)),
    new = intToUtf8(c(176, 8217, 46))
  )
}

news_kanji <-
  list(N = intToUtf8(c(21271, 32239)),
       E = intToUtf8(c(26481, 32076)),
       W = intToUtf8(c(35199, 32076)),
       S = intToUtf8(c(21335, 32239)))

is_dohunbyo_kanji <- function(x) {
  stringr::str_detect(x, paste0("^(",
                                paste0(news_kanji, collapse = "|"),
                                ")"))
}
