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
    c(meanlog = 2.178355650131613, sdlog = 0.336068813742589),
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
    c(meanlog = 2.07944157390479, sdlog = 4.25373938812171),
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
    c(shape = 9.20039196528191, scale = 1.02058982449651),
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
  # tolerance on this test is smaller because of differences across OS
  expect_equal(
    gamma_params,
    c(shape = 10.818161002571626, scale = 0.762652109735326),
    tolerance = 1e-3
  )
})

test_that("extract_param works for Weibull from percentiles", {
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
    c(shape = 3.55090029647809, scale = 10.57799242826989),
    tolerance = testthat_tolerance()
  )
})

test_that("extract_param works for Weibull from median and range", {
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
    c(shape = 3.55994647578890, scale = 8.87141329172117),
    tolerance = testthat_tolerance()
  )
})

test_that("extract_param warns when max_iter exceeded", {
  # set seed for stochastic optimisation
  set.seed(1)
  # suppress messages for testing
  expect_warning(
    suppressMessages(extract_param(
      type = "percentiles",
      values = c(2, 10),
      distribution = "lnorm",
      percentiles = c(0.05, 0.95),
      control = list(max_iter = 5)
    )), regexp = paste0(
      "(Maximum optimisation iterations reached)*(returning result early)*",
      "(Result may not be reliable)"
    )
  )

  # suppress messages for testing
  expect_warning(
    suppressMessages(extract_param(
      type = "range",
      values = c(5, 2, 10),
      distribution = "lnorm",
      samples = 10,
      control = list(max_iter = 5)
    )), regexp = paste0(
      "(Maximum optimisation iterations reached)*(returning result early)*",
      "(Result may not be reliable)"
    )
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
    regexp = paste0(
      "'arg' should be one of ", dQuote("percentiles"), ", ",
      dQuote("range")
    )
  )

  expect_error(
    extract_param(
      type = "percentiles",
      values = "values",
      distribution = "lnorm",
      percentiles = c(0.125, 0.875)
    ),
    regexp = "(Assertion)*(failed: Must be of type)*(numeric)*(not)*(character)"
  )

  expect_error(
    extract_param(
      type = "percentiles",
      values = c(6, 13),
      distribution = "distribution",
      percentiles = c(0.125, 0.875)
    ),
    regexp = paste0(
      "'arg' should be one of ", dQuote("lnorm"), ", ",
      dQuote("gamma"), ", ", dQuote("weibull")
    )
  )

  expect_error(
    extract_param(
      type = "percentiles",
      values = c(6, 13),
      distribution = "lnorm",
      percentiles = c("0.125", 0.875)
    ),
    regexp = paste0(
      "Assertion on 'percentiles' failed: Must be of type",
      " 'numeric', not 'character'."
    )
  )

  expect_error(
    extract_param(
      type = "range",
      values = c(8, 4, 13),
      distribution = "lnorm",
      samples = "20"
    ),
    regexp = paste0(
      "Assertion on 'samples' failed: Must be of type ",
      "'number', not 'character'."
    )
  )

  expect_error(
    extract_param(
      type = "percentiles",
      values = c(6, 13),
      distribution = "lnorm",
      percentiles = c(0.125, 0.875),
      control = list(extra = 1)
    ),
    regexp = "control list requires max_iter and tolerance elements"
  )
})

test_that(".extract_param works for lnorm percentiles", {
  # set seed for stochastic optimisation
  set.seed(1)
  lnorm_params <- .extract_param(
    values = c(6, 13),
    distribution = "lnorm",
    percentiles = c(0.125, 0.875)
  )

  expect_equal(
    lnorm_params,
    list(
      par = c(meanlog = 2.13097474713655e+00, sdlog = 1.00000008274037e-10),
      value = 0.03125,
      counts = c("function" = 7, "gradient" = 7),
      convergence = 0,
      message = "CONVERGENCE: NORM OF PROJECTED GRADIENT <= PGTOL"
    ),
    tolerance = testthat_tolerance()
  )
})

test_that(".extract_param works for gamma percentiles", {
  # set seed for stochastic optimisation
  set.seed(1)
  gamma_params <- .extract_param(
    values = c(6, 13),
    distribution = "gamma",
    percentiles = c(0.125, 0.875)
  )

  expect_equal(
    gamma_params,
    list(
      par = c(shape = 9.20038735184127, scale = 1.02058983834422),
      value = 2.45662828557338e-14,
      counts = c("function" = 30, "gradient" = 30),
      convergence = 0,
      message = "CONVERGENCE: REL_REDUCTION_OF_F <= FACTR*EPSMCH"
    ),
    tolerance = testthat_tolerance()
  )
})

test_that(".extract_param works for Weibull percentiles", {
  # set seed for stochastic optimisation
  set.seed(1)
  weibull_params <- .extract_param(
    values = c(6, 13),
    distribution = "weibull",
    percentiles = c(0.125, 0.875)
  )

  expect_equal(
    weibull_params,
    list(
      par = c(shape = 0.0000000001000, scale = 2.6184985826797),
      value = 0.316161684132644,
      counts = c("function" = 6, "gradient" = 6),
      convergence = 0,
      message = "CONVERGENCE: REL_REDUCTION_OF_F <= FACTR*EPSMCH"
    ),
    tolerance = testthat_tolerance()
  )
})

test_that(".extract_param works for lnorm range", {
  # set seed for stochastic optimisation
  set.seed(1)
  lnorm_params <- .extract_param(
    values = c(8, 4, 13),
    distribution = "lnorm",
    samples = 20
  )

  expect_equal(
    lnorm_params,
    list(
      par = c(meanlog = 2.07944153869882, sdlog = 1.95820599716772),
      value = -3.81451307459282e-15,
      counts = c("function" = 6, "gradient" = 6),
      convergence = 0,
      message = "CONVERGENCE: REL_REDUCTION_OF_F <= FACTR*EPSMCH"
    ),
    tolerance = testthat_tolerance()
  )
})

test_that(".extract_param works for gamma range", {
  # set seed for stochastic optimisation
  set.seed(1)
  gamma_params <- .extract_param(
    values = c(8, 4, 13),
    distribution = "gamma",
    samples = 20
  )

  expect_equal(
    gamma_params,
    list(
      par = c(shape = 2.72933343452509, scale = 3.32748567278955),
      value = -8.1823252560062e-07,
      counts = c("function" = 10, "gradient" = 10),
      convergence = 0,
      message = "CONVERGENCE: REL_REDUCTION_OF_F <= FACTR*EPSMCH"
    ),
    tolerance = testthat_tolerance()
  )
})

test_that(".extract_param works for Weibull range", {
  # set seed for stochastic optimisation
  set.seed(1)
  weibull_params <- .extract_param(
    values = c(8, 4, 13),
    distribution = "weibull",
    samples = 20
  )

  expect_equal(
    weibull_params,
    list(
      par = c(shape = 0.0000000001000, scale = 2.5047337931743),
      value = 0.0174558420764588,
      counts = c("function" = 8, "gradient" = 8),
      convergence = 0,
      message = "CONVERGENCE: REL_REDUCTION_OF_F <= FACTR*EPSMCH"
    ),
    tolerance = testthat_tolerance()
  )
})

test_that(".extract_param fails as expected", {
  expect_error(
    .extract_param(
      values = c(8, 4, 13),
      distribution = "weibull"
    ),
    regexp = "percentiles or samples arguments must be specified"
  )
})

test_that("fit_range works for lnorm for valid input", {
  lnorm_range <- fit_range(
    param = c(meanlog = 2.0, sdlog = 0.5),
    val = c(median = 8, lower = 4, upper = 13, n = 20),
    dist = "lnorm"
  )
  reference <- 0.00396181460097
  expect_equal(lnorm_range, reference, tolerance = testthat_tolerance())
})

test_that("fit_range works for gamma for valid input", {
  gamma_range <- fit_range(
    param = c(shape = 2.0, scale = 0.5),
    val = c(median = 8, lower = 4, upper = 13, n = 20),
    dist = "gamma"
  )
  reference <- 0.249998086906
  expect_equal(gamma_range, reference, tolerance = testthat_tolerance())
})

test_that("fit_range works for weibull for valid input", {
  weibull_range <- fit_range(
    param = c(shape = 2.0, scale = 0.5),
    val = c(median = 8, lower = 4, upper = 13, n = 20),
    dist = "weibull"
  )
  reference <- 0.25
  expect_equal(weibull_range, reference, tolerance = testthat_tolerance())
})

test_that("fit_percentiles works for lnorm for valud input", {
  lnorm <- fit_percentiles(
    param = c(meanlog = 2.0, sdlog = 0.5),
    val = c(lower = 6.0, upper = 13.0, q1 = 0.125, q2 = 0.875),
    dist = "lnorm"
  )
  reference <- 0.0456127816304
  expect_equal(lnorm, reference, tolerance = testthat_tolerance())
})

test_that("fit_percentiles works for gamma for valid input", {
  gamma <- fit_percentiles(
    param = c(shape = 2.0, scale = 0.5),
    val = c(lower = 6.0, upper = 13.0, q1 = 0.125, q2 = 0.875),
    dist = "gamma"
  )
  reference <- 0.781110225514
  expect_equal(gamma, reference, tolerance = testthat_tolerance())
})

test_that("fit_percentiles works for weibull for valid input", {
  weibull <- fit_percentiles(
    param = c(shape = 2.0, scale = 0.5),
    val = c(lower = 6.0, upper = 13.0, q1 = 0.125, q2 = 0.875),
    dist = "weibull"
  )
  reference <- 0.78125
  expect_equal(weibull, reference, tolerance = testthat_tolerance())
})
