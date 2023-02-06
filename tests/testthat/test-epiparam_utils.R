test_that("as_epidist works as expected", {
  eparam <- epiparam()
  edist <- as_epidist(x = eparam[12, ])

  expect_s3_class(edist, "epidist")
})

test_that("as_epidist fails as expected", {
  eparam <- epiparam()
  eparam$disease <- NULL
  expect_error(
    as_epidist(x = eparam[12, ]),
    regexp = "epiparam object does not contain the correct columns"
  )
})

test_that("make_epidist works as expected for gamma", {

  edist <- make_epidist(x = list(
    disease = "influenza",
    pathogen = "influenza-A-H1N1pdm",
    epi_distribution = "incubation_period",
    author = "Ghani_etal",
    year = 2009,
    sample_size = 16,
    region = "UK",
    vector_borne = FALSE,
    vector = NA,
    extrinsic = FALSE,
    prob_distribution = "gamma",
    inference_method = "mle",
    mean = 2.05,
    mean_ci_limits = c(NA, NA),
    mean_ci = NA,
    sd = 0.49,
    sd_ci_limits = c(NA, NA),
    sd_ci = NA,
    quantile_025 = NA,
    quantile_05 = NA,
    quantile_25 = NA,
    median = NA,
    median_ci_limits = c(NA, NA),
    median_ci = NA,
    quantile_75 = NA,
    quantile_875 = NA,
    quantile_95 = NA,
    quantile_975 = NA,
    lower_range = NA,
    upper_range = NA,
    shape = NA,
    shape_ci_limits = c(NA, NA),
    shape_ci = NA,
    scale = NA,
    scale_ci_limits = c(NA, NA),
    scale_ci = NA,
    meanlog = NA,
    meanlog_ci_limits = c(NA, NA),
    meanlog_ci = NA,
    sdlog = NA,
    sdlog_ci_limits = c(NA, NA),
    sdlog_ci = NA,
    dispersion = NA,
    dispersion_ci_limits = c(NA, NA),
    dispersion_ci = NA,
    precision = NA,
    precision_ci_limits = c(NA, NA),
    precision_ci = NA,
    truncation = NA,
    discretised = FALSE,
    censored = NA,
    right_truncated = NA,
    phase_bias_adjusted = NA,
    notes = "",
    PMID = 20029668,
    DOI = "10.1371/currents.RRN1130" # nolint
  ))

  expect_s3_class(edist, "epidist")
  expect_identical(stats::family(edist$prob_dist), "gamma")
})

test_that("make_epidist works as expected for weibull", {
  # suppress message about numerical approximation
  edist <- suppressMessages(make_epidist(x = list(
    disease = "influenza",
    pathogen = "influenza-A-H1N1pdm",
    epi_distribution = "incubation_period",
    author = "Ghani_etal",
    year = 2009,
    sample_size = 16,
    region = "UK",
    vector_borne = FALSE,
    vector = NA,
    extrinsic = FALSE,
    prob_distribution = "weibull",
    inference_method = "mle",
    mean = 2.05,
    mean_ci_limits = c(NA, NA),
    mean_ci = NA,
    sd = 0.49,
    sd_ci_limits = c(NA, NA),
    sd_ci = NA,
    quantile_025 = NA,
    quantile_05 = NA,
    quantile_25 = NA,
    median = NA,
    median_ci_limits = c(NA, NA),
    median_ci = NA,
    quantile_75 = NA,
    quantile_875 = NA,
    quantile_95 = NA,
    quantile_975 = NA,
    lower_range = NA,
    upper_range = NA,
    shape = NA,
    shape_ci_limits = c(NA, NA),
    shape_ci = NA,
    scale = NA,
    scale_ci_limits = c(NA, NA),
    scale_ci = NA,
    meanlog = NA,
    meanlog_ci_limits = c(NA, NA),
    meanlog_ci = NA,
    sdlog = NA,
    sdlog_ci_limits = c(NA, NA),
    sdlog_ci = NA,
    dispersion = NA,
    dispersion_ci_limits = c(NA, NA),
    dispersion_ci = NA,
    precision = NA,
    precision_ci_limits = c(NA, NA),
    precision_ci = NA,
    truncation = NA,
    discretised = FALSE,
    censored = NA,
    right_truncated = NA,
    phase_bias_adjusted = NA,
    notes = "",
    PMID = 20029668,
    DOI = "10.1371/currents.RRN1130" # nolint
  )))

  expect_s3_class(edist, "epidist")
  expect_identical(stats::family(edist$prob_dist), "weibull")
})

test_that("make_epidist works as expected for lognormal", {
  edist <- suppressMessages(make_epidist(x = list(
    disease = "influenza",
    pathogen = "influenza-A-H1N1pdm",
    epi_distribution = "incubation_period",
    author = "Ghani_etal",
    year = 2009,
    sample_size = 16,
    region = "UK",
    vector_borne = FALSE,
    vector = NA,
    extrinsic = FALSE,
    prob_distribution = "lognormal",
    inference_method = "mle",
    mean = 2.05,
    mean_ci_limits = c(NA, NA),
    mean_ci = NA,
    sd = 0.49,
    sd_ci_limits = c(NA, NA),
    sd_ci = NA,
    quantile_025 = NA,
    quantile_05 = NA,
    quantile_25 = NA,
    median = NA,
    median_ci_limits = c(NA, NA),
    median_ci = NA,
    quantile_75 = NA,
    quantile_875 = NA,
    quantile_95 = NA,
    quantile_975 = NA,
    lower_range = NA,
    upper_range = NA,
    shape = NA,
    shape_ci_limits = c(NA, NA),
    shape_ci = NA,
    scale = NA,
    scale_ci_limits = c(NA, NA),
    scale_ci = NA,
    meanlog = NA,
    meanlog_ci_limits = c(NA, NA),
    meanlog_ci = NA,
    sdlog = NA,
    sdlog_ci_limits = c(NA, NA),
    sdlog_ci = NA,
    dispersion = NA,
    dispersion_ci_limits = c(NA, NA),
    dispersion_ci = NA,
    precision = NA,
    precision_ci_limits = c(NA, NA),
    precision_ci = NA,
    truncation = NA,
    discretised = FALSE,
    censored = NA,
    right_truncated = NA,
    phase_bias_adjusted = NA,
    notes = "",
    PMID = 20029668,
    DOI = "10.1371/currents.RRN1130" # nolint
  )))

  expect_s3_class(edist, "epidist")
  expect_identical(stats::family(edist$prob_dist), "lognormal")
})

test_that("make_epidist works as expected for negative binomial", {

  edist <- make_epidist(x = list(
    disease = "influenza",
    pathogen = NA,
    epi_distribution = "offspring_distribution",
    author = "Smith_etal",
    year = 2002,
    sample_size = 45,
    region = "UK",
    vector_borne = FALSE,
    vector = NA,
    extrinsic = FALSE,
    prob_distribution = "negative_binomial",
    inference_method = "mle",
    mean = 2.05,
    mean_ci_limits = c(NA, NA),
    mean_ci = NA,
    sd = NA,
    sd_ci_limits = c(NA, NA),
    sd_ci = NA,
    quantile_025 = NA,
    quantile_05 = NA,
    quantile_25 = NA,
    median = NA,
    median_ci_limits = c(NA, NA),
    median_ci = NA,
    quantile_75 = NA,
    quantile_875 = NA,
    quantile_95 = NA,
    quantile_975 = NA,
    lower_range = NA,
    upper_range = NA,
    shape = NA,
    shape_ci_limits = c(NA, NA),
    shape_ci = NA,
    scale = NA,
    scale_ci_limits = c(NA, NA),
    scale_ci = NA,
    meanlog = NA,
    meanlog_ci_limits = c(NA, NA),
    meanlog_ci = NA,
    sdlog = NA,
    sdlog_ci_limits = c(NA, NA),
    sdlog_ci = NA,
    dispersion = 0.6,
    dispersion_ci_limits = c(NA, NA),
    dispersion_ci = NA,
    precision = NA,
    precision_ci_limits = c(NA, NA),
    precision_ci = NA,
    truncation = NA,
    discretised = FALSE,
    censored = NA,
    right_truncated = NA,
    phase_bias_adjusted = NA,
    notes = "",
    PMID = NA,
    DOI = "10.4824/216536228" # nolint
  ))

  expect_s3_class(edist, "epidist")
  expect_identical(stats::family(edist$prob_dist), "negbin")
})

test_that("make_epidist works as expected for geometric", {

  edist <- make_epidist(x = list(
    disease = "influenza",
    pathogen = NA,
    epi_distribution = "offspring_distribution",
    author = "Smith_etal",
    year = 2002,
    sample_size = 45,
    region = "UK",
    vector_borne = FALSE,
    vector = NA,
    extrinsic = FALSE,
    prob_distribution = "geometric",
    inference_method = "mle",
    mean = 2.05,
    mean_ci_limits = c(NA, NA),
    mean_ci = NA,
    sd = NA,
    sd_ci_limits = c(NA, NA),
    sd_ci = NA,
    quantile_025 = NA,
    quantile_05 = NA,
    quantile_25 = NA,
    median = NA,
    median_ci_limits = c(NA, NA),
    median_ci = NA,
    quantile_75 = NA,
    quantile_875 = NA,
    quantile_95 = NA,
    quantile_975 = NA,
    lower_range = NA,
    upper_range = NA,
    shape = NA,
    shape_ci_limits = c(NA, NA),
    shape_ci = NA,
    scale = NA,
    scale_ci_limits = c(NA, NA),
    scale_ci = NA,
    meanlog = NA,
    meanlog_ci_limits = c(NA, NA),
    meanlog_ci = NA,
    sdlog = NA,
    sdlog_ci_limits = c(NA, NA),
    sdlog_ci = NA,
    dispersion = NA,
    dispersion_ci_limits = c(NA, NA),
    dispersion_ci = NA,
    precision = NA,
    precision_ci_limits = c(NA, NA),
    precision_ci = NA,
    truncation = NA,
    discretised = FALSE,
    censored = NA,
    right_truncated = NA,
    phase_bias_adjusted = NA,
    notes = "",
    PMID = NA,
    DOI = "10.4824/216536228" # nolint
  ))

  expect_s3_class(edist, "epidist")
  expect_identical(stats::family(edist$prob_dist), "geometric")
})

test_that("as_epiparam works as expected", {
  # suppress message about citation
  edist <- suppressMessages(epidist(
    disease = "ebola",
    epi_dist = "incubation_period",
    prob_distribution = "gamma",
    prob_distribution_params = c(shape = 1, scale = 1)
  ))
  eparam <- as_epiparam(x = edist)

  expect_s3_class(eparam, "epiparam")
  expect_identical(nrow(eparam), 1L)
})

test_that("as_epiparam fails as expected", {
  # suppress message about citation
  edist <- suppressMessages(epidist(
    disease = "ebola",
    epi_dist = "incubation_period",
    prob_distribution = "gamma",
    prob_distribution_params = c(shape = 1, scale = 1)
  ))
  edist$disease <- NULL
  expect_error(
    as_epiparam(x = edist),
    regexp = "epidist object does not contain the correct attributes"
  )
})

test_that("epiparam subsetting works as expected", {
  eparam <- epiparam()
  eparam <- eparam[, -2]

  expect_s3_class(eparam, "epiparam")
  expect_identical(ncol(eparam), 55L)
})

test_that("epiparam subsetting fails as expected", {
  eparam <- epiparam()
  expect_error(
    eparam[, -1],
    regexp = "epiparam object does not contain the correct columns"
  )
})
