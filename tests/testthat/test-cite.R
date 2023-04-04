test_that("get_citation works as expected for epidist from db", {
  eparam <- epiparam()
  edist <- as_epidist(eparam[12, ])
  expect_type(get_citation(edist), "character")
})

test_that("get_citation works as expected for manual epidist", {
  edist <- epidist(
    disease = "ebola",
    epi_dist = "incubation_period",
    prob_distribution = "gamma",
    prob_distribution_params = c(shape = 1, scale = 1),
    citation = create_epidist_citation(
      author = "Smith_etal",
      year = 2000,
      DOI = "10.19832/j.1366-9516.2012.09147.x"
    )
  )
  expect_type(get_citation(edist), "character")
})

test_that("get_citation works as expected for epidist missing citation", {
  edist <- epidist(
    disease = "ebola",
    epi_dist = "incubation_period",
    prob_distribution = "gamma",
    prob_distribution_params = c(shape = 1, scale = 1)
  )
  citation <- get_citation(edist)
  expect_type(citation, "character")
  expect_identical(citation, "No citation available")
})

test_that("get_citation works as expected for epiparam", {
  eparam <- epiparam()
  citation <- get_citation(eparam)
  expect_type(citation, "list")
  expect_identical(length(citation), nrow(eparam))
})

test_that("get_citation works as expected for epiparam with one entry", {
  eparam <- epiparam()
  citation <- get_citation(eparam[12, ])
  expect_type(citation, "list")
  expect_identical(length(citation), nrow(eparam[12, ]))
})

