test_that("get_parameters works as expected for epidist from db", {
  # suppress message about return
  edist <- suppressMessages(epidist_db(disease = "SARS", single_epidist = TRUE))
  params <- get_parameters(edist)
  expect_vector(params, ptype = numeric(1), size = 2)
  expect_named(params, c("meanlog", "sdlog"))
})

test_that("get_parameters works as expected for unparameterised epidist", {
  edist <- suppressMessages(
    epidist(
      disease = "Ebola",
      epi_dist = "incubation period",
      prob_distribution = "gamma"
    )
  )
  expect_true(is.na(get_parameters(edist)))
})

test_that("get_parameters works as expected for continuous epidist", {
  edist <- suppressMessages(
    epidist(
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

test_that("get_parameters works as expected for discretised epidist", {
  edist <- suppressMessages(
    epidist(
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

test_that("get_citation works as expected for epidist from db", {
  # suppress message about return
  edist <- suppressMessages(epidist_db())
  citation <- get_citation(edist)
  expect_type(citation, "list")
  expect_length(citation, length(edist))
})

test_that("get_citation works as expected for one entry from db", {
  edist <- suppressMessages(epidist_db(single_epidist = TRUE))
  citation <- get_citation(edist)
  expect_s3_class(citation, "bibentry")
})

test_that("get_citation works as expected for manual epidist", {
  # suppress message about citation
  edist <- suppressMessages(
    epidist(
      disease = "ebola",
      epi_dist = "incubation_period",
      prob_distribution = "gamma",
      prob_distribution_params = c(shape = 1, scale = 1),
      citation = create_epidist_citation(
        author = person(given = "John F.", family = "Smith"),
        year = 2000,
        title = "Incubation period of COVID",
        journal = "Journal of Epi",
        DOI = "10.19832/j.1366-9516.2012.09147.x"
      )
    )
  )
  expect_s3_class(get_citation(edist), "bibentry")
})

test_that("get_citation works as expected for epidist missing citation", {
  # suppress message about citation
  edist <- suppressMessages(
    epidist(
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
    epidist_db(single_epidist = TRUE)
  )
  edist$citation <- "WHO-Ebola-Response-Team (2015) NEJM"
  expect_error(get_citation(edist), regexp = "Citation should be a <bibentry>")
})

test_that("get_citation produces warnings with extra arguments", {
  # suppress message about citation
  edist <- suppressMessages(
    epidist_db(single_epidist = TRUE)
  )
  expect_warning(
    get_citation(edist, extra_arg = "args"),
    regexp = "(extra argument)*(will be disregarded)"
  )
})
