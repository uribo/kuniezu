test_that("multiplication works", {
  p <-
    sf::st_sfc(sf::st_point(c(140.77, 36.8)), crs = 4326)
  expect_message(
    expect_equal(
      st_nearest_jgd2011(p),
      6677L
    )
  )
  expect_message(
    expect_equal(
      st_detect_jgd2011(p),
      NA_real_
    )
  )
  expect_message(
    expect_equal(
      st_detect_jgd2011(c(p,
                          sf::st_sfc(sf::st_point(c(140.112, 36.083)),
                                     crs = 4326))),
      c(NA_real_, 6677)
    )
  )
})
