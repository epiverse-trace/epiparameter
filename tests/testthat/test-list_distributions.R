test_that("list_distributions works for all, params = FALSE", {
  dist_tbl <- list_distributions(delay_dist = "all", parameters = FALSE)
  expect_s3_class(dist_tbl, "data.frame")
  expect_identical(dim(dist_tbl), c(41L, 6L))
  expect_named(
    dist_tbl,
    c("pathogen_id", "type_id", "study_id", "year", "size", "distribution")
  )
  expect_snapshot(
    list_distributions(delay_dist = "all", parameters = FALSE)
  )

  # check default behaviour is delay_dist = "all"
  expect_identical(dist_tbl, list_distributions())
})

test_that("list_distributions works for all, params = TRUE", {
  dist_tbl <- list_distributions(delay_dist = "all", parameters = TRUE)
  expect_s3_class(dist_tbl, "data.frame")
  expect_identical(dim(dist_tbl), c(41L, 27L))
  expect_named(
    dist_tbl,
    c("pathogen_id", "type_id", "study_id", "year", "size", "distribution",
      "mean", "sd", "quantile_025", "median", "quantile_75", "quantile_875",
      "quantile_95", "quantile_975", "lower_range", "upper_range",
      "shape", "scale", "meanlog", "sdlog", "extracted", "discretised",
      "phase_bias_adjusted", "notes", "PMID", "DOI", "added_by")
  )
  expect_snapshot(
    list_distributions(delay_dist = "all", parameters = TRUE)
  )

  # check default behaviour is delay_dist = "all"
  expect_identical(dist_tbl, list_distributions(parameters = TRUE))
})

test_that("list_distributions works for incubation, params = FALSE", {
  incub_tbl <- list_distributions(delay_dist = "incubation", parameters = FALSE)
  expect_s3_class(incub_tbl, "data.frame")
  expect_identical(dim(incub_tbl), c(22L, 6L))
  expect_named(
    incub_tbl,
    c("pathogen_id", "type_id", "study_id", "year", "size", "distribution")
  )
  expect_snapshot(
    list_distributions(delay_dist = "incubation", parameters = FALSE)
  )
})

test_that("list_distributions works for incubation, params = TRUE", {
  incub_tbl <- list_distributions(delay_dist = "incubation", parameters = TRUE)
  expect_s3_class(incub_tbl, "data.frame")
  expect_identical(dim(incub_tbl), c(22L, 27L))
  expect_named(
    incub_tbl,
    c("pathogen_id", "type_id", "study_id", "year", "size", "distribution",
      "mean", "sd", "quantile_025", "median", "quantile_75", "quantile_875",
      "quantile_95", "quantile_975", "lower_range", "upper_range",
      "shape", "scale", "meanlog", "sdlog", "extracted", "discretised",
      "phase_bias_adjusted", "notes", "PMID", "DOI", "added_by")
  )
  expect_snapshot(
    list_distributions(delay_dist = "incubation", parameters = TRUE)
  )
})

test_that("list_distributions works for onset_to_admission, params = FALSE", {
  on_to_ad_tbl <- list_distributions(
    delay_dist = "onset_to_admission",
    parameters = FALSE
  )
  expect_s3_class(on_to_ad_tbl, "data.frame")
  expect_identical(dim(on_to_ad_tbl), c(6L, 6L))
  expect_named(
    on_to_ad_tbl,
    c("pathogen_id", "type_id", "study_id", "year", "size", "distribution")
  )
  expect_snapshot(
    list_distributions(delay_dist = "onset_to_admission", parameters = FALSE)
  )
})

test_that("list_distributions works for onset_to_admission, params = TRUE", {
  on_to_ad_tbl <- list_distributions(
    delay_dist = "onset_to_admission",
    parameters = TRUE
  )
  expect_s3_class(on_to_ad_tbl, "data.frame")
  expect_identical(dim(on_to_ad_tbl), c(6L, 27L))
  expect_named(
    on_to_ad_tbl,
    c("pathogen_id", "type_id", "study_id", "year", "size", "distribution",
      "mean", "sd", "quantile_025", "median", "quantile_75", "quantile_875",
      "quantile_95", "quantile_975", "lower_range", "upper_range",
      "shape", "scale", "meanlog", "sdlog", "extracted", "discretised",
      "phase_bias_adjusted", "notes", "PMID", "DOI", "added_by")
  )
  expect_snapshot(
    list_distributions(delay_dist = "onset_to_admission", parameters = TRUE)
  )
})

test_that("list_distributions works for onset_to_death, params = FALSE", {
  on_to_death_tbl <- list_distributions(
    delay_dist = "onset_to_death",
    parameters = FALSE
  )
  expect_s3_class(on_to_death_tbl, "data.frame")
  expect_identical(dim(on_to_death_tbl), c(2L, 6L))
  expect_named(
    on_to_death_tbl,
    c("pathogen_id", "type_id", "study_id", "year", "size", "distribution")
  )
  expect_snapshot(
    list_distributions(delay_dist = "onset_to_death", parameters = FALSE)
  )
})

test_that("list_distributions works for onset_to_death, params = TRUE", {
  on_to_death_tbl <- list_distributions(
    delay_dist = "onset_to_death",
    parameters = TRUE
  )
  expect_s3_class(on_to_death_tbl, "data.frame")
  expect_identical(dim(on_to_death_tbl), c(2L, 27L))
  expect_named(
    on_to_death_tbl,
    c("pathogen_id", "type_id", "study_id", "year", "size", "distribution",
      "mean", "sd", "quantile_025", "median", "quantile_75", "quantile_875",
      "quantile_95", "quantile_975", "lower_range", "upper_range",
      "shape", "scale", "meanlog", "sdlog", "extracted", "discretised",
      "phase_bias_adjusted", "notes", "PMID", "DOI", "added_by")
  )
  expect_snapshot(
    list_distributions(delay_dist = "onset_to_death", parameters = TRUE)
  )
})

test_that("list_distributions works for serial_interval, params = FALSE", {
  serial_inter_tbl <- list_distributions(
    delay_dist = "serial_interval",
    parameters = FALSE
  )
  expect_s3_class(serial_inter_tbl, "data.frame")
  expect_identical(dim(serial_inter_tbl), c(5L, 6L))
  expect_named(
    serial_inter_tbl,
    c("pathogen_id", "type_id", "study_id", "year", "size", "distribution")
  )
  expect_snapshot(
    list_distributions(delay_dist = "serial_interval", parameters = FALSE)
  )
})

test_that("list_distributions works for serial_interval, params = TRUE", {
  serial_inter_tbl <- list_distributions(
    delay_dist = "serial_interval",
    parameters = TRUE
  )
  expect_s3_class(serial_inter_tbl, "data.frame")
  expect_identical(dim(serial_inter_tbl), c(5L, 27L))
  expect_named(
    serial_inter_tbl,
    c("pathogen_id", "type_id", "study_id", "year", "size", "distribution",
      "mean", "sd", "quantile_025", "median", "quantile_75", "quantile_875",
      "quantile_95", "quantile_975", "lower_range", "upper_range",
      "shape", "scale", "meanlog", "sdlog", "extracted", "discretised",
      "phase_bias_adjusted", "notes", "PMID", "DOI", "added_by")
  )
  expect_snapshot(
    list_distributions(delay_dist = "serial_interval", parameters = TRUE)
  )
})

test_that("list_distributions works for generation_time, params = FALSE", {
  gen_time_tbl <- list_distributions(
    delay_dist = "generation_time",
    parameters = FALSE
  )
  expect_s3_class(gen_time_tbl, "data.frame")
  expect_identical(dim(gen_time_tbl), c(2L, 6L))
  expect_named(
    gen_time_tbl,
    c("pathogen_id", "type_id", "study_id", "year", "size", "distribution")
  )
  expect_snapshot(
    list_distributions(delay_dist = "generation_time", parameters = FALSE)
  )
})

test_that("list_distributions works for generation_time, params = TRUE", {
  gen_time_tbl <- list_distributions(
    delay_dist = "generation_time",
    parameters = TRUE
  )
  expect_s3_class(gen_time_tbl, "data.frame")
  expect_identical(dim(gen_time_tbl), c(2L, 27L))
  expect_named(
    gen_time_tbl,
    c("pathogen_id", "type_id", "study_id", "year", "size", "distribution",
      "mean", "sd", "quantile_025", "median", "quantile_75", "quantile_875",
      "quantile_95", "quantile_975", "lower_range", "upper_range",
      "shape", "scale", "meanlog", "sdlog", "extracted", "discretised",
      "phase_bias_adjusted", "notes", "PMID", "DOI", "added_by")
  )
  expect_snapshot(
    list_distributions(delay_dist = "generation_time", parameters = TRUE)
  )
})

test_that("list_distributions fails correctly", {
  # check for incorrect input
  expect_error(
    list_distributions(delay_dist = "random", parameters = FALSE),
    regexp = paste0(
      "'arg' should be one of ", dQuote("all"), ", ", dQuote("incubation"),
      ", ", dQuote("onset_to_admission"), ", ", dQuote("onset_to_death"), ", ",
      dQuote("serial_interval"), ", ", dQuote("generation_time")
    )
  )
  expect_error(
    list_distributions(delay_dist = "random", parameters = TRUE),
    regexp = paste0(
      "'arg' should be one of ", dQuote("all"), ", ", dQuote("incubation"),
      ", ", dQuote("onset_to_admission"), ", ", dQuote("onset_to_death"), ", ",
      dQuote("serial_interval"), ", ", dQuote("generation_time")
    )
  )

  # check for multiple match input
  expect_error(
    list_distributions(delay_dist = "onset", parameters = FALSE),
    regexp = paste0(
      "'arg' should be one of ", dQuote("all"), ", ", dQuote("incubation"),
      ", ", dQuote("onset_to_admission"), ", ", dQuote("onset_to_death"), ", ",
      dQuote("serial_interval"), ", ", dQuote("generation_time")
    )
  )
  expect_error(
    list_distributions(delay_dist = "onset", parameters = TRUE),
    regexp = paste0(
      "'arg' should be one of ", dQuote("all"), ", ", dQuote("incubation"),
      ", ", dQuote("onset_to_admission"), ", ", dQuote("onset_to_death"), ", ",
      dQuote("serial_interval"), ", ", dQuote("generation_time")
    )
  )
  expect_error(
    list_distributions(delay_dist = "serial_interval", parameters = "TRUE"),
    regexp = paste0("Assertion on 'parameters' failed: Must be of type",
                    " 'logical', not 'character'."
    )
  )
})
