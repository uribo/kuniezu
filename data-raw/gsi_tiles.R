library(sf)
library(mapview)

atr <-
  paste0("<a href='http://maps.gsi.go.jp/development/ichiran.html' target='_blank'>",
         "\u5730\u7406\u9662\u30bf\u30a4\u30eb",
         "</a>")

gsi_tiles_url <-
  list(standard = "https://cyberjapandata.gsi.go.jp/xyz/std/{z}/{x}/{y}.png",
       pale = "https://cyberjapandata.gsi.go.jp/xyz/pale/{z}/{x}/{y}.png",
       english = "https://cyberjapandata.gsi.go.jp/xyz/english/{z}/{x}/{y}.png",
       lcm25k_2012 = "https://cyberjapandata.gsi.go.jp/xyz/lcm25k_2012/{z}/{x}/{y}.png",
       lcm25k = "https://cyberjapandata.gsi.go.jp/xyz/lcm25k/{z}/{x}/{y}.png",
       ccm1 = "https://cyberjapandata.gsi.go.jp/xyz/ccm1/{z}/{x}/{y}.png",
       ccm2 = "https://cyberjapandata.gsi.go.jp/xyz/ccm2/{z}/{x}/{y}.png",
       vbm = "https://cyberjapandata.gsi.go.jp/xyz/vbm/{z}/{x}/{y}.png",
       vbmd_bm = "https://cyberjapandata.gsi.go.jp/xyz/vbmd_bm/{z}/{x}/{y}.png",
       vbmd_colorrel = "https://cyberjapandata.gsi.go.jp/xyz/vbmd_colorrel/{z}/{x}/{y}.png",
       vbmd_pm = "https://cyberjapandata.gsi.go.jp/xyz/vbmd_pm/{z}/{x}/{y}.png",
       vlcd = "https://cyberjapandata.gsi.go.jp/xyz/vlcd/{z}/{x}/{y}.png",
       lum200k = "https://cyberjapandata.gsi.go.jp/xyz/lum200k/{z}/{x}/{y}.png",
       lake1 = "https://cyberjapandata.gsi.go.jp/xyz/lake1/{z}/{x}/{y}.png",
       lakedata = "https://cyberjapandata.gsi.go.jp/xyz/lakedata/{z}/{x}/{y}.png",
       blank = "https://cyberjapandata.gsi.go.jp/xyz/blank/{z}/{x}/{y}.png",
       seamlessphoto = "https://cyberjapandata.gsi.go.jp/xyz/seamlessphoto/{z}/{x}/{y}.jpg",
       ortho = "https://cyberjapandata.gsi.go.jp/xyz/ort/{z}/{x}/{y}.jpg",
       airphoto = "https://cyberjapandata.gsi.go.jp/xyz/airphoto/{z}/{x}/{y}.png",
       gazo4 = "https://cyberjapandata.gsi.go.jp/xyz/gazo4/{z}/{x}/{y}.jpg",
       gazo3 = "https://cyberjapandata.gsi.go.jp/xyz/gazo3/{z}/{x}/{y}.jpg",
       gazo2 = "https://cyberjapandata.gsi.go.jp/xyz/gazo2/{z}/{x}/{y}.jpg",
       gazo1 = "https://cyberjapandata.gsi.go.jp/xyz/gazo1/{z}/{x}/{y}.jpg",
       ort_old10 = "https://cyberjapandata.gsi.go.jp/xyz/ort_old10/{z}/{x}/{y}.png",
       ort_USA10 = "https://cyberjapandata.gsi.go.jp/xyz/ort_USA10/{z}/{x}/{y}.png",
       ort_riku10 = "https://cyberjapandata.gsi.go.jp/xyz/ort_riku10/{z}/{x}/{y}.png",
       #pp = "https://cyberjapandata.gsi.go.jp/xyz/pp/{z}/{x}/{y}.geojson",
       relief = "https://cyberjapandata.gsi.go.jp/xyz/relief/{z}/{x}/{y}.png",
       anaglyphmap_color = "https://cyberjapandata.gsi.go.jp/xyz/anaglyphmap_color/{z}/{x}/{y}.png",
       anaglyphmap_gray = "https://cyberjapandata.gsi.go.jp/xyz/anaglyphmap_gray/{z}/{x}/{y}.png",
       hillshademap = "https://cyberjapandata.gsi.go.jp/xyz/hillshademap/{z}/{x}/{y}.png",
       earthhillshade = "https://cyberjapandata.gsi.go.jp/xyz/earthhillshade/{z}/{x}/{y}.png",
       slopemap = "https://cyberjapandata.gsi.go.jp/xyz/slopemap/{z}/{x}/{y}.png",
       slopezone1map = "https://cyberjapandata.gsi.go.jp/xyz/slopezone1map/{z}/{x}/{y}.png",
       afm = "https://cyberjapandata.gsi.go.jp/xyz/afm/{z}/{x}/{y}.png",
       lcmfc2 = "https://cyberjapandata.gsi.go.jp/xyz/lcmfc2/{z}/{x}/{y}.png",
       lcmfc1 = "https://cyberjapandata.gsi.go.jp/xyz/lcmfc1/{z}/{x}/{y}.png",
       swale = "https://cyberjapandata.gsi.go.jp/xyz/swale/{z}/{x}/{y}.png",
       cp = "https://cyberjapandata.gsi.go.jp/xyz/cp/{z}/{x}/{y}.geojson",
       jikizu2015_chijiki_d = "https://cyberjapandata.gsi.go.jp/xyz/jikizu2015_chijiki_d/{z}/{x}/{y}.png",
       jikizu2015_chijiki_i = "https://cyberjapandata.gsi.go.jp/xyz/jikizu2015_chijiki_i/{z}/{x}/{y}.png",
       jikizu2015_chijiki_f = "https://cyberjapandata.gsi.go.jp/xyz/jikizu2015_chijiki_f/{z}/{x}/{y}.png",
       jikizu2015_chijiki_h = "https://cyberjapandata.gsi.go.jp/xyz/jikizu2015_chijiki_h/{z}/{x}/{y}.png",
       jikizu2015_chijiki_z = "https://cyberjapandata.gsi.go.jp/xyz/jikizu2015_chijiki_z/{z}/{x}/{y}.png",
       jikizu_chijikid = "https://cyberjapandata.gsi.go.jp/xyz/jikizu_chijikid/{z}/{x}/{y}.png",
       jikizu_chijikii = "https://cyberjapandata.gsi.go.jp/xyz/jikizu_chijikii/{z}/{x}/{y}.png",
       jikizu_chijikif = "https://cyberjapandata.gsi.go.jp/xyz/jikizu_chijikif/{z}/{x}/{y}.png",
       jikizu_chijikih = "https://cyberjapandata.gsi.go.jp/xyz/jikizu_chijikih/{z}/{x}/{y}.png",
       jikizu_chijikiz = "https://cyberjapandata.gsi.go.jp/xyz/jikizu_chijikiz/{z}/{x}/{y}.png")

gsi_tiles <-
  gsi_tiles_url %>%
  purrr::map(
    ~ leaflet::leaflet() %>%
      leaflet::addTiles(.x,
                        attribution = atr))

usethis::use_data(gsi_tiles, overwrite = TRUE)
