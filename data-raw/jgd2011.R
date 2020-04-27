####################################
# 日本測地系2011
# 平面直角座標系（平成十四年国土交通省告示第九号）
# ref) https://www.gsi.go.jp/LAW/heimencho.html
# EPSGコード
# 緯度経度: 6668
# 平面直角座標系: 6669~6687
# [todo] 市区町村での厳密な境界に対応
####################################
library(sf)
epsg_codes <-
  seq.int(6669, 6687)

jgd2011_bbox_coords <- function(srid) {
  if (srid %in% c(seq.int(6669L, 6687L)) == TRUE) {
    glue::glue("https://epsg.io/{srid}") %>%
      xml2::read_html() %>%
      rvest::html_nodes(css = '#detailpage > div:nth-child(4) > div > div.col3.minimap-pad > p') %>%
      rvest::html_text(trim = TRUE) %>%
      purrr::pluck(3) %>%
      stringr::str_remove(".+\n") %>%
      stringr::str_split("\n") %>%
      purrr::map_dfc(stringr::str_trim) %>%
      tidyr::separate(V1,
                      into = c("longitude", "latitude"),
                      sep = "[:space:]") %>%
      tidyr::expand(longitude, latitude) %>%
      purrr::modify_at(c(1, 2),
                       as.numeric) %>%
      dplyr::slice(c(1, 3, 4, 2, 1)) %>%
      as.matrix(ncol = 2) %>%
      unname()
  } else {
    rlang::abort("6669 to 6687")
  }
}

epsg_codes %>%
  purrr::map(
    jgd2011_bbox_coords
  ) %>%
  purrr::set_names(c(paste0("epsg_", epsg_codes))) %>% dput()

jgd2011_bbox <-
  list(
    epsg_6669 = structure(
      c(
        128.17,
        130.46,
        130.46,
        128.17,
        128.17,
        26.96,
        26.96,
        34.74,
        34.74,
        26.96
      ),
      .Dim = c(5L, 2L)
    ),
    epsg_6670 = structure(
      c(
        129.76,
        132.05,
        132.05,
        129.76,
        129.76,
        30.18,
        30.18,
        33.99,
        33.99,
        30.18
      ),
      .Dim = c(5L, 2L)
    ),
    epsg_6671 = structure(
      c(
        130.81,
        133.49,
        133.49,
        130.81,
        130.81,
        33.72,
        33.72,
        36.38,
        36.38,
        33.72
      ),
      .Dim = c(5L, 2L)
    ),
    epsg_6672 = structure(
      c(
        131.95,
        134.81,
        134.81,
        131.95,
        131.95,
        32.69,
        32.69,
        34.45,
        34.45,
        32.69
      ),
      .Dim = c(5L, 2L)
    ),
    epsg_6673 = structure(
      c(
        133.13,
        135.47,
        135.47,
        133.13,
        133.13,
        34.13,
        34.13,
        35.71,
        35.71,
        34.13
      ),
      .Dim = c(5L, 2L)
    ),
    epsg_6674 = structure(
      c(
        134.86,
        136.99,
        136.99,
        134.86,
        134.86,
        33.4,
        33.4,
        36.33,
        36.33,
        33.4
      ),
      .Dim = c(5L, 2L)
    ),
    epsg_6675 = structure(
      c(
        136.22,
        137.84,
        137.84,
        136.22,
        136.22,
        34.51,
        34.51,
        37.58,
        37.58,
        34.51
      ),
      .Dim = c(5L, 2L)
    ),
    epsg_6676 = structure(
      c(
        137.32,
        139.91,
        139.91,
        137.32,
        137.32,
        34.54,
        34.54,
        38.58,
        38.58,
        34.54
      ),
      .Dim = c(5L, 2L)
    ),
    epsg_6677 = structure(
      c(
        138.4,
        141.11,
        141.11,
        138.4,
        138.4,
        29.31,
        29.31,
        37.98,
        37.98,
        29.31
      ),
      .Dim = c(5L, 2L)
    ),
    epsg_6678 = structure(
      c(
        139.49,
        142.14,
        142.14,
        139.49,
        139.49,
        37.73,
        37.73,
        41.58,
        41.58,
        37.73
      ),
      .Dim = c(5L, 2L)
    ),
    epsg_6679 = structure(
      c(
        139.34,
        141.46,
        141.46,
        139.34,
        139.34,
        41.34,
        41.34,
        43.42,
        43.42,
        41.34
      ),
      .Dim = c(5L, 2L)
    ),
    epsg_6680 = structure(
      c(
        140.89,
        143.61,
        143.61,
        140.89,
        140.89,
        42.15,
        42.15,
        45.54,
        45.54,
        42.15
      ),
      .Dim = c(5L, 2L)
    ),
    epsg_6681 = structure(
      c(
        142.61,
        145.87,
        145.87,
        142.61,
        142.61,
        41.87,
        41.87,
        44.4,
        44.4,
        41.87
      ),
      .Dim = c(5L, 2L)
    ),
    epsg_6682 = structure(
      c(
        141.2,
        142.33,
        142.33,
        141.2,
        141.2,
        24.67,
        24.67,
        27.8,
        27.8,
        24.67
      ),
      .Dim = c(5L, 2L)
    ),
    epsg_6683 = structure(
      c(
        126.63,
        128.4,
        128.4,
        126.63,
        126.63,
        26.02,
        26.02,
        26.91,
        26.91,
        26.02
      ),
      .Dim = c(5L,
               2L)
    ),
    epsg_6684 = structure(
      c(
        122.83,
        125.51,
        125.51,
        122.83,
        122.83,
        23.98,
        23.98,
        24.94,
        24.94,
        23.98
      ),
      .Dim = c(5L,
               2L)
    ),
    epsg_6685 = structure(
      c(
        131.12,
        131.38,
        131.38,
        131.12,
        131.12,
        24.4,
        24.4,
        26.01,
        26.01,
        24.4
      ),
      .Dim = c(5L, 2L)
    ),
    epsg_6686 = structure(
      c(
        136.02,
        136.16,
        136.16,
        136.02,
        136.02,
        20.37,
        20.37,
        20.48,
        20.48,
        20.37
      ),
      .Dim = c(5L, 2L)
    ),
    epsg_6687 = structure(
      c(
        153.91,
        154.05,
        154.05,
        153.91,
        153.91,
        24.22,
        24.22,
        24.35,
        24.35,
        24.22
      ),
      .Dim = c(5L, 2L)
    )
  )

jgd2011_bbox <-
  jgd2011_bbox %>%
  purrr::map(~ list(.x) %>%
               sf::st_polygon() %>%
               sf::st_sfc(crs = 4326)) %>%
  purrr::reduce(c) %>%
  sf::st_sf() %>%
  tibble::new_tibble(nrow = nrow(.), class = "sf") %>%
  tibble::add_column(system = as.roman(seq_len(19)),
                     .before = "geometry") %>%
  tibble::add_column(epsg = epsg_codes,
                     .before = "geometry") %>%
  purrr::modify_at(c(1, 2),
                   ~ forcats::fct_inorder(as.character(.x)))

# mapview::mapview(jgd2011_bbox, zcol = "epsg")

usethis::use_data(jgd2011_bbox, overwrite = TRUE)
