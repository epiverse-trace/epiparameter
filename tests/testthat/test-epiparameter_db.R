test_that("epiparameter_db works as expected", {
  # suppress message about citation
  db <- suppressMessages(
    epiparameter_db(disease = "influenza", epi_dist = "serial interval")
  )

  expect_s3_class(db, class = "epiparameter")
  expect_length(db, 10)
})

test_that("epiparameter_db works as expected with author specified", {
  # suppress message about citation
  ep <- suppressMessages(
    epiparameter_db(
      disease = "influenza",
      epi_dist = "incubation period",
      author = "Ghani"
    )
  )

  expect_s3_class(ep, class = "epiparameter")
  expect_length(ep, 10)
})

test_that("epiparameter_db works as expected with subsetting", {
  # suppress message about citation
  ep <- suppressMessages(
    epiparameter_db(
      disease = "influenza",
      epi_dist = "incubation period",
      subset = sample_size > 100
    )
  )

  expect_s3_class(ep, class = "multi_epiparameter")
  expect_length(ep, 10)
})

test_that("epiparameter_db works as expected with functional subsetting", {
  db <- suppressMessages(
    epiparameter_db(
      disease = "COVID-19",
      epi_dist = "incubation period",
      subset = is_parameterised
    )
  )

  expect_type(db, "list")
  expect_s3_class(db, "multi_epiparameter")
  expect_length(db, 11)
})

test_that("epiparameter_db works as expected with single_epiparameter as TRUE", {
  # suppress message about citation
  ep <- suppressMessages(
    epiparameter_db(
      disease = "influenza",
      epi_dist = "incubation period",
      single_epiparameter = TRUE
    )
  )

  expect_s3_class(ep, class = "epiparameter")
  expect_length(ep, 10)
})

test_that("epiparameter_db chooses truncated with single_epiparameter as TRUE", {
  # suppress message about citation
  ep <- suppressMessages(
    epiparameter_db(
      disease = "COVID-19",
      epi_dist = "onset to death",
      single_epiparameter = TRUE
    )
  )

  expect_s3_class(ep, class = "epiparameter")
  expect_true(ep$method_assess$right_truncated)
})

test_that("epiparameter_db works as expected with subsetting and single_epiparameter", {
  ep <- suppressMessages(
    epiparameter_db(
      disease = "COVID-19",
      epi_dist = "incubation period",
      subset = sample_size > 50,
      single_epiparameter = TRUE
    )
  )

  expect_s3_class(ep, class = "epiparameter")
  expect_length(ep, 10)
})

test_that("epiparameter_db works as expected with subsetting and author", {
  db <- suppressMessages(
    epiparameter_db(
      disease = "COVID-19",
      epi_dist = "incubation period",
      author = "McAloon",
      subset = sample_size > 10
    )
  )

  expect_s3_class(db, class = "multi_epiparameter")
  expect_length(db, 2)
})

test_that("epiparameter_db works as expected with subsetting by prod_dist", {
  ep <- suppressMessages(
    epiparameter_db(
      disease = "COVID-19",
      epi_dist = "serial interval",
      author = "Nishiura",
      subset = prob_dist == "weibull"
    )
  )

  expect_s3_class(ep, class = "epiparameter")
  expect_length(ep, 10)
})

test_that("epiparameter_db works as expected with subsetting by pathogen", {
  # suppress message about citation
  db <- suppressMessages(
    epiparameter_db(
      pathogen = "SARS-CoV-2",
      epi_dist = "incubation period"
    )
  )

  expect_s3_class(db, class = "multi_epiparameter")
  expect_length(db, 15)
})

test_that("epiparameter_db fails as expected when author not recognised", {
  expect_error(
    epiparameter_db(
      disease = "influenza",
      epi_dist = "incubation period",
      author = "Lessler_et_al"
    ),
    regexp = "Parameters by Lessler_et_al are not available for influenza"
  )
})

test_that("epiparameter_db fails as expected when disease not recognised", {
  expect_error(
    epiparameter_db(disease = "COVI-19", epi_dist = "incubation period"),
    regexp = "incubation period distribution not available for COVI-19"
  )
})

test_that("epiparameter_db fails as expected when epi_dist not recognised", {
  expect_error(
    epiparameter_db(
      disease = "influenza",
      epi_dist = "delay dist"
    ),
    regexp = "delay dist distribution not available for influenza"
  )
})

test_that("epiparameter_db fails as expected with no entry in the database", {
  expect_error(
    epiparameter_db(
      disease = "RSV",
      epi_dist = "serial interval"
    ),
    regexp = "No entries in the database meet the search criteria."
  )
})

test_that("epiparameter_db gives message as expected with multiple entries", {
  expect_message(
    epiparameter_db(
      disease = "influenza",
      epi_dist = "incubation period",
      author = "Reich"
    ),
    regexp = "(Returning)*(results that match the criteria)"
  )
})

test_that("epiparameter_db fails as expected when subset given as string", {
  expect_error(
    epiparameter_db(
      disease = "influenza",
      epi_dist = "incubation period",
      subset = "author == 'Lessler_et_al'"
    ),
    regexp = "(Subsetting is done with expressions)"
  )
})

test_that("epiparameter_db fails as expected when subset returns no results", {
  expect_error(
    epiparameter_db(
      disease = "covid-19",
      epi_dist = "incubation period",
      subset = year == 2018
    ),
    regexp = "No entries in the database meet the search criteria."
  )
})

test_that(".read_epiparameter_db works as expected", {
  db <- .read_epiparameter_db()
  expect_s3_class(db, class = "multi_epiparameter")
  expect_type(db, type = "list")
  expect_length(db, 125)
  expect_true(all(vapply(db, is_epiparameter, FUN.VALUE = logical(1))))
})

test_that("sysdata is the same as .read_epiparameter_db output", {
  # skipped due to covr failing when checking body of object attributes
  skip_on_covr()
  # .read_epiparameter_db uses numerical optimisation which can converge to
  # different parameter estimates
  set.seed(1)
  sysdat <- suppressMessages(epiparameter_db())
  db <- .read_epiparameter_db()
  expect_equal(sysdat, db, tolerance = 2e-3)
})

test_that(".read_epiparameter_db fails correctly when jsonlite is not installed", {
  with_mocked_bindings(
    .is_pkg_installed = function(package) FALSE,
    code = expect_error(
      .read_epiparameter_db(),
      regexp =
        "Cannot use this internal function without \\{jsonlite\\} installed" # nolint file.path
    )
  )
})

test_that(".is_pkg_installed works as expected", {
  expect_true(.is_pkg_installed(package = "distributional"))
  expect_false(.is_pkg_installed(package = "jsonlit"))
})

test_that("as.data.frame works for <multi_epiparameter>", {
  # message about missing citation suppressed
  db <- suppressMessages(epiparameter_db())
  df <- as.data.frame(db)
  expect_s3_class(df, class = "data.frame")
  expect_identical(dim(df), c(125L, 10L))
  expect_identical(
    colnames(df),
    c("disease", "pathogen", "epi_distribution", "prob_distribution",
      "uncertainty", "summary_stats", "citation", "metadata", "method_assess",
      "notes")
  )
})
