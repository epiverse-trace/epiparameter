test_that("calc_dist_params works as expected converting from mean and sd", {
  params <- calc_dist_params(
    prob_dist = "gamma",
    prob_dist_params = NA,
    summary_stats = create_epidist_summary_stats(mean = 5, sd = 2)
  )

  expect_vector(params, ptype = numeric(), size = 2)
  expect_named(params, expected = c("shape", "scale"))
})

test_that("calc_dist_params works as expected converting for different dist", {
  params <- calc_dist_params(
    prob_dist = "lnorm",
    prob_dist_params = NA,
    summary_stats = create_epidist_summary_stats(mean = 5, sd = 2)
  )

  expect_vector(params, ptype = numeric(), size = 2)
  expect_named(params, expected = c("mu", "sigma"))
})

test_that("calc_dist_params works as expected extracting from percentiles", {
  # messages for numerical optimisation suppressed
  params <- suppressMessages(calc_dist_params(
    prob_dist = "gamma",
    prob_dist_params = NA,
    summary_stats = create_epidist_summary_stats(
      quantiles = c(q_25 = 10, q_75 = 20)
    )
  ))

  expect_vector(params, ptype = numeric(), size = 2)
  expect_named(params, expected = c("shape", "scale"))

  # messages for numerical optimisation suppressed
  params <- suppressMessages(calc_dist_params(
    prob_dist = "lognormal",
    prob_dist_params = NA,
    summary_stats = create_epidist_summary_stats(
      quantiles = c(q_25 = 10, q_75 = 20)
    )
  ))

  expect_vector(params, ptype = numeric(), size = 2)
  expect_named(params, expected = c("meanlog", "sdlog"))
})

test_that("calc_dist_params works as expected extracting from median & range", {
  # messages for numerical optimisation suppressed
  params <- suppressMessages(calc_dist_params(
    prob_dist = "gamma",
    prob_dist_params = NA,
    summary_stats = create_epidist_summary_stats(
      median = 10,
      lower_range = 5,
      upper_range = 15
    ),
    sample_size = 25
  ))

  expect_vector(params, ptype = numeric(), size = 2)
  expect_named(params, expected = c("shape", "scale"))
})

test_that("calc_dist_params fails as expected extracting without sample size", {
  expect_message(
    params <- calc_dist_params(
      prob_dist = "gamma",
      prob_dist_params = NA,
      summary_stats = create_epidist_summary_stats(
        median = 10,
        lower_range = 5,
        upper_range = 15
      ),
      sample_size = NA
    ),
    regexp = "(No adequate summary statistics available)"
  )

  expect_true(is.na(params))
})

test_that("calc_dist_params messages as expected without summary stats", {
  expect_message(
    params <- calc_dist_params(
      prob_dist = "gamma",
      prob_dist_params = NA,
      summary_stats = create_epidist_summary_stats(mean = 5, median = 5)
    ),
    regexp = "(No adequate summary statistics available)"
  )

  expect_true(is.na(params))
})

test_that("convert_params works as expected for gamma", {

  params <- convert_params(
    summary_stats = create_epidist_summary_stats(mean = 5, sd = 2),
    prob_dist = "gamma"
  )

  expect_vector(params, ptype = numeric(), size = 2)
  expect_named(params, expected = c("shape", "scale"))
  expect_equal(
    params,
    c(shape = 6.25, scale = 0.80),
    tolerance = testthat_tolerance()
  )
})

test_that("convert_params works as expected for lognormal", {

  params <- convert_params(
    summary_stats = create_epidist_summary_stats(mean = 5, sd = 2),
    prob_dist = "lnorm"
  )

  expect_vector(params, ptype = numeric(), size = 2)
  expect_named(params, expected = c("mu", "sigma"))
  expect_equal(
    params,
    c(mu = 1.5352279099, sigma = 0.3852531702),
    tolerance = testthat_tolerance()
  )
})

test_that("convert_params works as expected for weibull", {

  # suppress message about numerical approximation
  params <- suppressMessages(convert_params(
    summary_stats = create_epidist_summary_stats(mean = 5, sd = 2),
    prob_dist = "weibull"
  ))

  expect_vector(params, ptype = numeric(), size = 2)
  expect_named(params, expected = c("shape", "scale"))
  expect_equal(
    params,
    c(shape = 2.695620, scale = 5.622818),
    tolerance = 1e-3
  )
})

test_that("convert_params works as expected for unrecognised class", {
  expect_error(
    convert_params(
      summary_stats = create_epidist_summary_stats(mean = 5, sd = 2),
      prob_dist = "distribution"
    ),
    regexp = "(No conversion functions for)"
  )
})
