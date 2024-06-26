test_that("epidist_db works as expected", {
  # suppress message about citation
  edist <- suppressMessages(
    epidist_db(disease = "influenza", epi_dist = "serial interval")
  )

  expect_s3_class(edist, class = "epidist")
  expect_length(edist, 10)
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
  expect_length(edist, 10)
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
  expect_length(edist, 11)
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
  expect_length(edist, 10)
})

test_that("epidist_db chooses truncated with single_epidist as TRUE", {
  # suppress message about citation
  edist <- suppressMessages(
    epidist_db(
      disease = "COVID-19",
      epi_dist = "onset to death",
      single_epidist = TRUE
    )
  )

  expect_s3_class(edist, class = "epidist")
  expect_true(edist$method_assess$right_truncated)
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
  expect_length(edist, 10)
})

test_that("epidist_db works as expected with subsetting and author", {
  edist <- suppressMessages(
    epidist_db(
      disease = "COVID-19",
      epi_dist = "incubation period",
      author = "McAloon",
      subset = sample_size > 10
    )
  )

  expect_s3_class(edist, class = "multi_epidist")
  expect_length(edist, 2)
})

test_that("epidist_db works as expected with subsetting by prod_dist", {
  edist <- suppressMessages(
    epidist_db(
      disease = "COVID-19",
      epi_dist = "serial interval",
      author = "Nishiura",
      subset = prob_dist == "weibull"
    )
  )

  expect_s3_class(edist, class = "epidist")
  expect_length(edist, 10)
})

test_that("epidist_db works as expected with subsetting by pathogen", {
  # suppress message about citation
  edist <- suppressMessages(
    epidist_db(
      pathogen = "SARS-CoV-2",
      epi_dist = "incubation period"
    )
  )

  expect_s3_class(edist, class = "multi_epidist")
  expect_length(edist, 15)
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

test_that(".read_epidist_db works as expected", {
  edist <- .read_epidist_db()
  expect_s3_class(edist, class = "multi_epidist")
  expect_type(edist, type = "list")
  expect_length(edist, 122)
  expect_true(all(vapply(edist, is_epidist, FUN.VALUE = logical(1))))
})

test_that("sysdata is the same as .read_epidist_db output", {
  # skipped due to covr failing when checking body of object attributes
  skip_on_covr()
  # .read_epidist_db uses numerical optimisation which can converge to
  # different parameter estimates
  set.seed(1)
  sysdat <- suppressMessages(epidist_db())
  db <- .read_epidist_db()
  expect_equal(sysdat, db, tolerance = 2e-3)
})

test_that(".read_epidist_db fails correctly when jsonlite is not installed", {
  with_mocked_bindings(
    .is_pkg_installed = function(package) FALSE,
    code = expect_error(
      .read_epidist_db(),
      regexp =
        "Cannot use this internal function without \\{jsonlite\\} installed" # nolint file.path
    )
  )
})

test_that(".is_pkg_installed works as expected", {
  expect_true(.is_pkg_installed(package = "distributional"))
  expect_false(.is_pkg_installed(package = "jsonlit"))
})

test_that("as.data.frame works for <multi_epidist>", {
  # message about missing citation suppressed
  edist <- suppressMessages(epidist_db())
  df <- as.data.frame(edist)
  expect_s3_class(df, class = "data.frame")
  expect_identical(dim(df), c(122L, 10L))
  expect_identical(
    colnames(df),
    c("disease", "pathogen", "epi_distribution", "prob_distribution",
      "uncertainty", "summary_stats", "citation", "metadata", "method_assess",
      "notes")
  )
})
