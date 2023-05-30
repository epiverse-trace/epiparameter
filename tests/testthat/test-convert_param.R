test_that("lnorm_meanlogsdlog2meansd works as expected", {
  params <- lnorm_meanlogsdlog2meansd(meanlog = 1, sdlog = 0.5)
  expect_type(params, "list")
  expect_named(params, c("mean", "sd"))
  expect_equal(
    params,
    list(mean = 3.08021684891803, sd = 1.64157184562387),
    tolerance = testthat_tolerance()
  )
})

test_that("lnorm_meanlogsdlog2meansd fails as expected", {
  expect_error(
    lnorm_meanlogsdlog2meansd(meanlog = "1", sdlog = 0.5),
    regexp = paste0(
      "Assertion on 'meanlog' failed: Must be of type 'number',",
      " not 'character'."
    )
  )

  expect_error(
    lnorm_meanlogsdlog2meansd(meanlog = 1, sdlog = "0.5"),
    regexp = paste0(
      "Assertion on 'sdlog' failed: Must be of type 'number',",
      " not 'character'."
    )
  )

  expect_error(
    lnorm_meanlogsdlog2meansd(meanlog = 1, sdlog = -0.5),
    regexp = "Assertion on 'sdlog' failed: Element 1 is not >= 0."
  )
})

test_that("lnorm_meansd2meanlogsdlog works as expected", {
  params <- lnorm_meansd2meanlogsdlog(mean = 1, sd = 0.5)
  expect_type(params, "list")
  expect_named(params, c("meanlog", "sdlog"))
  expect_equal(
    params,
    list(meanlog = -0.111571775657105, sdlog = 0.472380727077439),
    tolerance = testthat_tolerance()
  )
})

test_that("lnorm_meansd2meanlogsdlog fails as expected", {
  expect_error(
    lnorm_meansd2meanlogsdlog(mean = "1", sd = 0.5),
    regexp = paste0(
      "Assertion on 'mean' failed: Must be of type 'number',",
      " not 'character'."
    )
  )

  expect_error(
    lnorm_meansd2meanlogsdlog(mean = 1, sd = "0.5"),
    regexp = paste0(
      "Assertion on 'sd' failed: Must be of type 'number',",
      " not 'character'."
    )
  )

  expect_error(
    lnorm_meansd2meanlogsdlog(mean = -1, sd = 0.5),
    regexp = "Assertion on 'mean' failed: Element 1 is not >= 0."
  )

  expect_error(
    lnorm_meansd2meanlogsdlog(mean = 1, sd = -0.5),
    regexp = "Assertion on 'sd' failed: Element 1 is not >= 0."
  )
})

test_that("lnorm conversions go back to original values", {
  params_1 <- lnorm_meanlogsdlog2meansd(meanlog = 1, sdlog = 0.5)
  params_2 <- lnorm_meansd2meanlogsdlog(mean = params_1$mean, sd = params_1$sd)
  expect_equal(
    params_2,
    list(meanlog = 1, sdlog = 0.5),
    tolerance = testthat_tolerance()
  )

  params_1 <- lnorm_meansd2meanlogsdlog(mean = 2, sd = 1)
  params_2 <- lnorm_meanlogsdlog2meansd(
    meanlog = params_1$meanlog,
    sdlog = params_1$sdlog
  )
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

test_that("nbinom_meandisp2probdisp works as expected", {
  params <- nbinom_meandisp2probdisp(
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

test_that("nbinom_meandisp2probdisp fails as expected", {
  expect_error(
    nbinom_meandisp2probdisp(
      mean = "1",
      dispersion = 0.5
    ),
    regexp = paste0(
      "Assertion on 'mean' failed: Must be of type 'number',",
      " not 'character'."
    )
  )

  expect_error(
    nbinom_meandisp2probdisp(
      mean = 1,
      dispersion = "0.5"
    ),
    regexp = paste0(
      "Assertion on 'dispersion' failed: Must be of type 'number',",
      " not 'character'."
    )
  )
})

test_that("nbinom_probdisp2meandisp works as expected", {
  params <- nbinom_probdisp2meandisp(
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

test_that("nbinom_probdisp2meandisp fails as expected", {
  expect_error(
    nbinom_probdisp2meandisp(
      prob = "1",
      dispersion = 0.5
    ),
    regexp = paste0(
      "Assertion on 'prob' failed: Must be of type 'number',",
      " not 'character'."
    )
  )

  expect_error(
    nbinom_probdisp2meandisp(
      prob = 1,
      dispersion = "0.5"
    ),
    regexp = paste0(
      "Assertion on 'dispersion' failed: Must be of type 'number',",
      " not 'character'."
    )
  )
})

test_that("geom_mean2prob works as expected", {
  params <- geom_mean2prob(mean = 3)
  expect_type(params, "list")
  expect_named(params, "prob")
  expect_equal(
    params,
    list(prob = 0.25),
    tolerance = testthat_tolerance()
  )
})

test_that("geom_mean2prob fails as expected", {
  expect_error(
    geom_mean2prob(mean = "1"),
    regexp = paste0(
      "Assertion on 'mean' failed: Must be of type 'number',",
      " not 'character'."
    )
  )

  expect_error(
    geom_mean2prob(mean = -1),
    regexp = paste0(
      "Assertion on 'mean' failed: Element 1 is not >= 0."
    )
  )

  expect_error(
    geom_mean2prob(mean = Inf),
    regexp = paste0(
      "Assertion on 'mean' failed: Must be finite."
    )
  )
})

test_that("geom_prob2mean works as expected", {
  params <- geom_prob2mean(prob = 0.3)
  expect_type(params, "list")
  expect_named(params, "mean")
  expect_equal(
    params,
    list(mean = 2.33333333333333),
    tolerance = testthat_tolerance()
  )
})

test_that("geom_prob2mean fails as expected", {
  expect_error(
    geom_prob2mean(prob = "1"),
    regexp = paste0(
      "Assertion on 'prob' failed: Must be of type 'number',",
      " not 'character'."
    )
  )

  expect_error(
    geom_prob2mean(prob = -1),
    regexp = paste0(
      "Assertion on 'prob' failed: Element 1 is not >= 0."
    )
  )

  expect_error(
    geom_prob2mean(prob = 1.1),
    regexp = paste0(
      "Assertion on 'prob' failed: Element 1 is not <= 1."
    )
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

test_that("convert_lnorm_params works as expected", {
  summary_stats <- convert_lnorm_params(meanlog = 1, sdlog = 1)
  expect_length(summary_stats, 8)
  expect_named(
    summary_stats,
    c("mean", "median", "mode", "var", "sd", "cv", "skewness", "ex_kurtosis")
  )
  expect_equal(
    summary_stats,
    list(
      4.481689, 2.718282, 1.000000, 34.512613, 5.874744, 1.310832,
      6.184877, 110.936392
    ),
    ignore_attr = TRUE,
    tolerance = 1e-4
  )
})

test_that("convert_lnorm_params fails as expected", {
  expect_error(
    convert_lnorm_params(meanlog = "1", sdlog = 1),
    regexp = "(Assertion)*(failed)*(Must be of type)*(number)*(not)*(character)"
  )
  expect_error(
    convert_lnorm_params(meanlog = 1, sdlog = "1"),
    regexp = "(Assertion)*(failed)*(Must be of type)*(number)*(not)*(character)"
  )
})

test_that("convert_lnorm_summary_stats works as expected", {
  params <- convert_lnorm_summary_stats(mean = 1, sd = 1)
  expect_length(params, 2)
  expect_named(params, c("meanlog", "sdlog"))
  expect_equal(
    params,
    list(-0.3465736, 0.8325546),
    ignore_attr = TRUE,
    tolerance = 1e-4
  )
})

test_that("convert_lnorm_summary_stats works as expected using mean and cv", {
  params <- convert_lnorm_summary_stats(mean = 1, cv = 1)
  expect_length(params, 2)
  expect_named(params, c("meanlog", "sdlog"))
  expect_equal(
    params,
    list(-0.3465736, 0.8325546),
    ignore_attr = TRUE,
    tolerance = 1e-4
  )
})

test_that("convert_lnorm_summary_stats works as expected using median", {
  params <- convert_lnorm_summary_stats(median = 1, var = 1)
  expect_length(params, 2)
  expect_named(params, c("meanlog", "sdlog"))
  expect_equal(
    params,
    list(-0.3465736, 0.8325546),
    ignore_attr = TRUE,
    tolerance = 1e-4
  )
})

test_that("convert_lnorm_summary_stats fails as expected", {
  expect_error(
    convert_lnorm_summary_stats(mean = 1, ex_kurtosis = 1),
    regexp = "Cannot calculate lognormal parameters from given input"
  )
})

test_that("convert_gamma_params works as expected", {
  summary_stats <- convert_gamma_params(shape = 1, scale = 1)
  expect_length(summary_stats, 8)
  expect_named(
    summary_stats,
    c("mean", "median", "mode", "var", "sd", "cv", "skewness", "ex_kurtosis")
  )
  expect_equal(
    summary_stats,
    list(1, 0.6931472, 0, 1, 1, 1, 2, 6),
    ignore_attr = TRUE,
    tolerance = 1e-4
  )
})

test_that("convert_gamma_params fails as expected", {
  expect_error(
    convert_gamma_params(shape = "1", scale = 1),
    regexp = "(Assertion)*(failed)*(Must be of type)*(number)*(not)*(character)"
  )
  expect_error(
    convert_gamma_params(shape = 1, scale = "1"),
    regexp = "(Assertion)*(failed)*(Must be of type)*(number)*(not)*(character)"
  )
})

test_that("convert_gamma_summary_stats works as expected", {
  params <- convert_gamma_summary_stats(mean = 1, sd = 1)
  expect_length(params, 2)
  expect_named(params, c("shape", "scale"))
  expect_equal(
    params,
    list(1, 1),
    ignore_attr = TRUE,
    tolerance = 1e-4
  )
})

test_that("convert_gamma_summary_stats fails as expected", {
  expect_error(
    convert_gamma_summary_stats(mean = 1, ex_kurtosis = 1),
    regexp = "Cannot calculate gamma parameters from given input"
  )
})

test_that("convert_weibull_params works as expected", {
  summary_stats <- convert_weibull_params(shape = 1, scale = 1)
  expect_length(summary_stats, 8)
  expect_named(
    summary_stats,
    c("mean", "median", "mode", "var", "sd", "cv", "skewness", "ex_kurtosis")
  )
  expect_equal(
    summary_stats,
    list(1, 0.6931472, 0, 1, 1, 1, 2, 21),
    ignore_attr = TRUE,
    tolerance = 1e-4
  )
})

test_that("convert_weibull_params fails as expected", {
  expect_error(
    convert_weibull_params(shape = "1", scale = 1),
    regexp = "(Assertion)*(failed)*(Must be of type)*(number)*(not)*(character)"
  )
  expect_error(
    convert_weibull_params(shape = 1, scale = "1"),
    regexp = "(Assertion)*(failed)*(Must be of type)*(number)*(not)*(character)"
  )
})

test_that("convert_weibull_summary_stats works as expected", {
  params <- suppressMessages(convert_weibull_summary_stats(mean = 1, sd = 1))
  expect_length(params, 2)
  expect_named(params, c("shape", "scale"))
  expect_equal(
    params,
    list(1, 1),
    ignore_attr = TRUE,
    tolerance = 1e-4
  )
})

test_that("convert_weibull_summary_stats fails as expected", {
  expect_error(
    convert_weibull_summary_stats(median = 1, sd = 1),
    regexp = "Cannot calculate Weibull parameters from given input"
  )
})

test_that("convert_nbinom_params works as expected", {
  summary_stats <- convert_nbinom_params(prob = 0.5, dispersion = 0.5)
  expect_length(summary_stats, 8)
  expect_named(
    summary_stats,
    c("mean", "median", "mode", "var", "sd", "cv", "skewness", "ex_kurtosis")
  )
  expect_equal(
    summary_stats,
    list(0.50, 0.00, 0.00, 1.00, 1.00, 2.00, 3.00, 12.25),
    ignore_attr = TRUE,
    tolerance = 1e-4
  )
})

test_that("convert_nbinom_params fails as expected", {
  expect_error(
    convert_nbinom_params(prob = "1", dispersion = 1),
    regexp = "(Assertion)*(failed)*(Must be of type)*(number)*(not)*(character)"
  )
  expect_error(
    convert_nbinom_params(prob = 1, dispersion = "1"),
    regexp = "(Assertion)*(failed)*(Must be of type)*(number)*(not)*(character)"
  )
})

test_that("convert_nbinom_summary_stats works as expected", {
  params <- convert_nbinom_summary_stats(mean = 1, sd = 1.5)
  expect_length(params, 2)
  expect_named(params, c("prob", "dispersion"))
  expect_equal(
    params,
    list(0.4444444, 0.8),
    ignore_attr = TRUE,
    tolerance = 1e-4
  )
})

test_that("convert_nbinom_summary_stats fails as expected", {
  expect_error(
    convert_nbinom_summary_stats(median = 1, sd = 1),
    regexp = "(Cannot calculate negative binomial)*(from given input)"
  )

  expect_error(
    convert_nbinom_summary_stats(mean = 2, sd = 1),
    regexp = "(Negative binomial)*(variance-to-mean ratio of greater)"
  )
})

test_that("convert_geom_params works as expected", {
  summary_stats <- convert_geom_params(prob = 0.5)
  expect_length(summary_stats, 8)
  expect_named(
    summary_stats,
    c("mean", "median", "mode", "var", "sd", "cv", "skewness", "ex_kurtosis")
  )
  expect_equal(
    summary_stats,
    list(1, 0, 0, 2, 1.414214, 1.414214, 2.121320, 6.5),
    ignore_attr = TRUE,
    tolerance = 1e-4
  )
})

test_that("convert_geom_params fails as expected", {
  expect_error(
    convert_geom_params(prob = "1"),
    regexp = "(Assertion)*(failed)*(Must be of type)*(number)*(not)*(character)"
  )
})

test_that("convert_geom_summary_stats works as expected", {
  params <- convert_geom_summary_stats(mean = 1)
  expect_length(params, 1)
  expect_named(params, "prob")
  expect_equal(
    params,
    list(0.5),
    ignore_attr = TRUE,
    tolerance = 1e-4
  )
})

test_that("convert_geom_summary_stats fails as expected", {
  expect_error(
    convert_geom_summary_stats(mode = 1),
    regexp = "(Cannot calculate geometric)*(from given input)"
  )
})
