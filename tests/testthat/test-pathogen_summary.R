test_that("pathogen_summary works with valid input", {
  ebola_summary <- pathogen_summary(pathogen = "ebola")
  expect_s3_class(ebola_summary, class = "epidist_tbl")
  expect_length(ebola_summary, 2)
  expect_equal(
    names(ebola_summary),
    c("pathogen", "pathogen_tbl")
  )
  expect_true(is.character(ebola_summary$pathogen))
  expect_true(is.data.frame(ebola_summary$pathogen_tbl))
})

test_that("pathogen_summary works with pathogen with gamma and lnorm", {
  sars_summary <- pathogen_summary(pathogen = "SARS_CoV")
  expect_s3_class(sars_summary, class = "epidist_tbl")
  expect_length(sars_summary, 2)
  expect_equal(
    names(sars_summary),
    c("pathogen", "pathogen_tbl")
  )
  expect_true(is.character(sars_summary$pathogen))
  expect_true(is.data.frame(sars_summary$pathogen_tbl))
})

test_that("epidist_summary print method works", {
  ebola_summary <- pathogen_summary(pathogen = "ebola")
  expect_output(print(ebola_summary))
  expect_snapshot(print(ebola_summary))
})