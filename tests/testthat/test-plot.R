test_that("epidist.plot does not produce an error", {
  ebola_dist <- suppressMessages(epidist(
    disease = "ebola",
    epi_dist = "incubation",
    prob_distribution = "gamma",
    prob_distribution_params = c(shape = 1, scale = 1)
  ))


  expect_silent(plot(ebola_dist))

  f <- function() plot(ebola_dist)
  vdiffr::expect_doppelganger(
    title = "epidist.plot",
    fig = f
  )
})

test_that("epidist.plot works with non-default day_range", {
  ebola_dist <- suppressMessages(epidist(
    disease = "ebola",
    epi_dist = "incubation",
    prob_distribution = "gamma",
    prob_distribution_params = c(shape = 1, scale = 1)
  ))

  expect_silent(
    plot(
      ebola_dist,
      day_range = c(0, 20)
    )
  )

  f <- function() {
    plot(
      ebola_dist,
      day_range = c(0, 20)
    )
  }
  vdiffr::expect_doppelganger(
    title = "epidist.plot non-default range",
    fig = f
  )
})

test_that("vb_epidist.plot does not produce an error", {
  # message about missing citation suppressed
  dengue_dist <- suppressMessages(
    vb_epidist(
      intrinsic_epidist = epidist(
        disease = "dengue",
        epi_dist = "incubation",
        prob_distribution = "gamma",
        prob_distribution_params = c(shape = 1, scale = 1),
        metadata = create_epidist_metadata(
          transmission_mode = "vector_borne",
          extrinsic = FALSE
        )
      ),
      extrinsic_epidist = epidist(
        disease = "dengue",
        epi_dist = "incubation",
        prob_distribution = "gamma",
        prob_distribution_params = c(shape = 1, scale = 1),
        metadata = create_epidist_metadata(
          transmission_mode = "vector_borne",
          extrinsic = TRUE
        )
      )
    )
  )


  expect_silent(plot(dengue_dist))

  f <- function() plot(dengue_dist)
  vdiffr::expect_doppelganger(
    title = "vb_epidist.plot",
    fig = f
  )
})

test_that("vb_epidist.plot works with non-default day_range", {
  # message about missing citation suppressed
  dengue_dist <- suppressMessages(
    vb_epidist(
      intrinsic_epidist = epidist(
        disease = "dengue",
        epi_dist = "incubation",
        prob_distribution = "gamma",
        prob_distribution_params = c(shape = 1, scale = 1),
        metadata = create_epidist_metadata(
          transmission_mode = "vector_borne",
          extrinsic = FALSE
        )
      ),
      extrinsic_epidist = epidist(
        disease = "dengue",
        epi_dist = "incubation",
        prob_distribution = "gamma",
        prob_distribution_params = c(shape = 1, scale = 1),
        metadata = create_epidist_metadata(
          transmission_mode = "vector_borne",
          extrinsic = TRUE
        )
      )
    )
  )

  expect_silent(
    plot(
      dengue_dist,
      day_range = c(0, 20)
    )
  )

  f <- function() {
    plot(
      dengue_dist,
      day_range = c(0, 20)
    )
  }
  vdiffr::expect_doppelganger(
    title = "vb_epidist.plot non-default range",
    fig = f
  )
})
