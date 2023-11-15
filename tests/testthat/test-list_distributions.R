# Data to be reused by multiple testing blocks
edist <- suppressMessages(epidist_db())

test_that("list_distributions works as expected supplied with db", {
  dist_tbl <- list_distributions(multi_epidist = edist)
  expect_s3_class(dist_tbl, "data.frame")
  expect_identical(dim(dist_tbl), c(118L, 5L))
  expect_named(
    dist_tbl,
    c("disease", "epi_distribution", "prob_distribution", "author", "year")
  )
  expect_snapshot(dist_tbl)
})

test_that("list_distributions works for incubation period with db", {
  incub_tbl <- list_distributions(
    multi_epidist = edist,
    epi_dist = "incubation period"
  )
  expect_s3_class(incub_tbl, "data.frame")
  expect_identical(dim(incub_tbl), c(72L, 5L))
  expect_named(
    incub_tbl,
    c("disease", "epi_distribution", "prob_distribution", "author", "year")
  )
  expect_snapshot(incub_tbl)
})

test_that("list_distributions works for different distribution with db", {
  serial_tbl <- list_distributions(
    multi_epidist = edist,
    epi_dist = "serial interval"
  )
  expect_s3_class(serial_tbl, "data.frame")
  expect_identical(dim(serial_tbl), c(15L, 5L))
  expect_named(
    serial_tbl,
    c("disease", "epi_distribution", "prob_distribution", "author", "year")
  )
  expect_snapshot(serial_tbl)
})

test_that("list_distributions works for COVID-19 db", {
  incub_tbl <- list_distributions(
    multi_epidist = edist,
    disease = "COVID-19"
  )
  expect_s3_class(incub_tbl, "data.frame")
  expect_identical(dim(incub_tbl), c(23L, 5L))
  expect_named(
    incub_tbl,
    c("disease", "epi_distribution", "prob_distribution", "author", "year")
  )
  expect_snapshot(incub_tbl)
})

test_that("list_distributions works for disease & epi_dist subset with db", {
  incub_tbl <- list_distributions(
    multi_epidist = edist,
    disease = "COVID-19",
    epi_dist = "incubation period"
  )
  expect_s3_class(incub_tbl, "data.frame")
  expect_identical(dim(incub_tbl), c(14L, 5L))
  expect_named(
    incub_tbl,
    c("disease", "epi_distribution", "prob_distribution", "author", "year")
  )
  expect_snapshot(incub_tbl)
})

test_that("list_distribution works when supplied a subset db", {
  edist <- suppressMessages(epidist_db(disease = "COVID-19"))
  covid_tbl <- list_distributions(multi_epidist = edist, disease = "COVID-19")
  expect_s3_class(covid_tbl, "data.frame")
  expect_identical(dim(covid_tbl), c(23L, 5L))
  expect_named(
    covid_tbl,
    c("disease", "epi_distribution", "prob_distribution", "author", "year")
  )
  expect_snapshot(covid_tbl)
})

test_that("list_distributions works as expected supplied with <epidist>", {
  edist <- suppressMessages(epidist_db(single_epidist = TRUE))
  dist_tbl <- list_distributions(multi_epidist = edist)
  expect_s3_class(dist_tbl, "data.frame")
  expect_identical(dim(dist_tbl), c(1L, 5L))
  expect_named(
    dist_tbl,
    c("disease", "epi_distribution", "prob_distribution", "author", "year")
  )
  expect_snapshot(dist_tbl)
})

test_that("list_distributions works as expected with discretised <epidist>", {
  edist <- suppressMessages(
    epidist(
      disease = "Ebola",
      epi_dist = "serial interval",
      prob_distribution = "gamma",
      prob_distribution_params = c(shape = 1, scale = 1),
      citation = create_epidist_citation(
        author = "John Smith",
        year = 2022,
        title = "A title",
        journal = "A journal",
        DOI = "10.32561.x"
      ),
      discretise = TRUE
    )
  )
  dist_tbl <- list_distributions(multi_epidist = edist)
  expect_s3_class(dist_tbl, "data.frame")
  expect_identical(dim(dist_tbl), c(1L, 5L))
  expect_named(
    dist_tbl,
    c("disease", "epi_distribution", "prob_distribution", "author", "year")
  )
  expect_snapshot(dist_tbl)
})

test_that("list_distribution fails correctly when subsetting a subset db", {
  edist <- suppressMessages(epidist_db(disease = "Ebola"))
  expect_error(
    list_distributions(multi_epidist = edist, disease = "COVID-19"),
    regexp = "(distribution not available for COVID-19)"
  )
})

test_that("list_distributions fails correctly", {
  # check for incorrect input
  expect_error(
    list_distributions(
      multi_epidist = list(),
      epi_dist = "incubation_period"
    ),
    regexp = "List of <epidist> objects should be supplied to multi_epidist"
  )

  expect_error(
    list_distributions(multi_epidist = edist, epi_dist = "random"),
    regexp = "random distribution not available"
  )

  # check for multiple match input
  expect_error(
    list_distributions(multi_epidist = edist, epi_dist = "onset"),
    regexp = "onset distribution not available"
  )
})
