test_that("create_prob_dist works as expected for continuous gamma", {
  res <- create_prob_dist(
    prob_dist = "gamma",
    prob_dist_params = c(shape = 1, scale = 1),
    discretise = FALSE,
    truncation = NA
  )

  expect_s3_class(res, "distribution")
  expect_identical(family(res), "gamma")
  expect_identical(
    distributional::parameters(res),
    data.frame(shape = 1, rate = 1)
  )
})

test_that("create_prob_dist works as expected for continuous lognormal", {
  res <- create_prob_dist(
    prob_dist = "lnorm",
    prob_dist_params = c(meanlog = 1, sdlog = 1),
    discretise = FALSE,
    truncation = NA
  )

  expect_s3_class(res, "distribution")
  expect_identical(family(res), "lognormal")
  expect_identical(
    distributional::parameters(res),
    data.frame(mu = 1, sigma = 1)
  )
})

test_that("create_prob_dist works as expected for continuous Weibull", {
  res <- create_prob_dist(
    prob_dist = "weibull",
    prob_dist_params = c(shape = 1, scale = 1),
    discretise = FALSE,
    truncation = NA
  )

  expect_s3_class(res, "distribution")
  expect_identical(family(res), "weibull")
  expect_identical(
    distributional::parameters(res),
    data.frame(shape = 1, scale = 1)
  )
})

test_that("create_prob_dist works as expected for negative binomial", {
  res <- create_prob_dist(
    prob_dist = "nbinom",
    prob_dist_params = c(mean = 1, dispersion = 1),
    discretise = FALSE,
    truncation = NA
  )

  expect_s3_class(res, "distribution")
  expect_identical(family(res), "negbin")
  expect_identical(
    distributional::parameters(res),
    data.frame(n = 1, p = 0.5)
  )
})

test_that("create_prob_dist works as expected for geometric", {
  res <- create_prob_dist(
    prob_dist = "geom",
    prob_dist_params = c(mean = 1),
    discretise = FALSE,
    truncation = NA
  )

  expect_s3_class(res, "distribution")
  expect_identical(family(res), "geometric")
  expect_identical(
    distributional::parameters(res),
    data.frame(p = 1)
  )
})

test_that("create_prob_dist works as expected for poisson", {
  res <- create_prob_dist(
    prob_dist = "pois",
    prob_dist_params = c(mean = 1),
    discretise = FALSE,
    truncation = NA
  )

  expect_s3_class(res, "distribution")
  expect_identical(family(res), "poisson")
  expect_identical(
    distributional::parameters(res),
    data.frame(l = 1)
  )
})

test_that("create_prob_dist works as expected for discrete gamma", {
  res <- create_prob_dist(
    prob_dist = "gamma",
    prob_dist_params = c(shape = 1, scale = 1),
    discretise = TRUE,
    truncation = NA
  )

  expect_s3_class(res, "distcrete")
  expect_identical(res$name, "gamma")
  expect_identical(
    res$parameters,
    list(shape = 1, scale = 1)
  )
})

test_that("create_prob_dist works as expected for discrete lognormal", {
  res <- create_prob_dist(
    prob_dist = "lnorm",
    prob_dist_params = c(meanlog = 1, sdlog = 1),
    discretise = TRUE,
    truncation = NA
  )

  expect_s3_class(res, "distcrete")
  expect_identical(res$name, "lnorm")
  expect_identical(
    res$parameters,
    list(meanlog = 1, sdlog = 1)
  )
})

test_that("create_prob_dist works as expected for discrete Weibull", {
  res <- create_prob_dist(
    prob_dist = "weibull",
    prob_dist_params = c(shape = 1, scale = 1),
    discretise = TRUE,
    truncation = NA
  )

  expect_s3_class(res, "distcrete")
  expect_identical(res$name, "weibull")
  expect_identical(
    res$parameters,
    list(shape = 1, scale = 1)
  )
})

test_that("create_prob_dist works as expected for discrete normal", {
  res <- create_prob_dist(
    prob_dist = "norm",
    prob_dist_params = c(mean = 1, sd = 1),
    discretise = TRUE,
    truncation = NA
  )

  expect_s3_class(res, "distcrete")
  expect_identical(res$name, "norm")
  expect_identical(
    res$parameters,
    list(mean = 1, sd = 1)
  )
})

test_that("create_prob_dist works as expected for truncated continuous", {
  res <- create_prob_dist(
    prob_dist = "gamma",
    prob_dist_params = c(shape = 1, scale = 1),
    discretise = FALSE,
    truncation = 10
  )

  expect_s3_class(res, "distribution")
  expect_identical(family(res), "truncated")
})

test_that("create_prob_dist fails for unrecognised discretised dist", {
  expect_error(
    create_prob_dist(
      prob_dist = "distribution",
      prob_dist_params = c(shape = 1, scale = 1),
      discretise = TRUE,
      truncation = NA
    ),
    regexp = "(arg)*(should be one of)*(gamma)*(lnorm)*(weibull)"
  )
})

test_that("create_prob_dist fails for unrecognised non-discretised dist", {
  expect_error(
    create_prob_dist(
      prob_dist = "distribution",
      prob_dist_params = c(shape = 1, scale = 1),
      discretise = FALSE,
      truncation = NA
    ),
    regexp = "Did not recognise distribution name"
  )
})

test_that("create_prob_dist errors for discrete truncation", {
  expect_error(
    create_prob_dist(
      prob_dist = "gamma",
      prob_dist_params = c(shape = 1, scale = 1),
      discretise = TRUE,
      truncation = 10
    ),
    regexp = "Truncation is not yet implemented for discrete distributions"
  )
})
