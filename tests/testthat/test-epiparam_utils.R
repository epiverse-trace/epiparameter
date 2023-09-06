test_that("as_epidist works as expected", {
  eparam <- epiparam()
  # suppress message about citation
  edist <- suppressMessages(as_epidist(x = eparam[12, ]))

  expect_s3_class(edist, "epidist")
})

test_that("as_epidist fails as expected when given invalidated epiparam", {
  eparam <- epiparam()
  # suppress message about returning data.frame
  suppressMessages(eparam$disease <- NULL) # nolint
  expect_error(
    as_epidist(x = eparam[12, ]),
    regexp = "Object should be of class epiparam"
  )
})

test_that("make_epidist works as expected for gamma", {
  # suppress message about citation
  edist <- suppressMessages(
    make_epidist(x = list(
      disease = "influenza",
      pathogen = "influenza-A-H1N1pdm",
      epi_distribution = "incubation_period",
      author = "Ghani_etal",
      title = "Incubation period of influenza",
      journal = "Journal of Epi",
      year = 2009,
      sample_size = 16,
      region = "UK",
      transmission_mode = "natural_human_to_human",
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
      quantile_2.5 = NA,
      quantile_5 = NA,
      quantile_25 = NA,
      median = NA,
      median_ci_limits = c(NA, NA),
      median_ci = NA,
      quantile_75 = NA,
      quantile_87.5 = NA,
      quantile_95 = NA,
      quantile_97.5 = NA,
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
  )

  expect_s3_class(edist, "epidist")
  expect_identical(family(edist), "gamma")
})

test_that("make_epidist works as expected for Weibull", {
  # suppress message about numerical approximation
  edist <- suppressMessages(make_epidist(x = list(
    disease = "influenza",
    pathogen = "influenza-A-H1N1pdm",
    epi_distribution = "incubation_period",
    author = "Ghani_etal",
    title = "Dynamics of H1N1pdm Influenza",
    journal = "PLoS Current",
    year = 2009,
    sample_size = 16,
    region = "UK",
    transmission_mode = "natural_human_to_human",
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
    quantile_2.5 = NA,
    quantile_5 = NA,
    quantile_25 = NA,
    median = NA,
    median_ci_limits = c(NA, NA),
    median_ci = NA,
    quantile_75 = NA,
    quantile_87.5 = NA,
    quantile_95 = NA,
    quantile_97.5 = NA,
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
  expect_identical(family(edist), "weibull")
})

test_that("make_epidist works as expected for lognormal", {
  edist <- suppressMessages(make_epidist(x = list(
    disease = "influenza",
    pathogen = "influenza-A-H1N1pdm",
    epi_distribution = "incubation_period",
    author = "Ghani_etal",
    title = "Dynamics of H1N1pdm Influenza",
    journal = "PLoS Current",
    year = 2009,
    sample_size = 16,
    region = "UK",
    transmission_mode = "natural_human_to_human",
    vector = NA,
    extrinsic = FALSE,
    prob_distribution = "lnorm",
    inference_method = "mle",
    mean = 2.05,
    mean_ci_limits = c(NA, NA),
    mean_ci = NA,
    sd = 0.49,
    sd_ci_limits = c(NA, NA),
    sd_ci = NA,
    quantile_2.5 = NA,
    quantile_5 = NA,
    quantile_25 = NA,
    median = NA,
    median_ci_limits = c(NA, NA),
    median_ci = NA,
    quantile_75 = NA,
    quantile_87.5 = NA,
    quantile_95 = NA,
    quantile_97.5 = NA,
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
  expect_identical(family(edist), "lnorm")
})

test_that("make_epidist works as expected for negative binomial", {
  # suppress message about citation
  edist <- suppressMessages(
    make_epidist(x = list(
      disease = "influenza",
      pathogen = NA,
      epi_distribution = "offspring_distribution",
      author = "Smith_etal",
      title = "Dynamics of H1N1pdm Influenza",
      journal = "PLoS Current",
      year = 2002,
      sample_size = 45,
      region = "UK",
      transmission_mode = "natural_human_to_human",
      vector = NA,
      extrinsic = FALSE,
      prob_distribution = "nbinom",
      inference_method = "mle",
      mean = 2.05,
      mean_ci_limits = c(NA, NA),
      mean_ci = NA,
      sd = NA,
      sd_ci_limits = c(NA, NA),
      sd_ci = NA,
      quantile_2.5 = NA,
      quantile_5 = NA,
      quantile_25 = NA,
      median = NA,
      median_ci_limits = c(NA, NA),
      median_ci = NA,
      quantile_75 = NA,
      quantile_87.5 = NA,
      quantile_95 = NA,
      quantile_97.5 = NA,
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
  )
  expect_s3_class(edist, "epidist")
  expect_identical(family(edist), "nbinom")
})

test_that("make_epidist works as expected for geometric", {
  # suppress message about citation
  edist <- suppressMessages(
    make_epidist(x = list(
      disease = "influenza",
      pathogen = NA,
      epi_distribution = "offspring_distribution",
      author = "Smith_etal",
      title = "Dynamics of H1N1pdm Influenza",
      journal = "PLoS Current",
      year = 2002,
      sample_size = 45,
      region = "UK",
      transmission_mode = "natural_human_to_human",
      vector = NA,
      extrinsic = FALSE,
      prob_distribution = "geom",
      inference_method = "mle",
      mean = 2.05,
      mean_ci_limits = c(NA, NA),
      mean_ci = NA,
      sd = NA,
      sd_ci_limits = c(NA, NA),
      sd_ci = NA,
      quantile_2.5 = NA,
      quantile_5 = NA,
      quantile_25 = NA,
      median = NA,
      median_ci_limits = c(NA, NA),
      median_ci = NA,
      quantile_75 = NA,
      quantile_87.5 = NA,
      quantile_95 = NA,
      quantile_97.5 = NA,
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
  )

  expect_s3_class(edist, "epidist")
  expect_identical(family(edist), "geom")
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
  eparam <- suppressMessages(dplyr::bind_cols(eparam, extra_col = NA_real_))
  # remove extra col
  eparam <- eparam[, -ncol(eparam)]

  expect_s3_class(eparam, "epiparam")
  expect_identical(ncol(eparam), 58L)
})

test_that("epiparam subsetting converts to data frame as expected", {
  eparam <- epiparam()
  expect_message(
    res <- eparam[, -1], # nolint
    regexp = "Removing crucial column in `<epiparam>` returning `<data.frame>`"
  )
  expect_s3_class(res, class = "data.frame")
})
