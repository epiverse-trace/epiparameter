test_that("epidist works with minimal viable input", {
  # message about missing citation suppressed
  ebola_dist <- suppressMessages(epidist(
    disease = "ebola",
    epi_dist = "incubation",
    prob_distribution = "gamma",
    prob_distribution_params = c(shape = 1, scale = 1)
  ))

  expect_s3_class(ebola_dist, class = "epidist")
  expect_length(ebola_dist, 9)
})

test_that("epidist works with all arguments set", {
  # suppress message about citation
  mers_dist <- suppressMessages(
    epidist(
      disease = "MERS",
      pathogen = "MERS_CoV",
      epi_dist = "serial_interval",
      prob_distribution = "lnorm",
      prob_distribution_params = c(meanlog = 2, sdlog = 1),
      uncertainty = list(
        meanlog = create_epidist_uncertainty(
          ci_limits = c(1, 3),
          ci = 95,
          ci_type = "confidence interval"
        ),
        sdlog = create_epidist_uncertainty(
          ci_limits = c(0.1, 1.9),
          ci = 95,
          ci_type = "confidence interval"
        )
      ),
      summary_stats = create_epidist_summary_stats(
        mean = 1,
        mean_ci_limits = c(0.8, 1.2),
        mean_ci = 95,
        sd = 0.5,
        sd_ci_limits = c(0.4, 0.6),
        sd_ci = 95,
        median = 1,
        median_ci_limits = c(0.9, 1.1),
        median_ci = 95,
        lower_range = 0.1,
        upper_range = 1.9,
        quantiles = c(
          "2.5" = 0.2, "5" = 0.3, "25" = 0.5, "75" = 0.7, "87.5" = 1.1,
          "95" = 1.2, "97.5" = 1.5
        )
      ), citation = create_epidist_citation(
        author = person(given = "John", family = "Smith"),
        year = 2002,
        title = "A title",
        journal = "A journal",
        DOI = "10.23271/176237.x", # nolint
        PMID = 28372882
      ),
      metadata = create_epidist_metadata(
        sample_size = 100,
        region = "UK",
        transmission_mode = "vector_borne",
        vector = NA,
        extrinsic = FALSE,
        inference_method = "MLE"
      ),
      method_assess = create_epidist_method_assess(
        censored = TRUE,
        right_truncated = FALSE,
        phase_bias_adjusted = FALSE
      ),
      discretise = FALSE,
      truncation = NA_real_,
      notes = "No notes"
    )
  )
  expect_s3_class(mers_dist, class = "epidist")
  expect_length(mers_dist, 9)
})

test_that("epidist works with default helper functions", {
  # message about missing citation suppressed
  sars_dist <- suppressMessages(epidist(
    disease = "SARS",
    pathogen = "SARS_CoV",
    epi_dist = "onset_to_death",
    prob_distribution = "lnorm",
    prob_distribution_params = c(meanlog = 2, sdlog = 1),
    uncertainty = create_epidist_uncertainty(),
    summary_stats = create_epidist_summary_stats(),
    citation = create_epidist_citation(),
    metadata = create_epidist_metadata(),
    method_assess = create_epidist_method_assess(),
    discretise = FALSE,
    truncation = NA,
    notes = "No notes"
  ))

  expect_s3_class(sars_dist, class = "epidist")
  expect_length(sars_dist, 9)
})

test_that("epidist fails as expected", {
  expect_error(
    epidist(
      disease = 1,
      epi_dist = "incubation",
      prob_distribution = "gamma",
      prob_distribution_params = c(shape = 1, scale = 1)
    ),
    regexp = paste0(
      "Assertion on 'disease' failed: Must be of type ",
      "'string', not 'double'."
    )
  )

  expect_error(
    epidist(
      disease = "ebola",
      epi_dist = 1,
      prob_distribution = "gamma",
      prob_distribution_params = c(shape = 1, scale = 1)
    ),
    regexp = paste0(
      "Assertion on 'epi_dist' failed: Must be of type ",
      "'string', not 'double'."
    )
  )

  expect_error(
    epidist(
      disease = "ebola",
      epi_dist = "incubation",
      prob_distribution = 1,
      prob_distribution_params = c(shape = 1, scale = 1)
    ),
    regexp = paste0(
      "(Assertion on 'prob_distribution' failed)*(Must be of type)*",
      "(character)*(NULL)*(double)"
    )
  )

  expect_error(
    # message about missing citation suppressed
    suppressMessages(
      epidist(
        disease = "ebola",
        epi_dist = "incubation",
        prob_distribution = "gamma",
        prob_distribution_params = c(shape = "NA", scale = 1)
      ),
      regexp = paste0(
        "(Assertion on 'prob_distribution_params' failed)*(Must be of type)*",
        "(numeric)*(NULL)*(character)."
      )
    )
  )
})

test_that("epidist.print works as expected", {
  expect_snapshot(epidist(
    disease = "ebola",
    epi_dist = "incubation",
    prob_distribution = "gamma",
    prob_distribution_params = c(shape = 1, scale = 1)
  ))
})

test_that("epidist.print works as expected", {
  expect_snapshot(epidist(
    disease = "ebola",
    epi_dist = "incubation",
    prob_distribution = "gamma",
    prob_distribution_params = c(shape = 1, scale = 1),
    discretise = TRUE
  ))
})

test_that("epidist.plot does not produce an error", {
  ebola_dist <- suppressMessages(epidist(
    disease = "ebola",
    epi_dist = "incubation",
    prob_distribution = "gamma",
    prob_distribution_params = c(shape = 1, scale = 1)
  ))


  expect_silent(plot(ebola_dist))

  f <- function() plot(ebola_dist)
  vdiffr::expect_doppelganger(
    title = "epidist.plot",
    fig = f
  )
})

test_that("epidist.plot works with non-default day_range", {
  ebola_dist <- suppressMessages(epidist(
    disease = "ebola",
    epi_dist = "incubation",
    prob_distribution = "gamma",
    prob_distribution_params = c(shape = 1, scale = 1)
  ))

  expect_silent(
    plot(
      ebola_dist,
      day_range = 0:20
    )
  )

  f <- function() {
    plot(
      ebola_dist,
      day_range = 0:20
    )
  }
  vdiffr::expect_doppelganger(
    title = "epidist.plot non-default range",
    fig = f
  )
})

test_that("new_epidist works with minimal viable input", {
  epidist_obj <- suppressMessages(
    new_epidist(
      disease = list(
        disease = "ebola",
        pathogen = "ebola_virus"
      ),
      epi_dist = "incubation",
      prob_dist = "gamma",
      prob_dist_params = c(shape = 1, scale = 1),
      uncertainty = list(
        shape = create_epidist_uncertainty(
          ci_limits = c(0, 2),
          ci = 95,
          ci_type = "confidence interval"
        ),
        scale = create_epidist_uncertainty(
          ci_limits = c(0, 2),
          ci = 95,
          ci_type = "confidence interval"
        )
      ),
      citation = create_epidist_citation(
        author = person(given = "John", family = "Smith"),
        year = 2002,
        title = "Ebola incubation",
        journal = "Journal of Epi"
      ),
      discretise = FALSE,
      truncation = NA,
      notes = "No notes"
    )
  )

  expect_s3_class(epidist_obj, class = "epidist")
  expect_length(epidist_obj, 9)
  expect_s3_class(validate_epidist(epidist_obj), class = "epidist")
})

test_that("validate_epidist passes when expected", {
  epidist_obj <- suppressMessages(
    new_epidist(
      disease = list(
        disease = "ebola",
        pathogen = "ebola_virus"
      ),
      epi_dist = "incubation",
      prob_dist = "gamma",
      prob_dist_params = c(shape = 1, scale = 1),
      uncertainty = list(
        shape = create_epidist_uncertainty(
          ci_limits = c(0, 2),
          ci = 95,
          ci_type = "confidence interval"
        ),
        scale = create_epidist_uncertainty(
          ci_limits = c(0, 2),
          ci = 95,
          ci_type = "confidence interval"
        )
      ),
      citation = create_epidist_citation(
        author = person(given = "John", family = "Smith"),
        year = 2000,
        title = "Ebola incubation",
        journal = "Journal of Epi",
        DOI = "10.1872372hc"
      ),
      discretise = FALSE,
      truncation = NA,
      notes = "No notes"
    )
  )

  expect_silent(validate_epidist(epidist = epidist_obj))
})

test_that("validate_epidist catches class faults when expected", {
  epidist_obj <- new_epidist(
    disease = list(
      disease = "ebola",
      pathogen = "ebola_virus"
    ),
    epi_dist = "incubation",
    prob_dist = "gamma",
    prob_dist_params = c(shape = 1, scale = 1),
    uncertainty = list(
      shape = create_epidist_uncertainty(
        ci_limits = c(0, 2),
        ci = 95,
        ci_type = "confidence interval"
      ),
      scale = create_epidist_uncertainty(
        ci_limits = c(0, 2),
        ci = 95,
        ci_type = "confidence interval"
      )
    ),
    citation = "Smith (2002) <10.128372837>",
    discretise = FALSE,
    truncation = NA
  )

  epidist_obj$disease <- NULL

  expect_error(
    validate_epidist(epidist = epidist_obj),
    regexp = "epidist object does not contain the correct attributes"
  )

  epidist_obj <- new_epidist(
    disease = list(
      disease = "ebola",
      pathogen = "ebola_virus"
    ),
    epi_dist = "incubation",
    prob_dist = "gamma",
    prob_dist_params = c(shape = 1, scale = 1),
    uncertainty = list(
      shape = create_epidist_uncertainty(
        ci_limits = c(0, 2),
        ci = 95,
        ci_type = "confidence interval"
      ),
      scale = create_epidist_uncertainty(
        ci_limits = c(0, 2),
        ci = 95,
        ci_type = "confidence interval"
      )
    ),
    citation = "Smith (2002) <10.128372837>",
    discretise = FALSE,
    truncation = NA
  )

  epidist_obj$disease$disease <- NULL

  expect_error(
    validate_epidist(epidist = epidist_obj),
    regexp = "(epidist must contain a disease)"
  )

  epidist_obj <- new_epidist(
    disease = list(
      disease = "ebola",
      pathogen = "ebola_virus"
    ),
    epi_dist = "incubation",
    prob_dist = "gamma",
    prob_dist_params = c(shape = 1, scale = 1),
    uncertainty = list(
      shape = create_epidist_uncertainty(
        ci_limits = c(0, 2),
        ci = 95,
        ci_type = "confidence interval"
      ),
      scale = create_epidist_uncertainty(
        ci_limits = c(0, 2),
        ci = 95,
        ci_type = "confidence interval"
      )
    ),
    citation = "Smith (2002) <10.128372837>",
    discretise = FALSE,
    truncation = NA
  )

  epidist_obj$epi_dist <- c("incubation", "period")

  expect_error(
    validate_epidist(epidist = epidist_obj),
    regexp = "epidist must contain an epidemiological distribution"
  )
})

test_that("validate_epidist fails as expected with input class", {
  expect_error(
    validate_epidist(epidist = 1),
    regexp = "Object should be of class epidist"
  )
})

test_that("density works as expected on continuous epidist object", {
  ebola_dist <- suppressMessages(
    epidist(
      disease = "ebola",
      epi_dist = "incubation_period",
      prob_distribution = "gamma",
      prob_distribution_params = c(shape = 1, scale = 1)
    )
  )

  res <- stats::density(ebola_dist, at = 0.5)
  expect_length(res, 1)
  expect_type(res, "double")
  expect_gte(res, 0)

  res <- stats::density(ebola_dist, at = 0)
  expect_length(res, 1)
  expect_type(res, "double")
  expect_gte(res, 0)

  res <- stats::density(ebola_dist, at = 1.5)
  expect_length(res, 1)
  expect_type(res, "double")
  expect_gte(res, 0)

  res <- stats::density(ebola_dist, at = 10)
  expect_length(res, 1)
  expect_type(res, "double")
  expect_gte(res, 0)
})

test_that("density works as expected on discrete epidist object", {
  ebola_dist <- suppressMessages(
    epidist(
      disease = "ebola",
      epi_dist = "incubation_period",
      prob_distribution = "gamma",
      prob_distribution_params = c(shape = 1, scale = 1),
      discretise = TRUE
    )
  )

  res <- stats::density(ebola_dist, at = 0.5)
  expect_length(res, 1)
  expect_type(res, "double")
  expect_gte(res, 0)

  res <- stats::density(ebola_dist, at = 0)
  expect_length(res, 1)
  expect_type(res, "double")
  expect_gte(res, 0)

  res <- stats::density(ebola_dist, at = 1.5)
  expect_length(res, 1)
  expect_type(res, "double")
  expect_gte(res, 0)

  res <- stats::density(ebola_dist, at = 10)
  expect_length(res, 1)
  expect_type(res, "double")
  expect_gte(res, 0)
})

test_that("density works as expected on continuous epidist object with vector
          input", {
  ebola_dist <- suppressMessages(
    epidist(
      disease = "ebola",
      epi_dist = "incubation_period",
      prob_distribution = "gamma",
      prob_distribution_params = c(shape = 1, scale = 1)
    )
  )

  res <- stats::density(ebola_dist, at = seq(0.1, 0.9, by = 0.1))
  expect_length(res, 9)
  expect_type(res, "double")
  expect_true(all(res >= 0))
})

test_that("density works as expected on discrete epidist object with vector
          input", {
  ebola_dist <- suppressMessages(
    epidist(
      disease = "ebola",
      epi_dist = "incubation_period",
      prob_distribution = "gamma",
      prob_distribution_params = c(shape = 1, scale = 1),
      discretise = TRUE
    )
  )

  res <- stats::density(ebola_dist, at = seq(0.1, 0.9, by = 0.1))
  expect_length(res, 9)
  expect_type(res, "double")
  expect_true(all(res >= 0))
})

test_that("cdf works as expected on continuous epidist object", {
  ebola_dist <- suppressMessages(
    epidist(
      disease = "ebola",
      epi_dist = "incubation_period",
      prob_distribution = "gamma",
      prob_distribution_params = c(shape = 1, scale = 1)
    )
  )

  res <- distributional::cdf(ebola_dist, q = 0.5)
  expect_length(res, 1)
  expect_type(res, "double")
  expect_gte(res, 0)
  expect_lte(res, 1)

  res <- distributional::cdf(ebola_dist, q = 0)
  expect_length(res, 1)
  expect_type(res, "double")
  expect_gte(res, 0)
  expect_lte(res, 1)

  res <- distributional::cdf(ebola_dist, q = 1.5)
  expect_length(res, 1)
  expect_type(res, "double")
  expect_gte(res, 0)
  expect_lte(res, 1)

  res <- distributional::cdf(ebola_dist, q = 10)
  expect_length(res, 1)
  expect_type(res, "double")
  expect_gte(res, 0)
  expect_lte(res, 1)
})

test_that("cdf works as expected on discrete epidist object", {
  ebola_dist <- suppressMessages(
    epidist(
      disease = "ebola",
      epi_dist = "incubation_period",
      prob_distribution = "gamma",
      prob_distribution_params = c(shape = 1, scale = 1),
      discretise = TRUE
    )
  )

  res <- distributional::cdf(ebola_dist, q = 0.5)
  expect_length(res, 1)
  expect_type(res, "double")
  expect_gte(res, 0)
  expect_lte(res, 1)

  res <- distributional::cdf(ebola_dist, q = 0)
  expect_length(res, 1)
  expect_type(res, "double")
  expect_gte(res, 0)
  expect_lte(res, 1)

  res <- distributional::cdf(ebola_dist, q = 1.5)
  expect_length(res, 1)
  expect_type(res, "double")
  expect_gte(res, 0)
  expect_lte(res, 1)

  res <- distributional::cdf(ebola_dist, q = 10)
  expect_length(res, 1)
  expect_type(res, "double")
  expect_gte(res, 0)
  expect_lte(res, 1)
})

test_that("cdf works as expected on continuous epidist object with vector
          input", {
  ebola_dist <- suppressMessages(
    epidist(
      disease = "ebola",
      epi_dist = "incubation_period",
      prob_distribution = "gamma",
      prob_distribution_params = c(shape = 1, scale = 1)
    )
  )

  res <- distributional::cdf(ebola_dist, q = seq(0.1, 0.9, by = 0.1))
  expect_length(res, 9)
  expect_type(res, "double")
  expect_true(all(res >= 0))
  expect_true(all(res <= 1))
})

test_that("cdf works as expected on discrete epidist object with vector
          input", {
  ebola_dist <- suppressMessages(
    epidist(
      disease = "ebola",
      epi_dist = "incubation_period",
      prob_distribution = "gamma",
      prob_distribution_params = c(shape = 1, scale = 1),
      discretise = TRUE
    )
  )

  res <- distributional::cdf(ebola_dist, q = seq(0.1, 0.9, by = 0.1))
  expect_length(res, 9)
  expect_type(res, "double")
  expect_true(all(res >= 0))
  expect_true(all(res <= 1))
})

test_that("quantile works as expected on continuous epidist object", {
  ebola_dist <- suppressMessages(
    epidist(
      disease = "ebola",
      epi_dist = "incubation_period",
      prob_distribution = "gamma",
      prob_distribution_params = c(shape = 1, scale = 1)
    )
  )

  res <- quantile(ebola_dist, p = 0.5)
  expect_length(res, 1)
  expect_type(res, "double")
  expect_gte(res, 0)

  res <- quantile(ebola_dist, p = 0)
  expect_length(res, 1)
  expect_type(res, "double")
  expect_gte(res, 0)

  res <- quantile(ebola_dist, p = 1)
  expect_length(res, 1)
  expect_type(res, "double")
  expect_gte(res, 0)
})

test_that("quantile works as expected on discrete epidist object", {
  ebola_dist <- suppressMessages(
    epidist(
      disease = "ebola",
      epi_dist = "incubation_period",
      prob_distribution = "gamma",
      prob_distribution_params = c(shape = 1, scale = 1),
      discretise = TRUE
    )
  )

  res <- quantile(ebola_dist, p = 0.5)
  expect_length(res, 1)
  expect_type(res, "double")
  expect_gte(res, 0)

  res <- quantile(ebola_dist, p = 0)
  expect_length(res, 1)
  expect_type(res, "double")
  expect_gte(res, 0)

  res <- quantile(ebola_dist, p = 1)
  expect_length(res, 1)
  expect_type(res, "double")
  expect_gte(res, 0)
})

test_that("quantile works as expected on continuous epidist object with vector
          input", {
  ebola_dist <- suppressMessages(
    epidist(
      disease = "ebola",
      epi_dist = "incubation_period",
      prob_distribution = "gamma",
      prob_distribution_params = c(shape = 1, scale = 1)
    )
  )

  res <- quantile(ebola_dist, p = seq(0.1, 0.9, by = 0.1))
  expect_length(res, 9)
  expect_type(res, "double")
  expect_true(all(res >= 0))
})

test_that("quantile works as expected on discrete epidist object with vector
          input", {
  ebola_dist <- suppressMessages(
    epidist(
      disease = "ebola",
      epi_dist = "incubation_period",
      prob_distribution = "gamma",
      prob_distribution_params = c(shape = 1, scale = 1),
      discretise = TRUE
    )
  )

  res <- quantile(ebola_dist, p = seq(0.1, 0.9, by = 0.1))
  expect_length(res, 9)
  expect_type(res, "double")
  expect_true(all(res >= 0))
})

test_that("generate works as expected on continuous epidist object", {
  ebola_dist <- suppressMessages(
    epidist(
      disease = "ebola",
      epi_dist = "incubation_period",
      prob_distribution = "gamma",
      prob_distribution_params = c(shape = 1, scale = 1)
    )
  )

  res <- distributional::generate(ebola_dist, times = 1)
  expect_length(res, 1)
  expect_type(res, "double")
  expect_gte(res, 0)

  res <- distributional::generate(ebola_dist, times = 10)
  expect_length(res, 10)
  expect_type(res, "double")
  expect_true(all(res >= 0))
})

test_that("generate works as expected on discrete epidist object", {
  ebola_dist <- suppressMessages(
    epidist(
      disease = "ebola",
      epi_dist = "incubation_period",
      prob_distribution = "gamma",
      prob_distribution_params = c(shape = 1, scale = 1),
      discretise = TRUE
    )
  )

  res <- distributional::generate(ebola_dist, times = 1)
  expect_length(res, 1)
  expect_type(res, "double")
  expect_gte(res, 0)

  res <- distributional::generate(ebola_dist, times = 10)
  expect_length(res, 10)
  expect_type(res, "double")
  expect_true(all(res >= 0))
})

test_that("generate fails as expected on continuous epidist object with vector
          input", {
  ebola_dist <- suppressMessages(
    epidist(
      disease = "ebola",
      epi_dist = "incubation_period",
      prob_distribution = "gamma",
      prob_distribution_params = c(shape = 1, scale = 1)
    )
  )

  expect_error(distributional::generate(ebola_dist, times = c(10, 15)))
})

test_that("generate fails as expected on discrete epidist object with vector
          input", {
  ebola_dist <- suppressMessages(
    epidist(
      disease = "ebola",
      epi_dist = "incubation_period",
      prob_distribution = "gamma",
      prob_distribution_params = c(shape = 1, scale = 1),
      discretise = TRUE
    )
  )

  expect_error(distributional::generate(ebola_dist, times = c(10, 15)))
})

test_that("is_epidist returns TRUE when expected", {
  # suppress message about citation
  edist <- suppressMessages(epidist(
    disease = "ebola",
    epi_dist = "serial_interval",
    prob_distribution = "gamma",
    prob_distribution_params = c(shape = 1, scale = 1)
  ))

  expect_true(is_epidist(edist))
})

test_that("is_epidist returns FALSE when expected", {
  false_edist <- list(
    disease = "ebola",
    epi_dist = "serial_interval",
    prob_distribution = "gamma",
    prob_distribution_params = c(shape = 1, scale = 1)
  )

  expect_false(is_epidist(false_edist))
})

test_that("discretise works as expected on continuous gamma", {
  # suppress message about citation
  edist <- suppressMessages(epidist(
    disease = "ebola",
    epi_dist = "incubation",
    prob_distribution = "gamma",
    prob_distribution_params = c(shape = 1, scale = 1)
  ))
  edist <- discretise(edist)

  expect_s3_class(edist$prob_dist, "distcrete")
  expect_identical(edist$prob_dist$parameters, list(shape = 1, scale = 1))
  expect_identical(edist$prob_dist$name, "gamma")
})

test_that("discretise works as expected on continuous lognormal", {
  # suppress message about citation
  edist <- suppressMessages(epidist(
    disease = "ebola",
    epi_dist = "incubation",
    prob_distribution = "lnorm",
    prob_distribution_params = c(meanlog = 1, sdlog = 1)
  ))
  edist <- discretise(edist)

  expect_s3_class(edist$prob_dist, "distcrete")
  expect_identical(edist$prob_dist$parameters, list(meanlog = 1, sdlog = 1))
  expect_identical(edist$prob_dist$name, "lnorm")
})

test_that("discretise works as expected on discretised dist", {
  # suppress message about citation
  edist <- suppressMessages(epidist(
    disease = "ebola",
    epi_dist = "incubation",
    prob_distribution = "gamma",
    prob_distribution_params = c(shape = 1, scale = 1),
    discretise = TRUE
  ))
  expect_message(
    discretise(edist),
    regexp = "Distribution in `epidist` is already discretised"
  )

  expect_s3_class(edist$prob_dist, "distcrete")
  expect_identical(edist$prob_dist$parameters, list(shape = 1, scale = 1))
  expect_identical(edist$prob_dist$name, "gamma")
})

test_that("discretise works as expected on truncated dist", {
  # suppress message about citation
  edist <- suppressMessages(epidist(
    disease = "ebola",
    epi_dist = "incubation",
    prob_distribution = "gamma",
    prob_distribution_params = c(shape = 1, scale = 1),
    truncation = 10
  ))

  expect_warning(
    discretise(edist),
    regexp = paste(
      "Discretising a truncated continuous distribution,",
      "returning non-truncated discretised distribution"
    )
  )

  edist <- suppressWarnings(discretise(edist))

  expect_s3_class(edist$prob_dist, "distcrete")
  expect_identical(edist$prob_dist$parameters, list(shape = 1, scale = 1))
  expect_identical(edist$prob_dist$name, "gamma")
})

test_that("discretise fails as expected on non-epidist object", {
  expect_error(
    discretise("epidist"),
    regexp = "No discretise method defined for class character"
  )

  expect_error(
    discretise(c(1, 2, 3)),
    regexp = "No discretise method defined for class numeric"
  )
})

test_that("parameters works as expected on continuous gamma", {
  # suppress message about citation
  edist <- suppressMessages(epidist(
    disease = "ebola",
    epi_dist = "incubation",
    prob_distribution = "gamma",
    prob_distribution_params = c(shape = 1, scale = 1)
  ))
  params <- get_parameters(edist)

  expect_vector(params, ptype = numeric(), size = 2)
  expect_named(params, expected = c("shape", "scale"))
})

test_that("parameters works as expected on continuous lognormal", {
  # suppress message about citation
  edist <- suppressMessages(epidist(
    disease = "ebola",
    epi_dist = "incubation",
    prob_distribution = "lnorm",
    prob_distribution_params = c(meanlog = 1, sdlog = 1)
  ))
  params <- get_parameters(edist)

  expect_vector(params, ptype = numeric(), size = 2)
  expect_named(params, expected = c("meanlog", "sdlog"))
})

test_that("parameters works as expected on discretised dist", {
  # suppress message about citation
  edist <- suppressMessages(epidist(
    disease = "ebola",
    epi_dist = "incubation",
    prob_distribution = "gamma",
    prob_distribution_params = c(shape = 1, scale = 1),
    discretise = TRUE
  ))
  params <- get_parameters(edist)

  expect_vector(params, ptype = numeric(), size = 2)
  expect_named(params, expected = c("shape", "scale"))
})

test_that("parameters works as expected on truncated dist", {
  # suppress message about citation
  edist <- suppressMessages(epidist(
    disease = "ebola",
    epi_dist = "incubation",
    prob_distribution = "gamma",
    prob_distribution_params = c(shape = 1, scale = 1),
    truncation = 10
  ))
  params <- get_parameters(edist)

  expect_vector(params, ptype = numeric(), size = 4)
  expect_named(params, expected = c("shape", "scale", "lower", "upper"))
})

test_that("parameters fails as expected on non-epidist object", {
  expect_error(
    get_parameters("epidist"),
    regexp = paste0(
      "(no applicable method for)*(parameters)*",
      "(applied to an object of class)*(character)"
    )
  )

  expect_error(
    get_parameters(c(1, 2, 3)),
    regexp = paste0(
      "(no applicable method for)*(parameters)*",
      "(applied to an object of class)*(numeric)"
    )
  )
})

test_that("family works as expected for distributional", {
  # message about missing citation suppressed
  edist <- suppressMessages(epidist(
    disease = "ebola",
    epi_dist = "incubation_period",
    prob_distribution = "lnorm",
    prob_distribution_params = c(meanlog = 1, sdlog = 1)
  ))
  expect_identical(family(edist), "lnorm")
})

test_that("family works as expected for distcrete", {
  # message about missing citation suppressed
  edist <- suppressMessages(epidist(
    disease = "ebola",
    epi_dist = "incubation_period",
    prob_distribution = "gamma",
    prob_distribution_params = c(shape = 1, scale = 1),
    discretise = TRUE
  ))
  expect_identical(family(edist), "gamma")
})

test_that("family works as expected for distributional truncated", {
  # message about missing citation suppressed
  edist <- suppressMessages(epidist(
    disease = "ebola",
    epi_dist = "incubation_period",
    prob_distribution = "weibull",
    prob_distribution_params = c(shape = 1, scale = 1),
    truncation = 10
  ))
  expect_identical(family(edist), "weibull")
})

test_that("is_truncated works as expected for continuous distributions", {
  # message about missing citation suppressed
  edist <- suppressMessages(epidist(
    disease = "ebola",
    epi_dist = "incubation_period",
    prob_distribution = "gamma",
    prob_distribution_params = c(shape = 1, scale = 1)
  ))
  expect_false(is_truncated(edist))
})

test_that("is_truncated works as expected for discretised distributions", {
  # message about missing citation suppressed
  edist <- suppressMessages(epidist(
    disease = "ebola",
    epi_dist = "incubation_period",
    prob_distribution = "gamma",
    prob_distribution_params = c(shape = 1, scale = 1),
    discretise = TRUE
  ))
  expect_false(is_truncated(edist))
})

test_that("is_truncated works as expected for truncated distributions", {
  # message about missing citation suppressed
  edist <- suppressMessages(epidist(
    disease = "ebola",
    epi_dist = "incubation_period",
    prob_distribution = "gamma",
    prob_distribution_params = c(shape = 1, scale = 1),
    truncation = 10
  ))
  expect_true(is_truncated(edist))
})

test_that("mean works as expected when mean is supplied", {
  edist <- suppressMessages(
    epidist(
      disease = "Ebola",
      epi_dist = "incubation_period",
      prob_distribution = "gamma",
      summary_stats = create_epidist_summary_stats(mean = 5)
    )
  )
  expect_identical(mean(edist), 5)
})

test_that("mean works as expected with params and no mean", {
  edist <- suppressMessages(
    epidist(
      disease = "Ebola",
      epi_dist = "incubation_period",
      prob_distribution = "gamma",
      prob_distribution_params = c(shape = 1, scale = 1)
    )
  )
  expect_identical(mean(edist), 1)
})

test_that("mean works as expected with no params and no mean", {
  edist <- suppressMessages(
    epidist(
      disease = "Ebola",
      epi_dist = "incubation_period",
      prob_distribution = "gamma"
    )
  )
  expect_true(is.na(mean(edist)))
})

test_that("mean works for corrupted epidist", {
  edist <- suppressMessages(
    epidist(
      disease = "Ebola",
      epi_dist = "incubation_period",
      prob_distribution = "gamma"
    )
  )
  edist$summary_stats <- list()
  expect_true(is.na(mean(edist)))
})

test_that("as.function works as expected for density", {
  # message about missing citation suppressed
  edist <- suppressMessages(epidist(
    disease = "ebola",
    epi_dist = "incubation",
    prob_distribution = "gamma",
    prob_distribution_params = c(shape = 1, scale = 1)
  ))
  edist_func <- as.function(edist, func_type = "density")
  expect_type(edist_func, type = "closure")
  expect_length(formals(edist_func), 1)
})

test_that("as.function works as expected for cdf", {
  # message about missing citation suppressed
  edist <- suppressMessages(epidist(
    disease = "ebola",
    epi_dist = "incubation",
    prob_distribution = "gamma",
    prob_distribution_params = c(shape = 1, scale = 1)
  ))
  edist_func <- as.function(edist, func_type = "cdf")
  expect_type(edist_func, type = "closure")
  expect_length(formals(edist_func), 1)
})

test_that("as.function works as expected for generate", {
  # message about missing citation suppressed
  edist <- suppressMessages(epidist(
    disease = "ebola",
    epi_dist = "incubation",
    prob_distribution = "gamma",
    prob_distribution_params = c(shape = 1, scale = 1)
  ))
  edist_func <- as.function(edist, func_type = "generate")
  expect_type(edist_func, type = "closure")
  expect_length(formals(edist_func), 1)
})

test_that("as.function works as expected for quantile", {
  # message about missing citation suppressed
  edist <- suppressMessages(epidist(
    disease = "ebola",
    epi_dist = "incubation",
    prob_distribution = "gamma",
    prob_distribution_params = c(shape = 1, scale = 1)
  ))
  edist_func <- as.function(edist, func_type = "quantile")
  expect_type(edist_func, type = "closure")
  expect_length(formals(edist_func), 1)
})

test_that("as.function fails as expected", {
  # message about missing citation suppressed
  edist <- suppressMessages(epidist(
    disease = "ebola",
    epi_dist = "incubation",
    prob_distribution = "gamma",
    prob_distribution_params = c(shape = 1, scale = 1)
  ))
  expect_error(
    as.function(edist, func_type = "random"),
    regexp = "(arg)*(should be one of)*(density)*(cdf)*(generate)*(quantile)"
  )

  # message about missing citation suppressed
  edist <- suppressMessages(epidist(
    disease = "ebola",
    epi_dist = "incubation",
    prob_distribution = "gamma"
  ))
  expect_error(
    as.function(edist),
    regexp = "Cannot convert unparameterised <epidist> to distribution function"
  )
})
