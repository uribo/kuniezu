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
  expect_equal(
    sf::st_as_text(res$geometry[17]),
    sf::st_as_text(jgd2011_bbox$geometry[17] +
                     c(5.2, 15.0))
  )
  res <-
    move_jpn_rs(jgd2011_bbox, clip = FALSE)
  expect_equal(
    dim(res),
    c(19, 3))
})
