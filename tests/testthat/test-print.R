test_that("epidist_db print method works as expected for > 5 <epidist>", {
  expect_snapshot(epidist_db())
})

test_that("epidist_db print method works as expected for <= 5 <epidist>", {
  expect_snapshot(
    epidist_db(disease = "SARS", epi_dist = "offspring distribution")
  )
})