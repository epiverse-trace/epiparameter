test_that("sim_contacts works as expected with defaults", {
  set.seed(1)
  expect_snapshot(sim_contacts())
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
})

test_that("sim_contacts works as expected", {
  set.seed(1)
  expect_snapshot(
    sim_contacts(
      contact_distribution = contact_distribution,
      infectious_period = infectious_period,
      prob_infection = 0.5
    )
  )
})

test_that("sim_contacts works as expected with modified config", {
  set.seed(1)
  expect_snapshot(
    sim_contacts(
      contact_distribution = contact_distribution,
      infectious_period = infectious_period,
      prob_infection = 0.5,
      config = create_config(
        last_contact_distribution = "geom",
        last_contact_distribution_params = c(prob = 0.5)
      )
    )
  )
})

test_that("sim_contacts works as expected with modified config parameters", {
  set.seed(1)
  expect_snapshot(
    sim_contacts(
      contact_distribution = contact_distribution,
      infectious_period = infectious_period,
      prob_infection = 0.5,
      config = create_config(
        last_contact_distribution_params = c(lambda = 5)
      )
    )
  )
})

test_that("sim_contacts fails as expected with modified config", {
  expect_error(
    sim_contacts(
      contact_distribution = contact_distribution,
      infectious_period = infectious_period,
      prob_infection = 0.5,
      config = create_config(
        last_contact_distribution = "geom"
      )
    ),
    regexp = "Incorrect parameterisation of distribution, check config"
  )
})

test_that("sim_contacts fails as expected with empty config", {
  expect_error(
    sim_contacts(
      contact_distribution = contact_distribution,
      infectious_period = infectious_period,
      prob_infection = 0.5,
      config = list()
    ),
    regexp = "Network incorrectly specified, check config"
  )
})

test_that("sim_contacts works as expected with age structure", {
  age_struct <- data.frame(
    age_range = c("1-4", "5-79", "80-90"),
    proportion = c(0.1, 0.7, 0.2),
    stringsAsFactors = FALSE
  )
  set.seed(1)
  expect_snapshot(
    sim_contacts(
      contact_distribution = contact_distribution,
      infectious_period = infectious_period,
      prob_infection = 0.5,
      population_age = age_struct
    )
  )
})
