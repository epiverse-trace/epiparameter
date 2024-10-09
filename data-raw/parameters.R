## code to prepare `parameters` dataset goes here

multi_epiparameter <- epiparameter:::.read_epiparameter_db()
usethis::use_data(
  multi_epiparameter,
  internal = TRUE,
  overwrite = TRUE,
  version = 3
)
