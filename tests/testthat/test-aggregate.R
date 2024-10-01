{
  suppressMessages(
    ebola_si <- epiparameter_db(epi_dist = "serial interval", disease = "ebola")
  )
}

test_that("aggregate works as expected", {
  ep <- aggregate(ebola_si)
  expect_s3_class(ep, class = "epiparameter")
  expect_identical(family(ep), "mixture")
  expect_identical(length(ep$citation), length(ebola_si))
})

test_that("aggregate works as expected with sample size weights", {
  ep <- aggregate(ebola_si, weighting = "sample_size")
  expect_s3_class(ep, class = "epiparameter")
  expect_identical(family(ep), "mixture")
  expect_identical(length(ep$citation), length(ebola_si))
})

test_that("aggregate works as expected with custom weights", {
  ep <- aggregate(
    ebola_si,
    weighting = "custom",
    weights = c(0.1, 0.2, 0.3, 0.4)
  )
  expect_s3_class(ep, class = "epiparameter")
  expect_identical(family(ep), "mixture")
  expect_identical(length(ep$citation), length(ebola_si))
})

test_that("aggregate works as expected for different distributions", {
  incub <- suppressMessages(
    epiparameter_db(
      disease = "Mpox",
      epi_dist = "incubation period",
      subset = is_parameterised
    )
  )
  ep <- aggregate(incub)
  expect_s3_class(ep, class = "epiparameter")
  expect_identical(family(ep), "mixture")
  expect_identical(length(ep$citation), length(incub))
})

test_that("aggregate warns when dropping NA sample size", {
  ebola_si[[1]]$metadata$sample_size <- NA
  ebola_si[[2]]$metadata$sample_size <- NA
  expect_warning(
    aggregate(ebola_si, weighting = "sample_size"),
    regexp = "(Input distribution)*(WHO)*(has been dropped)*(sample size)")
})

test_that("aggregate fails as expected for multiple diseases", {
  ebola_si[[1]]$disease <- "marburg"
  expect_error(
    aggregate(ebola_si),
    regexp = "All <epiparameter>s in x must contain the same disease"
  )
})

test_that("aggregate fails as expected for multiple pathogens", {
  ebola_si[[1]]$pathogen <- "marburg virus"
  expect_error(
    aggregate(ebola_si),
    regexp = "All <epiparameter>s in x must contain the same pathogen"
  )
})

test_that("aggregate fails as expected for multiple epi_dists", {
  ebola_si[[1]]$epi_dist <- "generation time"
  expect_error(
    aggregate(ebola_si),
    regexp = "All <epiparameter>s in x must contain the same type of epi_dist"
  )
})

test_that("aggregate fails as expected with unparameterised <epiparameter>", {
  incub <- suppressMessages(
    epiparameter_db(disease = "MERS", epi_dist = "incubation period")
  )
  expect_error(
    aggregate(incub),
    regexp = "(aggregate() requires all <epiparameter> objects)*(parameterised)"
  )
})

test_that("aggregate fails as expected for with discretised <epiparmeter>", {
  ebola_si[[1]] <- discretise(ebola_si[[1]])
  expect_error(
    aggregate(ebola_si),
    regexp = "(`aggregate()` only works with distributions)*(not discretised)"
  )
})

test_that("aggregate fails as expected with custom weighting without weights", {
  expect_error(
    aggregate(ebola_si, weighting = "custom"),
    regexp = "(weights)*(required for each distribution)*(weighting = custom)"
  )
})
