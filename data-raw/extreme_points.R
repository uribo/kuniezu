# https://www.gsi.go.jp/KOKUJYOHO/center.htm
pkgload::load_all()
library(sf)
extreme_points <-
  list(north = st_point(c(parse_lon_dohunbyo("148\u5ea645\u520608\u79d2"),
                          parse_lat_dohunbyo("45\u5ea633\u520626\u79d2"))),
       east = st_point(c(parse_lon_dohunbyo("153\u5ea659\u520612\u79d2"),
                         parse_lat_dohunbyo("24\u5ea616\u520659\u79d2"))),
       west = st_point(c(parse_lon_dohunbyo("122\u5ea655\u520657\u79d2"),
                         parse_lat_dohunbyo("24\u5ea627\u520605\u79d2"))),
       south = st_point(c(parse_lon_dohunbyo("136\u5ea604\u520611\u79d2"),
                          parse_lat_dohunbyo("20\u5ea625\u520631\u79d2"))))

usethis::use_data(extreme_points, overwrite = TRUE)
