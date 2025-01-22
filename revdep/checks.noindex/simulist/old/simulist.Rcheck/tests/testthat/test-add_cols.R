suppressMessages({
  # get onset to hospital admission from {epiparameter} database &
  # convert to function
  onset_to_hosp <- as.function(
    epiparameter::epiparameter_db(
      disease = "COVID-19",
      epi_name = "onset to hospitalisation",
      single_epiparameter = TRUE
    )
  )

  # get onset to death from {epiparameter} database
  onset_to_death <- as.function(
    epiparameter::epiparameter_db(
      disease = "COVID-19",
      epi_name = "onset to death",
      single_epiparameter = TRUE
    )
  )

  onset_to_recovery <- function(x) rep(NA, times = x)
})

test_that(".add_date_contact works as expected with contact_type = 'last'", {
  ll <- readRDS(file = file.path("testdata", "pre_date_last_contact.rds"))
  linelist <- .add_date_contact(
    .data = ll,
    contact_type = "last",
    outbreak_start_date = as.Date("2023-01-01"),
    distribution = "pois",
    lambda = 3
  )
  expect_s3_class(linelist, class = "data.frame")
  expect_s3_class(linelist$date_last_contact, class = "Date")
  expect_identical(dim(linelist), c(nrow(ll), ncol(ll) + 1L))
  expect_identical(colnames(linelist), c(colnames(ll), "date_last_contact"))
})

test_that(".add_date_contact works as expected with contact_type = 'first'", {
  ll <- readRDS(file.path("testdata", "pre_date_first_contact.rds"))
  linelist <- .add_date_contact(
    .data = ll,
    contact_type = "first",
    distribution = "pois",
    lambda = 3
  )
  expect_s3_class(linelist, class = "data.frame")
  expect_s3_class(linelist$date_first_contact, class = "Date")
  expect_identical(dim(linelist), c(nrow(ll), ncol(ll) + 1L))
  expect_identical(colnames(linelist), c(colnames(ll), "date_first_contact"))
})

test_that(".add_date_contact (last) works as expected with different param", {
  ll <- readRDS(file.path("testdata", "pre_date_last_contact.rds"))
  linelist <- .add_date_contact(
    .data = ll,
    contact_type = "last",
    outbreak_start_date = as.Date("2023-01-01"),
    distribution = "pois",
    lambda = 1
  )
  expect_s3_class(linelist, class = "data.frame")
  expect_s3_class(linelist$date_last_contact, class = "Date")
  expect_identical(dim(linelist), c(nrow(ll), ncol(ll) + 1L))
  expect_identical(colnames(linelist), c(colnames(ll), "date_last_contact"))
})

test_that(".add_date_contact (first) works as expected with different param", {
  ll <- readRDS(file.path("testdata", "pre_date_first_contact.rds"))
  linelist <- .add_date_contact(
    .data = ll,
    contact_type = "first",
    distribution = "pois",
    lambda = 1
  )
  expect_s3_class(linelist, class = "data.frame")
  expect_s3_class(linelist$date_first_contact, class = "Date")
  expect_identical(dim(linelist), c(nrow(ll), ncol(ll) + 1L))
  expect_identical(colnames(linelist), c(colnames(ll), "date_first_contact"))
})

test_that(".add_date_contact fails as expected", {
  ll <- readRDS(file.path("testdata", "pre_date_last_contact.rds"))
  expect_error(
    .add_date_contact(
      .data = ll,
      contact_type = "last",
      outbreak_start_date = as.Date("2023-01-01"),
      distribution = "nbinom",
      size = 10,
      prob = 0.5
    ),
    regexp = "(arg)*(should be)*(pois)"
  )

  expect_error(
    .add_date_contact(
      .data = ll,
      contact_type = "last",
      outbreak_start_date = as.Date("2023-01-01"),
      distribution = "pois"
    ),
    regexp = "Distribution parameters are missing, check config"
  )

  expect_error(
    .add_date_contact(
      .data = ll,
      contact_type = "last",
      outbreak_start_date = as.Date("2023-01-01"),
      distribution = "pois",
      prob = 0.5
    ),
    regexp = "Incorrect parameterisation of distribution, check config"
  )

  expect_error(
    .add_date_contact(
      .data = ll,
      contact_type = "last",
      outbreak_start_date = as.Date("2023-01-01"),
      distribution = "pois",
      lambda = NA
    ),
    regexp = "Incorrect parameterisation of distribution, check config"
  )
})

test_that(".add_hospitalisation works as expected", {
  ll <- readRDS(file.path("testdata", "pre_hospitalisation.rds"))
  linelist <- .add_hospitalisation(
    .data = ll,
    onset_to_hosp = onset_to_hosp,
    hosp_risk = 0.5
  )
  expect_s3_class(linelist, class = "data.frame")
  expect_type(linelist$hospitalisation, type = "double")
  expect_identical(dim(linelist), c(nrow(ll), ncol(ll) + 1L))
  expect_identical(
    colnames(linelist),
    c(colnames(ll), "hospitalisation")
  )
})

test_that(".add_hospitalisation works as expected with different parameter", {
  ll <- readRDS(file.path("testdata", "pre_hospitalisation.rds"))
  linelist <- .add_hospitalisation(
    .data = ll,
    onset_to_hosp = onset_to_hosp,
    hosp_risk = 0.1
  )
  expect_s3_class(linelist, class = "data.frame")
  expect_type(linelist$hospitalisation, type = "double")
  expect_identical(dim(linelist), c(nrow(ll), ncol(ll) + 1L))
  expect_identical(
    colnames(linelist),
    c(colnames(ll), "hospitalisation")
  )
})

test_that(".add_hospitalisation works as expected with age-strat risks", {
  ll <- readRDS(file.path("testdata", "pre_hospitalisation.rds"))
  age_dep_hosp_risk <- data.frame(
    min_age = c(1, 5, 80),
    max_age = c(4, 79, 90),
    risk = c(0.1, 0.05, 0.2)
  )
  linelist <- .add_hospitalisation(
    .data = ll,
    onset_to_hosp = onset_to_hosp,
    hosp_risk = age_dep_hosp_risk
  )
  expect_s3_class(linelist, class = "data.frame")
  expect_type(linelist$hospitalisation, type = "double")
  expect_identical(dim(linelist), c(nrow(ll), ncol(ll) + 1L))
  expect_identical(
    colnames(linelist),
    c(colnames(ll), "hospitalisation")
  )
})

test_that(".add_outcome works as expected", {
  ll <- readRDS(file.path("testdata", "pre_outcome.rds"))
  linelist <- .add_outcome(
    .data = ll,
    onset_to_death = onset_to_death,
    onset_to_recovery = onset_to_recovery,
    hosp_death_risk = 0.5,
    non_hosp_death_risk = 0.5,
    config = create_config()
  )
  expect_s3_class(linelist, class = "data.frame")
  expect_type(linelist$outcome, type = "character")
  expect_type(linelist$outcome_time, type = "double")
  expect_identical(dim(linelist), c(nrow(ll), ncol(ll) + 2L))
  expect_identical(
    colnames(linelist),
    c(colnames(ll), "outcome", "outcome_time")
  )
})

test_that(".add_outcome works as expected with different parameter", {
  ll <- readRDS(file.path("testdata", "pre_outcome.rds"))
  linelist <- .add_outcome(
    .data = ll,
    onset_to_death = onset_to_death,
    onset_to_recovery = onset_to_recovery,
    hosp_death_risk = 0.9,
    non_hosp_death_risk = 0.1,
    config = create_config()
  )
  expect_s3_class(linelist, class = "data.frame")
  expect_type(linelist$outcome, type = "character")
  expect_type(linelist$outcome_time, type = "double")
  expect_identical(dim(linelist), c(nrow(ll), ncol(ll) + 2L))
  expect_identical(
    colnames(linelist),
    c(colnames(ll), "outcome", "outcome_time")
  )
})

test_that(".add_outcome works as expected with age-strat risks", {
  ll <- readRDS(file.path("testdata", "pre_outcome.rds"))
  age_dep_hosp_death_risk <- data.frame(
    min_age = c(1, 5, 80),
    max_age = c(4, 79, 90),
    risk = c(0.1, 0.05, 0.2)
  )
  age_dep_non_hosp_death_risk <- data.frame(
    min_age = c(1, 5, 80),
    max_age = c(4, 79, 90),
    risk = c(0.05, 0.025, 0.1)
  )
  linelist <- .add_outcome(
    .data = ll,
    onset_to_death = onset_to_death,
    onset_to_recovery = onset_to_recovery,
    hosp_death_risk = age_dep_hosp_death_risk,
    non_hosp_death_risk = age_dep_non_hosp_death_risk,
    config = create_config()
  )
  expect_s3_class(linelist, class = "data.frame")
  expect_type(linelist$outcome, type = "character")
  expect_type(linelist$outcome_time, type = "double")
  expect_identical(dim(linelist), c(nrow(ll), ncol(ll) + 2L))
  expect_identical(
    colnames(linelist),
    c(colnames(ll), "outcome", "outcome_time")
  )
})

test_that(".add_names works as expected", {
  ll <- readRDS(file.path("testdata", "pre_names.rds"))
  linelist <- .add_names(.data = ll)
  expect_s3_class(linelist, class = "data.frame")
  expect_type(linelist$case_name, type = "character")
  expect_type(linelist$infector_name, type = "character")
  expect_identical(dim(linelist), c(nrow(ll), ncol(ll) + 2L))
  expect_identical(
    colnames(linelist),
    c(colnames(ll), "case_name", "infector_name")
  )
})

test_that(".add_names works as expected with anonymise = TRUE", {
  ll <- readRDS(file.path("testdata", "pre_names.rds"))
  linelist <- .add_names(.data = ll, anonymise = TRUE)
  expect_s3_class(linelist, class = "data.frame")
  expect_type(linelist$case_name, type = "character")
  expect_type(linelist$infector_name, type = "character")
  expect_identical(dim(linelist), c(nrow(ll), ncol(ll) + 2L))
  expect_identical(
    colnames(linelist),
    c(colnames(ll), "case_name", "infector_name")
  )
})

test_that(".add_ct works as expected", {
  ll <- readRDS(file.path("testdata", "pre_ct.rds"))
  linelist <- .add_ct(.data = ll, distribution = "norm", mean = 3, sd = 0.5)
  expect_s3_class(linelist, class = "data.frame")
  expect_type(linelist$ct_value, type = "double")
  expect_identical(dim(linelist), c(nrow(ll), ncol(ll) + 1L))
  expect_identical(colnames(linelist), c(colnames(ll), "ct_value"))
})

test_that(".add_ct works as expected with different parameter", {
  ll <- readRDS(file.path("testdata", "pre_ct.rds"))
  linelist <- .add_ct(.data = ll, distribution = "norm", mean = 1, sd = 2)
  expect_s3_class(linelist, class = "data.frame")
  expect_type(linelist$ct_value, type = "double")
  expect_identical(dim(linelist), c(nrow(ll), ncol(ll) + 1L))
  expect_identical(colnames(linelist), c(colnames(ll), "ct_value"))
})

test_that(".add_ct fails as expected", {
  ll <- readRDS(file.path("testdata", "pre_ct.rds"))
  expect_error(
    .add_ct(.data = ll, distribution = "gamma", shape = 1, scale = 1),
    regexp = "(arg)*(should be)*(norm)*(lnorm)"
  )

  expect_error(
    .add_ct(.data = ll, distribution = "norm"),
    regexp = "Distribution parameters are missing, check config"
  )

  expect_error(
    .add_ct(.data = ll, distribution = "norm", men = 1, sd = 1),
    regexp = "Incorrect parameterisation of distribution, check config"
  )

  expect_error(
    .add_ct(.data = ll, distribution = "norm", mean = NA),
    regexp = "Incorrect parameterisation of distribution, check config"
  )
})
