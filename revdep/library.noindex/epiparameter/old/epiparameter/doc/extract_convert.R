## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(epiparameter)

## -----------------------------------------------------------------------------
convert_params_to_summary_stats("gamma", shape = 2.5, scale = 1.5)

## -----------------------------------------------------------------------------
convert_summary_stats_to_params("gamma", mean = 2, sd = 2)
convert_summary_stats_to_params("gamma", mean = 2, var = 2)
convert_summary_stats_to_params("gamma", mean = 2, cv = 2)

## -----------------------------------------------------------------------------
ep <- epiparameter(
  disease = "<Disease name>",
  pathogen = "<Pathogen name>",
  epi_name = "<Epidemilogical Distribution name>",
  prob_distribution = create_prob_distribution(
    prob_distribution = "gamma",
    prob_distribution_params = c(shape = 2.5, scale = 1.5)
  )
)
convert_params_to_summary_stats(ep)

## -----------------------------------------------------------------------------
ep <- epiparameter(
  disease = "<Disease name>",
  pathogen = "<Pathogen name>",
  epi_name = "<Epidemilogical Distribution name>",
  prob_distribution = "gamma"
)
convert_params_to_summary_stats(ep, shape = 2.5, scale = 1.5)

## -----------------------------------------------------------------------------
ep <- epiparameter(
  disease = "<Disease name>",
  pathogen = "<Pathogen name>",
  epi_name = "<Epidemilogical Distribution name>",
  prob_distribution = "gamma",
  summary_stats = create_summary_stats(mean = 3.75, sd = 2.37)
)
convert_summary_stats_to_params(ep)

## -----------------------------------------------------------------------------
ep <- epiparameter(
  disease = "<Disease name>",
  pathogen = "<Pathogen name>",
  epi_name = "<Epidemilogical Distribution name>",
  prob_distribution = "gamma"
)
convert_summary_stats_to_params(ep, mean = 3.75, sd = 2.37)

## -----------------------------------------------------------------------------
convert_params_to_summary_stats("lnorm", meanlog = 2.5, sdlog = 1.5)

## -----------------------------------------------------------------------------
convert_summary_stats_to_params("lnorm", mean = 2, sd = 2)
convert_summary_stats_to_params("lnorm", mean = 2, var = 2)
convert_summary_stats_to_params("lnorm", mean = 2, cv = 2)
convert_summary_stats_to_params("lnorm", median = 2, sd = 2)
convert_summary_stats_to_params("lnorm", median = 2, var = 2)

## -----------------------------------------------------------------------------
convert_params_to_summary_stats("weibull", shape = 2.5, scale = 1.5)

## -----------------------------------------------------------------------------
convert_summary_stats_to_params("weibull", mean = 2, sd = 2)
convert_summary_stats_to_params("weibull", mean = 2, var = 2)
convert_summary_stats_to_params("weibull", mean = 2, cv = 2)

## -----------------------------------------------------------------------------
convert_params_to_summary_stats("nbinom", prob = 0.5, dispersion = 0.5)

## -----------------------------------------------------------------------------
convert_summary_stats_to_params("nbinom", mean = 1, sd = 1)
convert_summary_stats_to_params("nbinom", mean = 1, var = 1)
convert_summary_stats_to_params("nbinom", mean = 1, cv = 1)

## -----------------------------------------------------------------------------
convert_params_to_summary_stats("geom", prob = 0.5)

## -----------------------------------------------------------------------------
convert_summary_stats_to_params("geom", mean = 1)

## -----------------------------------------------------------------------------
extract_param(
  type = "percentiles",
  values = c(1, 10),
  distribution = "gamma",
  percentiles = c(0.025, 0.975)
)

## -----------------------------------------------------------------------------
extract_param(
  type = "range",
  values = c(10, 5, 15),
  distribution = "lnorm",
  samples = 25
)

## -----------------------------------------------------------------------------
# set seed to ensure warning is produced
set.seed(1)

# lower maximum iteration to show warning
extract_param(
  type = "range",
  values = c(10, 1, 25),
  distribution = "lnorm",
  samples = 100,
  control = list(max_iter = 100)
)

## ----extract_param for monkeypox percentiles----------------------------------
# Mpox lnorm from 75th percentiles in WHO data
extract_param(
  type = "percentiles",
  values = c(6, 13),
  distribution = "lnorm",
  percentiles = c(0.125, 0.875)
)

## ----extract_param for monkeypox median and range-----------------------------
# Mpox lnorm from median and range in 2022:
extract_param(
  type = "range",
  values = c(7, 3, 20),
  distribution = "lnorm",
  samples = 23
)

## ----convert parameters-------------------------------------------------------
# SARS gamma mean and var to shape and scale
convert_summary_stats_to_params("gamma", mean = 6.37, var = 16.7)

