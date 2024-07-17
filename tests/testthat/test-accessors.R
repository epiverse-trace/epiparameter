test_that("get_parameters works as expected for epiparameter from db", {
  # suppress message about return
  edist <- suppressMessages(epiparameter_db(disease = "SARS", single_epiparameter = TRUE))
  params <- get_parameters(edist)
  expect_vector(params, ptype = numeric(1), size = 2)
  expect_named(params, c("meanlog", "sdlog"))
})

test_that("get_parameters works as expected for unparameterised epiparameter", {
  edist <- suppressMessages(
    epiparameter(
      disease = "Ebola",
      epi_dist = "incubation period",
      prob_distribution = "gamma"
    )
  )
  expect_true(is.na(get_parameters(edist)))
})

test_that("get_parameters works as expected for continuous epiparameter", {
  edist <- suppressMessages(
    epiparameter(
      disease = "Ebola",
      epi_dist = "incubation period",
      prob_distribution = "gamma",
      prob_distribution_params = c(shape = 1, scale = 1)
    )
  )
  params <- get_parameters(edist)
  expect_vector(params, ptype = numeric(1), size = 2)
  expect_named(params, c("shape", "scale"))
})

test_that("get_parameters works as expected for discretised epiparameter", {
  edist <- suppressMessages(
    epiparameter(
      disease = "Ebola",
      epi_dist = "incubation period",
      prob_distribution = "gamma",
      prob_distribution_params = c(shape = 1, scale = 1),
      discretise = TRUE
    )
  )
  params <- get_parameters(edist)
  expect_vector(params, ptype = numeric(1), size = 2)
  expect_named(params, c("shape", "scale"))
})

test_that("get_citation works as expected for epiparameter from db", {
  # suppress message about return
  edist <- suppressMessages(epiparameter_db())
  citation <- get_citation(edist)
  expect_type(citation, "list")
  expect_length(citation, length(edist))
})

test_that("get_citation works as expected for one entry from db", {
  edist <- suppressMessages(epiparameter_db(single_epiparameter = TRUE))
  citation <- get_citation(edist)
  expect_s3_class(citation, "bibentry")
})

test_that("get_citation works as expected for manual epiparameter", {
  # suppress message about citation
  edist <- suppressMessages(
    epiparameter(
      disease = "ebola",
      epi_dist = "incubation_period",
      prob_distribution = "gamma",
      prob_distribution_params = c(shape = 1, scale = 1),
      citation = create_citation(
        author = person(given = "John F.", family = "Smith"),
        year = 2000,
        title = "Incubation period of COVID",
        journal = "Journal of Epi",
        doi = "10.19832/j.1366-9516.2012.09147.x"
      )
    )
  )
  expect_s3_class(get_citation(edist), "bibentry")
})

test_that("get_citation works as expected for epiparameter missing citation", {
  # suppress message about citation
  edist <- suppressMessages(
    epiparameter(
      disease = "ebola",
      epi_dist = "incubation_period",
      prob_distribution = "gamma",
      prob_distribution_params = c(shape = 1, scale = 1)
    )
  )
  citation <- get_citation(edist)
  expect_s3_class(citation, "bibentry")
  expect_null(citation$year)
  expect_identical(citation$title, "No citation")
})

test_that("get_citation works as expected for non-bibentry citation", {
  # suppress message about citation
  edist <- suppressMessages(
    epiparameter_db(single_epiparameter = TRUE)
  )
  edist$citation <- "WHO-Ebola-Response-Team (2015) NEJM"
  expect_error(get_citation(edist), regexp = "Citation should be a <bibentry>")
})

test_that("get_citation produces warnings with extra arguments", {
  # suppress message about citation
  edist <- suppressMessages(
    epiparameter_db(single_epiparameter = TRUE)
  )
  expect_warning(
    get_citation(edist, extra_arg = "args"),
    regexp = "(extra argument)*(will be disregarded)"
  )
})
