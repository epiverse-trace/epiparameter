test_that("create_epidist_metadata fails when vector is given for non-vb", {
  expect_error(
    create_epidist_metadata(
      transmission_mode = "natural_human_to_human",
      vector = "mosquito"
    ),
    regexp = "(A vector is given for a non-vector-borne disease)"
  )
})

test_that("create_epidist_citation works with PMID", {
  # suppress message about citation
  citation <- suppressMessages(
    create_epidist_citation(
      author = "Smith_etal",
      year = 2002,
      DOI = "10.1282718",
      PMID = 84772544
    )
  )
  expect_identical(
    citation,
    "Smith et al. (2002) <10.1282718> PMID: 84772544"
  )
})

test_that("possible_epidist_params works as expected", {
  expect_output(possible_epidist_params())
})

test_that("clean_epidist_params fails when gamma parameters are incorrect", {
  gamma_params <- c(meanlog = 1, sdlog = 1)
  class(gamma_params) <- "gamma"
  expect_error(
    clean_epidist_params(prob_dist_params = gamma_params),
    regexp = "Names of gamma distribution parameters are incorrect"
  )
})

test_that("clean_epidist_params fails when lognormal parameters are
          incorrect", {
  lognormal_params <- c(shape = 1, scale = 1)
  class(lognormal_params) <- "lnorm"
  expect_error(
    clean_epidist_params(prob_dist_params = lognormal_params),
    regexp = "Names of lognormal distribution parameters are incorrect"
  )
})

test_that("clean_epidist_params fails when weibull parameters are incorrect", {
  weibull_params <- c(meanlog = 1, sdlog = 1)
  class(weibull_params) <- "weibull"
  expect_error(
    clean_epidist_params(prob_dist_params = weibull_params),
    regexp = "Names of Weibull distribution parameters are incorrect"
  )
})

test_that("clean_epidist_params fails when nbinom parameters are incorrect", {
  nbinom_params <- c(meanlog = 1, sdlog = 1)
  class(nbinom_params) <- "nbinom"
  expect_error(
    clean_epidist_params(prob_dist_params = nbinom_params),
    regexp = "Names of negative binomial distribution parameters are incorrect"
  )
})

test_that("clean_epidist_params fails when geom parameters are incorrect", {
  geom_params <- c(meanlog = 1, sdlog = 1)
  class(geom_params) <- "geom"
  expect_error(
    clean_epidist_params(prob_dist_params = geom_params),
    regexp = "Names of geometric distribution parameters are incorrect"
  )
})

test_that("clean_epidist_params fails when pois parameters are incorrect", {
  pois_param <- c("means" = 1)
  class(pois_param) <- "pois"
  expect_error(
    clean_epidist_params(prob_dist_params = pois_param),
    regexp = "Name of poisson distribution parameter is incorrect"
  )
})

test_that("clean_epidist_params works for default method", {
  weibull_params <- c(meanlog = 1, sdlog = 1)
  class(weibull_params) <- "distribution"
  expect_message(
    clean_epidist_params(prob_dist_params = weibull_params),
    regexp = "parameters class not recognised"
  )
})

test_that("clean_epidist_params works for unparameterised (NA), (#161)", {
  params <- NA
  class(params) <- "gamma"
  res <- clean_epidist_params(prob_dist_params = params)
  expect_identical(res, c(shape = NA, scale = NA))

  class(params) <- "lnorm"
  res <- clean_epidist_params(prob_dist_params = params)
  expect_identical(res, c(meanlog = NA, sdlog = NA))

  class(params) <- "weibull"
  res <- clean_epidist_params(prob_dist_params = params)
  expect_identical(res, c(shape = NA, scale = NA))

  class(params) <- "nbinom"
  res <- clean_epidist_params(prob_dist_params = params)
  expect_identical(res, c(mean = NA, dispersion = NA))

  class(params) <- "geom"
  res <- clean_epidist_params(prob_dist_params = params)
  expect_identical(res, c(prob = NA))

  class(params) <- "pois"
  res <- clean_epidist_params(prob_dist_params = params)
  expect_identical(res, c(mean = NA))
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

test_that("clean_disease works as expected", {
  disease <- clean_disease("COVID-19")
  expect_identical(disease, "covid_19")
})

test_that("clean_disease fails as expected", {
  expect_error(
    clean_disease(5),
    regexp = "(Assertion on 'x' failed)*(Must be of type)"
  )
})
