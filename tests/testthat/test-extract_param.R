test_that("extract_param works for lnorm from percentiles", {
  lnorm_params <- extract_param(
    type = "percentiles",
    values = c(6, 13),
    distribution = "lnorm",
    percentiles = c(0.125, 0.875)
  )
  expect_equal(lnorm_params, c(a = 2.17835445066, b = 0.33606841584))
})

test_that("extract_param works for lnorm from median and range", {
  lnorm_params <- extract_param(
    type = "range",
    values = c(8, 4, 13),
    distribution = "lnorm",
    samples = 20
  )
  expect_equal(lnorm_params, c(a = 2.078970771947, b = 0.315613336301))
})

test_that("extract_param works for gamma from percentiles", {
  gamma_params <- extract_param(
    type = "percentiles",
    values = c(6, 13),
    distribution = "gamma",
    percentiles = c(0.125, 0.875)
  )
  expect_equal(gamma_params, c(a = 9.20039265138, b = 1.02058924190))
})

test_that("extract_param works for gamma from median and range", {
  gamma_params <- extract_param(
    type = "range",
    values = c(8, 4, 13),
    distribution = "gamma",
    samples = 20
  )
  expect_equal(gamma_params, c(a = 2.28598128108, b = 4.07606184746))
})

test_that("extract_param works for weibull from percentiles", {
  weibull_params <- extract_param(
    type = "percentiles",
    values = c(6, 13),
    distribution = "weibull",
    percentiles = c(0.125, 0.875)
  )
  expect_equal(weibull_params, c(a = 2.0, b = 0.5))
})

test_that("extract_param works for weibull from median and range", {
  weibull_params <- extract_param(
    type = "range",
    values = c(8, 4, 13),
    distribution = "weibull",
    samples = 20
  )
  expect_equal(weibull_params, c(a = 2.0, b = 0.5))
})

test_that("extract_param fails as expected", {
  expect_error(
    extract_param(
      type = "type",
      values = c(6, 13),
      distribution = "lnorm",
      percentiles = c(0.125, 0.875)
    ), 
    regexp = paste0("'arg' should be one of ", dQuote("percentiles"), ", ", dQuote("range"))
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
