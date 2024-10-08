# Data to be reused by multiple testing blocks
db <- suppressMessages(epiparameter_db())

test_that("parameter_tbl works as expected supplied with db", {
  dist_tbl <- parameter_tbl(multi_epiparameter = db)
  expect_s3_class(dist_tbl, "data.frame")
  expect_identical(dim(dist_tbl), c(125L, 7L))
  expect_named(
    dist_tbl,
    c("disease", "pathogen", "epi_name", "prob_distribution",
      "author", "year", "sample_size")
  )
  expect_snapshot(dist_tbl)
})

test_that("parameter_tbl works for incubation period with db", {
  incub_tbl <- parameter_tbl(
    multi_epiparameter = db,
    epi_name = "incubation period"
  )
  expect_s3_class(incub_tbl, "data.frame")
  expect_identical(dim(incub_tbl), c(73L, 7L))
  expect_named(
    incub_tbl,
    c("disease", "pathogen", "epi_name", "prob_distribution",
      "author", "year", "sample_size")
  )
  expect_snapshot(incub_tbl)
})

test_that("parameter_tbl works for different distribution with db", {
  serial_tbl <- parameter_tbl(
    multi_epiparameter = db,
    epi_name = "serial interval"
  )
  expect_s3_class(serial_tbl, "data.frame")
  expect_identical(dim(serial_tbl), c(18L, 7L))
  expect_named(
    serial_tbl,
    c("disease", "pathogen", "epi_name", "prob_distribution",
      "author", "year", "sample_size")
  )
  expect_snapshot(serial_tbl)
})

test_that("parameter_tbl works for COVID-19 db", {
  incub_tbl <- parameter_tbl(
    multi_epiparameter = db,
    disease = "COVID-19"
  )
  expect_s3_class(incub_tbl, "data.frame")
  expect_identical(dim(incub_tbl), c(27L, 7L))
  expect_named(
    incub_tbl,
    c("disease", "pathogen", "epi_name", "prob_distribution",
      "author", "year", "sample_size")
  )
  expect_snapshot(incub_tbl)
})

test_that("parameter_tbl works for SARS-CoV-2 db", {
  incub_tbl <- parameter_tbl(
    multi_epiparameter = db,
    pathogen = "SARS-CoV-2"
  )
  expect_s3_class(incub_tbl, "data.frame")
  expect_identical(dim(incub_tbl), c(27L, 7L))
  expect_named(
    incub_tbl,
    c("disease", "pathogen", "epi_name", "prob_distribution",
      "author", "year", "sample_size")
  )
  expect_snapshot(incub_tbl)
})

test_that("parameter_tbl works for disease & epi_name subset with db", {
  incub_tbl <- parameter_tbl(
    multi_epiparameter = db,
    disease = "COVID-19",
    epi_name = "incubation period"
  )
  expect_s3_class(incub_tbl, "data.frame")
  expect_identical(dim(incub_tbl), c(15L, 7L))
  expect_named(
    incub_tbl,
    c("disease", "pathogen", "epi_name", "prob_distribution",
      "author", "year", "sample_size")
  )
  expect_snapshot(incub_tbl)
})

test_that("parameter_tbl works when supplied a subset db", {
  db <- suppressMessages(epiparameter_db(disease = "COVID-19"))
  covid_tbl <- parameter_tbl(multi_epiparameter = db, disease = "COVID-19")
  expect_s3_class(covid_tbl, "data.frame")
  expect_identical(dim(covid_tbl), c(27L, 7L))
  expect_named(
    covid_tbl,
    c("disease", "pathogen", "epi_name", "prob_distribution",
      "author", "year", "sample_size")
  )
  expect_snapshot(covid_tbl)
})

test_that("parameter_tbl works as expected supplied with <epiparameter>", {
  db <- suppressMessages(epiparameter_db(single_epiparameter = TRUE))
  dist_tbl <- parameter_tbl(multi_epiparameter = db)
  expect_s3_class(dist_tbl, "data.frame")
  expect_identical(dim(dist_tbl), c(1L, 7L))
  expect_named(
    dist_tbl,
    c("disease", "pathogen", "epi_name", "prob_distribution",
      "author", "year", "sample_size")
  )
  expect_snapshot(dist_tbl)
})

test_that("parameter_tbl works as expected with discretised <epiparameter>", {
  ep <- suppressMessages(
    epiparameter(
      disease = "Ebola",
      epi_name = "serial interval",
      prob_distribution = "gamma",
      prob_distribution_params = c(shape = 1, scale = 1),
      citation = create_citation(
        author = person(given = "John", family = "Smith"),
        year = 2022,
        title = "A title",
        journal = "A journal",
        doi = "10.32561.x"
      ),
      discretise = TRUE
    )
  )
  dist_tbl <- parameter_tbl(multi_epiparameter = ep)
  expect_s3_class(dist_tbl, "data.frame")
  expect_identical(dim(dist_tbl), c(1L, 7L))
  expect_named(
    dist_tbl,
    c("disease", "pathogen", "epi_name", "prob_distribution",
      "author", "year", "sample_size")
  )
  expect_snapshot(dist_tbl)
})

test_that("parameter_tbl fails correctly when subsetting a subset db", {
  ep <- suppressMessages(epiparameter_db(disease = "Ebola"))
  expect_error(
    parameter_tbl(multi_epiparameter = ep, disease = "COVID-19"),
    regexp = "(distribution not available for COVID-19)"
  )
})

test_that("parameter_tbl fails correctly", {
  # check for incorrect input
  expect_error(
    parameter_tbl(
      multi_epiparameter = list(),
      epi_name = "incubation_period"
    ),
    regexp = "List of <epiparameter> objects should be supplied to multi_epiparameter"
  )

  expect_error(
    parameter_tbl(multi_epiparameter = db, epi_name = "random"),
    regexp = "random distribution not available"
  )

  # check for multiple match input
  expect_error(
    parameter_tbl(multi_epiparameter = db, epi_name = "onset"),
    regexp = "onset distribution not available"
  )
})
