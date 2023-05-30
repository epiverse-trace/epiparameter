test_that("list_distributions works as expected with defaults", {
  eparam <- epiparam()
  dist_tbl <- list_distributions(epiparam = eparam)
  expect_s3_class(dist_tbl, "data.frame")
  expect_identical(dim(dist_tbl), c(72L, 6L))
  expect_named(
    dist_tbl,
    c(
      "disease", "epi_distribution", "prob_distribution", "author", "year",
      "sample_size"
    )
  )
  expect_snapshot(
    list_distributions(epiparam = eparam)
  )
})

test_that("list_distributions works as expected with subset_db = FALSE", {
  eparam <- epiparam()
  dist_tbl <- list_distributions(epiparam = eparam, subset_db = FALSE)
  expect_s3_class(dist_tbl, "data.frame")
  expect_identical(dim(dist_tbl), c(72L, 56L))
  expect_named(
    dist_tbl,
    c(
      "disease", "pathogen", "epi_distribution", "author", "year",
      "sample_size", "region", "transmission_mode", "vector", "extrinsic",
      "prob_distribution", "inference_method", "mean", "mean_ci_limits",
      "mean_ci", "sd", "sd_ci_limits", "sd_ci",
      "quantile_2.5",
      "quantile_5", "quantile_25", "median", "median_ci_limits",
      "median_ci",
      "quantile_75", "quantile_87.5", "quantile_95", "quantile_97.5",
      "lower_range", "upper_range", "shape", "shape_ci_limits",
      "shape_ci",
      "scale", "scale_ci_limits", "scale_ci", "meanlog",
      "meanlog_ci_limits",
      "meanlog_ci", "sdlog", "sdlog_ci_limits", "sdlog_ci",
      "dispersion", "dispersion_ci_limits", "dispersion_ci",
      "precision",
      "precision_ci_limits", "precision_ci", "truncation",
      "discretised",
      "censored", "right_truncated", "phase_bias_adjusted", "notes", "PMID",
      "DOI"
    )
  )
  expect_snapshot(
    list_distributions(epiparam = eparam, subset_db = FALSE)
  )
})

test_that("list_distributions works for incubation period", {
  eparam <- epiparam()
  incub_tbl <- list_distributions(
    epiparam = eparam,
    epi_dist = "incubation_period"
  )
  expect_s3_class(incub_tbl, "data.frame")
  expect_identical(dim(incub_tbl), c(72L, 6L))
  expect_named(
    incub_tbl,
    c(
      "disease", "epi_distribution", "prob_distribution", "author", "year",
      "sample_size"
    )
  )
  expect_snapshot(
    list_distributions(
      epiparam = eparam,
      epi_dist = "incubation_period"
    )
  )
})

test_that("list_distributions works for incubation, subset_db = FALSE", {
  eparam <- epiparam()
  incub_tbl <- list_distributions(
    epiparam = eparam,
    epi_dist = "incubation",
    subset_db = FALSE
  )
  expect_s3_class(incub_tbl, "data.frame")
  expect_identical(dim(incub_tbl), c(72L, 56L))
  expect_named(
    incub_tbl,
    c(
      "disease", "pathogen", "epi_distribution", "author", "year",
      "sample_size", "region", "transmission_mode", "vector", "extrinsic",
      "prob_distribution", "inference_method", "mean", "mean_ci_limits",
      "mean_ci", "sd", "sd_ci_limits", "sd_ci", "quantile_2.5",
      "quantile_5", "quantile_25", "median", "median_ci_limits", "median_ci",
      "quantile_75", "quantile_87.5", "quantile_95", "quantile_97.5",
      "lower_range", "upper_range", "shape", "shape_ci_limits", "shape_ci",
      "scale", "scale_ci_limits", "scale_ci", "meanlog", "meanlog_ci_limits",
      "meanlog_ci", "sdlog", "sdlog_ci_limits", "sdlog_ci",
      "dispersion", "dispersion_ci_limits", "dispersion_ci", "precision",
      "precision_ci_limits", "precision_ci", "truncation", "discretised",
      "censored", "right_truncated", "phase_bias_adjusted", "notes", "PMID",
      "DOI"
    )
  )
  expect_snapshot(
    list_distributions(
      epiparam = eparam,
      epi_dist = "incubation",
      subset_db = FALSE
    )
  )
})

test_that("list_distributions works for different distribution", {
  eparam <- epiparam()
  serial_tbl <- list_distributions(
    epiparam = eparam,
    epi_dist = "serial_interval"
  )
  expect_s3_class(serial_tbl, "data.frame")
  expect_identical(dim(serial_tbl), c(15L, 6L))
  expect_named(
    serial_tbl,
    c(
      "disease", "epi_distribution", "prob_distribution", "author", "year",
      "sample_size"
    )
  )
  expect_snapshot(
    list_distributions(
      epiparam = eparam,
      epi_dist = "serial_interval"
    )
  )
})

test_that("list_distributions works for different dist, subset_db = FALSE", {
  eparam <- epiparam()
  serial_tbl <- list_distributions(
    epiparam = eparam,
    epi_dist = "serial_interval",
    subset_db = FALSE
  )
  expect_s3_class(serial_tbl, "data.frame")
  expect_identical(dim(serial_tbl), c(15L, 56L))
  expect_named(
    serial_tbl,
    c(
      "disease", "pathogen", "epi_distribution", "author", "year",
      "sample_size", "region", "transmission_mode", "vector", "extrinsic",
      "prob_distribution", "inference_method", "mean", "mean_ci_limits",
      "mean_ci", "sd", "sd_ci_limits", "sd_ci", "quantile_2.5",
      "quantile_5", "quantile_25", "median", "median_ci_limits", "median_ci",
      "quantile_75", "quantile_87.5", "quantile_95", "quantile_97.5",
      "lower_range", "upper_range", "shape", "shape_ci_limits", "shape_ci",
      "scale", "scale_ci_limits", "scale_ci", "meanlog", "meanlog_ci_limits",
      "meanlog_ci", "sdlog", "sdlog_ci_limits", "sdlog_ci",
      "dispersion", "dispersion_ci_limits", "dispersion_ci", "precision",
      "precision_ci_limits", "precision_ci", "truncation", "discretised",
      "censored", "right_truncated", "phase_bias_adjusted", "notes", "PMID",
      "DOI"
    )
  )
  expect_snapshot(
    list_distributions(
      epiparam = eparam,
      epi_dist = "serial_interval",
      subset_db = FALSE
    )
  )
})

test_that("list_distributions fails correctly", {
  # check for incorrect input
  expect_error(
    list_distributions(
      epiparam = data.frame(),
      epi_dist = "incubation_period",
      subset_db = TRUE
    ),
    regexp = "Object should be of class epiparam"
  )

  expect_error(
    list_distributions(
      epiparam = epiparam(),
      epi_dist = "random",
      subset_db = TRUE
    ),
    regexp = paste0(
      "('arg' should be one of)*(incubation_period)*",
      "(onset_to_hospitalisation)*(onset_to_death)*(serial_interval)*",
      "(generation_time)"
    )
  )

  expect_error(
    list_distributions(
      epiparam = epiparam(),
      epi_dist = "incubation_period",
      subset_db = "true"
    ),
    regexp = paste0(
      "Assertion on 'subset_db' failed: Must be of type 'logical', ",
      "not 'character'."
    )
  )

  # check for multiple match input
  expect_error(
    list_distributions(epiparam = epiparam(), epi_dist = "onset"),
    regexp = paste0(
      "('arg' should be one of)*(incubation_period)*",
      "(onset_to_hospitalisation)*(onset_to_death)*(serial_interval)*",
      "(generation_time)"
    )
  )
})
