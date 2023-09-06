test_that("get_percentiles works as expected", {
  res <- get_percentiles(c(q_5 = 1, q_95 = 10))
  expect_identical(res, c("5" = 1, "95" = 10))

  res <- get_percentiles(c(q_2.5 = 1, q_97.5 = 10))
  expect_identical(res, c("2.5" = 1, "97.5" = 10))

  res <- get_percentiles(c(q_5 = 1, q_45 = 10))
  expect_identical(res, NA)

  res <- get_percentiles(c(q_55 = 1, q_90 = 10))
  expect_identical(res, NA)
})

test_that("get_percentiles fails as expected", {
  expect_error(
    get_percentiles("string"),
    regexp = "(Assertion on 'percentiles' failed)*(type 'numeric')"
  )

  expect_error(
    get_percentiles(c(1, 10)),
    regexp = "Assertion on 'percentiles' failed: Must have names."
  )
})

test_that("get_sym_percentiles works as expected for symmetrical", {
  # trivial case
  percentiles <- c("5" = 5, "95" = 15)
  sym_percentiles <- get_sym_percentiles(percentiles = percentiles)
  expect_identical(sym_percentiles, c("5" = 5, "95" = 15))

  # case without NAs
  percentiles <- c(
    "2.5" = 1, "5" = 5, "95" = 15, "99" = 25
  )
  sym_percentiles <- get_sym_percentiles(percentiles = percentiles)
  expect_identical(sym_percentiles, c("5" = 5, "95" = 15))

  # case with NAs
  percentiles <- c(
    "2.5" = 1, "5" = 5, "25" = NA, "75" = NA, "95" = 15, "99" = 25
  )
  sym_percentiles <- get_sym_percentiles(percentiles = percentiles)
  expect_identical(sym_percentiles, c("5" = 5, "95" = 15))

  # case with multiple symmetrical percentiles
  percentiles <- c(
    "2.5" = 1, "5" = 5, "25" = 7, "75" = 10, "95" = 15, "99" = 25
  )
  sym_percentiles <- get_sym_percentiles(percentiles = percentiles)
  expect_identical(sym_percentiles, c("25" = 7, "75" = 10))
})

test_that("get_sym_percentiles works as expected for asymmetrical", {
  # trivial case
  percentiles <- c("2.5" = 5, "95" = 15)
  sym_percentiles <- get_sym_percentiles(percentiles = percentiles)
  expect_identical(sym_percentiles, c("2.5" = 5, "95" = 15))

  # case without NAs
  percentiles <- c(
    "2.5" = 1, "25" = 5, "95" = 15, "99" = 25
  )
  sym_percentiles <- get_sym_percentiles(percentiles = percentiles)
  expect_identical(sym_percentiles, c("2.5" = 1, "99" = 25))

  # case with NAs
  percentiles <- c(
    "2.5" = 5, "25" = NA, "87.5" = NA, "95" = 15, "99" = 25
  )
  sym_percentiles <- get_sym_percentiles(percentiles = percentiles)
  expect_identical(sym_percentiles, c("2.5" = 5, "99" = 25))

  # case with multiple equally asymmetrical percentiles
  percentiles <- c(
    "2.5" = 1, "5" = 5, "25" = 7, "75" = 10, "95" = 15, "97.5" = 25
  )
  sym_percentiles <- get_sym_percentiles(percentiles = percentiles)
  expect_identical(sym_percentiles, c("25" = 7, "75" = 10))
})

test_that("get_sym_percentiles works as expected for all NAs", {
  percentiles <- c("2.5" = NA, "95" = NA)
  expect_true(is.na(get_sym_percentiles(percentiles = percentiles)))
})
