## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----load-epiparameter, echo=FALSE--------------------------------------------
library(epiparameter)

## ----show-diseases, echo=FALSE------------------------------------------------
db <- epiparameter_db()
disease <- vapply(db, "[[", FUN.VALUE = character(1), "disease")
pathogen <- vapply(db, "[[", FUN.VALUE = character(1), "pathogen")
knitr::kable(
  data.frame(
    Disease = disease,
    Pathogen = pathogen
  ),
  align = "cc"
)

## ----show-epiparameters, echo=FALSE-------------------------------------------
db <- epiparameter_db()
epi_name <- epiparameter:::.clean_string(unique( # nolint undesirable_operator_linter
  vapply(db, "[[", FUN.VALUE = character(1), "epi_name")
))
knitr::kable(
  data.frame(epi_name),
  align = "cc",
  col.names = "Epidemiological Parameter"
)

