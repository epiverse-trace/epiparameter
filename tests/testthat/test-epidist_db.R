test_that("epidist_db works as expected", {
  # suppress message about citation
  edist <- suppressMessages(
    epidist_db(disease = "influenza", epi_dist = "serial_interval")
  )

  expect_s3_class(edist, class = "epidist")
  expect_length(edist, 9)
  expect_s3_class(validate_epidist(edist), class = "epidist")
})

test_that("epidist_db works as expected with author specified", {
  # suppress message about citation
  edist <- suppressMessages(
    epidist_db(
      disease = "influenza",
      epi_dist = "incubation_period",
      author = "Ghani_etal"
    )
  )

  expect_s3_class(edist, class = "epidist")
  expect_length(edist, 9)
  expect_s3_class(validate_epidist(edist), class = "epidist")
})

test_that("epidist_db works as expected with subsetting", {
  # suppress message about citation
  edist <- suppressMessages(
    epidist_db(
      disease = "influenza",
      epi_dist = "incubation_period",
      subset = sample_size == max(sample_size)
    )
  )

  expect_s3_class(edist, class = "epidist")
  expect_length(edist, 9)
  expect_s3_class(validate_epidist(edist), class = "epidist")
})

test_that("epidist_db works as expected with functional subsetting", {
  edist <- suppressMessages(
    epidist_db(
      disease = "COVID-19",
      epi_dist = "incubation_period",
      subset = is_parameterised
    )
  )

  expect_type(edist, "list")
  expect_length(edist, 2)
  expect_type(lapply(edist, validate_epidist), type = "list")
})

test_that("epidist_db works as expected with single_epidist as TRUE", {
  # suppress message about citation
  edist <- suppressMessages(
    epidist_db(
      disease = "influenza",
      epi_dist = "incubation_period",
      single_epidist = TRUE
    )
  )

  expect_s3_class(edist, class = "epidist")
  expect_length(edist, 9)
  expect_s3_class(validate_epidist(edist), class = "epidist")
})

test_that("epidist_db works as expected with subsetting and single_epidist", {
  edist <- suppressMessages(
    epidist_db(
      disease = "COVID-19",
      epi_dist = "incubation_period",
      subset = sample_size > 50,
      single_epidist = TRUE
    )
  )

  expect_s3_class(edist, class = "epidist")
  expect_length(edist, 9)
  expect_s3_class(validate_epidist(edist), class = "epidist")
})

test_that("epidist_db fails as expected when author not recognised", {
  expect_error(
    epidist_db(
      disease = "influenza",
      epi_dist = "incubation_period",
      author = "Lessler_et_al"
    ),
    regexp = "('arg' should be one of)"
  )
})

test_that("epidist_db fails as expected when disease not recognised", {
  expect_error(
    epidist_db(disease = "COVI-19", epi_dist = "incubation_period"),
    regexp = "(distribution not available for)"
  )
})

test_that("epidist_db fails as expected when epi_dist not recognised", {
  expect_error(
    epidist_db(
      disease = "influenza",
      epi_dist = "delay_dist"
    ),
    regexp = "('arg' should be one of)"
  )
})

test_that("epidist_db fails as expected with no entry in the database", {
  expect_error(
    epidist_db(
      disease = "RSV",
      epi_dist = "serial_interval"
    ),
    regexp = "(serial_interval distribution not available for RSV)"
  )
})

test_that("epidist_db gives message as expected with multiple entries", {
  expect_message(
    epidist_db(
      disease = "influenza",
      epi_dist = "incubation_period",
      author = "Reich_etal"
    ),
    regexp = "(Returning)*(results that match the criteria)"
  )
})

test_that("epidist_db fails as expected when subset given as string", {
  expect_error(
    epidist_db(
      disease = "influenza",
      epi_dist = "incubation_period",
      subset = "author == 'Lessler_et_al'"
    ),
    regexp = "(Subsetting is done with expressions)"
  )
})

test_that("epidist_db fails as expected when subset returns no results", {
  expect_error(
    epidist_db(
      disease = "covid-19",
      epi_dist = "incubation_period",
      subset = year == 2018
    ),
    regexp = "No entries in the database meet the subset criteria"
  )
})
