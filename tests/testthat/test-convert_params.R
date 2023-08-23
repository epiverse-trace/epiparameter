test_that("convert_params_to_summary_stats works as expected", {
  expect_equal(
    convert_params_to_summary_stats(
      distribution = "lnorm", meanlog = 1, sdlog = 0.5
    ),
    list(
      mean = 3.080217, median = 2.718282, mode = 2.117, var = 2.694758,
      sd = 1.641572, cv = 0.5329404, skewness = 1.75019, ex_kurtosis = 5.898446
    ),
    tolerance = 1e-4
  )

  expect_equal(
    convert_params_to_summary_stats(
      distribution = "nbinom", prob = 0.5, dispersion = 1
    ),
    list(
      mean = 1, median = 0, mode = 0, var = 2, sd = 1.414214, cv = 1.414214,
      skewness = 2.12132, ex_kurtosis = 6.5
    ),
    tolerance = 1e-4
  )

  expect_equal(
    convert_params_to_summary_stats(
      distribution = "gamma", shape = 1, scale = 1
    ),
    list(
      mean = 1, median = 0.6931472, mode = 0, var = 1, sd = 1, cv = 1,
      skewness = 2, ex_kurtosis = 6
    ),
    tolerance = 1e-4
  )

  expect_equal(
    convert_params_to_summary_stats(
      distribution = "weibull", shape = 1, scale = 1
    ),
    list(
      mean = 1, median = 0.6931472, mode = 0, var = 1, sd = 1, cv = 1,
      skewness = 2, ex_kurtosis = 21
    ),
    tolerance = 1e-4
  )

  expect_equal(
    convert_params_to_summary_stats(distribution = "geom", prob = 0.5),
    list(
      mean = 1, median = 0, mode = 0, var = 2, sd = 1.414214, cv = 1.414214,
      skewness = 2.12132, ex_kurtosis = 6.5
    ),
    tolerance = 1e-4
  )

})

test_that("convert_summary_stats_to_params works as expected", {
  expect_equal(
    convert_summary_stats_to_params(distribution = "gamma", mean = 1, sd = 0.5),
    list(shape = 4, scale = 0.25),
    tolerance = 1e-4
  )

  expect_equal(
    suppressMessages(
      convert_summary_stats_to_params(
        distribution = "weibull", mean = 0.5, cv = 1
      )
    ),
    list(shape = 1.0, scale = 0.5),
    tolerance = 1e-3
  )

  expect_equal(
    convert_summary_stats_to_params(distribution = "lnorm", median = 1, sd = 1),
    list(meanlog = -0.3465736, sdlog = 0.8325546),
    tolerance = 1e-4
  )

  expect_equal(
    convert_summary_stats_to_params(
      distribution = "nbinom", mean = 1, dispersion = 1
    ),
    list(prob = 0.5, dispersion = 1),
    tolerance = 1e-4
  )

  expect_equal(
    convert_summary_stats_to_params(
      distribution = "nbinom", mean = 1, sd = 1.5
    ),
    list(prob = 0.4444444, dispersion = 0.8),
    tolerance = 1e-4
  )

  expect_equal(
    convert_summary_stats_to_params(distribution = "geom", mean = 0.5),
    list(prob = 0.6666667),
    tolerance = 1e-4
  )
})

test_that("convert_params_to_summary_stats fails as expected", {
  expect_error(
    convert_params_to_summary_stats(
      distribution = "random", shape = 1, scale = 1
    ),
    regexp = "(arg)*(should be one of)*(lnorm)*(gamma)"
  )

  expect_error(
    convert_params_to_summary_stats(distribution = "lnorm"),
    regexp = "(Parameter(s) need to be named and supplied)*(to the function)"
  )

  expect_error(
    convert_params_to_summary_stats(
      distribution = "lnorm", meanlog = 1, meanlog = 1
    ),
    regexp = "(Parameter(s) need to be named and supplied)*(to the function)"
  )

  expect_error(
    convert_params_to_summary_stats(
      distribution = "gamma", shape = -1, scale = 1
    ),
    regexp = "(Assertion on)*(shape)*(failed: Element 1 is not >= 0.)"
  )

  expect_error(
    convert_params_to_summary_stats(
      distribution = "lnorm", shape = 1, scale = 1
    ),
    regexp = "(lnorm parameters must be named)*(meanlog)*(sdlog)"
  )

  expect_error(
    convert_params_to_summary_stats(
      distribution = "gamma", meanlog = 1, scale = 1
    ),
    regexp = "(gamma parameters must be named)*(shape)*(scale)"
  )

  expect_error(
    convert_params_to_summary_stats(
      distribution = "weibull", meanlog = 1, scale = 1
    ),
    regexp = "(weibull parameters must be named)*(shape)*(scale)"
  )

  expect_error(
    convert_params_to_summary_stats(
      distribution = "nbinom", probability = 0.5, dispersion = 1
    ),
    regexp = "(nbinom parameters must be named)*(prob)*(dispersion)"
  )

  expect_error(
    convert_params_to_summary_stats(distribution = "geom", probability = 0.5),
    regexp = "(geom parameter must be named)*(prob)"
  )
})

test_that("convert_summary_stats_to_params fails as expected", {
  expect_error(
    convert_summary_stats_to_params(distribution = "random", mean = 1, sd = 1),
    regexp = "(arg)*(should be one of)*(lnorm)*(gamma)"
  )

  expect_error(
    convert_summary_stats_to_params(distribution = "lnorm"),
    regexp = "Summary statistics need to be named and supplied to the function"
  )

  expect_error(
    convert_summary_stats_to_params(distribution = "lnorm", mean = 1, mean = 1),
    regexp = "Summary statistics need to be named and supplied to the function"
  )

  expect_error(
    convert_summary_stats_to_params(distribution = "gamma", mean = -1, sd = 1),
    regexp = "(Assertion on)*(x$mean)*(failed: Element 1 is not >= 0.)"
  )

  expect_error(
    convert_summary_stats_to_params(distribution = "lnorm", mode = 1, var = 1),
    regexp = "Cannot calculate lognormal parameters from given input"
  )

  expect_error(
    convert_summary_stats_to_params(distribution = "gamma", mode = 1, var = 1),
    regexp = "Cannot calculate gamma parameters from given input"
  )

  expect_error(
    convert_summary_stats_to_params(
      distribution = "weibull", mode = 1, var = 1
    ),
    regexp = "Cannot calculate Weibull parameters from given input"
  )

  expect_error(
    convert_summary_stats_to_params(distribution = "nbinom", mode = 1, var = 1),
    regexp = "(Cannot calculate negative binomial)*(parameters from)*(input)"
  )

  expect_error(
    convert_summary_stats_to_params(
      distribution = "nbinom", mean = 1, var = 0.5
    ),
    regexp = "(Negative binomial)*(variance-to-mean ratio)*(greater than one)"
  )

  expect_error(
    convert_summary_stats_to_params(distribution = "geom", mode = 1, var = 1),
    regexp = "(Cannot calculate geometric)*(parameter from given input)"
  )
})

test_that("get_sd works as expected", {
  x <- list(mean = 1, sd = 1)
  x <- get_sd(x)
  expect_identical(x, list(mean = 1, sd = 1))

  x <- list(mean = 1, var = 1)
  x <- get_sd(x)
  expect_identical(x, list(mean = 1, var = 1, sd = 1))

  x <- list(mean = 1, cv = 1)
  x <- get_sd(x)
  expect_identical(x, list(mean = 1, cv = 1, sd = 1))
})

test_that("chk_ss is working as expected", {
  x <- list(mean = 1, sd = 1)
  expect_no_error(chk_ss(x))

  x <- c(mean = 1, sd = 1)
  expect_error(
    chk_ss(x),
    regexp = "(Assertion)*(failed: Must be of type)*(list)*(double)"
  )

  x <- list(mean = 1)
  expect_error(
    chk_ss(x),
    regexp = "(Assertion)*(failed: Must have length)*(2)*(1)"
  )

  x <- list(mean = 1, 1)
  expect_error(
    chk_ss(x),
    regexp = "(Assertion)*(failed: Must have names)*(empty)"
  )

  x <- list(mean = 1, sd = "1")
  expect_error(
    chk_ss(x),
    regexp = "(Assertion)*(failed: May only contain)*(numeric)*(character)"
  )

  x <- list(mean = 1, ss = 1)
  expect_error(
    chk_ss(x),
    regexp = "(Assertion)*(failed: Must be a subset)*(has additional elements)"
  )
})
