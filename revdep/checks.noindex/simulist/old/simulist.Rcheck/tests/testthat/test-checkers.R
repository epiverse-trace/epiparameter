test_that(".check_risk_df works as expected", {
  age_dep_hosp_risk <- data.frame(
    age_limit = c(1, 5, 80),
    risk = c(0.1, 0.05, 0.2)
  )
  age_dep_hosp_risk <- .check_risk_df(
    age_dep_hosp_risk,
    age_range = c(lower = 1, upper = 90)
  )
  expect_s3_class(age_dep_hosp_risk, class = "data.frame")
  expect_identical(dim(age_dep_hosp_risk), c(3L, 3L))
  expect_identical(colnames(age_dep_hosp_risk), c("min_age", "max_age", "risk"))
  expect_identical(
    row.names(age_dep_hosp_risk),
    c("[1,5)", "[5,80)", "[80,90]")
  )
})

test_that(".check_risk_df fails as expected", {
  age_dep_hosp_risk <- data.frame(
    age_min = c(1, 5, 80),
    hosp_risk = c(0.1, 0.05, 0.2)
  )
  expect_error(
    .check_risk_df(age_dep_hosp_risk, age_range = c(lower = 1, upper = 91)),
    regexp = "Column names should be 'age_limit' & 'risk'"
  )

  age_dep_hosp_risk <- data.frame(
    age_limit = c(2, 5, 80),
    risk = c(0.1, 0.05, 0.2)
  )
  expect_error(
    .check_risk_df(age_dep_hosp_risk, age_range = c(lower = 1, upper = 90)),
    regexp = "Minimum age of lowest age group should match lower age range"
  )

  age_dep_hosp_risk <- data.frame(
    age_limit = c(1, 5, 90),
    risk = c(0.1, 0.05, 0.2)
  )
  expect_error(
    .check_risk_df(age_dep_hosp_risk, age_range = c(lower = 1, upper = 90)),
    regexp =
      "Lower bound of oldest age group must be lower than highest age range"
  )

  age_dep_hosp_risk <- data.frame(
    age_limit = c(1, 5, 80),
    risk = c(-0.1, 0.5, 1.1)
  )
  expect_error(
    .check_risk_df(age_dep_hosp_risk, age_range = c(lower = 1, upper = 90)),
    regexp = "Risk should be between 0 and 1"
  )

  age_dep_hosp_risk <- data.frame(
    age_limit = c(1, 5, 5),
    risk = c(0.1, 0.05, 0.2)
  )
  expect_error(
    .check_risk_df(age_dep_hosp_risk, age_range = c(lower = 1, upper = 90)),
    regexp = "Age limit in risk data frame must be unique"
  )

  age_dep_hosp_risk <- data.frame(
    age_limit = c(1, 10, 80),
    risk = c(0.1, 0.05, NA)
  )
  expect_error(
    .check_risk_df(age_dep_hosp_risk, age_range = c(lower = 1, upper = 90)),
    regexp = "Age limit or risk cannot be NA or NaN"
  )
})

test_that(".check_age_df works as expected", {
  age_struct <- data.frame(
    age_range = c("1-4", "5-79", "80-90"),
    proportion = c(0.1, 0.7, 0.2),
    stringsAsFactors = FALSE
  )
  age_struct <- .check_age_df(age_struct)
  expect_s3_class(age_struct, class = "data.frame")
  expect_identical(dim(age_struct), c(3L, 3L))
  expect_identical(colnames(age_struct), c("min_age", "max_age", "proportion"))
})

test_that(".check_age_df fails as expected", {
  age_struct <- data.frame(
    age_range = c("1-4", "5-79", "80-90"),
    percentage = c(0.1, 0.7, 0.2),
    stringsAsFactors = FALSE
  )
  expect_error(
    .check_age_df(age_struct),
    regexp = "Column names should be 'age_range' & 'proportion'"
  )

  age_struct <- data.frame(
    age_range = c("1-4", "5-79", "80-90"),
    proportion = c(0.1, NA, 0.2),
    stringsAsFactors = FALSE
  )
  expect_error(
    .check_age_df(age_struct),
    regexp = "Age range or proportion cannot be NA or NaN"
  )

  age_struct <- data.frame(
    age_range = c("1-4", "5-79", "80-90"),
    proportion = c(0.1, 0.7, 0.3),
    stringsAsFactors = FALSE
  )
  expect_error(
    .check_age_df(age_struct),
    regexp = "Proportions of each age bracket should sum to 1"
  )

  age_struct <- data.frame(
    age_range = c("1_4", "5-79", "80-90"),
    proportion = c(0.1, 0.7, 0.2),
    stringsAsFactors = FALSE
  )
  expect_error(
    .check_age_df(age_struct),
    regexp = "(All age groups should be separated with a)*(-)"
  )

  age_struct <- data.frame(
    age_range = c("1-4", "52-79", "80-90"),
    proportion = c(0.1, 0.7, 0.2),
    stringsAsFactors = FALSE
  )
  expect_error(
    .check_age_df(age_struct),
    regexp = "Age groups should be contiguous"
  )
})

suppressMessages({
  library(epiparameter)
  contact_distribution <- as.function(
    epiparameter(
      disease = "COVID-19",
      epi_name = "contact distribution",
      prob_distribution = create_prob_distribution(
        prob_distribution = "pois",
        prob_distribution_params = c(mean = 2)
      )
    )
  )

  infectious_period <- as.function(
    epiparameter(
      disease = "COVID-19",
      epi_name = "infectious period",
      prob_distribution = create_prob_distribution(
        prob_distribution = "gamma",
        prob_distribution_params = c(shape = 1, scale = 1)
      )
    )
  )

  # get onset to hospital admission from {epiparameter} database
  onset_to_hosp <- as.function(
    epiparameter_db(
      disease = "COVID-19",
      epi_name = "onset to hospitalisation",
      single_epiparameter = TRUE
    )
  )

  # get onset to death from {epiparameter} database
  onset_to_death <- as.function(
    epiparameter_db(
      disease = "COVID-19",
      epi_name = "onset to death",
      single_epiparameter = TRUE
    )
  )

  onset_to_recovery <- as.function(epiparameter(
    disease = "COVID-19",
    epi_name = "onset to recovery",
    prob_distribution = create_prob_distribution(
      prob_distribution = "lnorm",
      prob_distribution_params = c(meanlog = 3, sdlog = 1)
    )
  ))
})

test_that(".check_sim_input works as expected", {
  chk <- .check_sim_input(
    sim_type = "outbreak",
    contact_distribution = contact_distribution,
    infectious_period = infectious_period,
    prob_infection = 0.5,
    outbreak_start_date = as.Date("2023-01-01"),
    outbreak_size = c(10, 1e4),
    onset_to_hosp = onset_to_hosp,
    onset_to_death = onset_to_death,
    onset_to_recovery = onset_to_recovery,
    anonymise = FALSE,
    case_type_probs = c(
      suspected = 0.2,
      probable = 0.3,
      confirmed = 0.5
    ),
    contact_tracing_status_probs = c(
      under_followup = 0.7,
      lost_to_followup = 0.2,
      unknown = 0.1
    ),
    hosp_risk = 0.2,
    hosp_death_risk = 0.5,
    non_hosp_death_risk = 0.05,
    population_age = c(1, 90)
  )
  expect_type(chk, type = "character")
  expect_length(chk, n = 1)

  chk <- .check_sim_input(
    sim_type = "linelist",
    contact_distribution = contact_distribution,
    infectious_period = infectious_period,
    prob_infection = 0.5,
    outbreak_start_date = as.Date("2023-01-01"),
    outbreak_size = c(10, 1e4),
    onset_to_hosp = onset_to_hosp,
    onset_to_death = onset_to_death,
    onset_to_recovery = onset_to_recovery,
    anonymise = FALSE,
    case_type_probs = c(
      suspected = 0.2,
      probable = 0.3,
      confirmed = 0.5
    ),
    hosp_risk = 0.2,
    hosp_death_risk = 0.5,
    non_hosp_death_risk = 0.05,
    population_age = c(1, 90)
  )
  expect_type(chk, type = "character")
  expect_length(chk, n = 1)

  chk <- .check_sim_input(
    sim_type = "contacts",
    contact_distribution = contact_distribution,
    infectious_period = infectious_period,
    prob_infection = 0.5,
    outbreak_start_date = as.Date("2023-01-01"),
    outbreak_size = c(10, 1e4),
    contact_tracing_status_probs = c(
      under_followup = 0.7,
      lost_to_followup = 0.2,
      unknown = 0.1
    ),
    population_age = c(1, 90)
  )
  expect_type(chk, type = "character")
  expect_length(chk, n = 1)
})

test_that(".check_sim_input works as expected with NULL risks", {
  chk <- .check_sim_input(
    sim_type = "outbreak",
    contact_distribution = contact_distribution,
    infectious_period = infectious_period,
    prob_infection = 0.5,
    outbreak_start_date = as.Date("2023-01-01"),
    outbreak_size = c(10, 1e4),
    onset_to_hosp = onset_to_hosp,
    onset_to_death = onset_to_death,
    onset_to_recovery = onset_to_recovery,
    anonymise = FALSE,
    case_type_probs = c(
      suspected = 0.2,
      probable = 0.3,
      confirmed = 0.5
    ),
    contact_tracing_status_probs = c(
      under_followup = 0.7,
      lost_to_followup = 0.2,
      unknown = 0.1
    ),
    hosp_risk = NULL,
    hosp_death_risk = NULL,
    non_hosp_death_risk = NULL,
    population_age = c(1, 90)
  )
  expect_type(chk, type = "character")
  expect_length(chk, n = 1)
})

test_that(".check_sim_input fails as expected", {
  expect_error(
    .check_sim_input(sim_type = "random"),
    regexp = "(arg)*(should be one of)*(linelist)*(contacts)*(outbreak)"
  )
  expect_error(
    .check_sim_input(
      sim_type = "outbreak",
      contact_distribution = list(),
      prob_infection = 0.5
    ),
    regexp = "(Assertion on)*(contact_distribution)*(failed)"
  )
  expect_error(
    .check_sim_input(
      sim_type = "outbreak",
      contact_distribution = contact_distribution,
      infectious_period = list(),
      prob_infection = 0.5
    ),
    regexp = "(Assertion on)*(infectious_period)*(failed)"
  )
  expect_error(
    .check_sim_input(
      sim_type = "outbreak",
      contact_distribution = contact_distribution,
      infectious_period = infectious_period,
      prob_infection = 0.5,
      outbreak_start_date = "01-01-2023"
    ),
    regexp = "(Assertion on)*(outbreak_start_date)*(failed)"
  )
  expect_error(
    .check_sim_input(
      sim_type = "outbreak",
      contact_distribution = contact_distribution,
      infectious_period = infectious_period,
      prob_infection = 0.5,
      outbreak_start_date = as.Date("2023-01-01"),
      outbreak_size = "c(10, 1e4)"
    ),
    regexp = "(Assertion on)*(outbreak_size)*(failed)"
  )
})

test_that(".cross_check_sim_input works as expected with numeric risk", {
  chk <- .cross_check_sim_input(
    onset_to_hosp = onset_to_hosp,
    onset_to_death = onset_to_death,
    hosp_risk = 0.2,
    hosp_death_risk = 0.5,
    non_hosp_death_risk = 0.05
  )
  expect_type(chk, type = "closure")
  expect_length(chk, n = 1)
})

test_that(".cross_check_sim_input works as expected with <data.frame> risks", {
  age_dep_hosp_risk <- data.frame(
    age_limit = c(1, 5, 80),
    risk = c(0.1, 0.05, 0.2)
  )
  age_dep_hosp_death_risk <- data.frame(
    age_limit = c(1, 5, 80),
    risk = c(0.3, 0.1, 0.6)
  )
  age_dep_non_hosp_death_risk <- data.frame(
    age_limit = c(1, 5, 80),
    risk = c(0.1, 0.05, 0.1)
  )

  chk <- .cross_check_sim_input(
    onset_to_hosp = onset_to_hosp,
    onset_to_death = onset_to_death,
    hosp_risk = age_dep_hosp_risk,
    hosp_death_risk = age_dep_hosp_death_risk,
    non_hosp_death_risk = age_dep_non_hosp_death_risk
  )
  expect_type(chk, type = "closure")
  expect_length(chk, n = 1)
})

test_that(".cross_check_sim_input warns as expected", {
  expect_warning(
    .cross_check_sim_input(
      onset_to_hosp = function(x) rep(NA, times = x),
      onset_to_death = onset_to_death,
      hosp_risk = 0.2,
      hosp_death_risk = 0.5,
      non_hosp_death_risk = 0.05
    ),
    regexp = paste0(
      "(onset_to_hosp is set to NA)*(hosp_risk is being ignored)*",
      "(hosp_death_risk is being ignored)"
    )
  )

  expect_warning(
    .cross_check_sim_input(
      onset_to_hosp = function(x) rep(NA, times = x),
      onset_to_death = onset_to_death,
      hosp_risk = 0.2,
      hosp_death_risk = 0.5,
      non_hosp_death_risk = 0.05
    ),
    regexp = paste0(
      "(onset_to_hosp is set to NA)*(hosp_risk is being ignored)*",
      "(hosp_death_risk is being ignored)"
    )
  )
  expect_warning(
    .cross_check_sim_input(
      onset_to_hosp = onset_to_hosp,
      onset_to_death = function(x) rep(NA, times = x),
      hosp_risk = 0.2,
      hosp_death_risk = 0.5,
      non_hosp_death_risk = 0.05
    ),
    regexp = paste0(
      "(onset_to_death is set to NA)*(hosp_death_risk is being ignored)*",
      "(non_hosp_death_risk is being ignored)"
    )
  )
  expect_error(
    .cross_check_sim_input(
      onset_to_hosp = onset_to_hosp,
      onset_to_death = onset_to_death,
      hosp_risk = NULL,
      hosp_death_risk = 0.5,
      non_hosp_death_risk = 0.05
    ),
    regexp = paste0(
      "(hosp_risk is set to NA)*(but onset_to_hosp is specified)*",
      "(set hosp_risk to numeric value)"
    )
  )
  expect_error(
    .cross_check_sim_input(
      onset_to_hosp = onset_to_hosp,
      onset_to_death = onset_to_death,
      hosp_risk = 0.2,
      hosp_death_risk = NULL,
      non_hosp_death_risk = 0.05
    ),
    regexp = paste0(
      "(hosp_death_risk is set to NA)*(but onset_to_death is specified)*",
      "(set hosp_death_risk to numeric value)"
    )
  )
  expect_error(
    .cross_check_sim_input(
      onset_to_hosp = onset_to_hosp,
      onset_to_death = onset_to_death,
      hosp_risk = 0.2,
      hosp_death_risk = 0.5,
      non_hosp_death_risk = NULL
    ),
    regexp = paste0(
      "(non_hosp_death_risk is set to NA)*(onset_to_death is specified)*",
      "(set non_hosp_death_risk to numeric value)"
    )
  )
})

test_that(".check_func_req_args works as expected", {
  expect_silent(.check_func_req_args(func = function(x) x + 1, n_req_args = 1))
  expect_null(.check_func_req_args(func = function(x) x + 1, n_req_args = 1))
})

test_that(".check_func_req_args works with more than 1 req args", {
  fn <- function(x, y) x + y
  expect_silent(.check_func_req_args(func = fn, n_req_args = 2))
  expect_null(.check_func_req_args(func = fn, n_req_args = 2))
})

test_that(".check_func_req_args works with arg names", {
  fn <- function(x) x
  expect_silent(.check_func_req_args(func = fn, req_arg_names = "x"))
  expect_null(.check_func_req_args(func = fn, req_arg_names = "x"))
})

test_that(".check_func_req_args fails as expected", {
  expect_error(
    .check_func_req_args(
      func = function(x) x + 1, func_name = "anonymous func", n_req_args = 2
    ),
    regexp = "(anonymous func supplied must have)*(2)*(argument)"
  )
  expect_error(
    .check_func_req_args(
      func = function(x, y) x + y, func_name = "anonymous func", n_req_args = 1
    ),
    regexp = "(anonymous func supplied must have)*(1)*(argument)"
  )
})

test_that(".check_func_req_args fails with arg names", {
  fn <- function(x) x
  expect_error(
    .check_func_req_args(
      func = fn, func_name = "anonymous func", req_arg_names = c("x", "y")
    ),
    regexp = "(anonymous func supplied must have)*(y)*(arguments)"
  )
})
