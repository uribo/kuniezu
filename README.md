
<!-- README.md is generated from README.Rmd. Please edit that file -->

# kuniezu

*国絵図 (kuniezu)*

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/kuniezu)](https://cran.r-project.org/package=kuniezu)
[![minimal R
version](https://img.shields.io/badge/R%3E%3D-3.3.0-blue.svg)](https://cran.r-project.org/)
![R-CMD-check](https://github.com/uribo/kuniezu/workflows/R-CMD-check/badge.svg)
[![Codecov test
coverage](https://codecov.io/gh/uribo/kuniezu/branch/master/graph/badge.svg)](https://codecov.io/gh/uribo/kuniezu?branch=master)
<!-- badges: end -->

`{kuniezu}`は日本の国土地理に関する補助関数およびデータセットを提供するRパッケージです。

## インストール

GitHubより行ってください。remotesパッケージをインストールしたのち、`remotes::install_github()`でパッケージのインストールを行います。

``` r
install.packages("remotes")
remotes::install_github("uribo/kuniezu")
```

## 使い方

``` r
library(kuniezu)
```

**度分秒で表記される緯度経度のパース**

`北緯35度39分29秒1572`、`東経139度44分28秒8869`のように度分秒を使って示される緯度経度の値を十進数の表記に変換します。

``` r
parse_lon_dohunbyo("東経139度44分28秒8869")
#> [1] 139.7414
parse_lat_dohunbyo("北緯35度39分29秒1572")
#> [1] 35.6581
```

**日本測地系2011平面直角座標での区域**

> 現在、厳密な区分には対応できていません。大まかな区域の判定にのみ有効です。

任意の座標が日本測地系2011の平面直角座標で示した際にどの区域に該当するかを判定します。

``` r
library(sf)
#> Linking to GEOS 3.7.1, GDAL 2.4.0, PROJ 5.2.0
st_nearest_jgd2011(st_sfc(sf::st_point(c(140.778, 36.8)), crs = 4326))
#> although coordinates are longitude/latitude, st_nearest_feature assumes that they are planar
#> [1] 6677
```
