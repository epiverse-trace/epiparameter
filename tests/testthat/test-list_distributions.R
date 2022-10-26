test_that("list_distributions works for incubation, params = FALSE", {
  incub_tbl <- list_distributions(delay_dist = "incubation", parameters = FALSE)
  expect_true(is.data.frame(incub_tbl))
  expect_equal(dim(incub_tbl), c(21, 5))
  expect_equal(
    colnames(incub_tbl),
    c("pathogen_id", "study_id", "year", "size", "distribution")
  )
  expect_snapshot(
    list_distributions(delay_dist = "incubation", parameters = FALSE)
  )
})

test_that("list_distributions works for incubation, params = TRUE", {
  incub_tbl <- list_distributions(delay_dist = "incubation", parameters = TRUE)
  expect_true(is.data.frame(incub_tbl))
  expect_equal(dim(incub_tbl), c(21, 27))
  expect_equal(
    colnames(incub_tbl),
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
  expect_true(is.data.frame(on_to_ad_tbl))
  expect_equal(dim(on_to_ad_tbl), c(6, 5))
  expect_equal(
    colnames(on_to_ad_tbl),
    c("pathogen_id", "study_id", "year", "size", "distribution")
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
  expect_true(is.data.frame(on_to_ad_tbl))
  expect_equal(dim(on_to_ad_tbl), c(6, 27))
  expect_equal(
    colnames(on_to_ad_tbl),
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
  expect_true(is.data.frame(on_to_death_tbl))
  expect_equal(dim(on_to_death_tbl), c(2, 5))
  expect_equal(
    colnames(on_to_death_tbl),
    c("pathogen_id", "study_id", "year", "size", "distribution")
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
  expect_true(is.data.frame(on_to_death_tbl))
  expect_equal(dim(on_to_death_tbl), c(2, 27))
  expect_equal(
    colnames(on_to_death_tbl),
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
  expect_true(is.data.frame(serial_inter_tbl))
  expect_equal(dim(serial_inter_tbl), c(5, 5))
  expect_equal(
    colnames(serial_inter_tbl),
    c("pathogen_id", "study_id", "year", "size", "distribution")
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
  expect_true(is.data.frame(serial_inter_tbl))
  expect_equal(dim(serial_inter_tbl), c(5, 27))
  expect_equal(
    colnames(serial_inter_tbl),
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
  expect_true(is.data.frame(gen_time_tbl))
  expect_equal(dim(gen_time_tbl), c(2, 5))
  expect_equal(
    colnames(gen_time_tbl),
    c("pathogen_id", "study_id", "year", "size", "distribution")
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
  expect_true(is.data.frame(gen_time_tbl))
  expect_equal(dim(gen_time_tbl), c(2, 27))
  expect_equal(
    colnames(gen_time_tbl),
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
  skip("currently these do not throw an error")
  expect_error(list_distributions(delay_dist = "incubatio", parameters = FALSE))
  expect_error(list_distributions(delay_dist = "incubatio", parameters = TRUE))
})
