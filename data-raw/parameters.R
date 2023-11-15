## code to prepare `parameters` dataset goes here

mutli_epidist <- epiparameter:::.read_epidist_db()
usethis::use_data(multi_epidist, internal = TRUE, overwrite = TRUE, version = 3)
