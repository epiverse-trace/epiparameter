edist <- suppressMessages(
  epidist(
    disease = "Ebola",
    epi_dist = "incubation period",
    prob_distribution = "lnorm",
    prob_distribution_params = c(meanlog = 1, sdlog = 1),
    summary_stats = create_epidist_summary_stats(mean = 1, sd = 1)
  )
)

test_that("convert_summary_stats_to_params.character works as expected", {
  expect_snapshot_value(
    convert_summary_stats_to_params("gamma", mean = 1, sd = 0.5),
    style = "json2"
  )
  expect_snapshot_value(
    suppressMessages(
      convert_summary_stats_to_params("weibull", mean = 0.5, cv = 1)
    ),
    style = "json2"
  )
  expect_snapshot_value(
    convert_summary_stats_to_params("lnorm", median = 1, sd = 1),
    style = "json2"
  )
  expect_snapshot_value(
    convert_summary_stats_to_params("nbinom", mean = 1, dispersion = 1),
    style = "json2"
  )
  expect_snapshot_value(
    convert_summary_stats_to_params("nbinom", mean = 1, sd = 1.5),
    style = "json2"
  )
  expect_snapshot_value(
    convert_summary_stats_to_params("geom", mean = 0.5),
    style = "json2"
  )
})

test_that("convert_summary_stats_to_params.character works with dyn-dots", {
  expect_identical(
    convert_summary_stats_to_params("gamma", mean = 1, sd = 0.5),
    convert_summary_stats_to_params("gamma", !!!list(mean = 1, sd = 0.5))
  )
})

test_that("convert_summary_stats_to_params.epidist works as expected", {
  expect_snapshot_value(
    convert_summary_stats_to_params(edist),
    style = "json2"
  )
})

test_that("convert_summary_stats_to_params.epidist warns as expected", {
  expect_warning(
    convert_summary_stats_to_params(edist, mean = 1, sd = 1),
    regexp = "One or more summary statistics in <epidist> are being overwritten"
  )
})

test_that("convert_summary_stats_to_params.character fails as expected", {
  expect_error(
    convert_summary_stats_to_params("random", mean = 1, sd = 1),
    regexp = "(arg)*(should be one of)*(lnorm)*(gamma)"
  )
  expect_error(
    convert_summary_stats_to_params("lnorm"),
    regexp = "Summary statistics need to be named and supplied to the function"
  )
  expect_error(
    convert_summary_stats_to_params("gamma", mean = -1, sd = 1),
    regexp = "(Assertion on)*(x$mean)*(failed: Element 1 is not >= 0.)"
  )
  expect_error(
    convert_summary_stats_to_params("lnorm", mode = 1, var = 1),
    regexp = "Cannot calculate lognormal parameters from given input"
  )
  expect_error(
    convert_summary_stats_to_params("gamma", mode = 1, var = 1),
    regexp = "Cannot calculate gamma parameters from given input"
  )
  expect_error(
    convert_summary_stats_to_params("weibull", mode = 1, var = 1),
    regexp = "Cannot calculate Weibull parameters from given input"
  )
  expect_error(
    convert_summary_stats_to_params("nbinom", mode = 1, var = 1),
    regexp = "(Cannot calculate negative binomial)*(parameters from)*(input)"
  )
  expect_error(
    convert_summary_stats_to_params("geom", mode = 1, var = 1),
    regexp = "(Cannot calculate geometric)*(parameter from given input)"
  )
  expect_error(
    convert_summary_stats_to_params("nbinom", mean = 1, var = 0.5),
    regexp = "(Negative binomial)*(variance-to-mean ratio)*(greater than one)"
  )
})

test_that("convert_summary_stats_to_params.epidist fails as expected", {
  edist$summary_stats <- list()
  expect_error(
    convert_summary_stats_to_params(edist),
    regexp = "Summary statistics need to be named and supplied to the function"
  )
})

test_that("convert_params_to_summary_stats.character works as expected", {
  expect_snapshot_value(
    convert_params_to_summary_stats("lnorm", meanlog = 1, sdlog = 0.5),
    style = "json2"
  )
  expect_snapshot_value(
    convert_params_to_summary_stats("nbinom", prob = 0.5, dispersion = 1),
    style = "json2"
  )
  expect_snapshot_value(
    convert_params_to_summary_stats("gamma", shape = 1, scale = 1),
    style = "json2"
  )
  expect_snapshot_value(
    convert_params_to_summary_stats("weibull", shape = 1, scale = 1),
    style = "json2"
  )
  expect_snapshot_value(
    convert_params_to_summary_stats("geom", prob = 0.5),
    style = "json2"
  )
})

test_that("convert_params_to_summary_stats.character works with dyn-dots", {
  expect_identical(
    convert_params_to_summary_stats("lnorm", meanlog = 1, sdlog = 0.5),
    convert_params_to_summary_stats("lnorm", !!!list(meanlog = 1, sdlog = 0.5))
  )
})

test_that("convert_params_to_summary_stats.epidist works as expected", {
  expect_snapshot_value(
    convert_params_to_summary_stats(edist),
    style = "json2"
  )
  edist <- "lnorm"
  expect_snapshot_value(
    convert_params_to_summary_stats(edist, meanlog = 1, sdlog = 1),
    style = "json2"
  )
})

test_that("convert_params_to_summary_stats.epidist warns as expected", {
  expect_warning(
    convert_params_to_summary_stats(edist, meanlog = 1, sdlog = 1),
    regexp = "One or more parameters in <epidist> are being overwritten"
  )
})

test_that("convert_params_to_summary_stats.character fails as expected", {
  expect_error(
    convert_params_to_summary_stats("random", shape = 1, scale = 1),
    regexp = "(arg)*(should be one of)*(lnorm)*(gamma)"
  )
  expect_error(
    convert_params_to_summary_stats("lnorm"),
    regexp = "(Parameter(s) need to be named and supplied)*(to the function)"
  )
  expect_error(
    convert_params_to_summary_stats("gamma", shape = -1, scale = 1),
    regexp = "(Assertion on)*(shape)*(failed: Element 1 is not >= 0.)"
  )
  expect_error(
    convert_params_to_summary_stats("lnorm", shape = 1, scale = 1),
    regexp = "(lnorm parameters must be named)*(meanlog)*(sdlog)"
  )
  expect_error(
    convert_params_to_summary_stats("gamma", meanlog = 1, scale = 1),
    regexp = "(gamma parameters must be named)*(shape)*(scale)"
  )
  expect_error(
    convert_params_to_summary_stats("weibull", meanlog = 1, scale = 1),
    regexp = "(weibull parameters must be named)*(shape)*(scale)"
  )
  expect_error(
    convert_params_to_summary_stats(
      "nbinom", probability = 0.5, dispersion = 1
    ),
    regexp = "(nbinom parameters must be named)*(prob)*(dispersion)"
  )
  expect_error(
    convert_params_to_summary_stats("geom", probability = 0.5),
    regexp = "(geom parameter must be named)*(prob)"
  )
})

test_that("convert_params_to_summary_stats.epidist fails as expected", {
  edist$prob_dist <- "lnorm"
  expect_error(
    convert_params_to_summary_stats(edist),
    regexp = "<epidist> supplied has no parameters and none are suppled"
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
