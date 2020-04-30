####################################
# 日本測地系2011
# 平面直角座標系（平成十四年国土交通省告示第九号）
# ref) https://www.gsi.go.jp/LAW/heimencho.html, https://www.gsi.go.jp/sokuchikijun/jpc.html
# EPSGコード
# 緯度経度: 6668
# 平面直角座標系: 6669~6687
####################################
pkgload::load_all()
library(sf)
library(dplyr)
if (!dir.exists("data-raw/gm-jpn-all_u_2_2/")) {
  library(rvest)
  x <-
    read_html("https://www.gsi.go.jp/kankyochiri/gm_jpn.html")
  download_file <-
    x %>%
    html_nodes(css = "#layout > tr > td.w100p > div > div > div > div:nth-child(6) > div > table > tbody > tr:nth-child(3) > td:nth-child(2) > a") %>%
    html_attr("href")
  download.file(
    download_file,
    paste0("data-raw/", basename(download_file))
  )
  unzip(paste0("data-raw/", basename(download_file)),
        exdir = "data-raw")
}

jdg2011_union <- function(data, system) {
  s_code <-
    as.character(as.roman(system))
  s_code <-
    rlang::arg_match(s_code,
                     as.character(as.roman(seq_len(19))))
  d <-
    data %>%
    sf::st_union(by_feature = FALSE) %>%
    sf::st_sf() %>%
    purrr::update_list(system = s_code)
  d[, c("system", "geometry")]
}

x <-
  st_read("data-raw/gm-jpn-all_u_2_2/polbnda_jpn.shp",
          stringsAsFactors = FALSE,
          as_tibble = TRUE) %>%
  st_transform(crs = 4326) %>%
  mutate(nam = forcats::fct_inorder(nam)) %>%
  filter(adm_code != "UNK")

# 北方北緯32度
# 南方北緯27度
# 西方東経128度18分
# 東方東経130度を境界線とする区域内
v01_bb <-
  st_bbox(c(xmin = parse_lon_dohunbyo("東経128度18分"),
                    ymin = parse_lat_dohunbyo("北緯27度"),
                    xmax = parse_lon_dohunbyo("東経130度0分"),
                    ymax = parse_lat_dohunbyo("北緯32度"))) %>%
            st_as_sfc() %>%
            st_sf(crs = 4326)
v01 <-
  x %>%
  filter(nam %in% c("Kagoshima Ken")) %>%
  st_crop(v01_bb) %>%
  rbind(
    x %>%
      filter(nam %in% c("Nagasaki Ken"))) %>%
  jdg2011_union(1)
v02 <-
  x %>%
  filter(nam %in% c("Fukuoka Ken", "Saga Ken", "Kumamoto Ken", "Oita Ken", "Miyazaki Ken")) %>%
  rbind(
    x %>%
      filter(nam %in% c("Kagoshima Ken")) %>%
      st_join(v01_bb,
              join = st_disjoint,
              left = FALSE)
  ) %>%
  jdg2011_union(2)
v03 <-
  x %>%
  filter(nam %in% c("Yamaguchi Ken", "Shimane Ken", "Hiroshima Ken")) %>%
  jdg2011_union(3)
v04 <-
  x %>%
  filter(nam %in% c("Kagawa Ken", "Ehime Ken", "Tokushima Ken", "Kochi Ken")) %>%
  jdg2011_union(4)
v05 <-
  x %>%
  filter(nam %in% c("Hyogo Ken", "Tottori Ken", "Okayama Ken")) %>%
  jdg2011_union(5)
v06 <-
  x %>%
  filter(nam %in% c("Mie Ken", "Shiga Ken", "Kyoto Fu", "Osaka Fu", "Fukui Ken", "Nara Ken", "Wakayama Ken")) %>%
  jdg2011_union(6)
v07 <-
  x %>%
  filter(nam %in% c("Ishikawa Ken", "Toyama Ken", "Gifu Ken", "Aichi Ken")) %>%
  jdg2011_union(7)
v08 <-
  x %>%
  filter(nam %in% c("Niigata Ken", "Nagano Ken", "Yamanashi Ken", "Shizuoka Ken")) %>%
  jdg2011_union(8)
v09 <-
  x %>%
  filter(nam %in% c("Fukushima Ken", "Tochigi Ken", "Ibaraki Ken", "Saitama Ken", "Chiba Ken",
                    "Gunma Ken", "Kanagawa Ken")) %>%
  rbind(
    x %>%
      filter(nam == "Tokyo To") %>%
      filter(!adm_code %in% c("13421"))
  ) %>%
  jdg2011_union(9)
v10 <-
  x %>%
  filter(nam %in% c("Aomori Ken", "Akita Ken", "Yamagata Ken", "Iwate Ken", "Miyagi Ken")) %>%
  jdg2011_union(10)
v11 <-
  x %>%
  filter(nam %in% c("Hokkai Do")) %>%
  filter(adm_code %in% c("01202", "01203", "01233", "01236",
                         "01331", # Masaki Cho --> Matsumae Cho
                         "01332", "01333", "01334", "01337",
                         "01343", "01345", "01346",
                         "01361", "01362", "01363", "01364",
                         "01370", "01371", "01347", "01367",
                         "01391", "01392", "01393", "01394",
                         "01395", "01396", "01397", "01398", "01399",
                         "01233", "01400",
                         "01401", "01402", "01403", "01404", "01405",
                         "01406", "01407", "01408", "01409",
                         "01571", "01575", "01584"))
v13 <-
  x %>%
  filter(nam %in% c("Hokkai Do")) %>%
  filter(adm_code %in% c("01207", "01208", "01211", "01223",
                         "01543", "01544", "01545", "01546", "01547", "01549", "01550",
                         "01552", "01564",
                         "01631", "01632", "01633", "01634",
                         "01637", "01638", "01639", "01642", "01643", "01644",
                         "01646", "01647", "01648",
                         "01664", "01665", "01667", "01692",
                         "01693", "01694",
                         "01223", "01206", "01636", "01635",
                         "01668", "01649", "01645", "01641",
                         "01691", "01661", "01662", "01663", "01695",
                         "01696", "01697", "01698", "01699", "01700"))
v12 <-
  x %>%
  filter(nam %in% c("Hokkai Do")) %>%
  filter(!adm_code %in% unique(c(v11$adm_code, v13$adm_code))) %>%
  jdg2011_union(12)

v11 <-
  v11 %>%
  jdg2011_union(11)
v13 <-
  v13 %>%
  jdg2011_union(13)
# 北緯28度から南であり、かつ東経140度30分から東であり東経143度から西である区域
v14_bb <-
  st_bbox(c(xmin = parse_lon_dohunbyo("東経140度30分"),
            ymin = parse_lat_dohunbyo("北緯28度"),
            xmax = parse_lon_dohunbyo("東経143度"),
            ymax = parse_lat_dohunbyo("北緯20度25分30.6585秒"))) %>%
  st_as_sfc() %>%
  st_sf(crs = 4326)
v14 <-
  x %>%
  filter(nam %in% c("Tokyo To")) %>%
  st_crop(v14_bb) %>%
  jdg2011_union(14)
# 東経126度から東であり、かつ東経130度から西である区域
v15_bb <-
  st_bbox(c(xmin = parse_lon_dohunbyo("東経126度"),
          ymin = parse_lat_dohunbyo("北緯45度33分28秒"),
          xmax = parse_lon_dohunbyo("東経130度"),
          ymax = parse_lat_dohunbyo("北緯20度25分30.6585秒"))) %>%
  st_as_sfc() %>%
  st_sf(crs = 4326)
v15 <-
  x %>%
  filter(nam %in% c("Okinawa Ken")) %>%
  st_crop(v15_bb) %>%
  jdg2011_union(15)
# 東経126度から西である区域
v16_bb <-
  st_bbox(c(xmin = parse_lon_dohunbyo("東経126度"),
            ymin = parse_lat_dohunbyo("北緯45度33分28秒"),
            xmax = parse_lon_dohunbyo("東経122度55分57秒"),
            ymax = parse_lat_dohunbyo("北緯20度25分30.6585秒"))) %>%
  st_as_sfc() %>%
  st_sf(crs = 4326)
v16 <-
  x %>%
  filter(nam %in% c("Okinawa Ken")) %>%
  st_crop(v16_bb) %>%
  jdg2011_union(16)
# 東経130度から東である区域
v17_bb <-
  st_bbox(c(xmin = parse_lon_dohunbyo("東経130度"),
            ymin = parse_lat_dohunbyo("北緯45度33分28秒"),
            xmax = parse_lon_dohunbyo("東経153度59分12秒"),
            ymax = parse_lat_dohunbyo("北緯20度25分30.6585秒"))) %>%
  st_as_sfc() %>%
  st_sf(crs = 4326)
v17 <-
  x %>%
  filter(nam %in% c("Okinawa Ken")) %>%
  st_crop(v17_bb) %>%
  jdg2011_union(17)
# 北緯28度から南であり、かつ東経140度30分から西である区域
v18_bb <-
  st_bbox(c(xmin = parse_lon_dohunbyo("東経122度55分57秒"),
            ymin = parse_lat_dohunbyo("北緯28度"),
            xmax = parse_lon_dohunbyo("東経140度30分"),
            ymax = parse_lat_dohunbyo("北緯20度"))) %>%
  st_as_sfc() %>%
  st_sf(crs = 4326)
v18 <-
  x %>%
  filter(nam %in% c("Tokyo To")) %>%
  st_crop(v18_bb) %>%
  jdg2011_union(18)
# 北緯28度から南であり、かつ東経143度から東である区域
v19_bb <-
  st_bbox(c(xmin = parse_lon_dohunbyo("東経143度"),
            ymin = parse_lat_dohunbyo("北緯28度"),
            xmax = parse_lon_dohunbyo("東経153度59分12秒"),
            ymax = parse_lat_dohunbyo("北緯20度"))) %>%
  st_as_sfc() %>%
  st_sf(crs = 4326)
v19 <-
  x %>%
  filter(nam %in% c("Tokyo To")) %>%
  st_crop(v19_bb) %>%
  jdg2011_union(19)

epsg_codes <-
  seq.int(6669, 6687)

jgd2011_bbox <-
  ls(pattern = "^v[0-9]{2}$") %>%
  purrr::map(get) %>%
  purrr::reduce(rbind) %>%
  tibble::new_tibble(nrow = nrow(.), class = "sf") %>%
  tibble::add_column(epsg = epsg_codes,
                     .before = "geometry") %>%
  purrr::modify_at(c(1, 2),
                   ~ forcats::fct_inorder(as.character(.x)))

# mapview::mapview(jgd2011_bbox, zcol = "epsg")

usethis::use_data(jgd2011_bbox, overwrite = TRUE)
