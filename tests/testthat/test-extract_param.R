test_that("extract_param works for lnorm from percentiles", {
  # set seed for stochastic optimisation
  set.seed(1)
  # suppress messages for testing
  lnorm_params <- suppressMessages(extract_param(
    type = "percentiles",
    values = c(6, 13),
    distribution = "lnorm",
    percentiles = c(0.125, 0.875)
  ))
  expect_equal(
    lnorm_params,
    c(a = 2.178355650131613, b = 0.336068813742589),
    tolerance = testthat_tolerance()
  )
})

test_that("extract_param works for lnorm from median and range", {
  # set seed for stochastic optimisation
  set.seed(1)
  # suppress messages for testing
  lnorm_params <- suppressMessages(extract_param(
    type = "range",
    values = c(8, 4, 13),
    distribution = "lnorm",
    samples = 20
  ))
  expect_equal(
    lnorm_params,
    c(a = 2.07944157390479, b = 4.25373938812171),
    tolerance = testthat_tolerance()
  )
})

test_that("extract_param works for gamma from percentiles", {
  # set seed for stochastic optimisation
  set.seed(1)
  # suppress messages for testing
  gamma_params <- suppressMessages(extract_param(
    type = "percentiles",
    values = c(6, 13),
    distribution = "gamma",
    percentiles = c(0.125, 0.875)
  ))
  expect_equal(
    gamma_params,
    c(a = 9.20039196528191, b = 1.02058982449651),
    tolerance = testthat_tolerance()
  )
})

test_that("extract_param works for gamma from median and range", {
  # set seed for stochastic optimisation
  set.seed(1)
  # suppress messages for testing
  gamma_params <- suppressMessages(extract_param(
    type = "range",
    values = c(8, 4, 13),
    distribution = "gamma",
    samples = 20
  ))
  expect_equal(
    gamma_params,
    c(a = 10.818161002571626, b = 0.762652109735326),
    tolerance = testthat_tolerance()
  )
})

test_that("extract_param works for weibull from percentiles", {
  # set seed for stochastic optimisation
  set.seed(1)
  # suppress messages for testing
  weibull_params <- suppressMessages(extract_param(
    type = "percentiles",
    values = c(6, 13),
    distribution = "weibull",
    percentiles = c(0.125, 0.875)
  ))
  expect_equal(
    weibull_params,
    c(a = 3.55090029647809, b = 10.57799242826989),
    tolerance = testthat_tolerance()
  )
})

test_that("extract_param works for weibull from median and range", {
  # set seed for stochastic optimisation
  set.seed(1)
  # suppress messages for testing
  weibull_params <- suppressMessages(extract_param(
    type = "range",
    values = c(8, 4, 13),
    distribution = "weibull",
    samples = 20
  ))
  expect_equal(
    weibull_params,
    c(a = 3.55994647578890, b = 8.87141329172117),
    tolerance = testthat_tolerance()
  )
})

test_that("extract_param fails as expected", {
  expect_error(
    extract_param(
      type = "type",
      values = c(6, 13),
      distribution = "lnorm",
      percentiles = c(0.125, 0.875)
    ),
    regexp = paste0("'arg' should be one of ", dQuote("percentiles"), ", ",
                    dQuote("range"))
  )

  expect_error(
    extract_param(
      type = "percentiles",
      values = "values",
      distribution = "lnorm",
      percentiles = c(0.125, 0.875)
    ),
    regexp = paste0("Assertion on 'values' failed: Must be of type 'numeric',",
                    " not 'character'.")
  )

  expect_error(
    extract_param(
      type = "percentiles",
      values = c(6, 13),
      distribution = "distribution",
      percentiles = c(0.125, 0.875)
    ),
    regexp = paste0("'arg' should be one of ", dQuote("lnorm"), ", ",
                    dQuote("gamma"), ", ", dQuote("weibull"))
  )

  expect_error(
    extract_param(
      type = "percentiles",
      values = c(6, 13),
      distribution = "lnorm",
      percentiles = c("0.125", 0.875)
    ),
    regexp = paste0("Assertion on 'percentiles' failed: Must be of type",
                    " 'numeric', not 'character'.")
  )

  expect_error(
    extract_param(
      type = "range",
      values = c(8, 4, 13),
      distribution = "lnorm",
      samples = "20"
    ), regexp = paste0("Assertion on 'samples' failed: Must be of type ",
                       "'numeric', not 'character'.")
  )
})

test_that("extract_param_percentile works for lnorm", {
  # set seed for stochastic optimisation
  set.seed(1)
  lnorm_params <- extract_param_percentile(
    values = c(6, 13),
    distribution = "lnorm",
    percentiles = c(0.125, 0.875)
  )
  expect_equal(
    lnorm_params,
    list(
      par = c(a = 2.13097474713655e+00, b = 1.00000008274037e-10),
      value = 0.03125,
      counts = c("function" = 7, "gradient" = 7),
      convergence = 0,
      message = "CONVERGENCE: NORM OF PROJECTED GRADIENT <= PGTOL"
    ),
    tolerance = testthat_tolerance()
  )
})

test_that("extract_param_percentile works for gamma", {
  # set seed for stochastic optimisation
  set.seed(1)
  gamma_params <- extract_param_percentile(
    values = c(6, 13),
    distribution = "gamma",
    percentiles = c(0.125, 0.875)
  )
  expect_equal(
    gamma_params,
    list(
      par = c(a = 9.20038735184127, b = 1.02058983834422),
      value = 2.45662828557338e-14,
      counts = c("function" = 30, "gradient" = 30),
      convergence = 0,
      message = "CONVERGENCE: REL_REDUCTION_OF_F <= FACTR*EPSMCH"
    ),
    tolerance = testthat_tolerance()
  )
})

test_that("extract_param_percentile works for weibull", {
  # set seed for stochastic optimisation
  set.seed(1)
  weibull_params <- extract_param_percentile(
    values = c(6, 13),
    distribution = "weibull",
    percentiles = c(0.125, 0.875)
  )
  expect_equal(
    weibull_params,
    list(
      par = c(a = 0.0000000001000, b = 2.6184985826797),
      value = 0.316161684132644,
      counts = c("function" = 6, "gradient" = 6),
      convergence = 0,
      message = "CONVERGENCE: REL_REDUCTION_OF_F <= FACTR*EPSMCH"
    ),
    tolerance = testthat_tolerance()
  )
})

test_that("extract_param_percentile fails as expected", {

  expect_error(
    extract_param_percentile(
      values = c("6", 13),
      distribution = "weibull",
      percentiles = c(0.125, 0.875)
    ),
    regexp = paste0("Assertion on 'values' failed: Must be of type 'numeric',",
                    " not 'character'.")
  )

  expect_error(
    extract_param_percentile(
      values = c(6, 13),
      distribution = "distribution",
      percentiles = c(0.125, 0.875)
    ),
    regexp = paste0("'arg' should be one of ", dQuote("lnorm"), ", ",
                    dQuote("gamma"), ", ", dQuote("weibull"))
  )

  expect_error(
    extract_param_percentile(
      values = c(6, 13),
      distribution = "weibull",
      percentiles = c("0.125", 0.875)
    ),
    regexp = paste0("Assertion on 'percentiles' failed: Must be of type",
                    " 'numeric', not 'character'.")
  )
})

test_that("extract_param_range works for lnorm", {
  # set seed for stochastic optimisation
  set.seed(1)
  lnorm_params <- extract_param_range(
    values = c(8, 4, 13),
    distribution = "lnorm",
    samples = 20
  )
  expect_equal(
    lnorm_params,
    list(
      par = c(a = 2.07944153869882, b = 1.95820599716772),
      value = -3.81451307459282e-15,
      counts = c("function" = 6, "gradient" = 6),
      convergence = 0,
      message = "CONVERGENCE: REL_REDUCTION_OF_F <= FACTR*EPSMCH"
    ),
    tolerance = testthat_tolerance()
  )
})

test_that("extract_param_range works for gamma", {
  # set seed for stochastic optimisation
  set.seed(1)
  gamma_params <- extract_param_range(
    values = c(8, 4, 13),
    distribution = "gamma",
    samples = 20
  )
  expect_equal(
    gamma_params,
    list(
      par = c(a = 2.72933343452509, b = 3.32748567278955),
      value = -8.1823252560062e-07,
      counts = c("function" = 10, "gradient" = 10),
      convergence = 0,
      message = "CONVERGENCE: REL_REDUCTION_OF_F <= FACTR*EPSMCH"
    ),
    tolerance = testthat_tolerance()
  )
})

test_that("extract_param_range works for weibull", {
  # set seed for stochastic optimisation
  set.seed(1)
  weibull_params <- extract_param_range(
    values = c(8, 4, 13),
    distribution = "weibull",
    samples = 20
  )
  expect_equal(
    weibull_params,
    list(
      par = c(a = 0.0000000001000, b = 2.5047337931743),
      value = 0.0174558420764588,
      counts = c("function" = 8, "gradient" = 8),
      convergence = 0,
      message = "CONVERGENCE: REL_REDUCTION_OF_F <= FACTR*EPSMCH"
    ),
    tolerance = testthat_tolerance()
  )
})

test_that("extract_param_range fails as expected", {

  expect_error(
    extract_param_range(
      values = c("8", 4, 13),
      distribution = "lnorm",
      samples = 20
    ),
    regexp = paste0("Assertion on 'values' failed: Must be of type 'numeric',",
                    " not 'character'.")
  )

  expect_error(
    extract_param_range(
      values = c(8, 4, 13),
      distribution = "distribution",
      samples = 20
    ),
    regexp = paste0("'arg' should be one of ", dQuote("lnorm"), ", ",
                    dQuote("gamma"), ", ", dQuote("weibull"))
  )

  expect_error(
    extract_param_range(
      values = c(8, 4, 13),
      distribution = "lnorm",
      samples = "20"
    ),
    regexp = paste0("Assertion on 'samples' failed: Must be of type",
                    " 'numeric', not 'character'.")
  )
})

test_that("fit_function_lnorm_range works for valid input", {
  lnorm_range <- fit_function_lnorm_range(
    param = c(a = 2.0, b = 0.5),
    val = c(8, 4, 13, n = 20)
  )
  reference <- 0.00396181460097
  names(reference) <- ""
  expect_equal(lnorm_range, reference, tolerance = testthat_tolerance())
})

test_that("fit_function_gamma_range works for valid input", {
  gamma_range <- fit_function_gamma_range(
    param = c(a = 2.0, b = 0.5),
    val = c(8, 4, 13, n = 20)
  )
  reference <- 0.249998086906
  names(reference) <- ""
  expect_equal(gamma_range, reference, tolerance = testthat_tolerance())
})

test_that("fit_function_weibull_range works for valid input", {
  weibull_range <- fit_function_weibull_range(
    param = c(a = 2.0, b = 0.5),
    val = c(8, 4, 13, n = 20)
  )
  reference <- 0.25
  names(reference) <- ""
  expect_equal(weibull_range, reference, tolerance = testthat_tolerance())
})

test_that("fit_function_lnorm works for valud input", {
  lnorm <- fit_function_lnorm(
    param = c(a = 2.0, b = 0.5),
    val = c(6.0, 13.0, q1 = 0.125, q2 = 0.875)
  )
  reference <- 0.0456127816304
  names(reference) <- ""
  expect_equal(lnorm, reference, tolerance = testthat_tolerance())
})

test_that("fit_function_gamma works for valid input", {
  gamma <- fit_function_gamma(
    param = c(a = 2.0, b = 0.5),
    val = c(6.0, 13.0, q1 = 0.125, q2 = 0.875)
  )
  reference <- 0.781110225514
  names(reference) <- ""
  expect_equal(gamma, reference, tolerance = testthat_tolerance())
})

test_that("fit_function_weibull works for valid input", {
  weibull <- fit_function_weibull(
    param = c(a = 2.0, b = 0.5),
    val = c(6.0, 13.0, q1 = 0.125, q2 = 0.875)
  )
  reference <- 0.78125
  names(reference) <- ""
  expect_equal(weibull, reference, tolerance = testthat_tolerance())
})
