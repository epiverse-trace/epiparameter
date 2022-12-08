test_that("epidist works with minimal viable input", {

  # message about missing citation suppressed
  ebola_dist <- suppressMessages(epidist(
    disease = "ebola",
    epi_distribution = "incubation",
    prob_distribution = "gamma",
    prob_distribution_params = c(shape = 1, scale = 1)
  ))

  expect_s3_class(ebola_dist, class = "epidist")
  expect_length(ebola_dist, 9)
  expect_named(
    ebola_dist,
    c("disease", "epi_dist", "prob_dist", "uncertainty", "summary_stats",
      "citation", "metadata", "method_assessment", "notes")
  )
  expect_type(ebola_dist$disease, "list")
  expect_type(ebola_dist$epi_dist, "character")
  expect_type(ebola_dist$prob_dist, "list")
  expect_s3_class(ebola_dist$prob_dist, "distribution")
  expect_type(ebola_dist$uncertainty, "NULL")
  expect_type(ebola_dist$summary_stats, "list")
  expect_type(ebola_dist$citation, "character")
  expect_type(ebola_dist$metadata, "list")
  expect_type(ebola_dist$method_assessment, "list")
  expect_type(ebola_dist$notes, "character")
})

test_that("epidist works with all arguments set", {

  mers_dist <- epidist(
    disease = "MERS",
    pathogen = "MERS_CoV",
    epi_distribution = "serial_interval",
    prob_distribution = "lognormal",
    prob_distribution_params = c(meanlog = 2, sdlog = 1),
    uncertainty = NULL,
    summary_stats = create_epidist_summary_stats(
      mean = 1,
      mean_ci = c(0.8, 1.2),
      mean_ci_interval = 95,
      sd = 0.5,
      sd_ci = c(0.4, 0.6),
      sd_ci_interval = 95,
      median = 1,
      median_ci = c(0.9, 1.1),
      median_ci_interval = 95,
      dispersion = 1,
      dispersion_ci = c(0.9, 1.1),
      dispersion_ci_interval = 90,
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
      DOI = "10.23271/176237.x",
      use_PMID = FALSE
    ),
    metadata = create_epidist_metadata(
      sample_size = 100,
      region = "UK",
      vector_borne = FALSE,
      vector = NULL
    ),
    method_assessment = create_epidist_method_assessment(
      censorred = TRUE,
      right_truncated = FALSE,
      phase_bias_adjusted = FALSE
    ),
    discretised = FALSE,
    truncation = NULL,
    notes = "No notes"
  )

  expect_s3_class(mers_dist, class = "epidist")
  expect_length(mers_dist, 9)
  expect_named(
    mers_dist,
    c("disease", "epi_dist", "prob_dist", "uncertainty", "summary_stats",
      "citation", "metadata", "method_assessment", "notes")
  )
  expect_type(mers_dist$disease, "list")
  expect_type(mers_dist$epi_dist, "character")
  expect_type(mers_dist$prob_dist, "list")
  expect_s3_class(mers_dist$prob_dist, "distribution")
  expect_type(mers_dist$uncertainty, "NULL")
  expect_type(mers_dist$summary_stats, "list")
  expect_type(mers_dist$citation, "character")
  expect_type(mers_dist$metadata, "list")
  expect_type(mers_dist$method_assessment, "list")
  expect_type(mers_dist$notes, "character")
})

test_that("epidist works with default helper functions", {
  # message about missing citation suppressed
  sars_dist <- suppressMessages(epidist(
    disease = "SARS",
    pathogen = "SARS_CoV",
    epi_distribution = "onset_to_death",
    prob_distribution = "lognormal",
    prob_distribution_params = c(meanlog = 2, sdlog = 1),
    uncertainty = NULL,
    summary_stats = create_epidist_summary_stats(),
    citation = create_epidist_citation(),
    metadata = create_epidist_metadata(),
    method_assessment = create_epidist_method_assessment(),
    discretised = FALSE,
    truncation = NULL,
    notes = "No notes"
  ))

  expect_s3_class(sars_dist, class = "epidist")
  expect_length(sars_dist, 9)
  expect_named(
    sars_dist,
    c("disease", "epi_dist", "prob_dist", "uncertainty", "summary_stats",
      "citation", "metadata", "method_assessment", "notes")
  )
  expect_type(sars_dist$disease, "list")
  expect_type(sars_dist$epi_dist, "character")
  expect_type(sars_dist$prob_dist, "list")
  expect_s3_class(sars_dist$prob_dist, "distribution")
  expect_type(sars_dist$uncertainty, "NULL")
  expect_type(sars_dist$summary_stats, "list")
  expect_type(sars_dist$citation, "character")
  expect_type(sars_dist$metadata, "list")
  expect_type(sars_dist$method_assessment, "list")
  expect_type(sars_dist$notes, "character")
})

test_that("epidist fails as expected", {

  expect_error(
    epidist(
      disease = 1,
      epi_distribution = "incubation",
      prob_distribution = "gamma",
      prob_distribution_params = c(shape = 1, scale = 1)
    ),
    regexp = paste0("Assertion on 'disease' failed: Must be of type ",
                   "'character', not 'double'."
    )
  )

  expect_error(
    epidist(
      disease = "ebola",
      epi_distribution = 1,
      prob_distribution = "gamma",
      prob_distribution_params = c(shape = 1, scale = 1)
    ),
    regexp = paste0("Assertion on 'epi_distribution' failed: Must be of type ",
                   "'character', not 'double'."
    )
  )

  expect_error(
    epidist(
      disease = "ebola",
      epi_distribution = "incubation",
      prob_distribution = 1,
      prob_distribution_params = c(shape = 1, scale = 1)
    ),
    regexp = paste0(
      "(Assertion on 'prob_distribution' failed)*(Must be of type)*",
      "(character)*(NULL)*(double)"
    )
  )

  expect_error(
    epidist(
      disease = "ebola",
      epi_distribution = "incubation",
      prob_distribution = "gamma",
      prob_distribution_params = c(shape = "NA", scale = 1)
    ),
    regexp = paste0(
      "(Assertion on 'prob_distribution_params' failed)*(Must be of type)*",
      "(numeric)*(NULL)*(character)."
    )
  )
})


test_that("epidist.print works as expected", {
  expect_snapshot(epidist(
    disease = "ebola",
    epi_distribution = "incubation",
    prob_distribution = "gamma",
    prob_distribution_params = c(shape = 1, scale = 1)
  ))
})

test_that("epidist.plot does not produce an error", {
  skip("Temp skipped before refactor")
  expect_silent(plot(epidist(pathogen = "ebola", delay_dist = "incubation")))

  f <- function() plot(epidist(pathogen = "ebola", delay_dist = "incubation"))
  vdiffr::expect_doppelganger(
    title = "epidist.plot",
    fig = f
  )
})

test_that("epidist.plot works with non-default day_range", {
  skip("Temp skipped before refactor")
  expect_silent(
    plot(
      epidist(
        pathogen = "ebola",
        delay_dist = "incubation"
      ),
      day_range = 0:20
    )
  )

  f <- function() {
    plot(
      epidist(pathogen = "ebola", delay_dist = "incubation"),
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
    citation = "Smith (2002) <10.128372837>"
  )

  expect_s3_class(epidist_obj, class = "epidist")
  expect_length(epidist_obj, 9)
  expect_named(
    epidist_obj,
    c("disease", "epi_dist", "prob_dist", "uncertainty", "summary_stats",
      "citation", "metadata", "method_assessment", "notes")
  )
  expect_type(epidist_obj$disease, "list")
  expect_type(epidist_obj$epi_dist, "character")
  expect_type(epidist_obj$prob_dist, "list")
  expect_s3_class(epidist_obj$prob_dist, "distribution")
  expect_type(epidist_obj$uncertainty, "list")
  expect_type(epidist_obj$summary_stats, "list")
  expect_type(epidist_obj$citation, "character")
  expect_type(epidist_obj$metadata, "list")
  expect_type(epidist_obj$method_assessment, "list")
  expect_type(epidist_obj$notes, "character")
})

test_that("new_epidist fails as expected", {

  expect_error(
    new_epidist(
      disease = list(
        disease = 1,
        pathogen = "ebola_virus"
      ),
      epi_dist = "incubation",
      prob_dist = "gamma",
      prob_dist_params = c(shape = 1, scale = 1),
      citation = "Smith (2002) <10.128372837>"
    ),
    regexp = paste0("(Assertion on 'disease' failed)*(May only contain)*",
                    "(character,null)*(numeric)."
    )
  )

  expect_error(
    new_epidist(
      disease = list(
        disease = "ebola",
        pathogen = "ebola_virus"
      ),
      epi_dist = 1,
      prob_dist = "gamma",
      prob_dist_params = c(shape = 1, scale = 1),
      citation = "Smith (2002) <10.128372837>"
    ),
    regexp = paste0("(Assertion on 'epi_dist' failed)*(Must be of type)*",
                    "(character)*(double)."
    )
  )

  expect_error(
    new_epidist(
      disease = list(
        disease = "ebola",
        pathogen = "ebola_virus"
      ),
      epi_dist = "incubation",
      prob_dist = 1,
      prob_dist_params = c(shape = 1, scale = 1),
      citation = "Smith (2002) <10.128372837>"
    ),
    regexp = paste0(
      "(Assertion on 'prob_distribution' failed)*(Must be of type)*",
      "(character)*(NULL)*(double)"
    )
  )

  expect_error(
    new_epidist(
      disease = list(
        disease = "ebola",
        pathogen = "ebola_virus"
      ),
      epi_dist = "incubation",
      prob_dist = "gamma",
      prob_dist_params = c(shape = "1", scale = 1),
      citation = "Smith (2002) <10.128372837>"
    ),
    regexp = paste0(
      "(Assertion on 'prob_distribution_params' failed)*(Must be of type)*",
      "(numeric)*(NULL)*(character)."
    )
  )

  expect_error(
    new_epidist(
      disease = list(
        disease = "ebola",
        pathogen = "ebola_virus"
      ),
      epi_dist = "incubation",
      prob_dist = "gamma",
      prob_dist_params = c(shape = 1, scale = 1),
      citation = character()
    ),
    regexp = "(Assertion on 'citation' failed)*(Must have length)"
  )
})

