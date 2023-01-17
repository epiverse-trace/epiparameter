test_that("vb_epidist works with minimal viable input", {
  # message about missing citation suppressed
  dengue_dist <- suppressMessages(
    vb_epidist(
      intrinsic_epidist = epidist(
        disease = "dengue",
        epi_distribution = "incubation",
        prob_distribution = "gamma",
        prob_distribution_params = c(shape = 1, scale = 1),
        metadata = create_epidist_metadata(
          vector_borne = TRUE,
          extrinsic = FALSE
        )
      ),
      extrinsic_epidist = epidist(
        disease = "dengue",
        epi_distribution = "incubation",
        prob_distribution = "gamma",
        prob_distribution_params = c(shape = 1, scale = 1),
        metadata = create_epidist_metadata(
          vector_borne = TRUE,
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
        epi_distribution = "incubation",
        prob_distribution = "gamma",
        prob_distribution_params = c(shape = 1, scale = 1),
        uncertainty = NA,
        summary_stats = create_epidist_summary_stats(),
        citation = create_epidist_citation(),
        metadata = create_epidist_metadata(
          vector_borne = TRUE,
          extrinsic = FALSE
        ),
        method_assessment = create_epidist_method_assessment(),
        discretise = FALSE,
        truncation = NA,
        notes = "No notes"
      ),
      extrinsic_epidist = epidist(
        disease = "dengue",
        pathogen = "dengue_virus",
        epi_distribution = "incubation",
        prob_distribution = "gamma",
        prob_distribution_params = c(shape = 1, scale = 1),
        uncertainty = NA,
        summary_stats = create_epidist_summary_stats(),
        citation = create_epidist_citation(),
        metadata = create_epidist_metadata(
          vector_borne = TRUE,
          extrinsic = TRUE
        ),
        method_assessment = create_epidist_method_assessment(),
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
            epi_distribution = "incubation",
            prob_distribution = "gamma",
            prob_distribution_params = c(shape = 1, scale = 1),
            metadata = create_epidist_metadata(
              vector_borne = FALSE,
              extrinsic = FALSE
            )
          ),
          extrinsic_epidist = epidist(
            disease = "dengue",
            epi_distribution = "incubation",
            prob_distribution = "gamma",
            prob_distribution_params = c(shape = 1, scale = 1),
            metadata = create_epidist_metadata(
              vector_borne = TRUE,
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
          epi_distribution = "incubation",
          prob_distribution = "gamma",
          prob_distribution_params = c(shape = 1, scale = 1),
          metadata = create_epidist_metadata(
            vector_borne = TRUE,
            extrinsic = FALSE
          )
        ),
        extrinsic_epidist = epidist(
          disease = "dengue",
          epi_distribution = "incubation",
          prob_distribution = "gamma",
          prob_distribution_params = c(shape = 1, scale = 1),
          metadata = create_epidist_metadata(
            vector_borne = FALSE,
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
          epi_distribution = "incubation",
          prob_distribution = "gamma",
          prob_distribution_params = c(shape = 1, scale = 1),
          metadata = create_epidist_metadata(
            vector_borne = TRUE,
            extrinsic = FALSE
          )
        ),
        extrinsic_epidist = epidist(
          disease = "dengue",
          epi_distribution = "incubation",
          prob_distribution = "gamma",
          prob_distribution_params = c(shape = 1, scale = 1),
          metadata = create_epidist_metadata(
            vector_borne = TRUE,
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
          epi_distribution = "incubation",
          prob_distribution = "gamma",
          prob_distribution_params = c(shape = 1, scale = 1),
          metadata = create_epidist_metadata(
            vector_borne = TRUE,
            extrinsic = TRUE
          )
        ),
        extrinsic_epidist = epidist(
          disease = "dengue",
          epi_distribution = "incubation",
          prob_distribution = "gamma",
          prob_distribution_params = c(shape = 1, scale = 1),
          metadata = create_epidist_metadata(
            vector_borne = TRUE,
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
          epi_distribution = "incubation",
          prob_distribution = "gamma",
          prob_distribution_params = c(shape = 1, scale = 1),
          metadata = create_epidist_metadata(
            vector_borne = TRUE,
            extrinsic = FALSE
          )
        ),
        extrinsic_epidist = epidist(
          disease = "chikungunya",
          epi_distribution = "incubation",
          prob_distribution = "gamma",
          prob_distribution_params = c(shape = 1, scale = 1),
          metadata = create_epidist_metadata(
            vector_borne = TRUE,
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
          epi_distribution = "incubation",
          prob_distribution = "gamma",
          prob_distribution_params = c(shape = 1, scale = 1),
          metadata = create_epidist_metadata(
            vector_borne = TRUE,
            extrinsic = FALSE
          )
        ),
        extrinsic_epidist = epidist(
          disease = "dengue",
          epi_distribution = "serial_interval",
          prob_distribution = "gamma",
          prob_distribution_params = c(shape = 1, scale = 1),
          metadata = create_epidist_metadata(
            vector_borne = TRUE,
            extrinsic = TRUE
          )
        )
      )
    ), regexp = "(epi distribution in intrinsic and extrinsic distributions)"
  )
})