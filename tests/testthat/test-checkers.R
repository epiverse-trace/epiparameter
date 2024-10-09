test_that("is_parameterised works as expected with epiparameter parameters", {
  # message about missing citation suppressed
  ep <- suppressMessages(epiparameter(
    disease = "ebola",
    epi_name = "incubation_period",
    prob_distribution = create_prob_distribution(
      prob_distribution = "gamma",
      prob_distribution_params = c(shape = 1, scale = 1)
    )
  ))
  expect_true(is_parameterised(ep))
})

test_that("is_parameterised works as expected without epiparameter parameters", {
  # message about missing citation suppressed
  ep <- suppressMessages(epiparameter(
    disease = "ebola",
    epi_name = "incubation_period"
  ))
  expect_false(is_parameterised(ep))
})

test_that("is_parameterised works as expected for multi_epiparameter", {
  ep <- suppressMessages(epiparameter_db())
  res <- is_parameterised(ep)
  expect_vector(res, ptype = logical(1), size = length(ep))
})

test_that("is_parameterised works as expected with multi_epiparameter parameters", {
  ep <- suppressMessages(
    epiparameter_db(
      epi_name = "incubation period",
      author = "McAloon",
      single_epiparameter = TRUE
    )
  )
  expect_true(is_parameterised(ep))
})

test_that("is_parameterised works as expected without parameters", {
  ep <- suppressMessages(
    epiparameter_db(epi_name = "incubation period", author = "Alene")
  )
  expect_false(is_parameterised(ep))
})
