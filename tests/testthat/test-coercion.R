test_that("as_epidist works for ebola infectious period (issue #327 & #306)", {
  # {epireview} is not a dependency so only run if already on system
  skip_if_not_installed("epireview")
  # suppress warning and message about loading data
  ebola <- suppressWarnings(
    suppressMessages(
      epireview::load_epidata("ebola")
    )
  )
  ebola_params <- ebola$params
  ebola_infectiousness <- ebola_params[
    ebola_params$parameter_type == "Human delay - infectious period",
  ]
  ebola_infectiousness <- ebola_infectiousness[
    !is.na(ebola_infectiousness$distribution_type),
  ]
  # suppress warning and message about citation
  ebola_infectiousness_epidist <- suppressWarnings(
    suppressMessages(
      as_epidist(ebola_infectiousness)
    )
  )
  expect_s3_class(ebola_infectiousness_epidist, class = "epidist")
  # Lau 2017 has information to parameterise an exponential distribution
  expect_s3_class(
    ebola_infectiousness_epidist$prob_dist,
    class = "distribution"
  )
  # populate mean summary statistics
  expect_true(all(!is.na(ebola_infectiousness_epidist$summary_stats[1:3])))
})

test_that("as_epidist works for lassa incubation period (issue #306)", {
  # {epireview} is not a dependency so only run if already on system
  skip_if_not_installed("epireview")
  # suppress warning and message about loading data
  lassa_data <- suppressWarnings(
    suppressMessages(
      epireview::load_epidata("lassa")
    )
  )
  lassa_params <- lassa_data$params
  lassa_incub <- lassa_params[
    which(lassa_params$article_label == "Akhmetzhanov 2019" &
            lassa_params$parameter_type == "Human delay - incubation period"),
  ]
  # suppress warning and message about citation
  lassa_incub_epidist <- suppressWarnings(
    suppressMessages(
      as_epidist(lassa_incub)
    )
  )
  expect_s3_class(lassa_incub_epidist, class = "epidist")
  # Akhmetzhanov 2019 has information to parameterise a gamma distribution
  expect_s3_class(
    lassa_incub_epidist$prob_dist,
    class = "distribution"
  )
  # populate mean and sd summary statistics without uncertainty
  expect_true(all(!is.na(lassa_incub_epidist$summary_stats[c("mean", "sd")])))
})

test_that("as_epidist works for ebola serial interval (issue #303)", {
  # {epireview} is not a dependency so only run if already on system
  skip_if_not_installed("epireview")
  # suppress warning and message about loading data
  ebola_data <- suppressWarnings(
    suppressMessages(
      epireview::load_epidata("ebola")
    )
  )
  ebola_params <- ebola_data$params
  ebola_serial <- ebola_params[
    which(ebola_params$parameter_type == "Human delay - serial interval" &
            ebola_params$distribution_type == "Gamma" &
            ebola_params$article_label == "Chan 2020 (1)"),
  ]
  # suppress warning and message about citation
  ebola_serial_epidist <- suppressWarnings(
    suppressMessages(
      as_epidist(ebola_serial)
    )
  )
  expect_s3_class(ebola_serial_epidist, class = "epidist")
  # Chan 2020 has information to parameterise a gamma distribution
  expect_s3_class(
    ebola_serial_epidist$prob_dist,
    class = "distribution"
  )
  # populate mean and sd summary statistics without uncertainty
  expect_true(all(!is.na(ebola_serial_epidist$summary_stats[c("mean", "sd")])))
})
