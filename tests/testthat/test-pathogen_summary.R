test_that("pathogen_summary works with valid input", {
  ebola_summary <- pathogen_summary(pathogen = "ebola")
  expect_s3_class(ebola_summary, "data.frame")
  expect_equal(nrow(ebola_summary), 3)
  expect_equal(ncol(ebola_summary), 7)
  expect_named(
    ebola_summary,
    c("pathogen", "delay_dist", "distribution", "mean", "sd", "study", "DOI")
  )
  expect_type(ebola_summary$pathogen, "character")
  expect_true(is.character(ebola_summary$delay_dist))
  expect_true(is.character(ebola_summary$distribution))
  expect_true(is.numeric(ebola_summary$mean))
  expect_true(is.numeric(ebola_summary$sd))
  expect_true(is.character(ebola_summary$study))
  expect_true(is.character(ebola_summary$DOI))
  expect_snapshot(pathogen_summary(pathogen = "ebola"))
})

test_that("pathogen_summary works with pathogen with gamma and lnorm", {
  sars_summary <- pathogen_summary(pathogen = "SARS_CoV")
  expect_true(is.data.frame(sars_summary))
  expect_equal(nrow(sars_summary), 3)
  expect_equal(ncol(sars_summary), 7)
  expect_equal(
    colnames(sars_summary),
    c("pathogen", "delay_dist", "distribution", "mean", "sd", "study", "DOI")
  )
  expect_true(is.character(sars_summary$pathogen))
  expect_true(is.character(sars_summary$delay_dist))
  expect_true(is.character(sars_summary$distribution))
  expect_true(is.numeric(sars_summary$mean))
  expect_true(is.numeric(sars_summary$sd))
  expect_true(is.character(sars_summary$study))
  expect_true(is.character(sars_summary$DOI))
  expect_snapshot(pathogen_summary(pathogen = "SARS_CoV"))
})

test_that("pathogen_summary works with pathogen with weibull", {
  h5n1_summary <- pathogen_summary(pathogen = "influenza_H5N1")
  expect_s3_class(h5n1_summary, "data.frame")
  expect_equal(nrow(h5n1_summary), 2)
  expect_equal(ncol(h5n1_summary), 7)
  expect_named(
    h5n1_summary,
    c("pathogen", "delay_dist", "distribution", "mean", "sd", "study", "DOI")
  )
  expect_type(h5n1_summary$pathogen, "character")
  expect_true(is.character(h5n1_summary$delay_dist))
  expect_true(is.character(h5n1_summary$distribution))
  expect_true(is.numeric(h5n1_summary$mean))
  expect_true(is.numeric(h5n1_summary$sd))
  expect_true(is.character(h5n1_summary$study))
  expect_true(is.character(h5n1_summary$DOI))
  expect_snapshot(pathogen_summary(pathogen = "influenza_H5N1"))
})
