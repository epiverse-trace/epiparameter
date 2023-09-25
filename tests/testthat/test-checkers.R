test_that("is_parameterised works as expected for epiparam", {
  eparam <- epiparam()
  res <- is_parameterised(eparam)
  expect_length(res, nrow(eparam))
  expect_type(res, type = "logical")
})

test_that("is_parameterised works as expected with epiparam parameters", {
  eparam <- epiparam(epi_dist = "incubation_period")
  set <- lapply(eparam, grepl, pattern = "McAloon")$author
  eparam <- subset(eparam, set)
  eparam <- subset(eparam, sample_size == max(sample_size))
  expect_true(is_parameterised(eparam))
})

test_that("is_parameterised works as expected without epiparam parameters", {
  eparam <- epiparam(epi_dist = "incubation_period")
  set <- lapply(eparam, grepl, pattern = "Alene")$author
  eparam <- subset(eparam, set)
  expect_false(is_parameterised(eparam))
})

test_that("is_parameterised works when dist is not recognised", {
  eparam <- epiparam()
  eparam <- rbind(eparam, eparam[1, ])
  eparam[nrow(eparam), "prob_distribution"] <- "lognormal"
  res <- is_parameterised(eparam)
  expect_length(res, 119)
  expect_type(res, type = "logical")
})

test_that("is_parameterised works as expected with epidist parameters", {
  # message about missing citation suppressed
  edist <- suppressMessages(epidist(
    disease = "ebola",
    epi_dist = "incubation_period",
    prob_distribution = "gamma",
    prob_distribution_params = c(shape = 1, scale = 1)
  ))
  expect_true(is_parameterised(edist))
})

test_that("is_parameterised works as expected without epidist parameters", {
  # message about missing citation suppressed
  edist <- suppressMessages(epidist(
    disease = "ebola",
    epi_dist = "incubation_period"
  ))
  expect_false(is_parameterised(edist))
})
