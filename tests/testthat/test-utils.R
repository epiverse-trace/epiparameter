test_that("calc_disc_dist_quantile works as expected", {
  prob <- dgamma(seq(0, 10, length.out = 21), shape = 2, scale = 2)
  days <- seq(0, 10, 0.5)
  quantiles <- c(0.025, 0.975)
  quants <- calc_disc_dist_quantile(
    prob = prob,
    days = days,
    quantile = quantiles
  )
  expect_vector(quants)
  expect_named(quants, expected = as.character(quantiles))
  expect_equal(
    quants,
    c("0.025" = 0, "0.975" = 9),
    tolerance = testthat_tolerance()
  )
})

test_that("calc_disc_dist_quantile fails as expected", {
  prob <- dgamma(seq(0, 10, length.out = 21), shape = 2, scale = 2)
  days <- seq(0, 10, 0.5)
  quantiles <- c(0.025, 0.975)
  expect_error(
    calc_disc_dist_quantile(
      prob = "prob",
      days = days,
      quantile = quantiles
    ),
    regexp = paste0(
      "Assertion on 'prob' failed: Must be of type 'numeric',",
      " not 'character'."
    )
  )

  expect_error(
    calc_disc_dist_quantile(
      prob = prob,
      days = "days",
      quantile = quantiles
    ),
    regexp = paste0(
      "Assertion on 'days' failed: Must be of type 'numeric',",
      " not 'character'."
    )
  )

  expect_error(
    calc_disc_dist_quantile(
      prob = prob,
      days = days,
      quantile = "quantiles"
    ),
    regexp = paste0(
      "Assertion on 'quantile' failed: Must be of type 'numeric',",
      " not 'character'."
    )
  )
})

test_that(".citet works as expected for multi-author", {
  suppressMessages(
    epidist <- epidist_db(
      author = "Lessler",
      disease = "RSV",
      single_epidist = TRUE
    )
  )
  expect_identical(.citet(epidist$citation), "Lessler et al. (2009)")
})

test_that(".citet works as expected for single author", {
  suppressMessages(
    epidist <- epidist_db(
      author = "Pavlin",
      disease = "Marburg",
      single_epidist = TRUE
    )
  )
  expect_identical(.citet(epidist$citation), "Pavlin (2014)")
})

test_that(".citet works as expected for two authors", {
  suppressMessages(
    epidist <- epidist_db(
      author = "Nishiura",
      disease = "Influenza",
      single_epidist = TRUE
    )
  )
  expect_identical(.citet(epidist$citation), "Nishiura & Inaba (2011)")
})

test_that(".citet works as expected for organisation author", {
  suppressMessages(
    epidist <- epidist_db(
      author = "WHO",
      disease = "Ebola",
      single_epidist = TRUE
    )
  )
  expect_identical(
    .citet(epidist$citation),
    "WHO Ebola Response Team et al. (2015)"
  )
})
