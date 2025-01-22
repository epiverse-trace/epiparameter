# Instructions for updating test data

The {simulist} R package contains test data files in order to test internal functions. The intermediate output required to test the internals of the simulation functions cannot be produced by running a function (hence intermediate). The test data files contain in progress mock line lists at different stages of the simulation. Each test data file contains a single R object (stored as `.rds`), and is named according to where in the simulation the data object is saved from. The names are: 

* "pre_date_last_contact"
* "pre_date_first_contact"
* "pre_hospitalisation"
* "pre_outcome"
* "pre_names"
* "pre_ct"


Each of the scenarios are created by taking a snapshot (i.e copy) of the  line list `<data.frame>` are each stage of the simulation (`sim_linelist()`) after setting the seed to 1 (`set.seed(1)`). The scenarios are before each function call, for example, `"pre_date_last_contact"` is the state of the line list prior to calling `.add_date_contact(..., contact_type = "last")`, and `"pre_names"` is the state of the line list prior to calling `.add_names()`.

Breakpoints (`browser()`) need to be placed before each function call to stop the simulation and snapshot the intermediate `<data.frame>`.

The script to reproduce the data is:

``` r
# load data required to simulate line list
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
set.seed(1)

linelist <- sim_linelist(
  contact_distribution = contact_distribution,
  infectious_period = infectious_period,
  prob_infection = 0.5,
  onset_to_hosp = onset_to_hosp,
  onset_to_death = onset_to_death,
  hosp_risk = 0.5
)
```

Files can be saved using `saveRDS()`. Ensure the working directory is at the root of the R package (working directory can be queried with `getwd()` and set with `setwd()`). For example:
``` r
saveRDS(pre_ct, file = "tests/testthat/testdata/pre_ct.rds")
```
