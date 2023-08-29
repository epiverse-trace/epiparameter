test_that("epiparam works as expected", {
  eparam <- epiparam()

  expect_s3_class(eparam, "epiparam")
  expect_identical(dim(eparam), c(118L, 58L))
})

test_that("epiparam works with all epi distributions", {
  eparam <- epiparam(epi_dist = "all")

  expect_s3_class(eparam, "epiparam")
  expect_identical(dim(eparam), c(118L, 58L))
})

test_that("epiparam works with incubation period", {
  eparam <- epiparam(epi_dist = "incubation_period")

  expect_s3_class(eparam, "epiparam")
  expect_identical(dim(eparam), c(72L, 58L))
})

test_that("epiparam works with onset-to-hospitalisation", {
  eparam <- epiparam(epi_dist = "onset_to_hospitalisation")

  expect_s3_class(eparam, "epiparam")
  expect_identical(dim(eparam), c(5L, 58L))
})

test_that("epiparam works with onset-to-death", {
  eparam <- epiparam(epi_dist = "onset_to_death")

  expect_s3_class(eparam, "epiparam")
  expect_identical(dim(eparam), c(7L, 58L))
})

test_that("epiparam works with serial interval", {
  eparam <- epiparam(epi_dist = "serial_interval")

  expect_s3_class(eparam, "epiparam")
  expect_identical(dim(eparam), c(15L, 58L))
})

test_that("epiparam works with generation time", {
  eparam <- epiparam(epi_dist = "generation_time")

  expect_s3_class(eparam, "epiparam")
  expect_identical(dim(eparam), c(1L, 58L))
})

test_that("epiparam fails when expected", {
  expect_error(
    epiparam(epi_dist = "delay_dist"),
    regexp = "('arg' should be one of)*(all)*(incubation_period)"
  )
})

test_that("epiparam print & format method works as expected", {
  expect_snapshot(epiparam())

  expect_output(print(epiparam()))
  expect_snapshot(print(epiparam()))

  expect_output(format(epiparam()))
  expect_snapshot(format(epiparam()))
})

test_that("epiparam summary method works as expected", {
  epiparam_summary <- summary(epiparam())

  expect_type(epiparam_summary, "list")
  expect_length(epiparam_summary, 8)
  expect_true(all(vapply(epiparam_summary, is.numeric, FUN.VALUE = logical(1))))
  expect_named(
    epiparam_summary,
    c(
      "num_entries", "num_diseases", "num_delay_dist", "num_offspring_dist",
      "num_studies", "num_continuous_distributions",
      "num_discrete_distributions", "num_vector_borne_diseases"
      )
  )
})

test_that("epiparam head & tails methods works as expected", {
  expect_snapshot(head(epiparam()))

  expect_snapshot(tail(epiparam()))
})

test_that("new_epiparam works as expected", {
  eparam <- new_epiparam(epi_dist = "all")
  expect_s3_class(eparam, "epiparam")
  expect_identical(dim(eparam), c(118L, 58L))
})

test_that("new_epiparam works with filtering by epi dist", {
  eparam <- new_epiparam(epi_dist = "incubation_period")

  expect_s3_class(eparam, "epiparam")
  expect_identical(dim(eparam), c(72L, 58L))
})

test_that("new_epiparam fails when expected", {
  expect_error(
    new_epiparam(epi_dist = c("incubation_period", "serial_interval")),
    regexp = "(Assertion on 'epi_dist' failed)"
  )
})

test_that("validate_epiparam passes when expected", {
  eparam <- new_epiparam(epi_dist = "all")

  expect_silent(validate_epiparam(epiparam = eparam))
})

test_that("validate_epidist catches class faults when expected", {
  eparam <- new_epiparam(epi_dist = "all")
  # suppress message about converting to data.frame
  suppressMessages(eparam <- eparam[, -1]) # nolint
  expect_error(
    validate_epiparam(epiparam = eparam),
    regexp = "Object should be of class epiparam"
  )

  eparam <- new_epiparam(epi_dist = "all")
  # suppress message about converting to data.frame
  suppressMessages(eparam$epi_distribution <- NULL) # nolint
  # convert back to `epiparam` to check validation
  class(eparam) <- c("epiparam", "data.frame")
  expect_error(
    validate_epiparam(epiparam = eparam),
    regexp = "epiparam object does not contain the correct columns"
  )

  eparam <- new_epiparam(epi_dist = "all")
  # suppress message about converting to data.frame
  suppressMessages(eparam$disease <- 1) # nolint
  # convert back to `epiparam` to check validation
  class(eparam) <- c("epiparam", "data.frame")
  expect_error(
    validate_epiparam(epiparam = eparam),
    regexp = "incorrect data type in character fields"
  )
})

test_that("validate_epidist fails when expected for reconstructed = TRUE", {
  eparam <- new_epiparam(epi_dist = "all")
  # suppress message about converting to data.frame
  suppressMessages(eparam <- eparam[, -1]) # nolint
  expect_error(
    validate_epiparam(epiparam = eparam, reconstruct = TRUE),
    regexp = "epiparam object does not contain the correct columns"
  )
})

test_that("validate_epiparam fails as expected with input class", {
  expect_error(
    validate_epiparam(epiparam = 1),
    regexp = "Object should be of class epiparam"
  )
})

test_that("is_epiparam returns TRUE when expected", {
  eparam <- epiparam()

  expect_true(is_epiparam(eparam))
})

test_that("is_epiparam returns FALSE when expected", {
  eparam <- epiparam()
  eparam <- unclass(eparam)

  expect_false(is_epiparam(eparam))
})

test_that("epiparam_fields returns vector as expected", {
  expect_vector(object = epiparam_fields(), ptype = character(0), size = 58)
})

test_that("epiparam_char_fields returns vector as expected", {
  eparam <- epiparam()
  expect_vector(
    object = epiparam_char_fields(eparam), ptype = integer(0), size = 13
  )
})

test_that("epiparam_num_fields returns vector as expected", {
  eparam <- epiparam()
  expect_vector(
    object = epiparam_num_fields(eparam), ptype = integer(0), size = 31
  )
})

test_that("epiparam_logic_fields returns vector as expected", {
  eparam <- epiparam()
  expect_vector(
    object = epiparam_logic_fields(eparam), ptype = integer(0), size = 5
  )
})
