test_that("set_epiparameter_options uses defaults when no user option is set", {
  old <- options(epiparameter = NULL)
  on.exit(options(old), add = TRUE)

  set_epiparameter_options()

  expect_identical(getOption("epiparameter"), epiparameter_default_options)
})

test_that("set_epiparameter_options preserves a fully user-set option", {
  user_opts <- list(print_max = 10L, print_min = 5L)
  old <- options(epiparameter = user_opts)
  on.exit(options(old), add = TRUE)

  set_epiparameter_options()

  expect_identical(getOption("epiparameter"), user_opts)
})

test_that("set_epiparameter_options merges partial user options with defaults", {
  old <- options(epiparameter = list(print_max = 99L))
  on.exit(options(old), add = TRUE)

  set_epiparameter_options()

  merged <- getOption("epiparameter")
  expect_identical(merged$print_max, 99L)
  expect_identical(merged$print_min, epiparameter_default_options$print_min)
})

test_that("set_epiparameter_options retains extra fields supplied by the user", {
  old <- options(epiparameter = list(print_max = 7L, custom_field = "keep me"))
  on.exit(options(old), add = TRUE)

  set_epiparameter_options()

  merged <- getOption("epiparameter")
  expect_identical(merged$print_max, 7L)
  expect_identical(merged$custom_field, "keep me")
  expect_identical(merged$print_min, epiparameter_default_options$print_min)
})

test_that("set_epiparameter_options falls back to defaults when option is not a list", {
  old <- options(epiparameter = "not a list")
  on.exit(options(old), add = TRUE)

  set_epiparameter_options()

  expect_identical(getOption("epiparameter"), epiparameter_default_options)
})
