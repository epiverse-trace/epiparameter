test_that("create_epidist_metadata fails when vector is given for non-vb", {
  expect_error(
    create_epidist_metadata(vector_borne = FALSE, vector = "mosquito"),
    regexp = "(A vector is given for a non-vector-borne disease)"
  )
})

test_that("create_epidist_citation works with PMID", {
    citation <- create_epidist_citation(
      author = "Smith_etal",
      year = 2002,
      DOI = "10.1282718",
      PMID = 84772544,
      use_PMID = TRUE
    )
    expect_identical(
      citation,
      "Smith et al. (2002) <10.1282718> PMID: 84772544"
    )
})

test_that("create_epidist_citation fails when PMID is used but not given", {
  expect_error(
    create_epidist_citation(
      author = "Smith_etal", year = 2002, DOI = "10.1282718", use_PMID = TRUE
    ),
    regexp = "use_PMID set to TRUE but PMID not provided"
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
  class(lognormal_params) <- "lognormal"
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
    regexp = "Names of weibull distribution parameters are incorrect"
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
