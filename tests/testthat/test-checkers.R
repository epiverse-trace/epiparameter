test_that("is_parameterised works as expected with epiparameter parameters", {
  # message about missing citation suppressed
  edist <- suppressMessages(epiparameter(
    disease = "ebola",
    epi_dist = "incubation_period",
    prob_distribution = "gamma",
    prob_distribution_params = c(shape = 1, scale = 1)
  ))
  expect_true(is_parameterised(edist))
})

test_that("is_parameterised works as expected without epiparameter parameters", {
  # message about missing citation suppressed
  edist <- suppressMessages(epiparameter(
    disease = "ebola",
    epi_dist = "incubation_period"
  ))
  expect_false(is_parameterised(edist))
})

test_that("is_parameterised works as expected for multi_epiparameter", {
  edist <- suppressMessages(epiparameter_db())
  res <- is_parameterised(edist)
  expect_vector(res, ptype = logical(1), size = length(edist))
})

test_that("is_parameterised works as expected with multi_epiparameter parameters", {
  edist <- suppressMessages(
    epiparameter_db(
      epi_dist = "incubation period",
      author = "McAloon",
      single_epiparameter = TRUE
    )
  )
  expect_true(is_parameterised(edist))
})

test_that("is_parameterised works as expected without epiparam parameters", {
  edist <- suppressMessages(
    epiparameter_db(epi_dist = "incubation period", author = "Alene")
  )
  expect_false(is_parameterised(edist))
})
