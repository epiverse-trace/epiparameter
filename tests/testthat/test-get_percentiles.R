test_that("get_percentiles works as expected", {
  res <- get_percentiles(c(q_05 = 1, q_95 = 10))
  expect_identical(res, c("0.5" = 1, "95" = 10))

  res <- get_percentiles(c(q_025 = 1, q_975 = 10))
  expect_identical(res, c("0.25" = 1, "97.5" = 10))

  res <- get_percentiles(c(q_05 = 1, q_45 = 10))
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
