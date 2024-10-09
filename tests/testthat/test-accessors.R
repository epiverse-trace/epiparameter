test_that("get_parameters works as expected for epiparameter from db", {
  # suppress message about return
  ep <- suppressMessages(epiparameter_db(disease = "SARS", single_epiparameter = TRUE))
  params <- get_parameters(ep)
  expect_vector(params, ptype = numeric(1), size = 2)
  expect_named(params, c("meanlog", "sdlog"))
})

test_that("get_parameters works as expected for unparameterised epiparameter", {
  ep <- suppressMessages(
    epiparameter(
      disease = "Ebola",
      epi_name = "incubation period",
      prob_distribution = create_prob_distribution(prob_distribution = "gamma")
    )
  )
  expect_true(is.na(get_parameters(ep)))
})

test_that("get_parameters works as expected for continuous epiparameter", {
  ep <- suppressMessages(
    epiparameter(
      disease = "Ebola",
      epi_name = "incubation period",
      prob_distribution = create_prob_distribution(
        prob_distribution = "gamma",
        prob_distribution_params = c(shape = 1, scale = 1)
      )
    )
  )
  params <- get_parameters(ep)
  expect_vector(params, ptype = numeric(1), size = 2)
  expect_named(params, c("shape", "scale"))
})

test_that("get_parameters works as expected for discretised epiparameter", {
  ep <- suppressMessages(
    epiparameter(
      disease = "Ebola",
      epi_name = "incubation period",
      prob_distribution = create_prob_distribution(
        prob_distribution = "gamma",
        prob_distribution_params = c(shape = 1, scale = 1),
        discretise = TRUE
      )
    )
  )
  params <- get_parameters(ep)
  expect_vector(params, ptype = numeric(1), size = 2)
  expect_named(params, c("shape", "scale"))
})

test_that("get_citation works as expected for epiparameter from db", {
  # suppress message about return
  db <- suppressMessages(epiparameter_db())
  citation <- get_citation(db)
  expect_type(citation, "list")
  expect_length(citation, length(db))
})

test_that("get_citation works as expected for one entry from db", {
  ep <- suppressMessages(epiparameter_db(single_epiparameter = TRUE))
  citation <- get_citation(ep)
  expect_s3_class(citation, "bibentry")
})

test_that("get_citation works as expected for manual epiparameter", {
  # suppress message about citation
  ep <- suppressMessages(
    epiparameter(
      disease = "ebola",
      epi_name = "incubation_period",
      prob_distribution = create_prob_distribution(
        prob_distribution = "gamma",
        prob_distribution_params = c(shape = 1, scale = 1)
      ),
      citation = create_citation(
        author = person(given = "John F.", family = "Smith"),
        year = 2000,
        title = "Incubation period of COVID",
        journal = "Journal of Epi",
        doi = "10.19832/j.1366-9516.2012.09147.x"
      )
    )
  )
  expect_s3_class(get_citation(ep), "bibentry")
})

test_that("get_citation works as expected for epiparameter missing citation", {
  # suppress message about citation
  ep <- suppressMessages(
    epiparameter(
      disease = "ebola",
      epi_name = "incubation_period",
      prob_distribution = create_prob_distribution(
        prob_distribution = "gamma",
        prob_distribution_params = c(shape = 1, scale = 1)
      )
    )
  )
  citation <- get_citation(ep)
  expect_s3_class(citation, "bibentry")
  expect_null(citation$year)
  expect_identical(citation$title, "No citation")
})

test_that("get_citation works as expected for non-bibentry citation", {
  # suppress message about citation
  ep <- suppressMessages(
    epiparameter_db(single_epiparameter = TRUE)
  )
  ep$citation <- "WHO-Ebola-Response-Team (2015) NEJM"
  expect_error(get_citation(ep), regexp = "Citation should be a <bibentry>")
})

test_that("get_citation produces warnings with extra arguments", {
  # suppress message about citation
  ep <- suppressMessages(
    epiparameter_db(single_epiparameter = TRUE)
  )
  expect_warning(
    get_citation(ep, extra_arg = "args"),
    regexp = "(extra argument)*(will be disregarded)"
  )
})

test_that(".get_mixture_family works as expected", {
  ebola_si <- suppressMessages(
    epiparameter_db(disease = "Ebola", epi_name = "serial interval")
  )
  ep <- aggregate(ebola_si)
  expect_identical(
    .get_mixture_family(ep),
    rep("gamma", times = length(ebola_si))
  )
  incub <- suppressMessages(
    epiparameter_db(
      epi_name = "incubation period",
      subset = is_parameterised
    )
  )
  incub <- suppressMessages(
    epiparameter_db(
      disease = "Mpox",
      epi_name = "incubation period",
      subset = is_parameterised
    )
  )
  ep <- aggregate(incub)
  expect_identical(
    .get_mixture_family(ep),
    c(rep("lnorm", 2), "gamma", rep("lnorm", 2))
  )
})
