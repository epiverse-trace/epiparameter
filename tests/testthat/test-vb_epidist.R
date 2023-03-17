test_that("vb_epidist works with minimal viable input", {
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

  expect_s3_class(dengue_dist, class = "vb_epidist")
  expect_length(dengue_dist, 2)
  expect_named(dengue_dist, c("intrinsic", "extrinsic"))
  expect_s3_class(dengue_dist$intrinsic, "epidist")
  expect_s3_class(dengue_dist$extrinsic, "epidist")
})

test_that("vb_epidist works with all arguements set", {

  # message about missing citation suppressed
  dengue_dist <- suppressMessages(
    vb_epidist(
      intrinsic_epidist = epidist(
        disease = "dengue",
        pathogen = "dengue_virus",
        epi_dist = "incubation",
        prob_distribution = "gamma",
        prob_distribution_params = c(shape = 1, scale = 1),
        uncertainty = create_epidist_uncertainty(),
        summary_stats = create_epidist_summary_stats(),
        citation = create_epidist_citation(),
        metadata = create_epidist_metadata(
          transmission_mode = "vector_borne",
          extrinsic = FALSE
        ),
        method_assess = create_epidist_method_assess(),
        discretise = FALSE,
        truncation = NA,
        notes = "No notes"
      ),
      extrinsic_epidist = epidist(
        disease = "dengue",
        pathogen = "dengue_virus",
        epi_dist = "incubation",
        prob_distribution = "gamma",
        prob_distribution_params = c(shape = 1, scale = 1),
        uncertainty = create_epidist_uncertainty(),
        summary_stats = create_epidist_summary_stats(),
        citation = create_epidist_citation(),
        metadata = create_epidist_metadata(
          transmission_mode = "vector_borne",
          extrinsic = TRUE
        ),
        method_assess = create_epidist_method_assess(),
        discretise = FALSE,
        truncation = NA,
        notes = "No notes"
      )
    )
  )

  expect_s3_class(dengue_dist, class = "vb_epidist")
  expect_length(dengue_dist, 2)
  expect_named(dengue_dist, c("intrinsic", "extrinsic"))
  expect_s3_class(dengue_dist$intrinsic, "epidist")
  expect_s3_class(dengue_dist$extrinsic, "epidist")
})

test_that("vb_epidist throws warning when expected", {

    expect_warning(
      suppressMessages(
        vb_epidist(
          intrinsic_epidist = epidist(
            disease = "dengue",
            epi_dist = "incubation",
            prob_distribution = "gamma",
            prob_distribution_params = c(shape = 1, scale = 1),
            metadata = create_epidist_metadata(
              transmission_mode = "natural_human_to_human",
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
      ),
      regexp = paste0(
        "(Distributions in vb_epidist class are not vector-borne)"
      )
    )

  expect_warning(
    suppressMessages(
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
            transmission_mode = "natural_human_to_human",
            extrinsic = TRUE
          )
        )
      )
    ),
    regexp = paste0(
      "(Distributions in vb_epidist class are not vector-borne)"
    )
  )

  expect_warning(
    suppressMessages(
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
            extrinsic = FALSE
          )
        )
      )
    ),
    regexp = paste0(
      "(The extrinsic distribution is not specified extrinsic)"
    )
  )

  expect_warning(
    suppressMessages(
      vb_epidist(
        intrinsic_epidist = epidist(
          disease = "dengue",
          epi_dist = "incubation",
          prob_distribution = "gamma",
          prob_distribution_params = c(shape = 1, scale = 1),
          metadata = create_epidist_metadata(
            transmission_mode = "vector_borne",
            extrinsic = TRUE
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
    ),
    regexp = paste0(
      "(The intrinsic distribution is specified extrinsic)"
    )
  )
})

test_that("vb_epidist fails as expected", {

  expect_error(
    suppressMessages(
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
          disease = "chikungunya",
          epi_dist = "incubation",
          prob_distribution = "gamma",
          prob_distribution_params = c(shape = 1, scale = 1),
          metadata = create_epidist_metadata(
            transmission_mode = "vector_borne",
            extrinsic = TRUE
          )
        )
      )
    ),
    regexp = "diseases in intrinsic and extrinsic distribution are different"
  )

  expect_error(
    suppressMessages(
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
          epi_dist = "serial_interval",
          prob_distribution = "gamma",
          prob_distribution_params = c(shape = 1, scale = 1),
          metadata = create_epidist_metadata(
            transmission_mode = "vector_borne",
            extrinsic = TRUE
          )
        )
      )
    ), regexp = "(epi distribution in intrinsic and extrinsic distributions)"
  )
})

test_that("validate_vb_epidist fails as expected with input class", {
  expect_error(
    validate_vb_epidist(vb_epidist = 1),
    regexp = "Object should be of class vb_epidist"
  )
})

test_that("vb_epidist print & format method works as expected", {

  expect_snapshot(
    # suppress messages about citation
    dengue_dist <- suppressMessages(vb_epidist(
      intrinsic_epidist = epidist(
        disease = "dengue",
        epi_dist = "incubation",
        prob_distribution = "gamma",
        prob_distribution_params = c(shape = 1, scale = 1),
        metadata = create_epidist_metadata(transmission_mode = "vector_borne")
      ),
      extrinsic_epidist = epidist(
        disease = "dengue",
        epi_dist = "incubation",
        prob_distribution = "gamma",
        prob_distribution_params = c(shape = 2, scale = 2),
        metadata = create_epidist_metadata(
          transmission_mode = "vector_borne",
          extrinsic = TRUE
        )
      )
    ))
  )

  expect_output(print(dengue_dist))
  expect_snapshot(print(dengue_dist))

  expect_output(format(dengue_dist))
  expect_snapshot(format(dengue_dist))

  expect_snapshot(
    # suppress messages about citation
    dengue_dist <- suppressMessages(vb_epidist(
      intrinsic_epidist = epidist(
        disease = "dengue",
        epi_dist = "incubation",
        prob_distribution = "gamma",
        prob_distribution_params = c(shape = 1, scale = 1),
        metadata = create_epidist_metadata(transmission_mode = "vector_borne"),
        discretise = TRUE
      ),
      extrinsic_epidist = epidist(
        disease = "dengue",
        epi_dist = "incubation",
        prob_distribution = "gamma",
        prob_distribution_params = c(shape = 2, scale = 2),
        metadata = create_epidist_metadata(
          transmission_mode = "vector_borne",
          extrinsic = TRUE
        ),
        discretise = TRUE
      )
    ))
  )

  expect_output(print(dengue_dist))
  expect_snapshot(print(dengue_dist))

  expect_output(format(dengue_dist))
  expect_snapshot(format(dengue_dist))
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
      day_range = 0:20
    )
  )

  f <- function() {
    plot(
      dengue_dist,
      day_range = 0:20
    )
  }
  vdiffr::expect_doppelganger(
    title = "vb_epidist.plot non-default range",
    fig = f
  )
})

test_that("density works as expected on continuous vb_epidist object", {
  # suppress messages about citation
  dengue_dist <- suppressMessages(vb_epidist(
    intrinsic_epidist = epidist(
      disease = "dengue",
      epi_dist = "incubation",
      prob_distribution = "gamma",
      prob_distribution_params = c(shape = 1, scale = 1),
      metadata = create_epidist_metadata(transmission_mode = "vector_borne")
    ),
    extrinsic_epidist = epidist(
      disease = "dengue",
      epi_dist = "incubation",
      prob_distribution = "gamma",
      prob_distribution_params = c(shape = 2, scale = 2),
      metadata = create_epidist_metadata(
        transmission_mode = "vector_borne",
        extrinsic = TRUE
      )
    )
  ))

  res <- stats::density(dengue_dist, at = 0.5)
  expect_length(res, 2)
  expect_type(res, "list")
  expect_type(res$intrinsic, "double")
  expect_type(res$extrinsic, "double")
  expect_gte(res$intrinsic, 0)
  expect_gte(res$extrinsic, 0)

  res <- stats::density(dengue_dist, at = 0)
  expect_length(res, 2)
  expect_type(res, "list")
  expect_type(res$intrinsic, "double")
  expect_type(res$extrinsic, "double")
  expect_gte(res$intrinsic, 0)
  expect_gte(res$extrinsic, 0)

  res <- stats::density(dengue_dist, at = 1.5)
  expect_length(res, 2)
  expect_type(res, "list")
  expect_type(res$intrinsic, "double")
  expect_type(res$extrinsic, "double")
  expect_gte(res$intrinsic, 0)
  expect_gte(res$extrinsic, 0)

  res <- stats::density(dengue_dist, at = 10)
  expect_length(res, 2)
  expect_type(res, "list")
  expect_type(res$intrinsic, "double")
  expect_type(res$extrinsic, "double")
  expect_gte(res$intrinsic, 0)
  expect_gte(res$extrinsic, 0)
})

test_that("density works as expected on discrete vb_epidist object", {
  # suppress messages about citation
  dengue_dist <- suppressMessages(vb_epidist(
    intrinsic_epidist = epidist(
      disease = "dengue",
      epi_dist = "incubation",
      prob_distribution = "gamma",
      prob_distribution_params = c(shape = 1, scale = 1),
      metadata = create_epidist_metadata(transmission_mode = "vector_borne"),
      discretise = TRUE
    ),
    extrinsic_epidist = epidist(
      disease = "dengue",
      epi_dist = "incubation",
      prob_distribution = "gamma",
      prob_distribution_params = c(shape = 2, scale = 2),
      metadata = create_epidist_metadata(
        transmission_mode = "vector_borne",
        extrinsic = TRUE
      ),
      discretise = TRUE
    )
  ))

  res <- stats::density(dengue_dist, at = 0.5)
  expect_length(res, 2)
  expect_type(res, "list")
  expect_type(res$intrinsic, "double")
  expect_type(res$extrinsic, "double")
  expect_gte(res$intrinsic, 0)
  expect_gte(res$extrinsic, 0)

  res <- stats::density(dengue_dist, at = 0)
  expect_length(res, 2)
  expect_type(res, "list")
  expect_type(res$intrinsic, "double")
  expect_type(res$extrinsic, "double")
  expect_gte(res$intrinsic, 0)
  expect_gte(res$extrinsic, 0)

  res <- stats::density(dengue_dist, at = 1.5)
  expect_length(res, 2)
  expect_type(res, "list")
  expect_type(res$intrinsic, "double")
  expect_type(res$extrinsic, "double")
  expect_gte(res$intrinsic, 0)
  expect_gte(res$extrinsic, 0)

  res <- stats::density(dengue_dist, at = 10)
  expect_length(res, 2)
  expect_type(res, "list")
  expect_type(res$intrinsic, "double")
  expect_type(res$extrinsic, "double")
  expect_gte(res$intrinsic, 0)
  expect_gte(res$extrinsic, 0)
})

test_that("density works as expected on continuous vb_epidist object with
          vector input", {
  # suppress messages about citation
  dengue_dist <- suppressMessages(vb_epidist(
    intrinsic_epidist = epidist(
      disease = "dengue",
      epi_dist = "incubation",
      prob_distribution = "gamma",
      prob_distribution_params = c(shape = 1, scale = 1),
      metadata = create_epidist_metadata(transmission_mode = "vector_borne")
    ),
    extrinsic_epidist = epidist(
      disease = "dengue",
      epi_dist = "incubation",
      prob_distribution = "gamma",
      prob_distribution_params = c(shape = 2, scale = 2),
      metadata = create_epidist_metadata(
        transmission_mode = "vector_borne",
        extrinsic = TRUE
      )
    )
  ))
  res <- stats::density(dengue_dist, at = seq(0.1, 0.9, by = 0.1))
  expect_length(res, 2)
  expect_type(res, "list")
  expect_type(res$intrinsic, "double")
  expect_type(res$extrinsic, "double")
  expect_length(res$intrinsic, 9)
  expect_length(res$extrinsic, 9)
  expect_true(all(res$intrinsic >= 0))
  expect_true(all(res$extrinsic >= 0))
})

test_that("density works as expected on discrete vb_epidist object with
          vector input", {
  # suppress messages about citation
  dengue_dist <- suppressMessages(vb_epidist(
    intrinsic_epidist = epidist(
      disease = "dengue",
      epi_dist = "incubation",
      prob_distribution = "gamma",
      prob_distribution_params = c(shape = 1, scale = 1),
      metadata = create_epidist_metadata(transmission_mode = "vector_borne"),
      discretise = TRUE
    ),
    extrinsic_epidist = epidist(
      disease = "dengue",
      epi_dist = "incubation",
      prob_distribution = "gamma",
      prob_distribution_params = c(shape = 2, scale = 2),
      metadata = create_epidist_metadata(
        transmission_mode = "vector_borne",
        extrinsic = TRUE
      ),
      discretise = TRUE
    )
  ))

  res <- stats::density(dengue_dist, at = seq(0.1, 0.9, by = 0.1))
  expect_length(res, 2)
  expect_type(res, "list")
  expect_type(res$intrinsic, "double")
  expect_type(res$extrinsic, "double")
  expect_length(res$intrinsic, 9)
  expect_length(res$extrinsic, 9)
  expect_true(all(res$intrinsic >= 0))
  expect_true(all(res$extrinsic >= 0))
})

test_that("cdf works as expected on continuous vb_epidist object", {
  # suppress messages about citation
  dengue_dist <- suppressMessages(vb_epidist(
    intrinsic_epidist = epidist(
      disease = "dengue",
      epi_dist = "incubation",
      prob_distribution = "gamma",
      prob_distribution_params = c(shape = 1, scale = 1),
      metadata = create_epidist_metadata(transmission_mode = "vector_borne")
    ),
    extrinsic_epidist = epidist(
      disease = "dengue",
      epi_dist = "incubation",
      prob_distribution = "gamma",
      prob_distribution_params = c(shape = 2, scale = 2),
      metadata = create_epidist_metadata(
        transmission_mode = "vector_borne",
        extrinsic = TRUE
      )
    )
  ))

  res <- distributional::cdf(dengue_dist, q = 0.5)
  expect_length(res, 2)
  expect_type(res, "list")
  expect_type(res$intrinsic, "double")
  expect_type(res$extrinsic, "double")
  expect_gte(res$intrinsic, 0)
  expect_lte(res$intrinsic, 1)
  expect_gte(res$extrinsic, 0)
  expect_lte(res$extrinsic, 1)

  res <- distributional::cdf(dengue_dist, q = 0)
  expect_length(res, 2)
  expect_type(res, "list")
  expect_type(res$intrinsic, "double")
  expect_type(res$extrinsic, "double")
  expect_gte(res$intrinsic, 0)
  expect_lte(res$intrinsic, 1)
  expect_gte(res$extrinsic, 0)
  expect_lte(res$extrinsic, 1)

  res <- distributional::cdf(dengue_dist, q = 1.5)
  expect_length(res, 2)
  expect_type(res, "list")
  expect_type(res$intrinsic, "double")
  expect_type(res$extrinsic, "double")
  expect_gte(res$intrinsic, 0)
  expect_lte(res$intrinsic, 1)
  expect_gte(res$extrinsic, 0)
  expect_lte(res$extrinsic, 1)

  res <- distributional::cdf(dengue_dist, q = 10)
  expect_length(res, 2)
  expect_type(res, "list")
  expect_type(res$intrinsic, "double")
  expect_type(res$extrinsic, "double")
  expect_gte(res$intrinsic, 0)
  expect_lte(res$intrinsic, 1)
  expect_gte(res$extrinsic, 0)
  expect_lte(res$extrinsic, 1)
})

test_that("cdf works as expected on discrete vb_epidist object", {
  # suppress messages about citation
  dengue_dist <- suppressMessages(vb_epidist(
    intrinsic_epidist = epidist(
      disease = "dengue",
      epi_dist = "incubation",
      prob_distribution = "gamma",
      prob_distribution_params = c(shape = 1, scale = 1),
      metadata = create_epidist_metadata(transmission_mode = "vector_borne"),
      discretise = TRUE
    ),
    extrinsic_epidist = epidist(
      disease = "dengue",
      epi_dist = "incubation",
      prob_distribution = "gamma",
      prob_distribution_params = c(shape = 2, scale = 2),
      metadata = create_epidist_metadata(
        transmission_mode = "vector_borne",
        extrinsic = TRUE
      ),
      discretise = TRUE
    )
  ))

  res <- distributional::cdf(dengue_dist, q = 0.5)
  expect_length(res, 2)
  expect_type(res, "list")
  expect_type(res$intrinsic, "double")
  expect_type(res$extrinsic, "double")
  expect_gte(res$intrinsic, 0)
  expect_lte(res$intrinsic, 1)
  expect_gte(res$extrinsic, 0)
  expect_lte(res$extrinsic, 1)

  res <- distributional::cdf(dengue_dist, q = 0)
  expect_length(res, 2)
  expect_type(res, "list")
  expect_type(res$intrinsic, "double")
  expect_type(res$extrinsic, "double")
  expect_gte(res$intrinsic, 0)
  expect_lte(res$intrinsic, 1)
  expect_gte(res$extrinsic, 0)
  expect_lte(res$extrinsic, 1)

  res <- distributional::cdf(dengue_dist, q = 1.5)
  expect_length(res, 2)
  expect_type(res, "list")
  expect_type(res$intrinsic, "double")
  expect_type(res$extrinsic, "double")
  expect_gte(res$intrinsic, 0)
  expect_lte(res$intrinsic, 1)
  expect_gte(res$extrinsic, 0)
  expect_lte(res$extrinsic, 1)

  res <- distributional::cdf(dengue_dist, q = 10)
  expect_length(res, 2)
  expect_type(res, "list")
  expect_type(res$intrinsic, "double")
  expect_type(res$extrinsic, "double")
  expect_gte(res$intrinsic, 0)
  expect_lte(res$intrinsic, 1)
  expect_gte(res$extrinsic, 0)
  expect_lte(res$extrinsic, 1)
})

test_that("cdf works as expected on continuous vb_epidist object with
          vector input", {
  # suppress messages about citation
  dengue_dist <- suppressMessages(vb_epidist(
    intrinsic_epidist = epidist(
      disease = "dengue",
      epi_dist = "incubation",
      prob_distribution = "gamma",
      prob_distribution_params = c(shape = 1, scale = 1),
      metadata = create_epidist_metadata(transmission_mode = "vector_borne")
    ),
    extrinsic_epidist = epidist(
      disease = "dengue",
      epi_dist = "incubation",
      prob_distribution = "gamma",
      prob_distribution_params = c(shape = 2, scale = 2),
      metadata = create_epidist_metadata(
        transmission_mode = "vector_borne",
        extrinsic = TRUE
      )
    )
  ))

  res <- distributional::cdf(dengue_dist, q = seq(0.1, 0.9, by = 0.1))
  expect_length(res, 2)
  expect_type(res, "list")
  expect_type(res$intrinsic, "double")
  expect_type(res$extrinsic, "double")
  expect_length(res$intrinsic, 9)
  expect_length(res$extrinsic, 9)
  expect_true(all(res$intrinsic >= 0))
  expect_true(all(res$intrinsic <= 1))
  expect_true(all(res$extrinsic >= 0))
  expect_true(all(res$extrinsic <= 1))
})

test_that("cdf works as expected on discrete vb_epidist object with
          vector input", {
  # suppress messages about citation
  dengue_dist <- suppressMessages(vb_epidist(
    intrinsic_epidist = epidist(
      disease = "dengue",
      epi_dist = "incubation",
      prob_distribution = "gamma",
      prob_distribution_params = c(shape = 1, scale = 1),
      metadata = create_epidist_metadata(transmission_mode = "vector_borne"),
      discretise = TRUE
    ),
    extrinsic_epidist = epidist(
      disease = "dengue",
      epi_dist = "incubation",
      prob_distribution = "gamma",
      prob_distribution_params = c(shape = 2, scale = 2),
      metadata = create_epidist_metadata(
        transmission_mode = "vector_borne",
        extrinsic = TRUE
      ),
      discretise = TRUE
    )
  ))

  res <- distributional::cdf(dengue_dist, q = seq(0.1, 0.9, by = 0.1))
  expect_length(res, 2)
  expect_type(res, "list")
  expect_type(res$intrinsic, "double")
  expect_type(res$extrinsic, "double")
  expect_length(res$intrinsic, 9)
  expect_length(res$extrinsic, 9)
  expect_true(all(res$intrinsic >= 0))
  expect_true(all(res$intrinsic <= 1))
  expect_true(all(res$extrinsic >= 0))
  expect_true(all(res$extrinsic <= 1))
})

test_that("quantile works as expected on continuous vb_epidist object", {
  # suppress messages about citation
  dengue_dist <- suppressMessages(vb_epidist(
    intrinsic_epidist = epidist(
      disease = "dengue",
      epi_dist = "incubation",
      prob_distribution = "gamma",
      prob_distribution_params = c(shape = 1, scale = 1),
      metadata = create_epidist_metadata(transmission_mode = "vector_borne")
    ),
    extrinsic_epidist = epidist(
      disease = "dengue",
      epi_dist = "incubation",
      prob_distribution = "gamma",
      prob_distribution_params = c(shape = 2, scale = 2),
      metadata = create_epidist_metadata(
        transmission_mode = "vector_borne",
        extrinsic = TRUE
      )
    )
  ))

  res <- quantile(dengue_dist, p = 0.5)
  expect_length(res, 2)
  expect_type(res, "list")
  expect_type(res$intrinsic, "double")
  expect_type(res$extrinsic, "double")
  expect_gte(res$intrinsic, 0)
  expect_gte(res$extrinsic, 0)

  res <- quantile(dengue_dist, p = 0)
  expect_length(res, 2)
  expect_type(res, "list")
  expect_type(res$intrinsic, "double")
  expect_type(res$extrinsic, "double")
  expect_gte(res$intrinsic, 0)
  expect_gte(res$extrinsic, 0)

  res <- quantile(dengue_dist, p = 1)
  expect_length(res, 2)
  expect_type(res, "list")
  expect_type(res$intrinsic, "double")
  expect_type(res$extrinsic, "double")
  expect_gte(res$intrinsic, 0)
  expect_gte(res$extrinsic, 0)
})

test_that("quantile works as expected on discrete epidist object", {
  # suppress messages about citation
  dengue_dist <- suppressMessages(vb_epidist(
    intrinsic_epidist = epidist(
      disease = "dengue",
      epi_dist = "incubation",
      prob_distribution = "gamma",
      prob_distribution_params = c(shape = 1, scale = 1),
      metadata = create_epidist_metadata(transmission_mode = "vector_borne"),
      discretise = TRUE
    ),
    extrinsic_epidist = epidist(
      disease = "dengue",
      epi_dist = "incubation",
      prob_distribution = "gamma",
      prob_distribution_params = c(shape = 2, scale = 2),
      metadata = create_epidist_metadata(
        transmission_mode = "vector_borne",
        extrinsic = TRUE
      ),
      discretise = TRUE
    )
  ))

  res <- quantile(dengue_dist, p = 0.5)
  expect_length(res, 2)
  expect_type(res, "list")
  expect_type(res$intrinsic, "double")
  expect_type(res$extrinsic, "double")
  expect_gte(res$intrinsic, 0)
  expect_gte(res$extrinsic, 0)

  res <- quantile(dengue_dist, p = 0)
  expect_length(res, 2)
  expect_type(res, "list")
  expect_type(res$intrinsic, "double")
  expect_type(res$extrinsic, "double")
  expect_gte(res$intrinsic, 0)
  expect_gte(res$extrinsic, 0)

  res <- quantile(dengue_dist, p = 1)
  expect_length(res, 2)
  expect_type(res, "list")
  expect_type(res$intrinsic, "double")
  expect_type(res$extrinsic, "double")
  expect_gte(res$intrinsic, 0)
  expect_gte(res$extrinsic, 0)
})

test_that("quantile works as expected on continuous vb_epidist object with
          vector input", {
  # suppress messages about citation
  dengue_dist <- suppressMessages(vb_epidist(
    intrinsic_epidist = epidist(
      disease = "dengue",
      epi_dist = "incubation",
      prob_distribution = "gamma",
      prob_distribution_params = c(shape = 1, scale = 1),
      metadata = create_epidist_metadata(transmission_mode = "vector_borne")
    ),
    extrinsic_epidist = epidist(
      disease = "dengue",
      epi_dist = "incubation",
      prob_distribution = "gamma",
      prob_distribution_params = c(shape = 2, scale = 2),
      metadata = create_epidist_metadata(
        transmission_mode = "vector_borne",
        extrinsic = TRUE
      )
    )
  ))

  res <- quantile(dengue_dist, p = seq(0.1, 0.9, by = 0.1))
  expect_length(res, 2)
  expect_type(res, "list")
  expect_type(res$intrinsic, "double")
  expect_type(res$extrinsic, "double")
  expect_true(all(res$intrinsic >= 0))
  expect_true(all(res$extrinsic >= 0))
})

test_that("quantile works as expected on discrete vb_epidist object with
          vector input", {
  # suppress messages about citation
  dengue_dist <- suppressMessages(vb_epidist(
    intrinsic_epidist = epidist(
      disease = "dengue",
      epi_dist = "incubation",
      prob_distribution = "gamma",
      prob_distribution_params = c(shape = 1, scale = 1),
      metadata = create_epidist_metadata(transmission_mode = "vector_borne"),
      discretise = TRUE
    ),
    extrinsic_epidist = epidist(
      disease = "dengue",
      epi_dist = "incubation",
      prob_distribution = "gamma",
      prob_distribution_params = c(shape = 2, scale = 2),
      metadata = create_epidist_metadata(
        transmission_mode = "vector_borne",
        extrinsic = TRUE
      ),
      discretise = TRUE
    )
  ))

  res <- quantile(dengue_dist, p = seq(0.1, 0.9, by = 0.1))
  expect_length(res, 2)
  expect_type(res, "list")
  expect_type(res$intrinsic, "double")
  expect_type(res$extrinsic, "double")
  expect_true(all(res$intrinsic >= 0))
  expect_true(all(res$extrinsic >= 0))
})

test_that("generate works as expected on continuous vb_epidist object", {
  # suppress messages about citation
  dengue_dist <- suppressMessages(vb_epidist(
    intrinsic_epidist = epidist(
      disease = "dengue",
      epi_dist = "incubation",
      prob_distribution = "gamma",
      prob_distribution_params = c(shape = 1, scale = 1),
      metadata = create_epidist_metadata(transmission_mode = "vector_borne")
    ),
    extrinsic_epidist = epidist(
      disease = "dengue",
      epi_dist = "incubation",
      prob_distribution = "gamma",
      prob_distribution_params = c(shape = 2, scale = 2),
      metadata = create_epidist_metadata(
        transmission_mode = "vector_borne",
        extrinsic = TRUE
      )
    )
  ))

  res <- distributional::generate(dengue_dist, times = 1)
  expect_length(res, 2)
  expect_type(res, "list")
  expect_type(res$intrinsic, "double")
  expect_type(res$extrinsic, "double")
  expect_gte(res$intrinsic, 0)
  expect_gte(res$extrinsic, 0)

  res <- distributional::generate(dengue_dist, times = 10)
  expect_length(res, 2)
  expect_type(res, "list")
  expect_type(res$intrinsic, "double")
  expect_type(res$extrinsic, "double")
  expect_length(res$intrinsic, 10)
  expect_length(res$extrinsic, 10)
  expect_true(all(res$intrinsic >= 0))
  expect_true(all(res$extrinsic >= 0))
})

test_that("generate works as expected on discrete vb_epidist object", {
  # suppress messages about citation
  dengue_dist <- suppressMessages(vb_epidist(
    intrinsic_epidist = epidist(
      disease = "dengue",
      epi_dist = "incubation",
      prob_distribution = "gamma",
      prob_distribution_params = c(shape = 1, scale = 1),
      metadata = create_epidist_metadata(transmission_mode = "vector_borne"),
      discretise = TRUE
    ),
    extrinsic_epidist = epidist(
      disease = "dengue",
      epi_dist = "incubation",
      prob_distribution = "gamma",
      prob_distribution_params = c(shape = 2, scale = 2),
      metadata = create_epidist_metadata(
        transmission_mode = "vector_borne",
        extrinsic = TRUE
      ),
      discretise = TRUE
    )
  ))

  res <- distributional::generate(dengue_dist, times = 1)
  expect_length(res, 2)
  expect_type(res, "list")
  expect_type(res$intrinsic, "double")
  expect_type(res$extrinsic, "double")
  expect_gte(res$intrinsic, 0)
  expect_gte(res$extrinsic, 0)

  res <- distributional::generate(dengue_dist, times = 10)
  expect_length(res, 2)
  expect_type(res, "list")
  expect_type(res$intrinsic, "double")
  expect_type(res$extrinsic, "double")
  expect_length(res$intrinsic, 10)
  expect_length(res$extrinsic, 10)
  expect_true(all(res$intrinsic >= 0))
  expect_true(all(res$extrinsic >= 0))
})

test_that("generate fails as expected on continuous vb_epidist object with
          vector input", {
  # suppress messages about citation
  dengue_dist <- suppressMessages(vb_epidist(
    intrinsic_epidist = epidist(
      disease = "dengue",
      epi_dist = "incubation",
      prob_distribution = "gamma",
      prob_distribution_params = c(shape = 1, scale = 1),
      metadata = create_epidist_metadata(transmission_mode = "vector_borne")
    ),
    extrinsic_epidist = epidist(
      disease = "dengue",
      epi_dist = "incubation",
      prob_distribution = "gamma",
      prob_distribution_params = c(shape = 2, scale = 2),
      metadata = create_epidist_metadata(
        transmission_mode = "vector_borne",
        extrinsic = TRUE
      )
    )
  ))

  expect_error(distributional::generate(dengue_dist, times = c(10, 15)))
})

test_that("generate fails as expected on discrete vb_epidist object with
          vector input", {
  # suppress messages about citation
  dengue_dist <- suppressMessages(vb_epidist(
    intrinsic_epidist = epidist(
      disease = "dengue",
      epi_dist = "incubation",
      prob_distribution = "gamma",
      prob_distribution_params = c(shape = 1, scale = 1),
      metadata = create_epidist_metadata(transmission_mode = "vector_borne"),
      discretise = TRUE
    ),
    extrinsic_epidist = epidist(
      disease = "dengue",
      epi_dist = "incubation",
      prob_distribution = "gamma",
      prob_distribution_params = c(shape = 2, scale = 2),
      metadata = create_epidist_metadata(
        transmission_mode = "vector_borne",
        extrinsic = TRUE
      ),
      discretise = TRUE
    )
  ))

  expect_error(distributional::generate(dengue_dist, times = c(10, 15)))
})

test_that("is_vb_epidist returns TRUE when expected", {
  # suppress message about citation
  vb_edist <- suppressMessages(vb_epidist(
    intrinsic_epidist = epidist(
      disease = "dengue",
      epi_dist = "incubation_period",
      prob_distribution = "gamma",
      prob_distribution_params = c(shape = 1, scale = 1),
      metadata = create_epidist_metadata(transmission_mode = "vector_borne")
    ),
    extrinsic_epidist = epidist(
      disease = "dengue",
      epi_dist = "incubation_period",
      prob_distribution = "gamma",
      prob_distribution_params = c(shape = 1, scale = 1),
      metadata = create_epidist_metadata(
        transmission_mode = "vector_borne",
        extrinsic = TRUE
      )
    )
  ))

  expect_true(is_vb_epidist(vb_edist))
})

test_that("is_vb_epidist returns FALSE when expected", {
  # suppress message about citation
  vb_edist <- suppressMessages(list(
    intrinsic_epidist = epidist(
      disease = "dengue",
      epi_dist = "incubation_period",
      prob_distribution = "gamma",
      prob_distribution_params = c(shape = 1, scale = 1),
      metadata = create_epidist_metadata(transmission_mode = "vector_borne")
    ),
    extrinsic_epidist = epidist(
      disease = "dengue",
      epi_dist = "incubation_period",
      prob_distribution = "gamma",
      prob_distribution_params = c(shape = 1, scale = 1),
      metadata = create_epidist_metadata(
        transmission_mode = "vector_borne",
        extrinsic = TRUE
      )
    )
  ))

  expect_false(is_vb_epidist(vb_edist))
})
