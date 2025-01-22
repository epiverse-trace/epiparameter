test_that("create_config works as expected with defaults", {
  config <- create_config()
  expect_type(config, type = "list")
  expect_length(config, 8)
  expect_named(
    config,
    c(
      "last_contact_distribution", "last_contact_distribution_params",
      "first_contact_distribution", "first_contact_distribution_params",
      "ct_distribution", "ct_distribution_params", "network",
      "time_varying_death_risk"
    )
  )
})

test_that("create_config works as expected modifying element", {
  config <- create_config(last_contact_distribution = "geom")
  expect_type(config, type = "list")
  expect_length(config, 8)
  expect_named(
    config,
    c(
      "last_contact_distribution", "last_contact_distribution_params",
      "first_contact_distribution", "first_contact_distribution_params",
      "ct_distribution", "ct_distribution_params", "network",
      "time_varying_death_risk"
    )
  )
  expect_identical(config$last_contact_distribution, "geom")
})

test_that("create_config works as expected with spliced list", {
  config <- create_config(
    !!!list(
      ct_distribution = "lnorm",
      ct_distribution_params = c(meanlog = 2, sdlog = 1)
    )
  )
  expect_type(config, type = "list")
  expect_length(config, 8)
  expect_named(
    config,
    c(
      "last_contact_distribution", "last_contact_distribution_params",
      "first_contact_distribution", "first_contact_distribution_params",
      "ct_distribution", "ct_distribution_params", "network",
      "time_varying_death_risk"
    )
  )
  expect_identical(config$ct_distribution, "lnorm")
  expect_identical(config$ct_distribution_params, c(meanlog = 2, sdlog = 1))

  config <- create_config(
    last_contact_distribution = "geom",
    !!!list(
      ct_distribution = "lnorm",
      ct_distribution_params = c(meanlog = 2, sdlog = 1)
    )
  )
  expect_type(config, type = "list")
  expect_length(config, 8)
  expect_named(
    config,
    c(
      "last_contact_distribution", "last_contact_distribution_params",
      "first_contact_distribution", "first_contact_distribution_params",
      "ct_distribution", "ct_distribution_params", "network",
      "time_varying_death_risk"
    )
  )
  expect_identical(config$last_contact_distribution, "geom")
  expect_identical(config$ct_distribution, "lnorm")
  expect_identical(config$ct_distribution_params, c(meanlog = 2, sdlog = 1))
})

test_that("create_config fails as expected misspelling modifying element", {
  # test also checks that partial name matching of list names does not happen
  expect_error(
    create_config(last_contact_dist = "geom"),
    regexp = "Incorrect argument names supplied to create_config"
  )
})

test_that("create_config fails as expected with unnamed elements", {
  expect_error(
    create_config("lnorm", c(meanlog = 2, sdlog = 1)),
    regexp = "Incorrect argument names supplied to create_config"
  )
  expect_error(
    create_config(ct_distribution = "lnorm", c(meanlog = 2, sdlog = 1)),
    regexp = "Incorrect argument names supplied to create_config"
  )
})

test_that("create_config fails as expected with list input", {
  expect_error(
    create_config(
      list(
        ct_distribution = "lnorm",
        ct_distribution_params = c(meanlog = 2, sdlog = 1)
      )
    ),
    regexp = "Incorrect argument names supplied to create_config"
  )
  expect_error(
    create_config(
      list(ct_distribution = "lnorm"),
      ct_distribution_params = c(meanlog = 2, sdlog = 1)
    ),
    regexp = "Incorrect argument names supplied to create_config"
  )
})
