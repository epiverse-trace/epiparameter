test_that("calc_dist_params works as expected converting from mean and sd", {
  params <- calc_dist_params(
    prob_dist = "gamma",
    prob_dist_params = NA,
    summary_stats = create_epidist_summary_stats(mean = 5, sd = 2),
    sample_size = NA
  )

  expect_vector(params, ptype = numeric(), size = 2)
  expect_named(params, expected = c("shape", "scale"))
})

test_that("calc_dist_params works as expected converting for different dist", {
  params <- calc_dist_params(
    prob_dist = "lnorm",
    prob_dist_params = NA,
    summary_stats = create_epidist_summary_stats(mean = 5, sd = 2),
    sample_size = NA
  )

  expect_vector(params, ptype = numeric(), size = 2)
  expect_named(params, expected = c("meanlog", "sdlog"))
})

test_that("calc_dist_params works as expected extracting from percentiles", {
  # messages for numerical optimisation suppressed
  params <- suppressMessages(calc_dist_params(
    prob_dist = "gamma",
    prob_dist_params = NA,
    summary_stats = create_epidist_summary_stats(
      quantiles = c("25" = 10, "75" = 20)
    ),
    sample_size = NA
  ))

  expect_vector(params, ptype = numeric(), size = 2)
  expect_named(params, expected = c("shape", "scale"))

  # messages for numerical optimisation suppressed
  params <- suppressMessages(calc_dist_params(
    prob_dist = "lnorm",
    prob_dist_params = NA,
    summary_stats = create_epidist_summary_stats(
      quantiles = c("25" = 10, "75" = 20)
    ),
    sample_size = NA
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
      summary_stats = create_epidist_summary_stats(mean = 5, median = 5),
      sample_size = NA
    ),
    regexp = "(No adequate summary statistics available)"
  )

  expect_true(is.na(params))
})
