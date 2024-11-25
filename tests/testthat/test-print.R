# tests are skipped when R version < 4.2.0 due to a change in base tools::Rd2txt()
# https://github.com/r-devel/r-svn/commit/aaabe42cc32582db77ba275233def72b11e32e45

test_that("epiparameter_db print method works as expected for > 5 <epiparameter>", {
  skip_if(getRversion() < "4.2.0")
  expect_snapshot(epiparameter_db())
})

test_that("epiparameter_db print method works as expected for <= 5 <epiparameter>", {
  skip_if(getRversion() < "4.2.0")
  expect_snapshot(
    epiparameter_db(disease = "SARS", epi_name = "offspring distribution")
  )
})

test_that("epiparameter.print works as expected", {
  expect_snapshot(epiparameter(
    disease = "ebola",
    epi_name = "incubation",
    prob_distribution = create_prob_distribution(
      prob_distribution = "gamma",
      prob_distribution_params = c(shape = 1, scale = 1)
    )
  ))
})

test_that("epiparameter.print works as expected", {
  expect_snapshot(epiparameter(
    disease = "ebola",
    epi_name = "incubation",
    prob_distribution = create_prob_distribution(
      prob_distribution = "gamma",
      prob_distribution_params = c(shape = 1, scale = 1),
      discretise = TRUE
    )
  ))
})
