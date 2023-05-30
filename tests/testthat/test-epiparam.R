test_that("epiparam works as expected", {
  eparam <- epiparam()

  expect_s3_class(eparam, "epiparam")
  expect_identical(dim(eparam), c(118L, 56L))
  expect_identical(
    colnames(eparam),
    c(
      "disease", "pathogen", "epi_distribution", "author", "year",
      "sample_size", "region", "transmission_mode", "vector", "extrinsic",
      "prob_distribution", "inference_method", "mean", "mean_ci_limits",
      "mean_ci", "sd", "sd_ci_limits", "sd_ci", "quantile_2.5",
      "quantile_5", "quantile_25", "median", "median_ci_limits", "median_ci",
      "quantile_75", "quantile_87.5", "quantile_95", "quantile_97.5",
      "lower_range", "upper_range", "shape", "shape_ci_limits",
      "shape_ci",
      "scale", "scale_ci_limits", "scale_ci", "meanlog",
      "meanlog_ci_limits",
      "meanlog_ci", "sdlog", "sdlog_ci_limits", "sdlog_ci",
      "dispersion", "dispersion_ci_limits", "dispersion_ci", "precision",
      "precision_ci_limits", "precision_ci", "truncation", "discretised",
      "censored", "right_truncated", "phase_bias_adjusted", "notes", "PMID",
      "DOI"
    )
  )
  expect_type(eparam$disease, "character")
  expect_type(eparam$pathogen, "character")
  expect_type(eparam$epi_distribution, "character")
  expect_type(eparam$author, "character")
  expect_type(eparam$year, "double")
  expect_type(eparam$sample_size, "double")
  expect_type(eparam$region, "character")
  expect_type(eparam$transmission_mode, "character")
  expect_type(eparam$vector, "character")
  expect_type(eparam$extrinsic, "logical")
  expect_type(eparam$prob_distribution, "character")
  expect_type(eparam$inference_method, "character")
  expect_type(eparam$mean, "double")
  expect_type(eparam$mean_ci_limits, "list")
  lapply(eparam$mean_ci_limits, expect_type, "double")
  expect_type(eparam$mean_ci, "double")
  expect_type(eparam$sd, "double")
  expect_type(eparam$sd_ci_limits, "list")
  lapply(eparam$sd_ci_limits, expect_type, "double")
  expect_type(eparam$sd_ci, "double")
  expect_type(eparam$quantile_2.5, "double")
  expect_type(eparam$quantile_5, "double")
  expect_type(eparam$quantile_25, "double")
  expect_type(eparam$median, "double")
  expect_type(eparam$median_ci_limits, "list")
  lapply(eparam$median_ci_limits, expect_type, "double")
  expect_type(eparam$quantile_75, "double")
  expect_type(eparam$quantile_87.5, "double")
  expect_type(eparam$quantile_95, "double")
  expect_type(eparam$quantile_97.5, "double")
  expect_type(eparam$lower_range, "double")
  expect_type(eparam$upper_range, "double")
  expect_type(eparam$shape, "double")
  expect_type(eparam$shape_ci_limits, "list")
  lapply(eparam$shape_ci_limits, expect_type, "double")
  expect_type(eparam$shape_ci, "double")
  expect_type(eparam$scale, "double")
  expect_type(eparam$scale_ci_limits, "list")
  lapply(eparam$scale_ci_limits, expect_type, "double")
  expect_type(eparam$scale_ci, "double")
  expect_type(eparam$meanlog, "double")
  expect_type(eparam$meanlog_ci_limits, "list")
  lapply(eparam$meanlog_ci_limits, expect_type, "double")
  expect_type(eparam$meanlog_ci, "double")
  expect_type(eparam$sdlog, "double")
  expect_type(eparam$sdlog_ci_limits, "list")
  lapply(eparam$sdlog_ci_limits, expect_type, "double")
  expect_type(eparam$sdlog_ci, "double")
  expect_type(eparam$dispersion, "double")
  expect_type(eparam$dispersion_ci_limits, "list")
  lapply(eparam$dispersion_ci_limits, expect_type, "double")
  expect_type(eparam$dispersion_ci, "double")
  expect_type(eparam$precision, "double")
  expect_type(eparam$precision_ci_limits, "list")
  lapply(eparam$precision_ci_limits, expect_type, "double")
  expect_type(eparam$precision_ci, "double")
  expect_type(eparam$truncation, "double")
  expect_type(eparam$discretised, "logical")
  expect_type(eparam$censored, "logical")
  expect_type(eparam$right_truncated, "logical")
  expect_type(eparam$phase_bias_adjusted, "logical")
  expect_type(eparam$notes, "character")
  expect_type(eparam$PMID, "double")
  expect_type(eparam$DOI, "character")
})

test_that("epiparam works with all epi distributions", {
  eparam <- epiparam(epi_dist = "all")

  expect_s3_class(eparam, "epiparam")
  expect_identical(dim(eparam), c(118L, 56L))
})

test_that("epiparam works with incubation period", {
  eparam <- epiparam(epi_dist = "incubation_period")

  expect_s3_class(eparam, "epiparam")
  expect_identical(dim(eparam), c(72L, 56L))
})

test_that("epiparam works with onset-to-hospitalisation", {
  eparam <- epiparam(epi_dist = "onset_to_hospitalisation")

  expect_s3_class(eparam, "epiparam")
  expect_identical(dim(eparam), c(5L, 56L))
})

test_that("epiparam works with onset-to-death", {
  eparam <- epiparam(epi_dist = "onset_to_death")

  expect_s3_class(eparam, "epiparam")
  expect_identical(dim(eparam), c(7L, 56L))
})

test_that("epiparam works with serial interval", {
  eparam <- epiparam(epi_dist = "serial_interval")

  expect_s3_class(eparam, "epiparam")
  expect_identical(dim(eparam), c(15L, 56L))
})

test_that("epiparam works with generation time", {
  eparam <- epiparam(epi_dist = "generation_time")

  expect_s3_class(eparam, "epiparam")
  expect_identical(dim(eparam), c(1L, 56L))
})

test_that("epiparam fails when expected", {
  expect_error(
    epiparam(epi_dist = "delay_dist"),
    regexp = "('arg' should be one of)*(all)*(incubation_period)"
  )
})

test_that("epiparam print & format method works as expected", {
  expect_snapshot(epiparam())

  expect_output(print(epiparam()))
  expect_snapshot(print(epiparam()))

  expect_output(format(epiparam()))
  expect_snapshot(format(epiparam()))
})

test_that("epiparam summary method works as expected", {
  epiparam_summary <- summary(epiparam())

  expect_type(epiparam_summary, "list")
  expect_length(epiparam_summary, 8)
  expect_true(all(vapply(epiparam_summary, is.numeric, FUN.VALUE = logical(1))))
  expect_named(
    epiparam_summary,
    c(
      "num_entries", "num_diseases", "num_delay_dist", "num_offspring_dist",
      "num_studies", "num_continuous_distributions",
      "num_discrete_distributions", "num_vector_borne_diseases"
    )
  )
})

test_that("epiparam head & tails methods works as expected", {
  expect_snapshot(head(epiparam()))

  expect_snapshot(tail(epiparam()))
})

test_that("new_epiparam works as expected", {
  eparam <- new_epiparam(epi_dist = "all")
  expect_s3_class(eparam, "epiparam")
  expect_identical(dim(eparam), c(118L, 56L))
})

test_that("new_epiparam works with filtering by epi dist", {
  eparam <- new_epiparam(epi_dist = "incubation_period")

  expect_s3_class(eparam, "epiparam")
  expect_identical(dim(eparam), c(72L, 56L))
})

test_that("new_epiparam fails when expected", {
  expect_error(
    new_epiparam(epi_dist = c("incubation_period", "serial_interval")),
    regexp = "(Assertion on 'epi_dist' failed)"
  )
})

test_that("validate_epiparam passes when expected", {
  eparam <- new_epiparam(epi_dist = "all")

  expect_silent(validate_epiparam(epiparam = eparam))
})

test_that("validate_epidist catches class faults when expected", {
  eparam <- new_epiparam(epi_dist = "all")
  # suppress message about converting to data.frame
  suppressMessages(eparam <- eparam[, -1])
  expect_error(
    validate_epiparam(epiparam = eparam),
    regexp = "Object should be of class epiparam"
  )

  eparam <- new_epiparam(epi_dist = "all")
  # suppress message about converting to data.frame
  suppressMessages(eparam$epi_distribution <- NULL)
  # convert back to `epiparam` to check validation
  class(eparam) <- c("epiparam", "data.frame")
  expect_error(
    validate_epiparam(epiparam = eparam),
    regexp = "epiparam object does not contain the correct columns"
  )

  eparam <- new_epiparam(epi_dist = "all")
  # suppress message about converting to data.frame
  suppressMessages(eparam$disease <- 1)
  # convert back to `epiparam` to check validation
  class(eparam) <- c("epiparam", "data.frame")
  expect_error(
    validate_epiparam(epiparam = eparam),
    regexp = "incorrect data type in character fields"
  )
})

test_that("validate_epidist fails when expected for reconstructed = TRUE", {
  eparam <- new_epiparam(epi_dist = "all")
  # suppress message about converting to data.frame
  suppressMessages(eparam <- eparam[, -1])
  expect_error(
    validate_epiparam(epiparam = eparam, reconstruct = TRUE),
    regexp = "epiparam object does not contain the correct columns"
  )
})

test_that("validate_epiparam fails as expected with input class", {
  expect_error(
    validate_epiparam(epiparam = 1),
    regexp = "Object should be of class epiparam"
  )
})

test_that("is_epiparam returns TRUE when expected", {
  eparam <- epiparam()

  expect_true(is_epiparam(eparam))
})

test_that("is_epiparam returns FALSE when expected", {
  eparam <- epiparam()
  eparam <- unclass(eparam)

  expect_false(is_epiparam(eparam))
})

test_that("epiparam_fields returns vector as expected", {
  expect_vector(object = epiparam_fields(), ptype = character(0), size = 56)
})

test_that("epiparam_char_fields returns vector as expected", {
  eparam <- epiparam()
  expect_vector(
    object = epiparam_char_fields(eparam), ptype = integer(0), size = 11
  )
})

test_that("epiparam_num_fields returns vector as expected", {
  eparam <- epiparam()
  expect_vector(
    object = epiparam_num_fields(eparam), ptype = integer(0), size = 31
  )
})

test_that("epiparam_logic_fields returns vector as expected", {
  eparam <- epiparam()
  expect_vector(
    object = epiparam_logic_fields(eparam), ptype = integer(0), size = 5
  )
})
