## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.width = 8,
  fig.height = 5
)

## ----setup--------------------------------------------------------------------
library(epiparameter)

## ----read-in-library----------------------------------------------------------
db <- epiparameter_db()
db

## ----parameter-tbl------------------------------------------------------------
parameter_tbl(multi_epiparameter = db)

## ----parameter-tbl-subset-----------------------------------------------------
parameter_tbl(multi_epiparameter = db, disease = "Ebola")

## ----epiparameter-db----------------------------------------------------------
# <epiparameter> from database

# fetch <epiparameter> for COVID-19 incubation period from database
# return only a single <epiparameter>
covid_incubation <- epiparameter_db(
  disease = "COVID-19",
  epi_name = "incubation period",
  single_epiparameter = TRUE
)
covid_incubation

## ----epiparameter-constructor-------------------------------------------------
# <epiparameter> using constructor function
covid_incubation <- epiparameter(
  disease = "COVID-19",
  pathogen = "SARS-CoV-2",
  epi_name = "incubation period",
  prob_distribution = create_prob_distribution(
    prob_distribution = "gamma",
    prob_distribution_params = c(shape = 2, scale = 1)
  ),
  summary_stats = create_summary_stats(mean = 2),
  citation = create_citation(
    author = person(
      given = list("John", "Amy"),
      family = list("Smith", "Jones")
    ),
    year = 2022,
    title = "COVID Incubation Period",
    journal = "Epi Journal",
    doi = "10.27861182.x"
  )
)
covid_incubation

## ----epiparameter-db-subset-author--------------------------------------------
epiparameter_db(
  disease = "COVID-19",
  epi_name = "incubation period",
  author = "Linton"
)

## ----epiparameter-db-single-epiparameter--------------------------------------
epiparameter_db(disease = "SARS", single_epiparameter = TRUE)

## ----epiparameter-dist-methods------------------------------------------------
ebola_incubation <- epiparameter_db(
  disease = "Ebola",
  epi_name = "incubation period",
  single_epiparameter = TRUE
)

density(ebola_incubation, at = 0.5)
cdf(ebola_incubation, q = 0.5)
quantile(ebola_incubation, p = 0.5)
generate(ebola_incubation, times = 10)

## ----plot-epiparameter--------------------------------------------------------
plot(ebola_incubation)

## ----plot-epiparameter-dayrange-----------------------------------------------
plot(ebola_incubation, xlim = c(1, 25))

## ----epiparameter-accessors---------------------------------------------------
get_parameters(ebola_incubation)
get_citation(ebola_incubation)

## ----add-to-library-----------------------------------------------------------
# wrap <epiparameter> in list to append to database
new_db <- append(db, covid_incubation)
tail(new_db, n = 3)

