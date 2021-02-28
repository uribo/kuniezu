#####################################
# 日本の東西南北端点の経度緯度
# https://www.gsi.go.jp/KOKUJYOHO/center.htm
# Last Update: 2021-02-28 (元データは令和元年6月1日更新)
#####################################
pkgload::load_all()
library(sf)
extreme_points <-
  list(north = st_point(c(parse_lon_dohunbyo("\u6771\u7d4c148\u5ea645\u520608\u79d2"),
                          parse_lat_dohunbyo("\u5317\u7def45\u5ea633\u520626\u79d2"))),
       east = st_point(c(parse_lon_dohunbyo("\u6771\u7d4c153\u5ea659\u520612\u79d2"),
                         parse_lat_dohunbyo("\u5317\u7def24\u5ea616\u520659\u79d2"))),
       west = st_point(c(parse_lon_dohunbyo("\u6771\u7d4c122\u5ea655\u520657\u79d2"),
                         parse_lat_dohunbyo("\u5317\u7def24\u5ea627\u520605\u79d2"))),
       south = st_point(c(parse_lon_dohunbyo("\u6771\u7d4c136\u5ea604\u520611\u79d2"),
                          parse_lat_dohunbyo("\u5317\u7def20\u5ea625\u520631\u79d2")))) %>%
  purrr::map(
    ~ st_sfc(.x, crs = 4326) %>%
      st_transform(crs = 6668))

usethis::use_data(extreme_points, overwrite = TRUE)
