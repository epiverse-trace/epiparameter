test_that("create_epidist_metadata fails when vector is given for non-vb", {
  expect_error(
    create_epidist_metadata(
      transmission_mode = "natural_human_to_human",
      vector = "mosquito"
    ),
    regexp = "(A vector is given for a non-vector-borne disease)"
  )
})

test_that("create_epidist_citation works with different author inputs", {
  cit <- suppressMessages(create_epidist_citation(
    author = person(given = "John", family = "Smith"),
    year = 2002,
    title = "COVID-19 incubation period",
    journal = "Epi Journal",
    doi = "10.19832/j.1366-9516.2012.09147.x" # nolint file.path
  ))
  expect_s3_class(cit, class = "bibentry")
  expect_s3_class(cit$author, class = "person")
  expect_identical(cit$author$given, "John")
  expect_identical(cit$author$family, "Smith")

  cit <- suppressMessages(create_epidist_citation(
    author = person(
      given = list("John", "Amy"), family = list("Smith", "Jones")
    ),
    year = 2002,
    title = "COVID-19 incubation period",
    journal = "Epi Journal",
    doi = "10.19832/j.1366-9516.2012.09147.x" # nolint file.path
  ))
  expect_s3_class(cit, class = "bibentry")
  expect_s3_class(cit$author, class = "person")
  expect_identical(cit$author$given, list("John", "Amy"))
  expect_identical(cit$author$family, list("Smith", "Jones"))

  cit <- suppressMessages(create_epidist_citation(
    author = "John Smith",
    year = 2002,
    title = "COVID-19 incubation period",
    journal = "Epi Journal",
    doi = "10.19832/j.1366-9516.2012.09147.x" # nolint file.path
  ))
  expect_s3_class(cit, class = "bibentry")
  expect_s3_class(cit$author, class = "person")
  expect_identical(cit$author$given, "John")
  expect_identical(cit$author$family, "Smith")

  cit <- suppressMessages(create_epidist_citation(
    author = c("John Smith", "Amy Jones", "WHO Team"),
    year = 2002,
    title = "COVID-19 incubation period",
    journal = "Epi Journal",
    doi = "10.19832/j.1366-9516.2012.09147.x" # nolint file.path
  ))
  expect_s3_class(cit, class = "bibentry")
  expect_s3_class(cit$author, class = "person")
  expect_identical(cit$author$given, list("John", "Amy", "WHO"))
  expect_identical(cit$author$family, list("Smith", "Jones", "Team"))

  cit <- suppressMessages(create_epidist_citation(
    author = list("John Smith", "Amy Jones", "WHO Team"),
    year = 2002,
    title = "COVID-19 incubation period",
    journal = "Epi Journal",
    doi = "10.19832/j.1366-9516.2012.09147.x" # nolint file.path
  ))
  expect_s3_class(cit, class = "bibentry")
  expect_s3_class(cit$author, class = "person")
  expect_identical(cit$author$given, list("John", "Amy", "WHO"))
  expect_identical(cit$author$family, list("Smith", "Jones", "Team"))
})

test_that("create_epidist_citation works with PMID", {
  # suppress message about citation
  citation <- suppressMessages(
    create_epidist_citation(
      author = person(given = "John", family = "Smith"),
      year = 2002,
      title = "Incubation period of COVID",
      journal = "Journal of Epi",
      doi = "10.1282718",
      pmid = 84772544
    )
  )
  expect_s3_class(citation, "bibentry")
  expect_s3_class(citation$author, "person")
  expect_identical(citation$pmid, "84772544")
})

test_that(".clean_epidist_params works as expected for gamma", {
  params <- .clean_epidist_params(
    prob_dist = "gamma",
    prob_dist_params = c(shape = 1, scale = 1)
  )
  expect_identical(params, c(shape = 1, scale = 1))

  params <- .clean_epidist_params(
    prob_dist = "gamma",
    prob_dist_params = c(shape = 1, rate = 0.5)
  )
  expect_identical(params, c(shape = 1, scale = 2))
})

test_that(".clean_epidist_params fails when gamma parameters are incorrect", {
  expect_error(
    .clean_epidist_params(
      prob_dist = "gamma",
      prob_dist_params = c(meanlog = 1, sdlog = 1)
    ),
    regexp = "Invalid parameterisation for gamma distribution"
  )
})

test_that(".clean_epidist_params works as expected for lnorm", {
  params <- .clean_epidist_params(
    prob_dist = "lnorm",
    prob_dist_params = c(meanlog = 1, sdlog = 1)
  )
  expect_identical(params, c(meanlog = 1, sdlog = 1))

  params <- .clean_epidist_params(
    prob_dist = "lnorm",
    prob_dist_params = c(mu = 2, sigma = 2)
  )
  expect_identical(params, c(meanlog = 2, sdlog = 2))
})

test_that(".clean_epidist_params fails when lnorm parameters are incorrect", {
  expect_error(
    .clean_epidist_params(
      prob_dist = "lnorm",
      prob_dist_params = c(shape = 1, scale = 1)
    ),
    regexp = "Invalid parameterisation for lnorm distribution"
  )
})

test_that(".clean_epidist_params works as expected for weibull", {
  params <- .clean_epidist_params(
    prob_dist = "weibull",
    prob_dist_params = c(shape = 1, scale = 1)
  )
  expect_identical(params, c(shape = 1, scale = 1))
})

test_that(".clean_epidist_params fails when weibull parameters are incorrect", {
  expect_error(
    .clean_epidist_params(
      prob_dist = "weibull",
      prob_dist_params = c(meanlog = 1, sdlog = 1)
    ),
    regexp = "Invalid parameterisation for weibull distribution"
  )
})

test_that(".clean_epidist_params works as expected for nbinom", {
  params <- .clean_epidist_params(
    prob_dist = "nbinom",
    prob_dist_params = c(n = 2, p = 0.5)
  )
  expect_identical(params, c(mean = 2, dispersion = 2))

  params <- .clean_epidist_params(
    prob_dist = "nbinom",
    prob_dist_params = c(mean = 1, dispersion = 1)
  )
  expect_identical(params, c(mean = 1, dispersion = 1))
})

test_that(".clean_epidist_params fails when nbinom parameters are incorrect", {
  expect_error(
    .clean_epidist_params(
      prob_dist = "nbinom",
      prob_dist_params = c(meanlog = 1, sdlog = 1)
    ),
    regexp = "Invalid parameterisation for nbinom distribution"
  )
})

test_that(".clean_epidist_params works as expected for geom", {
  params <- .clean_epidist_params(
    prob_dist = "geom",
    prob_dist_params = c(prob = 0.5)
  )
  expect_identical(params, c(prob = 0.5))

  params <- .clean_epidist_params(
    prob_dist = "geom",
    prob_dist_params = c(p = 0.5)
  )
  expect_identical(params, c(prob = 0.5))

  params <- .clean_epidist_params(
    prob_dist = "geom",
    prob_dist_params = c(mean = 2)
  )
  expect_identical(params, c(prob = 0.5))
})

test_that(".clean_epidist_params fails when geom parameters are incorrect", {
  expect_error(
    .clean_epidist_params(
      prob_dist = "geom",
      prob_dist_params = c(meanlog = 1, sdlog = 1)
    ),
    regexp = "Invalid parameterisation for geom distribution"
  )
})

test_that(".clean_epidist_params works as expected for pois", {
  params <- .clean_epidist_params(
    prob_dist = "pois",
    prob_dist_params = c(mean = 0.5)
  )
  expect_identical(params, c(mean = 0.5))

  params <- .clean_epidist_params(
    prob_dist = "pois",
    prob_dist_params = c(l = 0.5)
  )
  expect_identical(params, c(mean = 0.5))

  params <- .clean_epidist_params(
    prob_dist = "pois",
    prob_dist_params = c(lambda = 0.5)
  )
  expect_identical(params, c(mean = 0.5))
})

test_that(".clean_epidist_params fails when pois parameters are incorrect", {
  expect_error(
    .clean_epidist_params(
      prob_dist = "pois",
      prob_dist_params = c(means = 1)
    ),
    regexp = "Invalid parameterisation for pois distribution"
  )
})

test_that(".clean_epidist_params works as expected for exp", {
  params <- .clean_epidist_params(
    prob_dist = "exp",
    prob_dist_params = c(rate = 2)
  )
  expect_identical(params, c(rate = 2))

  params <- .clean_epidist_params(
    prob_dist = "exp",
    prob_dist_params = c(lambda = 2)
  )
  expect_identical(params, c(rate = 2))

  params <- .clean_epidist_params(
    prob_dist = "exp",
    prob_dist_params = c(mean = 0.5)
  )
  expect_identical(params, c(rate = 2))
})

test_that(".clean_epidist_params fails when exp parameters are incorrect", {
  expect_error(
    .clean_epidist_params(
      prob_dist = "exp",
      prob_dist_params = c(means = 1)
    ),
    regexp = "Invalid parameterisation for exp distribution"
  )
})

test_that(".clean_epidist_params fails as expected", {
  expect_error(
    .clean_epidist_params(
      prob_dist = "distribution",
      prob_dist_params = c(meanlog = 1, sdlog = 1)
    ),
    regexp = "Invalid parameterisation for distribution distribution"
  )
})

test_that("create_epidist_region works as expected", {
  region <- create_epidist_region(
    continent = "Europe",
    country = "UK",
    region = "Cambridgeshire",
    city = "Cambridge"
  )
  expect_identical(
    region,
    list(
      continent = "Europe",
      country = "UK",
      region = "Cambridgeshire",
      city = "Cambridge"
    )
  )

  region <- create_epidist_region(
    continent = NA,
    country = "UK",
    region = NA,
    city = "Cambridge"
  )
  expect_identical(
    region,
    list(
      continent = NA,
      country = "UK",
      region = NA,
      city = "Cambridge"
    )
  )
})

test_that(".clean_string works as expected", {
  expect_identical(.clean_string("COVID-19"), "covid 19")
})

test_that(".clean_string fails as expected", {
  expect_error(
    .clean_string(5),
    regexp = "(Assertion on 'x' failed)*(Must be of type)"
  )
})
