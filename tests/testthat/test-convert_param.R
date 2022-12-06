test_that("lnorm_musigma2meansd works as expected", {
  params <- lnorm_musigma2meansd(mu = 1, sigma = 0.5)
  expect_type(params, "list")
  expect_named(params, c("mean", "sd"))
  expect_equal(
    params,
    list(mean = 3.08021684891803, sd = 1.64157184562387),
    tolerance = testthat_tolerance()
  )
})

test_that("lnorm_musigma2meansd fails as expected", {
  expect_error(
    lnorm_musigma2meansd(mu = "1", sigma = 0.5),
    regexp = paste0(
      "Assertion on 'mu' failed: Must be of type 'number',",
      " not 'character'."
    )
  )

  expect_error(
    lnorm_musigma2meansd(mu = 1, sigma = "0.5"),
    regexp = paste0(
      "Assertion on 'sigma' failed: Must be of type 'number',",
      " not 'character'."
    )
  )

  expect_error(
    lnorm_musigma2meansd(mu = 1, sigma = -0.5),
    regexp = "Assertion on 'sigma' failed: Element 1 is not >= 0."
  )
})

test_that("lnorm_meansd2musigma works as expected", {
  params <- lnorm_meansd2musigma(mean = 1, sd = 0.5)
  expect_type(params, "list")
  expect_named(params, c("mu", "sigma"))
  expect_equal(
    params,
    list(mu = -0.111571775657105, sigma = 0.472380727077439),
    tolerance = testthat_tolerance()
  )
})

test_that("lnorm_meansd2musigma fails as expected", {
  expect_error(
    lnorm_meansd2musigma(mean = "1", sd = 0.5),
    regexp = paste0(
      "Assertion on 'mean' failed: Must be of type 'number',",
      " not 'character'."
    )
  )

  expect_error(
    lnorm_meansd2musigma(mean = 1, sd = "0.5"),
    regexp = paste0(
      "Assertion on 'sd' failed: Must be of type 'number',",
      " not 'character'."
    )
  )

  expect_error(
    lnorm_meansd2musigma(mean = -1, sd = 0.5),
    regexp = "Assertion on 'mean' failed: Element 1 is not >= 0."
  )

  expect_error(
    lnorm_meansd2musigma(mean = 1, sd = -0.5),
    regexp = "Assertion on 'sd' failed: Element 1 is not >= 0."
  )
})

test_that("lnorm conversions go back to original values", {
  params_1 <- lnorm_musigma2meansd(mu = 1, sigma = 0.5)
  params_2 <- lnorm_meansd2musigma(mean = params_1$mean, sd = params_1$sd)
  expect_equal(
    params_2,
    list(mu = 1, sigma = 0.5),
    tolerance = testthat_tolerance()
  )

  params_1 <- lnorm_meansd2musigma(mean = 2, sd = 1)
  params_2 <- lnorm_musigma2meansd(mu = params_1$mu, sigma = params_1$sigma)
  expect_equal(
    params_2,
    list(mean = 2, sd = 1),
    tolerance = testthat_tolerance()
  )
})

test_that("gamma_shapescale2meansd works as expected", {
  params <- gamma_shapescale2meansd(shape = 1, scale = 0.5)
  expect_type(params, "list")
  expect_named(params, c("mean", "sd"))
  expect_equal(
    params,
    list(mean = 0.5, sd = 0.5),
    tolerance = testthat_tolerance()
  )
})

test_that("gamma_shapescale2meansd fails as expected", {
  expect_error(
    gamma_shapescale2meansd(shape = "1", scale = 0.5),
    regexp = paste0(
      "Assertion on 'shape' failed: Must be of type 'number',",
      " not 'character'."
    )
  )

  expect_error(
    gamma_shapescale2meansd(shape = 1, scale = "0.5"),
    regexp = paste0(
      "Assertion on 'scale' failed: Must be of type 'number',",
      " not 'character'."
    )
  )

  expect_error(
    gamma_shapescale2meansd(shape = -1, scale = 0.5),
    regexp = "Assertion on 'shape' failed: Element 1 is not >= 0."
  )

  expect_error(
    gamma_shapescale2meansd(shape = 1, scale = -0.5),
    regexp = "Assertion on 'scale' failed: Element 1 is not >= 0."
  )
})

test_that("gamma_meansd2shapescale works as expected", {
  params <- gamma_meansd2shapescale(mean = 2, sd = 1)
  expect_type(params, "list")
  expect_named(params, c("shape", "scale"))
  expect_equal(
    params,
    list(shape = 4, scale = 0.5),
    tolerance = testthat_tolerance()
  )
})

test_that("gamma_meansd2shapescale fails as expected", {
  expect_error(
    gamma_meansd2shapescale(mean = "1", sd = 0.5),
    regexp = paste0(
      "Assertion on 'mean' failed: Must be of type 'number',",
      " not 'character'."
    )
  )

  expect_error(
    gamma_meansd2shapescale(mean = 1, sd = "0.5"),
    regexp = paste0(
      "Assertion on 'sd' failed: Must be of type 'number',",
      " not 'character'."
    )
  )

  expect_error(
    gamma_meansd2shapescale(mean = -1, sd = 0.5),
    regexp = "Assertion on 'mean' failed: Element 1 is not >= 0."
  )

  expect_error(
    gamma_meansd2shapescale(mean = 1, sd = -0.5),
    regexp = "Assertion on 'sd' failed: Element 1 is not >= 0."
  )
})

test_that("gamma conversions go back to original values", {
  params_1 <- gamma_shapescale2meansd(shape = 3, scale = 1)
  params_2 <- gamma_meansd2shapescale(mean = params_1$mean, sd = params_1$sd)
  expect_equal(
    params_2,
    list(shape = 3, scale = 1),
    tolerance = testthat_tolerance()
  )

  params_1 <- gamma_meansd2shapescale(mean = 2, sd = 0.5)
  params_2 <- gamma_shapescale2meansd(
    shape = params_1$shape,
    scale = params_1$scale
  )
  expect_equal(
    params_2,
    list(mean = 2, sd = 0.5),
    tolerance = testthat_tolerance()
  )
})

test_that("weibull_shapescale2meansd works as expected", {
  params <- weibull_shapescale2meansd(shape = 1.5, scale = 1)
  expect_type(params, "list")
  expect_named(params, c("mean", "sd"))
  expect_equal(
    params,
    list(mean = 0.902745292950934, sd = 0.287894055808065),
    tolerance = testthat_tolerance()
  )
})

test_that("weibull_shapescale2meansd fails as expected", {
  expect_error(
    weibull_shapescale2meansd(shape = "1.5", scale = 1),
    regexp = paste0(
      "Assertion on 'shape' failed: Must be of type 'number',",
      " not 'character'."
    )
  )

  expect_error(
    weibull_shapescale2meansd(shape = 1.5, scale = "1"),
    regexp = paste0(
      "Assertion on 'scale' failed: Must be of type 'number',",
      " not 'character'."
    )
  )

  expect_error(
    weibull_shapescale2meansd(shape = -1.5, scale = 1),
    regexp = "Assertion on 'shape' failed: Element 1 is not >= 0."
  )

  expect_error(
    weibull_shapescale2meansd(shape = 1.5, scale = -1),
    regexp = "Assertion on 'scale' failed: Element 1 is not >= 0."
  )
})

test_that("weibull_meansd2shapescale works as expected", {
  # suppress message in testing
  params <- suppressMessages(weibull_meansd2shapescale(mean = 1, sd = 0.5))
  expect_type(params, "list")
  expect_named(params, c("shape", "scale"))
  expect_equal(
    params,
    list(shape = 2.10134909110144, scale = 1.12906338952704),
    tolerance = testthat_tolerance()
  )
})

test_that("weibull_meansd2shapescale fails as expected", {
  expect_error(
    weibull_meansd2shapescale(mean = "1", sd = 0.5),
    regexp = paste0(
      "Assertion on 'mean' failed: Must be of type 'number',",
      " not 'character'."
    )
  )

  expect_error(
    weibull_meansd2shapescale(mean = 1, sd = "0.5"),
    regexp = paste0(
      "Assertion on 'sd' failed: Must be of type 'number',",
      " not 'character'."
    )
  )

  expect_error(
    weibull_meansd2shapescale(mean = -1, sd = 0.5),
    regexp = "Assertion on 'mean' failed: Element 1 is not >= 0."
  )

  expect_error(
    weibull_meansd2shapescale(mean = 1, sd = -0.5),
    regexp = "Assertion on 'sd' failed: Element 1 is not >= 0."
  )
})

test_that("negative_binomial_meandispersion2probdispersion works as expected", {
  params <- negative_binomial_meandispersion2probdispersion(
    mean = 1,
    dispersion = 0.5
  )
  expect_type(params, "list")
  expect_named(params, c("prob", "dispersion"))
  expect_equal(
    params,
    list(prob = 0.333333333333333, dispersion = 0.5),
    tolerance = testthat_tolerance()
  )
})

test_that("negative_binomial_meandispersion2probdispersion fails as expected", {
  expect_error(
    negative_binomial_meandispersion2probdispersion(
      mean = "1",
      dispersion = 0.5
    ),
    regexp = paste0(
      "Assertion on 'mean' failed: Must be of type 'number',",
      " not 'character'."
    )
  )

  expect_error(
    negative_binomial_meandispersion2probdispersion(
      mean = 1,
      dispersion = "0.5"
    ),
    regexp = paste0(
      "Assertion on 'dispersion' failed: Must be of type 'number',",
      " not 'character'."
    )
  )
})

test_that("negative_binomial_probdispersion2meandispersion works as expected", {
  params <- negative_binomial_probdispersion2meandispersion(
    prob = 0.25,
    dispersion = 0.5
  )
  expect_type(params, "list")
  expect_named(params, c("mean", "dispersion"))
  expect_equal(
    params,
    list(mean = 1.5, dispersion = 0.5),
    tolerance = testthat_tolerance()
  )
})

test_that("negative_binomial_probdispersion2meandispersion fails as expected", {
  expect_error(
    negative_binomial_probdispersion2meandispersion(
      prob = "1",
      dispersion = 0.5
    ),
    regexp = paste0(
      "Assertion on 'prob' failed: Must be of type 'number',",
      " not 'character'."
    )
  )

  expect_error(
    negative_binomial_probdispersion2meandispersion(
      prob = 1,
      dispersion = "0.5"
    ),
    regexp = paste0(
      "Assertion on 'dispersion' failed: Must be of type 'number',",
      " not 'character'."
    )
  )
})

test_that("geometric_mean2prob works as expected", {
  params <- geometric_mean2prob(mean = 3)
  expect_type(params, "list")
  expect_named(params, "prob")
  expect_equal(
    params,
    list(prob = 0.25),
    tolerance = testthat_tolerance()
  )
})

test_that("geometric_mean2prob fails as expected", {
  expect_error(
    geometric_mean2prob(mean = "1"),
    regexp = paste0(
      "Assertion on 'mean' failed: Must be of type 'number',",
      " not 'character'."
    )
  )

  expect_error(
    geometric_mean2prob(mean = -1),
    regexp = paste0(
      "Assertion on 'mean' failed: Element 1 is not >= 0."
    )
  )

  expect_error(
    geometric_mean2prob(mean = Inf),
    regexp = paste0(
      "Assertion on 'mean' failed: Must be finite."
    )
  )
})

test_that("geometric_prob2mean works as expected", {
  params <- geometric_prob2mean(prob = 0.3)
  expect_type(params, "list")
  expect_named(params, "mean")
  expect_equal(
    params,
    list(mean = 2.33333333333333),
    tolerance = testthat_tolerance()
  )
})

test_that("geometric_prob2mean fails as expected", {
  expect_error(
    geometric_prob2mean(prob = "1"),
    regexp = paste0(
      "Assertion on 'prob' failed: Must be of type 'number',",
      " not 'character'."
    )
  )

  expect_error(
    geometric_prob2mean(prob = -1),
    regexp = paste0(
      "Assertion on 'prob' failed: Element 1 is not >= 0."
    )
  )

  expect_error(
    geometric_prob2mean(prob = 1.1),
    regexp = paste0(
      "Assertion on 'prob' failed: Element 1 is not <= 1."
    )
  )
})
