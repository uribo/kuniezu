test_that("multiplication works", {
  res <-
    move_jpn_rs(jgd2011_bbox)
  expect_equal(
    dim(res),
    c(17, 3))
  expect_equal(
    as.character(res$system),
    as.character(as.roman(seq_len(19)[-c(18, 19)]))
  )
  x <-
    jgd2011_bbox$geometry[17] + c(5.2, 15.0)
  sf::st_crs(x) <- 6668
  if (sf::sf_extSoftVersion()["GEOS"] < "3.9.0") {
    expect_equal(
      sf::st_as_text(res$geometry[17]),
      sf::st_as_text(x)
    )
  } else {
    expect_true(
      sf::st_equals(res$geometry[17],
                    x,
                    sparse = FALSE))
    expect_false(
      sf::st_equals(res$geometry[1],
                    x,
                    sparse = FALSE))
  }
  res <-
    move_jpn_rs(jgd2011_bbox, clip = FALSE)
  expect_equal(
    dim(res),
    c(19, 3))
})
