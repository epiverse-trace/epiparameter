test_that("lnorm_musigma2meansd works as expected", {
  params <- lnorm_musigma2meansd(mu = 1, sigma = 0.5)
  expect_type(params, "list")
  expect_named(params, c("mean", "sd"))
  expect_equal(params, list(mean = 3.08021684891803, sd = 1.64157184562387))
})

test_that("lnorm_meansd2musigma works as expected", {
  params <- lnorm_meansd2musigma(mean = 1, sd = 0.5)
  expect_type(params, "list")
  expect_named(params, c("mu", "sigma"))
  expect_equal(params, list(mu = -0.111571775657105, sigma = 0.472380727077439))
})

test_that("lnorm conversions go back to original values", {
  params_1 <- lnorm_musigma2meansd(mu = 1, sigma = 0.5)
  params_2 <- lnorm_meansd2musigma(mean = params_1$mean, sd = params_1$sd)
  expect_equal(params_2, list(mu = 1, sigma = 0.5))

  params_1 <- lnorm_meansd2musigma(mean = 2, sd = 1)
  params_2 <- lnorm_musigma2meansd(mu = params_1$mu, sigma = params_1$sigma)
  expect_equal(params_2, list(mean = 2, sd = 1))
})

test_that("gamma_shapescale2meansd works as expected", {
  params <- gamma_shapescale2meansd(shape = 1, scale = 0.5)
  expect_type(params, "list")
  expect_named(params, c("mean", "sd"))
  expect_equal(params, list(mean = 0.5, sd = 0.5))
})

test_that("gamma_meansd2shapescale works as expected", {
  params <- gamma_meansd2shapescale(mean = 2, sd = 1)
  expect_type(params, "list")
  expect_named(params, c("shape", "scale"))
  expect_equal(params, list(shape = 4, scale = 0.5))
})

test_that("gamma conversions go back to original values", {
  params_1 <- gamma_shapescale2meansd(shape = 3, scale = 1)
  params_2 <- gamma_meansd2shapescale(mean = params_1$mean, sd = params_1$sd)
  expect_equal(params_2, list(shape = 3, scale = 1))

  params_1 <- gamma_meansd2shapescale(mean = 2, sd = 0.5)
  params_2 <- gamma_shapescale2meansd(
    shape = params_1$shape,
    scale = params_1$scale
  )
  expect_equal(params_2, list(mean = 2, sd = 0.5))
})

test_that("weibull_shapescale2meansd works as expected", {
  params <- weibull_shapescale2meansd(shape = 1.5, scale = 1)
  expect_type(params, "list")
  expect_named(params, c("mean", "sd"))
  expect_equal(params, list(mean = 0.902745292950934, sd = 0.287894055808065))
})

test_that("weibull_meansd2shapescale works as expected", {
  # suppress message in testing
  params <- suppressMessages(weibull_meansd2shapescale(mean = 1, sd = 0.5))
  expect_type(params, "list")
  expect_named(params, c("shape", "scale"))
  expect_equal(params, list(shape = 2.10134909110144, scale = 1.12906338952704))
})
