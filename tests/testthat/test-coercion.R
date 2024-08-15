if (requireNamespace("epireview", quietly = TRUE)) {
  # suppress message about loading data
  ebola_data <- suppressMessages(
    epireview::load_epidata("ebola")
  )
  lassa_data <- suppressMessages(
    epireview::load_epidata("lassa")
  )
}

test_that("as_epiparameter works for ebola infectious period (issue #327 & #306)", {
  # {epireview} is not a dependency so only run if already on system
  skip_if_not_installed("epireview")
  ebola_params <- ebola_data$params
  ebola_infectiousness <- ebola_params[
    ebola_params$parameter_type == "Human delay - infectious period",
  ]
  ebola_infectiousness <- ebola_infectiousness[
    !is.na(ebola_infectiousness$distribution_type),
  ]
  # suppress warning and message about citation
  ebola_infectiousness_epiparameter <- suppressWarnings(
    suppressMessages(
      as_epiparameter(ebola_infectiousness)
    )
  )
  expect_s3_class(ebola_infectiousness_epiparameter, class = "epiparameter")
  # Lau 2017 has information to parameterise an exponential distribution
  expect_s3_class(
    ebola_infectiousness_epiparameter$prob_dist,
    class = "distribution"
  )
  # populate mean summary statistics
  expect_true(all(!is.na(ebola_infectiousness_epiparameter$summary_stats[1:3])))
})

test_that("as_epiparameter works for lassa incubation period (issue #306)", {
  # {epireview} is not a dependency so only run if already on system
  skip_if_not_installed("epireview")
  lassa_params <- lassa_data$params
  lassa_incub <- lassa_params[
    # TODO: temp use id until epireview #122 is fixed
    which(lassa_params$id == "62332f18a631d2cdaafc5c5a500caea5" &
            lassa_params$parameter_type == "Human delay - incubation period"),
  ]
  # suppress warning and message about citation
  lassa_incub_epiparameter <- suppressWarnings(
    suppressMessages(
      as_epiparameter(lassa_incub)
    )
  )
  expect_s3_class(lassa_incub_epiparameter, class = "epiparameter")
  # Akhmetzhanov 2019 has information to parameterise a gamma distribution
  expect_s3_class(
    lassa_incub_epiparameter$prob_dist,
    class = "distribution"
  )
  # populate mean and sd summary statistics without uncertainty
  expect_true(all(!is.na(lassa_incub_epiparameter$summary_stats[c("mean", "sd")])))
})

test_that("as_epiparameter works for ebola serial interval (issue #303)", {
  # {epireview} is not a dependency so only run if already on system
  skip_if_not_installed("epireview")
  ebola_params <- ebola_data$params
  ebola_serial <- ebola_params[
    which(ebola_params$parameter_type == "Human delay - serial interval" &
            ebola_params$distribution_type == "Gamma" &
            ebola_params$article_label == "Chan 2020 (1)"),
  ]
  # suppress warning and message about citation
  ebola_serial_epiparameter <- suppressWarnings(
    suppressMessages(
      as_epiparameter(ebola_serial)
    )
  )
  expect_s3_class(ebola_serial_epiparameter, class = "epiparameter")
  # Chan 2020 has information to parameterise a gamma distribution
  expect_s3_class(
    ebola_serial_epiparameter$prob_dist,
    class = "distribution"
  )
  # populate mean and sd summary statistics without uncertainty
  expect_true(all(!is.na(ebola_serial_epiparameter$summary_stats[c("mean", "sd")])))
})

test_that("as_epiparameter works for ebola SI assumed prob_dist (issue #310)", {
  # {epireview} is not a dependency so only run if already on system
  skip_if_not_installed("epireview")
  ebola_params <- ebola_data$params
  ebola_serial <- ebola_params[
    which(
      grepl(pattern = "Faye", x = ebola_params$article_label) &
        grepl(pattern = "serial", ebola_params$parameter_type)
    ),
  ]
  # suppress warning and message about citation
  ebola_serial_epiparameter <- suppressWarnings(
    suppressMessages(
      as_epiparameter(ebola_serial, prob_dist = "gamma")
    )
  )
  expect_s3_class(ebola_serial_epiparameter, class = "epiparameter")
  # Faye 2015 parameterise an assumed gamma distribution
  expect_s3_class(
    ebola_serial_epiparameter$prob_dist,
    class = "distribution"
  )
  # populate mean and sd summary statistics without uncertainty
  expect_true(all(!is.na(ebola_serial_epiparameter$summary_stats[c("mean", "sd")])))
})

test_that("as_epiparameter works for lassa incubation overwritten prob_dist", {
  # {epireview} is not a dependency so only run if already on system
  skip_if_not_installed("epireview")
  lassa_params <- lassa_data$params
  lassa_incub <- lassa_params[
    # TODO: temp use id until epireview #122 is fixed
    which(lassa_params$id == "62332f18a631d2cdaafc5c5a500caea5" &
            lassa_params$parameter_type == "Human delay - incubation period"),
  ]
  # suppress warning and message about citation
  lassa_incub_epiparameter <- suppressWarnings(
    suppressMessages(
      as_epiparameter(lassa_incub, prob_dist = "lnorm")
    )
  )
  expect_s3_class(lassa_incub_epiparameter, class = "epiparameter")
  # Akhmetzhanov 2019 has information to parameterise a gamma distribution
  expect_s3_class(
    lassa_incub_epiparameter$prob_dist,
    class = "distribution"
  )
  expect_identical(family(lassa_incub_epiparameter), "lnorm")
  expect_true(is_parameterised(lassa_incub_epiparameter))
  # populate mean and sd summary statistics without uncertainty
  expect_true(all(!is.na(lassa_incub_epiparameter$summary_stats[c("mean", "sd")])))
})

test_that("as_epiparameter works for overwritten prob_dist with same parameters", {
  # {epireview} is not a dependency so only run if already on system
  skip_if_not_installed("epireview")
  ebola_params <- ebola_data$params
  ebola_si <- ebola_params[
    which(
      ebola_params$distribution_par1_type == "Shape" &
        ebola_params$article_label == "Fallah 2015 (1)"
    ),
  ]
  # suppress warning and message about citation
  ebola_si_gamma <- suppressWarnings(
    suppressMessages(
      as_epiparameter(ebola_si)
    )
  )
  ebola_si_weibull <- suppressWarnings(
    suppressMessages(
      as_epiparameter(ebola_si, prob_dist = "weibull")
    )
  )
  expect_s3_class(ebola_si_gamma, class = "epiparameter")
  expect_s3_class(ebola_si_weibull, class = "epiparameter")
  expect_true(is_parameterised(ebola_si_gamma))
  expect_true(is_parameterised(ebola_si_weibull))
  expect_identical(family(ebola_si_gamma), "gamma")
  expect_identical(family(ebola_si_weibull), "weibull")
})

test_that("as_epiparameter fails as expected with overwritten prob_dist", {
  # {epireview} is not a dependency so only run if already on system
  skip_if_not_installed("epireview")
  ebola_params <- ebola_data$params
  ebola_si <- ebola_params[
    which(
      ebola_params$distribution_par1_type == "Shape" &
        ebola_params$article_label == "Fallah 2015 (1)"
    ),
  ]
  # suppress warning and message about citation
  ebola_si_lnorm <- suppressWarnings(
    suppressMessages(
      as_epiparameter(ebola_si, prob_dist = "lnorm")
    )
  )
  expect_s3_class(ebola_si_lnorm, class = "epiparameter")
  expect_false(is_parameterised(ebola_si_lnorm))
  expect_identical(family(ebola_si_lnorm), "lnorm")
})
