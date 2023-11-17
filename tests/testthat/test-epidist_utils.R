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
      title = "Incubation period of COVID",
      journal = "Journal of Epi",
      DOI = "10.1282718",
      PMID = 84772544
    )
  )
  expect_s3_class(citation, "bibentry")
  expect_s3_class(citation$author, "person")
  expect_identical(citation$PMID, "84772544")
})

test_that("clean_epidist_params works as expected for gamma", {
  gamma_params <- c(shape = 1, scale = 1)
  class(gamma_params) <- "gamma"
  params <- clean_epidist_params(prob_dist_params = gamma_params)
  expect_identical(params, c(shape = 1, scale = 1))

  gamma_params <- c(shape = 1, rate = 0.5)
  class(gamma_params) <- "gamma"
  params <- clean_epidist_params(prob_dist_params = gamma_params)
  expect_identical(params, c(shape = 1, scale = 2))
})

test_that("clean_epidist_params fails when gamma parameters are incorrect", {
  gamma_params <- c(meanlog = 1, sdlog = 1)
  class(gamma_params) <- "gamma"
  expect_error(
    clean_epidist_params(prob_dist_params = gamma_params),
    regexp = "Names of gamma distribution parameters are incorrect"
  )
})

test_that("clean_epidist_params works as expected for lnorm", {
  lnorm_params <- c(meanlog = 1, sdlog = 1)
  class(lnorm_params) <- "lnorm"
  params <- clean_epidist_params(prob_dist_params = lnorm_params)
  expect_identical(params, c(meanlog = 1, sdlog = 1))

  lnorm_params <- c(mu = 2, sigma = 2)
  class(lnorm_params) <- "lnorm"
  params <- clean_epidist_params(prob_dist_params = lnorm_params)
  expect_identical(params, c(meanlog = 2, sdlog = 2))
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

test_that("clean_epidist_params works as expected for weibull", {
  weibull_params <- c(shape = 1, scale = 1)
  class(weibull_params) <- "weibull"
  params <- clean_epidist_params(prob_dist_params = weibull_params)
  expect_identical(params, c(shape = 1, scale = 1))
})

test_that("clean_epidist_params fails when weibull parameters are incorrect", {
  weibull_params <- c(meanlog = 1, sdlog = 1)
  class(weibull_params) <- "weibull"
  expect_error(
    clean_epidist_params(prob_dist_params = weibull_params),
    regexp = "Names of Weibull distribution parameters are incorrect"
  )
})

test_that("clean_epidist_params works as expected for nbinom", {
  nbinom_params <- c(n = 2, p = 0.5)
  class(nbinom_params) <- "nbinom"
  params <- clean_epidist_params(prob_dist_params = nbinom_params)
  expect_identical(params, c(mean = 2, dispersion = 2))

  nbinom_params <- c(mean = 1, dispersion = 1)
  class(nbinom_params) <- "nbinom"
  params <- clean_epidist_params(prob_dist_params = nbinom_params)
  expect_identical(params, c(mean = 1, dispersion = 1))
})

test_that("clean_epidist_params fails when nbinom parameters are incorrect", {
  nbinom_params <- c(meanlog = 1, sdlog = 1)
  class(nbinom_params) <- "nbinom"
  expect_error(
    clean_epidist_params(prob_dist_params = nbinom_params),
    regexp = "Names of negative binomial distribution parameters are incorrect"
  )
})

test_that("clean_epidist_params works as expected for geom", {
  geom_params <- c(prob = 0.5)
  class(geom_params) <- "geom"
  params <- clean_epidist_params(prob_dist_params = geom_params)
  expect_identical(params, c(prob = 0.5))

  geom_params <- c(p = 0.5)
  class(geom_params) <- "geom"
  params <- clean_epidist_params(prob_dist_params = geom_params)
  expect_identical(params, c(prob = 0.5))

  geom_params <- c(mean = 2)
  class(geom_params) <- "geom"
  params <- clean_epidist_params(prob_dist_params = geom_params)
  expect_identical(params, c(prob = 0.5))
})

test_that("clean_epidist_params fails when geom parameters are incorrect", {
  geom_params <- c(meanlog = 1, sdlog = 1)
  class(geom_params) <- "geom"
  expect_error(
    clean_epidist_params(prob_dist_params = geom_params),
    regexp = "Names of geometric distribution parameters are incorrect"
  )
})

test_that("clean_epidist_params works as expected for pois", {
  pois_params <- c(mean = 0.5)
  class(pois_params) <- "pois"
  params <- clean_epidist_params(prob_dist_params = pois_params)
  expect_identical(params, c(mean = 0.5))

  pois_params <- c(l = 0.5)
  class(pois_params) <- "pois"
  params <- clean_epidist_params(prob_dist_params = pois_params)
  expect_identical(params, c(mean = 0.5))

  pois_params <- c(lambda = 0.5)
  class(pois_params) <- "pois"
  params <- clean_epidist_params(prob_dist_params = pois_params)
  expect_identical(params, c(mean = 0.5))
})

test_that("clean_epidist_params fails when pois parameters are incorrect", {
  pois_param <- c(means = 1)
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
  expect_identical(disease, "covid 19")
})

test_that("clean_disease fails as expected", {
  expect_error(
    clean_disease(5),
    regexp = "(Assertion on 'x' failed)*(Must be of type)"
  )
})
