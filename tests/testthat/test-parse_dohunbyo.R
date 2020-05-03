test_that("Check input value", {
  expect_equal(
    length(news_kanji),
    4L
  )
  expect_true(
    is_dohunbyo_kanji("東経139度44分28秒8869")
  )
  expect_false(
    is_dohunbyo_kanji("とうけい139度44分28秒8869")
  )
})

test_that("replace works", {
  expect_equal(
    replace_dohunbyo_kanji("東経139度44分28秒8869"),
    c("E139°44’28.8869")
  )
  expect_equal(
    replace_dohunbyo_kanji("北緯35度39分29秒1572"),
    c("N35°39’29.1572")
  )
})

test_that("parse dohunbyo coordinates", {
  expect_equal(
    parse_lon_dohunbyo("東経139度44分28秒8869"),
    139.7414,
    tolerance = .002)
  expect_equal(
    parse_lat_dohunbyo("北緯35度39分29秒1572"),
    parzer::parse_lat("N35°39’29.1572"),
    tolerance = .002)
})
