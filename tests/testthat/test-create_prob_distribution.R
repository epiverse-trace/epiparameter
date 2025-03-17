test_that("create_prob_distribution works for continuous gamma", {
  res <- create_prob_distribution(
    prob_distribution = "gamma",
    prob_distribution_params = c(shape = 1, scale = 1),
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

test_that("create_prob_distribution works for continuous lognormal", {
  res <- create_prob_distribution(
    prob_distribution = "lnorm",
    prob_distribution_params = c(meanlog = 1, sdlog = 1),
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

test_that("create_prob_distribution works for continuous Weibull", {
  res <- create_prob_distribution(
    prob_distribution = "weibull",
    prob_distribution_params = c(shape = 1, scale = 1),
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

test_that("create_prob_distribution works for negative binomial", {
  res <- create_prob_distribution(
    prob_distribution = "nbinom",
    prob_distribution_params = c(mean = 1, dispersion = 1),
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

test_that("create_prob_distribution works for geometric", {
  res <- create_prob_distribution(
    prob_distribution = "geom",
    prob_distribution_params = c(mean = 1),
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

test_that("create_prob_distribution works for poisson", {
  res <- create_prob_distribution(
    prob_distribution = "pois",
    prob_distribution_params = c(mean = 1),
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

test_that("create_prob_distribution works for exponential", {
  res <- create_prob_distribution(
    prob_distribution = "exp",
    prob_distribution_params = c(rate = 2),
    discretise = FALSE,
    truncation = NA
  )

  expect_s3_class(res, "distribution")
  expect_identical(family(res), "exponential")
  expect_identical(
    distributional::parameters(res),
    data.frame(rate = 2)
  )
})

test_that("create_prob_distribution works for discrete gamma", {
  res <- create_prob_distribution(
    prob_distribution = "gamma",
    prob_distribution_params = c(shape = 1, scale = 1),
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

test_that("create_prob_distribution works for discrete lognormal", {
  res <- create_prob_distribution(
    prob_distribution = "lnorm",
    prob_distribution_params = c(meanlog = 1, sdlog = 1),
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

test_that("create_prob_distribution works for discrete Weibull", {
  res <- create_prob_distribution(
    prob_distribution = "weibull",
    prob_distribution_params = c(shape = 1, scale = 1),
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

test_that("create_prob_distribution works for discrete normal", {
  res <- create_prob_distribution(
    prob_distribution = "norm",
    prob_distribution_params = c(mean = 1, sd = 1),
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

test_that("create_prob_distribution works for truncated continuous", {
  res <- create_prob_distribution(
    prob_distribution = "gamma",
    prob_distribution_params = c(shape = 1, scale = 1),
    discretise = FALSE,
    truncation = 10
  )

  expect_s3_class(res, "distribution")
  expect_identical(family(res), "truncated")
})

test_that("create_prob_distribution works for offset", {
  res <- create_prob_distribution(
    prob_distribution = "gamma",
    prob_distribution_params = c(shape = 1, scale = 1),
    offset = 10
  )

  expect_s3_class(res, "distribution")
  expect_identical(attr(res, "offset"), 10)
})

test_that("create_prob_distribution works passing args via ...", {
  dist1 <- create_prob_distribution(
    prob_distribution = "gamma",
    prob_distribution_params = c(shape = 1, scale = 1),
    discretise = TRUE,
    truncation = NA,
    w = 1
  )
  dist2 <- create_prob_distribution(
    prob_distribution = "gamma",
    prob_distribution_params = c(shape = 1, scale = 1),
    discretise = TRUE,
    truncation = NA,
    w = 0.5
  )
  expect_false(identical(dist1, dist2))
  expect_identical(dist1$w, 1)
  expect_identical(dist2$w, 0.5)
})

test_that("create_prob_distribution fails for unrecognised discretised", {
  expect_error(
    create_prob_distribution(
      prob_distribution = "distribution",
      prob_distribution_params = c(shape = 1, scale = 1),
      discretise = TRUE,
      truncation = NA
    ),
    regexp = "Incorrect parameters provided for probability distribution."
  )
})

test_that("create_prob_distribution fails for unrecognised non-discretised", {
  expect_error(
    create_prob_distribution(
      prob_distribution = "distribution",
      prob_distribution_params = c(shape = 1, scale = 1),
      discretise = FALSE,
      truncation = NA
    ),
    regexp = "Incorrect parameters provided for probability distribution."
  )
})

test_that("create_prob_distribution errors for discrete truncation", {
  expect_error(
    create_prob_distribution(
      prob_distribution = "gamma",
      prob_distribution_params = c(shape = 1, scale = 1),
      discretise = TRUE,
      truncation = 10
    ),
    regexp = "Truncation is not yet implemented for discrete distributions"
  )
})

test_that("create_prob_distribution errors for incorrect offset", {
  expect_error(
    create_prob_distribution(
      prob_distribution = "gamma",
      prob_distribution_params = c(shape = 1, scale = 1),
      offset = NA
    ),
    regexp = "(Assertion on)*(offset)*(failed)"
  )
})
