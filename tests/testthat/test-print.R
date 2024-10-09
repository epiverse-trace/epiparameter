test_that("epiparameter_db print method works as expected for > 5 <epiparameter>", {
  expect_snapshot(epiparameter_db())
})

test_that("epiparameter_db print method works as expected for <= 5 <epiparameter>", {
  expect_snapshot(
    epiparameter_db(disease = "SARS", epi_name = "offspring distribution")
  )
})