test_that("bind_epiparam works as expected for binding continuous epidist", {
  eparam <- epiparam()
  # message about missing citation suppressed
  edist <- suppressMessages(epidist(
    disease = "ebola",
    epi_dist = "incubation_period",
    prob_distribution = "gamma",
    prob_distribution_params = c(shape = 1, scale = 1)
  ))

  new_eparam <- bind_epiparam(epiparam = eparam, epi_obj = edist)

  expect_s3_class(new_eparam, "epiparam")
  expect_identical(nrow(new_eparam), nrow(eparam) + 1L)
  # check epidist info has been added
  expect_identical(new_eparam[nrow(new_eparam), ]$disease, "ebola")
  expect_identical(
    new_eparam[nrow(new_eparam), ]$epi_distribution,
    "incubation_period"
  )
  expect_identical(new_eparam[nrow(new_eparam), ]$prob_distribution, "gamma")
  expect_identical(new_eparam[nrow(new_eparam), ]$shape, 1)
  expect_identical(new_eparam[nrow(new_eparam), ]$scale, 1)
  # check some defaults missing from epidist
  expect_true(is.na(new_eparam[nrow(new_eparam), ]$author))
  expect_true(is.na(new_eparam[nrow(new_eparam), ]$sample_size))
  expect_false(new_eparam[nrow(new_eparam), ]$discretised)
  expect_type(new_eparam[nrow(new_eparam), ]$notes, "character")
})

test_that("bind_epiparam works as expected for binding discrete epidist", {
  eparam <- epiparam()
  # message about missing citation suppressed
  edist <- suppressMessages(epidist(
    disease = "ebola",
    epi_dist = "incubation_period",
    prob_distribution = "gamma",
    prob_distribution_params = c(shape = 1, scale = 1),
    discretise = TRUE
  ))

  new_eparam <- bind_epiparam(epiparam = eparam, epi_obj = edist)

  expect_s3_class(new_eparam, "epiparam")
  expect_identical(nrow(new_eparam), nrow(eparam) + 1L)
  # check epidist info has been added
  expect_identical(new_eparam[nrow(new_eparam), ]$disease, "ebola")
  expect_identical(
    new_eparam[nrow(new_eparam), ]$epi_distribution,
    "incubation_period"
  )
  expect_identical(new_eparam[nrow(new_eparam), ]$prob_distribution, "gamma")
  expect_identical(new_eparam[nrow(new_eparam), ]$shape, 1)
  expect_identical(new_eparam[nrow(new_eparam), ]$scale, 1)
  expect_true(new_eparam[nrow(new_eparam), ]$discretised)
  # check some defaults missing from epidist
  expect_true(is.na(new_eparam[nrow(new_eparam), ]$author))
  expect_true(is.na(new_eparam[nrow(new_eparam), ]$sample_size))
  expect_type(new_eparam[nrow(new_eparam), ]$notes, "character")
})

test_that("bind_epiparam works as expected for binding list of epidist", {
  eparam <- epiparam()
  # message about missing citation suppressed
  edist_list <- suppressMessages(
    list(
      epidist(
        disease = "ebola",
        epi_dist = "incubation_period",
        prob_distribution = "gamma",
        prob_distribution_params = c(shape = 1, scale = 1)
      ),
      epidist(
        disease = "ebola",
        epi_dist = "incubation_period",
        prob_distribution = "lnorm",
        prob_distribution_params = c(meanlog = 2, sdlog = 2)
      ),
      epidist(
        disease = "ebola",
        epi_dist = "incubation_period",
        prob_distribution = "weibull",
        prob_distribution_params = c(shape = 3, scale = 3)
      )
    )
  )

  new_eparam <- bind_epiparam(epiparam = eparam, epi_obj = edist_list)

  expect_s3_class(new_eparam, "epiparam")
  expect_identical(nrow(new_eparam), nrow(eparam) + 3L)
  # check epidist info has been added
  expect_identical(new_eparam[nrow(new_eparam) - 2, ]$disease, "ebola")
  expect_identical(new_eparam[nrow(new_eparam) - 1, ]$disease, "ebola")
  expect_identical(new_eparam[nrow(new_eparam), ]$disease, "ebola")
  expect_identical(
    new_eparam[nrow(new_eparam) - 2, ]$epi_distribution,
    "incubation_period"
  )
  expect_identical(
    new_eparam[nrow(new_eparam) - 1, ]$epi_distribution,
    "incubation_period"
  )
  expect_identical(
    new_eparam[nrow(new_eparam), ]$epi_distribution,
    "incubation_period"
  )
  expect_identical(
    new_eparam[nrow(new_eparam) - 2, ]$prob_distribution,
    "gamma"
  )
  expect_identical(
    new_eparam[nrow(new_eparam) - 1, ]$prob_distribution,
    "lnorm"
  )
  expect_identical(new_eparam[nrow(new_eparam), ]$prob_distribution, "weibull")
  expect_identical(new_eparam[nrow(new_eparam) - 2, ]$shape, 1)
  expect_identical(new_eparam[nrow(new_eparam) - 1, ]$meanlog, 2)
  expect_identical(new_eparam[nrow(new_eparam), ]$shape, 3)
  expect_identical(new_eparam[nrow(new_eparam) - 2, ]$scale, 1)
  expect_identical(new_eparam[nrow(new_eparam) - 1, ]$sdlog, 2)
  expect_identical(new_eparam[nrow(new_eparam), ]$scale, 3)
  # check some defaults missing from epidist
  expect_true(is.na(new_eparam[nrow(new_eparam) - 2, ]$author))
  expect_true(is.na(new_eparam[nrow(new_eparam) - 1, ]$author))
  expect_true(is.na(new_eparam[nrow(new_eparam), ]$author))
  expect_true(is.na(new_eparam[nrow(new_eparam) - 2, ]$sample_size))
  expect_true(is.na(new_eparam[nrow(new_eparam) - 1, ]$sample_size))
  expect_true(is.na(new_eparam[nrow(new_eparam), ]$sample_size))
  expect_false(new_eparam[nrow(new_eparam) - 2, ]$discretised)
  expect_false(new_eparam[nrow(new_eparam) - 1, ]$discretised)
  expect_false(new_eparam[nrow(new_eparam), ]$discretised)
  expect_type(new_eparam[nrow(new_eparam) - 2, ]$notes, "character")
  expect_type(new_eparam[nrow(new_eparam) - 1, ]$notes, "character")
  expect_type(new_eparam[nrow(new_eparam), ]$notes, "character")
})

test_that("bind_epiparam works as expected for binding vb_epidist", {
  eparam <- epiparam()
  # message about missing citation suppressed
  vb_edist <- suppressMessages(vb_epidist(
    intrinsic_epidist = epidist(
      disease = "dengue",
      epi_dist = "incubation_period",
      prob_distribution = "lnorm",
      prob_distribution_params = c(meanlog = 1, sdlog = 1),
      metadata = create_epidist_metadata(transmission_mode = "vector_borne")
    ),
    extrinsic_epidist = epidist(
      disease = "dengue",
      epi_dist = "incubation_period",
      prob_distribution = "lnorm",
      prob_distribution_params = c(meanlog = 2, sdlog = 2),
      metadata = create_epidist_metadata(
        transmission_mode = "vector_borne",
        extrinsic = TRUE
      )
    )
  ))

  new_eparam <- bind_epiparam(epiparam = eparam, epi_obj = vb_edist)

  expect_s3_class(new_eparam, "epiparam")
  expect_identical(nrow(new_eparam), nrow(eparam) + 2L)
  # check epidist info has been added for intrinsic
  expect_identical(new_eparam[nrow(new_eparam) - 1, ]$disease, "dengue")
  expect_identical(
    new_eparam[nrow(new_eparam) - 1, ]$epi_distribution,
    "incubation_period"
  )
  expect_identical(
    new_eparam[nrow(new_eparam) - 1, ]$prob_distribution,
    "lnorm"
  )
  expect_identical(new_eparam[nrow(new_eparam) - 1, ]$meanlog, 1)
  expect_identical(new_eparam[nrow(new_eparam) - 1, ]$sdlog, 1)
  expect_identical(
    new_eparam[nrow(new_eparam) - 1, ]$transmission_mode,
    "vector_borne"
  )
  expect_false(new_eparam[nrow(new_eparam) - 1, ]$extrinsic)
  # check some defaults missing from intrinsic epidist
  expect_true(is.na(new_eparam[nrow(new_eparam) - 1, ]$author))
  expect_true(is.na(new_eparam[nrow(new_eparam) - 1, ]$sample_size))
  expect_false(new_eparam[nrow(new_eparam) - 1, ]$discretised)
  expect_type(new_eparam[nrow(new_eparam) - 1, ]$notes, "character")
  # check epidist info has been added for extrinsic
  expect_identical(new_eparam[nrow(new_eparam), ]$disease, "dengue")
  expect_identical(
    new_eparam[nrow(new_eparam), ]$epi_distribution,
    "incubation_period"
  )
  expect_identical(
    new_eparam[nrow(new_eparam), ]$prob_distribution,
    "lnorm"
  )
  expect_identical(new_eparam[nrow(new_eparam), ]$meanlog, 2)
  expect_identical(new_eparam[nrow(new_eparam), ]$sdlog, 2)
  expect_identical(
    new_eparam[nrow(new_eparam), ]$transmission_mode,
    "vector_borne"
  )
  expect_true(new_eparam[nrow(new_eparam), ]$extrinsic)
  # check some defaults missing from intrinsic epidist
  expect_true(is.na(new_eparam[nrow(new_eparam), ]$author))
  expect_true(is.na(new_eparam[nrow(new_eparam), ]$sample_size))
  expect_false(new_eparam[nrow(new_eparam), ]$discretised)
  expect_type(new_eparam[nrow(new_eparam), ]$notes, "character")
})

test_that("bind_epiparam works as expected for binding epiparam", {
  eparam <- epiparam()
  eparam2 <- epiparam()

  new_eparam <- bind_epiparam(epiparam = eparam, epi_obj = eparam2)

  expect_s3_class(new_eparam, "epiparam")
  expect_identical(nrow(new_eparam), nrow(eparam) * 2L)
  # check last row matches last row of original epiparam
  expect_identical(
    new_eparam[nrow(new_eparam) / 2, ]$disease,
    new_eparam[nrow(new_eparam), ]$disease
  )
  expect_identical(
    new_eparam[nrow(new_eparam) / 2, ]$epi_distribution,
    new_eparam[nrow(new_eparam), ]$epi_distribution
  )
  expect_identical(
    new_eparam[nrow(new_eparam) / 2, ]$prob_distribution,
    new_eparam[nrow(new_eparam), ]$prob_distribution
  )
  expect_identical(
    new_eparam[nrow(new_eparam) / 2, ]$shape,
    new_eparam[nrow(new_eparam), ]$shape
  )
  expect_identical(
    new_eparam[nrow(new_eparam) / 2, ]$scale,
    new_eparam[nrow(new_eparam), ]$scale
  )
  expect_identical(
    new_eparam[nrow(new_eparam) / 2, ]$author,
    new_eparam[nrow(new_eparam), ]$author
  )
  expect_identical(
    new_eparam[nrow(new_eparam) / 2, ]$sample_size,
    new_eparam[nrow(new_eparam), ]$sample_size
  )
  expect_identical(
    new_eparam[nrow(new_eparam) / 2, ]$discretised,
    new_eparam[nrow(new_eparam), ]$discretised
  )
  expect_identical(
    new_eparam[nrow(new_eparam) / 2, ]$notes,
    new_eparam[nrow(new_eparam), ]$notes
  )
})

test_that("bind_epiparam works as expected for binding data.frame", {
  eparam <- epiparam()
  eparam2 <- epiparam()
  class(eparam2) <- "data.frame"

  new_eparam <- bind_epiparam(epiparam = eparam, epi_obj = eparam2)

  expect_s3_class(new_eparam, "epiparam")
  expect_identical(nrow(new_eparam), nrow(eparam) * 2L)
  # check last row matches last row of original epiparam
  expect_identical(
    new_eparam[nrow(new_eparam) / 2, ]$disease,
    new_eparam[nrow(new_eparam), ]$disease
  )
  expect_identical(
    new_eparam[nrow(new_eparam) / 2, ]$epi_distribution,
    new_eparam[nrow(new_eparam), ]$epi_distribution
  )
  expect_identical(
    new_eparam[nrow(new_eparam) / 2, ]$prob_distribution,
    new_eparam[nrow(new_eparam), ]$prob_distribution
  )
  expect_identical(
    new_eparam[nrow(new_eparam) / 2, ]$shape,
    new_eparam[nrow(new_eparam), ]$shape
  )
  expect_identical(
    new_eparam[nrow(new_eparam) / 2, ]$scale,
    new_eparam[nrow(new_eparam), ]$scale
  )
  expect_identical(
    new_eparam[nrow(new_eparam) / 2, ]$author,
    new_eparam[nrow(new_eparam), ]$author
  )
  expect_identical(
    new_eparam[nrow(new_eparam) / 2, ]$sample_size,
    new_eparam[nrow(new_eparam), ]$sample_size
  )
  expect_identical(
    new_eparam[nrow(new_eparam) / 2, ]$discretised,
    new_eparam[nrow(new_eparam), ]$discretised
  )
  expect_identical(
    new_eparam[nrow(new_eparam) / 2, ]$notes,
    new_eparam[nrow(new_eparam), ]$notes
  )
})

test_that("bind_epiparam fails as expected for binding corrupt epidist", {
  eparam <- epiparam()
  # message about missing citation suppressed
  edist <- suppressMessages(epidist(
    disease = "ebola",
    epi_dist = "incubation_period",
    prob_distribution = "gamma",
    prob_distribution_params = c(shape = 1, scale = 1)
  ))
  edist$disease <- NULL

  expect_error(
    bind_epiparam(epiparam = eparam, epi_obj = edist),
    regexp = "epidist object does not contain the correct attributes"
  )
})

test_that("bind_epiparam fails as expected for binding corrupt epidist list", {
  eparam <- epiparam()
  # message about missing citation suppressed
  edist_list <- suppressMessages(
    list(
      epidist(
        disease = "ebola",
        epi_dist = "incubation_period",
        prob_distribution = "gamma",
        prob_distribution_params = c(shape = 1, scale = 1)
      ),
      epidist(
        disease = "ebola",
        epi_dist = "incubation_period",
        prob_distribution = "lnorm",
        prob_distribution_params = c(meanlog = 2, sdlog = 2)
      ),
      epidist(
        disease = "ebola",
        epi_dist = "incubation_period",
        prob_distribution = "weibull",
        prob_distribution_params = c(shape = 3, scale = 3)
      )
    )
  )
  edist_list[[1]]$disease <- NULL

  expect_error(
    bind_epiparam(epiparam = eparam, epi_obj = edist_list),
    regexp = "epidist object does not contain the correct attributes"
  )
})

test_that("bind_epiparam fails as expected for binding list without epidist", {
  eparam <- epiparam()
  # message about missing citation suppressed
  edist_list <- suppressMessages(
    list(
      epidist(
        disease = "ebola",
        epi_dist = "incubation_period",
        prob_distribution = "gamma",
        prob_distribution_params = c(shape = 1, scale = 1)
      ),
      epidist(
        disease = "ebola",
        epi_dist = "incubation_period",
        prob_distribution = "lnorm",
        prob_distribution_params = c(meanlog = 2, sdlog = 2)
      ),
      c(1, 2)
    )
  )

  expect_error(
    bind_epiparam(epiparam = eparam, epi_obj = edist_list),
    regexp = "Object should be of class epidist"
  )
})

test_that("bind_epiparam fails as expected for binding corrupt vb_epidist", {
  eparam <- epiparam()
  # message about missing citation suppressed
  vb_edist <- suppressMessages(vb_epidist(
    intrinsic_epidist = epidist(
      disease = "dengue",
      epi_dist = "incubation_period",
      prob_distribution = "lnorm",
      prob_distribution_params = c(meanlog = 1, sdlog = 1),
      metadata = create_epidist_metadata(transmission_mode = "vector_borne")
    ),
    extrinsic_epidist = epidist(
      disease = "dengue",
      epi_dist = "incubation_period",
      prob_distribution = "lnorm",
      prob_distribution_params = c(meanlog = 2, sdlog = 2),
      metadata = create_epidist_metadata(
        transmission_mode = "vector_borne",
        extrinsic = TRUE
      )
    )
  ))

  vb_edist$intrinsic$disease <- NULL

  expect_error(
    bind_epiparam(epiparam = eparam, epi_obj = vb_edist),
    regexp = "diseases in intrinsic and extrinsic distribution are different"
  )
})

test_that("bind_epiparam fails as expected for binding corrupt epiparam", {
  eparam <- epiparam()
  eparam2 <- epiparam()
  # suppress message about converting to data.frame
  suppressMessages(eparam2$disease <- NULL)
  # convert back to epiparam for testing bind_epiparam
  class(eparam2) <- c("epiparam", "data.frame")
  expect_error(
    bind_epiparam(epiparam = eparam, epi_obj = eparam2),
    regexp = "epiparam object does not contain the correct columns"
  )
})

test_that("bind_epiparam fails as expected for binding incorrect data.frame", {
  eparam <- epiparam()
  eparam2 <- epiparam()
  class(eparam2) <- "data.frame"
  eparam2$disease <- NULL

  expect_error(
    bind_epiparam(epiparam = eparam, epi_obj = eparam2),
    regexp = "<data.frame> given must include all columns in <epiparam>"
  )
})

test_that("bind_epiparam fails as expected for incorrect epi_obj class", {
  eparam <- epiparam()
  eparam2 <- c(1, 2)

  expect_error(
    bind_epiparam(epiparam = eparam, epi_obj = eparam2),
    regexp = "(Only <epidist>)*(<epiparam>)*(can bind to <epiparam>)"
  )
})
