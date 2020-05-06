#' Clip and move some geometries for mapping
#' @description Move geometry differently from the real-life arrangement for mapping.
#' When displaying a map showing Japan, the southern islands are sometimes moved.
#' To achieve this, we need to perform false operations on the geometry.
#' @param data [sf][sf::st_sf] that records the prefecture or municipality of Japan
#' @param clip An option to hide isolated island that are separated from other geometry and have a small area.
#' @examples
#' require("sf")
#' move_jpn_rs(jgd2011_bbox)
#' @return [sf][sf::st_sf]. Geometry in Tokyo may have rows duplicated in Honshu and islands.
#' @export
move_jpn_rs <- function(data, clip = TRUE) {
  .row_num <- geometry <- NULL
  data <-
    data %>%
    dplyr::mutate(.row_num = dplyr::row_number())
  x_nansei <-
    suppressWarnings(
      suppressMessages(data %>%
                         sf::st_crop(bb_nansei)) %>%
        dplyr::mutate(geometry = magrittr::add(geometry, c(5.2, 15.0))))
  if (isTRUE(clip)) {
    x_ogswr <-
      suppressWarnings(
        suppressMessages(
          data %>%
            sf::st_crop(jgd2011_bbox %>%
                          dplyr::filter(system %in% as.character(utils::as.roman(c(14))))) %>%
            dplyr::mutate(geometry = magrittr::add(geometry, c(1.5, 6.0)))))
    if (nrow(data) == 47L) {
      x_main <-
        data %>%
        sf::st_difference(bb_nansei) %>%
        sf::st_difference(bb_ogswr)
    } else {
      x_main <-
        suppressMessages(
          data %>%
            st_disjoin_lf(bb_nansei) %>%
            st_disjoin_lf(jgd2011_bbox[14, "geometry"]) %>%
            st_disjoin_lf(jgd2011_bbox[18, "geometry"]) %>%
            st_disjoin_lf(jgd2011_bbox[19, "geometry"]))
    }
    res <-
      list(
        x_main,
        x_ogswr,
        x_nansei)
  } else {
    x_main <-
      suppressWarnings(
        suppressMessages(
          data %>%
            st_disjoin_lf(bb_nansei)))
    res <-
      list(
        x_main,
        x_nansei)
  }
  res %>%
    purrr::map(
      ~ sf::st_set_crs(.x, value = 6668)) %>%
    purrr::reduce(rbind) %>%
    dplyr::arrange(`.row_num`) %>%
    dplyr::select(-`.row_num`)
}

bb_nansei <-
  sf::st_bbox(c(xmin = 122.93, ymin = 24.04,
            xmax = 131.34, ymax = 28.53)) %>%
  sf::st_as_sfc() %>%
  sf::st_sf(crs = 4326) %>%
  sf::st_transform(crs = 6668)

bb_ogswr <-
  sf::st_bbox(c(xmin = 136.06, ymin = 20.42,
            xmax = 153.99, ymax = 27.75)) %>%
  sf::st_as_sfc() %>%
  sf::st_sf(crs = 4326) %>%
  sf::st_transform(crs= 6668)

st_disjoin_lf <-
  purrr::partial(sf::st_join,
                 join = sf::st_disjoint,
                 left = FALSE)
