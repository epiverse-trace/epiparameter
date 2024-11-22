# package environment for storing global objects for caching
cache_env <- new.env(parent = emptyenv())

.onLoad <- function(libname, pkgname) {
  options(epiparameter = epiparameter_options) # nolint undersirable_function_linter

  # create an in-memory cache
  cache_env$cache <- cachem::cache_mem()

  # suppress DB loading message on package loading
  db <- suppressMessages(epiparameter_db())

  # store epiparameter library in cache
  cache_env$cache$set("multi_epiparameter", db)
}
