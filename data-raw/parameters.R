## code to prepare `parameters` dataset goes here

multi_epidist <- epiparameter:::.read_epidist_db()
usethis::use_data(multi_epidist, internal = TRUE, overwrite = TRUE, version = 3)
