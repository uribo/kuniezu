library(dplyr)
library(sf)
if (!dir.exists("data-raw/offices"))
  dir.create("data-raw/offices")
fix_coord_symbol <- function(x) {
  chartr(old = "\u00b0\u2032\u2033",
         new = "\u00b0\u2019.",
         x = stringr::str_replace(x, "′′", "″"))
}
gsi_office_extract_page <- function(data) {
  d3 <-
    data %>%
    stringr::str_remove(".+世界測地系") %>%
    stringr::str_split("\n", simplify = TRUE) %>%
    stringr::str_subset("北端|経度|緯度") %>%
    purrr::discard(~ nchar(.x) == 0L) %>%
    stringr::str_squish() %>%
    stringr::str_split("[[:space:]]", simplify = TRUE) %>%
    as.data.frame(stringsAsFactors = FALSE) %>%
    mutate(id = dplyr::row_number()) %>%
    select(id, everything())
  d4 <-
    seq.int(1, nrow(d3), by = 3) %>%
    purrr::map_dfr(
      ~ tibble::add_column(d3[.x, ], aa = NA_character_, .after = 2) %>%
        select(-V6)) %>%
    purrr::set_names(c("id",
                       paste0("V", seq_len(6))))

  d3 %>%
    filter(!id %in% d4$id) %>%
    mutate(V1 = NA_character_) %>%
    bind_rows(d4) %>%
    arrange(id) %>%
    tidyr::fill(V1, .direction = "down") %>%
    filter(!is.na(V2)) %>%
    select(-1) %>%
    purrr::set_names(c("office", "coords", "e", "w", "n", "s")) %>%
    mutate(type = rep(c("longitude", "latitude"), nrow(.)/2)) %>%
    tidyr::pivot_longer(cols = 2:6,
                        names_to = "var",
                        values_to = "value") %>%
    tidyr::pivot_wider(names_from = type,
                       values_from = value) %>%
    mutate_at(vars(longitude, latitude),
              fix_coord_symbol) %>%
    mutate(longitude = parzer::parse_lon(longitude),
           latitude = parzer::parse_lat(latitude)) %>%
    st_as_sf(coords = c("longitude", "latitude"), crs = 4326) %>%
    filter(var == "coords") %>%
    select(-var)
}
gsi_office_extract <- function(file) {
  pdftools::pdf_text(file) %>%
    purrr::map(
      gsi_office_extract_page
    ) %>%
    purrr::reduce(rbind)
}
# Prefectural Office ------------------------------------------------------
if (!file.exists("data-raw/offices/zenken.pdf")) {
  target_file <- "https://www.gsi.go.jp/KOKUJYOHO/CENTER/kendata/zenken.pdf"
  download.file(target_file,
                paste0("data-raw/offices/", basename(target_file)))
}
jp47prefectural_offices <-
  gsi_office_extract("data-raw/offices/zenken.pdf")

# jp47prefectural_offices$office %>%
#   stringi::stri_escape_unicode() %>%
#   dput()

jp47prefectural_offices$office <-
  c("\u5317\u6d77\u9053\u5e81", "\u9752\u68ee\u770c\u5e81",
    "\u5ca9\u624b\u770c\u5e81", "\u5bae\u57ce\u770c\u5e81",
    "\u79cb\u7530\u770c\u5e81", "\u5c71\u5f62\u770c\u5e81",
    "\u798f\u5cf6\u770c\u5e81", "\u8328\u57ce\u770c\u5e81",
    "\u6803\u6728\u770c\u5e81", "\u7fa4\u99ac\u770c\u5e81",
    "\u57fc\u7389\u770c\u5e81", "\u5343\u8449\u770c\u5e81",
    "\u6771\u4eac\u90fd\u5e81", "\u795e\u5948\u5ddd\u770c\u5e81",
    "\u5c71\u68a8\u770c\u5e81", "\u9577\u91ce\u770c\u5e81",
    "\u65b0\u6f5f\u770c\u5e81", "\u5bcc\u5c71\u770c\u5e81",
    "\u77f3\u5ddd\u770c\u5e81", "\u798f\u4e95\u770c\u5e81",
    "\u5c90\u961c\u770c\u5e81", "\u9759\u5ca1\u770c\u5e81",
    "\u611b\u77e5\u770c\u5e81", "\u4e09\u91cd\u770c\u5e81",
    "\u6ecb\u8cc0\u770c\u5e81", "\u4eac\u90fd\u5e9c\u5e81",
    "\u5927\u962a\u5e9c\u5e81", "\u5175\u5eab\u770c\u5e81",
    "\u5948\u826f\u770c\u5e81", "\u548c\u6b4c\u5c71\u770c\u5e81",
    "\u9ce5\u53d6\u770c\u5e81", "\u5cf6\u6839\u770c\u5e81",
    "\u5ca1\u5c71\u770c\u5e81", "\u5e83\u5cf6\u770c\u5e81",
    "\u5c71\u53e3\u770c\u5e81", "\u5fb3\u5cf6\u770c\u5e81",
    "\u9999\u5ddd\u770c\u5e81", "\u611b\u5a9b\u770c\u5e81",
    "\u9ad8\u77e5\u770c\u5e81", "\u798f\u5ca1\u770c\u5e81",
    "\u4f50\u8cc0\u770c\u5e81", "\u9577\u5d0e\u770c\u5e81",
    "\u718a\u672c\u770c\u5e81", "\u5927\u5206\u770c\u5e81",
    "\u5bae\u5d0e\u770c\u5e81", "\u9e7f\u5150\u5cf6\u770c\u5e81",
    "\u6c96\u7e04\u770c\u5e81")

usethis::use_data(jp47prefectural_offices, overwrite = TRUE)
