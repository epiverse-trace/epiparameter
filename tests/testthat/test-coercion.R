test_that("as_epidist works for infectious period (issue #327)", {
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
    ebola_infectiousness$article_label == "Lau 2017 (1)",
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
