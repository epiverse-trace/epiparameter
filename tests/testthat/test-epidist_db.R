test_that("epidist_db works as expected", {
  # suppress message about citation
  edist <- suppressMessages(
    epidist_db(disease = "influenza", epi_dist = "serial interval")
  )

  expect_s3_class(edist, class = "epidist")
  expect_length(edist, 9)
})

test_that("epidist_db works as expected with author specified", {
  # suppress message about citation
  edist <- suppressMessages(
    epidist_db(
      disease = "influenza",
      epi_dist = "incubation period",
      author = "Ghani"
    )
  )

  expect_s3_class(edist, class = "epidist")
  expect_length(edist, 9)
})

test_that("epidist_db works as expected with subsetting", {
  # suppress message about citation
  edist <- suppressMessages(
    epidist_db(
      disease = "influenza",
      epi_dist = "incubation period",
      subset = sample_size > 100
    )
  )

  expect_s3_class(edist, class = "multi_epidist")
  expect_length(edist, 10)
})

test_that("epidist_db works as expected with functional subsetting", {
  edist <- suppressMessages(
    epidist_db(
      disease = "COVID-19",
      epi_dist = "incubation period",
      subset = is_parameterised
    )
  )

  expect_type(edist, "list")
  expect_s3_class(edist, "multi_epidist")
  expect_length(edist, 10)
})

test_that("epidist_db works as expected with single_epidist as TRUE", {
  # suppress message about citation
  edist <- suppressMessages(
    epidist_db(
      disease = "influenza",
      epi_dist = "incubation period",
      single_epidist = TRUE
    )
  )

  expect_s3_class(edist, class = "epidist")
  expect_length(edist, 9)
})

test_that("epidist_db works as expected with subsetting and single_epidist", {
  edist <- suppressMessages(
    epidist_db(
      disease = "COVID-19",
      epi_dist = "incubation period",
      subset = sample_size > 50,
      single_epidist = TRUE
    )
  )

  expect_s3_class(edist, class = "epidist")
  expect_length(edist, 9)
})

test_that("epidist_db fails as expected when author not recognised", {
  expect_error(
    epidist_db(
      disease = "influenza",
      epi_dist = "incubation period",
      author = "Lessler_et_al"
    ),
    regexp = "Parameters by Lessler_et_al are not available for influenza"
  )
})

test_that("epidist_db fails as expected when disease not recognised", {
  expect_error(
    epidist_db(disease = "COVI-19", epi_dist = "incubation period"),
    regexp = "incubation period distribution not available for COVI-19"
  )
})

test_that("epidist_db fails as expected when epi_dist not recognised", {
  expect_error(
    epidist_db(
      disease = "influenza",
      epi_dist = "delay dist"
    ),
    regexp = "delay dist distribution not available for influenza"
  )
})

test_that("epidist_db fails as expected with no entry in the database", {
  expect_error(
    epidist_db(
      disease = "RSV",
      epi_dist = "serial interval"
    ),
    regexp = "No entries in the database meet the search criteria."
  )
})

test_that("epidist_db gives message as expected with multiple entries", {
  expect_message(
    epidist_db(
      disease = "influenza",
      epi_dist = "incubation period",
      author = "Reich"
    ),
    regexp = "(Returning)*(results that match the criteria)"
  )
})

test_that("epidist_db fails as expected when subset given as string", {
  expect_error(
    epidist_db(
      disease = "influenza",
      epi_dist = "incubation period",
      subset = "author == 'Lessler_et_al'"
    ),
    regexp = "(Subsetting is done with expressions)"
  )
})

test_that("epidist_db fails as expected when subset returns no results", {
  expect_error(
    epidist_db(
      disease = "covid-19",
      epi_dist = "incubation period",
      subset = year == 2018
    ),
    regexp = "No entries in the database meet the search criteria."
  )
})

test_that("epidist_db print method works as expected for > 5 <epidist>", {
  expect_snapshot(epidist_db())
})

test_that("epidist_db print method works as expected for <= 5 <epidist>", {
  expect_snapshot(
    epidist_db(disease = "SARS", epi_dist = "offspring distribution")
  )
})
