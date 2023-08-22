test_that("epidist_db works as expected", {
  # suppress message about citation
  edist <- suppressMessages(
    epidist_db(disease = "influenza", epi_dist = "serial_interval")
  )

  expect_s3_class(edist, class = "epidist")
  expect_length(edist, 9)
  expect_named(
    edist,
    c("disease", "epi_dist", "prob_dist", "uncertainty", "summary_stats",
      "citation", "metadata", "method_assess", "notes")
  )
  expect_type(edist$disease, "list")
  expect_type(edist$epi_dist, "character")
  expect_type(edist$prob_dist, "list")
  expect_type(edist$uncertainty, "list")
  expect_type(edist$summary_stats, "list")
  expect_type(edist$citation, "character")
  expect_type(edist$metadata, "list")
  expect_type(edist$method_assess, "list")
  expect_type(edist$notes, "character")
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
  expect_named(
    edist,
    c("disease", "epi_dist", "prob_dist", "uncertainty", "summary_stats",
      "citation", "metadata", "method_assess", "notes")
  )
  expect_type(edist$disease, "list")
  expect_type(edist$epi_dist, "character")
  expect_type(edist$prob_dist, "list")
  expect_type(edist$uncertainty, "list")
  expect_type(edist$summary_stats, "list")
  expect_type(edist$citation, "character")
  expect_true(grepl(pattern = "Ghani", x = edist$citation, fixed = TRUE))
  expect_type(edist$metadata, "list")
  expect_type(edist$method_assess, "list")
  expect_type(edist$notes, "character")
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
  expect_named(
    edist,
    c("disease", "epi_dist", "prob_dist", "uncertainty", "summary_stats",
      "citation", "metadata", "method_assess", "notes")
  )
  expect_type(edist$disease, "list")
  expect_type(edist$epi_dist, "character")
  expect_type(edist$prob_dist, "character")
  expect_type(edist$uncertainty, "list")
  expect_type(edist$summary_stats, "list")
  expect_type(edist$citation, "character")
  expect_true(grepl(pattern = "Virlogeux", x = edist$citation, fixed = TRUE))
  expect_type(edist$metadata, "list")
  expect_type(edist$method_assess, "list")
  expect_type(edist$notes, "character")
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
  expect_named(
    edist,
    c("disease", "epi_dist", "prob_dist", "uncertainty", "summary_stats",
      "citation", "metadata", "method_assess", "notes")
  )
  expect_type(edist$disease, "list")
  expect_type(edist$epi_dist, "character")
  expect_type(edist$prob_dist, "list")
  expect_type(edist$uncertainty, "list")
  expect_type(edist$summary_stats, "list")
  expect_type(edist$citation, "character")
  expect_true(grepl(pattern = "Ghani", x = edist$citation, fixed = TRUE))
  expect_type(edist$metadata, "list")
  expect_type(edist$method_assess, "list")
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
  # set seed for stochastic optimisation
  set.seed(123)

  suppressMessages(
    expect_message(
      epidist_db(
        disease = "influenza",
        epi_dist = "incubation_period",
        author = "Reich_etal"
      )  ,
      regexp = "(Returning multiple studies that match the criteria)"
    )
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
