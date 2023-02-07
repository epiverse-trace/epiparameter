test_that("epidist_db works as expected", {
  edist <- epidist_db(disease = "influenza", epi_dist = "serial_interval")

  expect_s3_class(edist, class = "epidist")
  expect_length(edist, 9)
  expect_named(
    edist,
    c("disease", "epi_dist", "prob_dist", "uncertainty", "summary_stats",
      "citation", "metadata", "method_assessment", "notes")
  )
  expect_type(edist$disease, "list")
  expect_type(edist$epi_dist, "character")
  expect_type(edist$prob_dist, "list")
  expect_type(edist$uncertainty, "list")
  expect_type(edist$summary_stats, "list")
  expect_type(edist$citation, "character")
  expect_type(edist$metadata, "list")
  expect_type(edist$method_assessment, "list")
  expect_type(edist$notes, "character")
})

test_that("epidist_db works as expected with author specified", {
  edist <- epidist_db(
    disease = "influenza",
    epi_dist = "incubation_period",
    author = "Ghani_etal"
  )

  expect_s3_class(edist, class = "epidist")
  expect_length(edist, 9)
  expect_named(
    edist,
    c("disease", "epi_dist", "prob_dist", "uncertainty", "summary_stats",
      "citation", "metadata", "method_assessment", "notes")
  )
  expect_type(edist$disease, "list")
  expect_type(edist$epi_dist, "character")
  expect_type(edist$prob_dist, "list")
  expect_type(edist$uncertainty, "list")
  expect_type(edist$summary_stats, "list")
  expect_type(edist$citation, "character")
  expect_true(grepl(pattern = "Ghani", x = edist$citation, fixed = TRUE))
  expect_type(edist$metadata, "list")
  expect_type(edist$method_assessment, "list")
  expect_type(edist$notes, "character")
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

test_that("epidist_db fails as expected when epi_dist not recognised", {
  expect_error(
    epidist_db(
      disease = "influenza",
      epi_dist = "onset_to_hospitalisation"
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

test_that("epidist_db throws warning as expected with multiple entries", {
  expect_warning(
    # message about stochastic optimisation suppressed
    suppressMessages(epidist_db(
      disease = "influenza",
      epi_dist = "incubation_period",
      author = "Reich_etal"
    )),
    regexp = "(More than one study found. Selecting first one)"
  )
})
