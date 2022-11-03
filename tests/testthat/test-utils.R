test_that("calc_disc_dist_quantile works as expected", {
  prob <- dgamma(seq(0, 10, length.out = 21), shape = 2, scale = 2)
  days <- seq(0, 10, 0.5)
  quantiles <- c(0.025, 0.975)
  quants <- calc_disc_dist_quantile(
    prob = prob, 
    days = days, 
    quantile = quantiles
  )
  expect_vector(quants)
  expect_named(quants, expected = as.character(quantiles))
  expect_equal(quants, c("0.025" = 0, "0.975" = 9))
})

test_that("calc_disc_dist_quantile fails as expected", {
  prob <- dgamma(seq(0, 10, length.out = 21), shape = 2, scale = 2)
  days <- seq(0, 10, 0.5)
  quantiles <- c(0.025, 0.975)
  expect_error(
    calc_disc_dist_quantile(
      prob = "prob", 
      days = days, 
      quantile = quantiles
    ), 
    regexp = 
      "Assertion on 'prob' failed: Must be of type 'numeric', not 'character'."
  )
  
  expect_error(
    calc_disc_dist_quantile(
      prob = prob, 
      days = "days", 
      quantile = quantiles
    ), 
    regexp = 
      "Assertion on 'days' failed: Must be of type 'numeric', not 'character'."
  )
  
  expect_error(
    calc_disc_dist_quantile(
      prob = prob, 
      days = days, 
      quantile = "quantiles"
    ), 
    regexp = paste0(
      "Assertion on 'quantile' failed: Must be of type 'numeric',",
      " not 'character'."
    )
  )
})

