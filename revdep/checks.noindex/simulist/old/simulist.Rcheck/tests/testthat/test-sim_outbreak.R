test_that("sim_outbreak works as expected with defaults", {
  set.seed(1)
  expect_snapshot(sim_outbreak())
})

suppressMessages({
  contact_distribution <- epiparameter::epiparameter(
    disease = "COVID-19",
    epi_name = "contact distribution",
    prob_distribution = create_prob_distribution(
      prob_distribution = "pois",
      prob_distribution_params = c(mean = 2)
    )
  )

  infectious_period <- epiparameter::epiparameter(
    disease = "COVID-19",
    epi_name = "infectious period",
    prob_distribution = create_prob_distribution(
      prob_distribution = "gamma",
      prob_distribution_params = c(shape = 1, scale = 1)
    )
  )

  # get onset to hospital admission from {epiparameter} database
  onset_to_hosp <- epiparameter::epiparameter_db(
    disease = "COVID-19",
    epi_name = "onset to hospitalisation",
    single_epiparameter = TRUE
  )

  # get onset to death from {epiparameter} database
  onset_to_death <- epiparameter::epiparameter_db(
    disease = "COVID-19",
    epi_name = "onset to death",
    single_epiparameter = TRUE
  )
})

test_that("sim_outbreak works as expected", {
  set.seed(1)
  expect_snapshot(
    sim_outbreak(
      contact_distribution = contact_distribution,
      infectious_period = infectious_period,
      prob_infection = 0.5,
      onset_to_hosp = onset_to_hosp,
      onset_to_death = onset_to_death
    )
  )
})

test_that("sim_outbreak works as expected with anonymised", {
  set.seed(1)
  expect_snapshot(
    sim_outbreak(
      contact_distribution = contact_distribution,
      infectious_period = infectious_period,
      prob_infection = 0.5,
      onset_to_hosp = onset_to_hosp,
      onset_to_death = onset_to_death,
      anonymise = TRUE
    )
  )
})

test_that("sim_outbreak works as expected with age-strat risks", {
  age_dep_hosp_risk <- data.frame(
    age_limit = c(1, 5, 80),
    risk = c(0.1, 0.05, 0.2)
  )
  age_dep_hosp_death_risk <- data.frame(
    age_limit = c(1, 5, 80),
    risk = c(0.1, 0.05, 0.2)
  )
  age_dep_non_hosp_death_risk <- data.frame(
    age_limit = c(1, 5, 80),
    risk = c(0.05, 0.025, 0.1)
  )
  set.seed(1)
  expect_snapshot(
    sim_outbreak(
      contact_distribution = contact_distribution,
      infectious_period = infectious_period,
      prob_infection = 0.5,
      onset_to_hosp = onset_to_hosp,
      onset_to_death = onset_to_death,
      hosp_risk = age_dep_hosp_risk,
      hosp_death_risk = age_dep_hosp_death_risk,
      non_hosp_death_risk = age_dep_non_hosp_death_risk
    )
  )
})

test_that("sim_outbreak works as expected with age structure", {
  age_struct <- data.frame(
    age_range = c("1-4", "5-79", "80-90"),
    proportion = c(0.1, 0.7, 0.2),
    stringsAsFactors = FALSE
  )
  set.seed(1)
  expect_snapshot(
    sim_outbreak(
      contact_distribution = contact_distribution,
      infectious_period = infectious_period,
      prob_infection = 0.5,
      onset_to_hosp = onset_to_hosp,
      onset_to_death = onset_to_death,
      population_age = age_struct
    )
  )
})
