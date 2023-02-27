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
  expect_named(
    ebola_dist,
    c("disease", "epi_dist", "prob_dist", "uncertainty", "summary_stats",
      "citation", "metadata", "method_assess", "notes")
  )
  expect_type(ebola_dist$disease, "list")
  expect_type(ebola_dist$epi_dist, "character")
  expect_type(ebola_dist$prob_dist, "list")
  expect_type(ebola_dist$uncertainty, "list")
  expect_type(ebola_dist$summary_stats, "list")
  expect_type(ebola_dist$citation, "character")
  expect_type(ebola_dist$metadata, "list")
  expect_type(ebola_dist$method_assess, "list")
  expect_type(ebola_dist$notes, "character")
})

test_that("epidist works with all arguments set", {

  mers_dist <- epidist(
    disease = "MERS",
    pathogen = "MERS_CoV",
    epi_dist = "serial_interval",
    prob_distribution = "lognormal",
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
      dispersion = 1,
      dispersion_ci_limits = c(0.9, 1.1),
      dispersion_ci = 90,
      lower_range = 0.1,
      upper_range = 1.9,
      q_025 = 0.2,
      q_05 = 0.3,
      q_25 = 0.5,
      q_75 = 0.7,
      q_875 = 1.1,
      q_95 = 1.2,
      q_975 = 1.5
    ), citation = create_epidist_citation(
      author = "Smith",
      year = 2002,
      PMID = 28372882,
      DOI = "10.23271/176237.x" # nolint
    ),
    metadata = create_epidist_metadata(
      sample_size = 100,
      region = "UK",
      vector_borne = FALSE,
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

  expect_s3_class(mers_dist, class = "epidist")
  expect_length(mers_dist, 9)
  expect_named(
    mers_dist,
    c("disease", "epi_dist", "prob_dist", "uncertainty", "summary_stats",
      "citation", "metadata", "method_assess", "notes")
  )
  expect_type(mers_dist$disease, "list")
  expect_type(mers_dist$epi_dist, "character")
  expect_type(mers_dist$prob_dist, "list")
  expect_type(mers_dist$uncertainty, "list")
  expect_type(mers_dist$summary_stats, "list")
  expect_type(mers_dist$citation, "character")
  expect_type(mers_dist$metadata, "list")
  expect_type(mers_dist$method_assess, "list")
  expect_type(mers_dist$notes, "character")
})

test_that("epidist works with default helper functions", {
  # message about missing citation suppressed
  sars_dist <- suppressMessages(epidist(
    disease = "SARS",
    pathogen = "SARS_CoV",
    epi_dist = "onset_to_death",
    prob_distribution = "lognormal",
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
  expect_named(
    sars_dist,
    c("disease", "epi_dist", "prob_dist", "uncertainty", "summary_stats",
      "citation", "metadata", "method_assess", "notes")
  )
  expect_type(sars_dist$disease, "list")
  expect_type(sars_dist$epi_dist, "character")
  expect_type(sars_dist$prob_dist, "list")
  expect_type(sars_dist$uncertainty, "list")
  expect_type(sars_dist$summary_stats, "list")
  expect_type(sars_dist$citation, "character")
  expect_type(sars_dist$metadata, "list")
  expect_type(sars_dist$method_assess, "list")
  expect_type(sars_dist$notes, "character")
})

test_that("epidist fails as expected", {

  expect_error(
    epidist(
      disease = 1,
      epi_dist = "incubation",
      prob_distribution = "gamma",
      prob_distribution_params = c(shape = 1, scale = 1)
    ),
    regexp = paste0("Assertion on 'disease' failed: Must be of type ",
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
    regexp = paste0("Assertion on 'epi_dist' failed: Must be of type ",
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
    suppressMessages(epidist(
      disease = "ebola",
      epi_dist = "incubation",
      prob_distribution = "gamma",
      prob_distribution_params = c(shape = "NA", scale = 1)
    ),
    regexp = paste0(
      "(Assertion on 'prob_distribution_params' failed)*(Must be of type)*",
      "(numeric)*(NULL)*(character)."
    )
  ))
})


test_that("epidist.print works as expected", {
  expect_snapshot(epidist(
    disease = "ebola",
    epi_dist = "incubation",
    prob_distribution = "gamma",
    prob_distribution_params = c(shape = 1, scale = 1)
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
    truncation = NA
  )

  expect_s3_class(epidist_obj, class = "epidist")
  expect_length(epidist_obj, 9)
  expect_named(
    epidist_obj,
    c("disease", "epi_dist", "prob_dist", "uncertainty", "summary_stats",
      "citation", "metadata", "method_assess", "notes")
  )
  expect_type(epidist_obj$disease, "list")
  expect_type(epidist_obj$epi_dist, "character")
  expect_type(epidist_obj$prob_dist, "list")
  expect_type(epidist_obj$uncertainty, "list")
  expect_type(epidist_obj$summary_stats, "list")
  expect_type(epidist_obj$citation, "character")
  expect_type(epidist_obj$metadata, "list")
  expect_type(epidist_obj$method_assess, "list")
  expect_type(epidist_obj$notes, "character")
})

test_that("validate_epidist passes when expected", {
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
    truncation = NA
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
    truncation = NA
  )

  epidist_obj$disease$disease <- NULL

  expect_error(
    validate_epidist(epidist = epidist_obj),
    regexp = "(Epidist must contains a disease)"
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
    truncation = NA
  )

  epidist_obj$epi_dist <- c("incubation", "period")

  expect_error(
    validate_epidist(epidist = epidist_obj),
    regexp = "Epidist must contain an epidemiological distribution"
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
