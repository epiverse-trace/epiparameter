# package environment for storing global objects for caching
cache_env <- new.env(parent = emptyenv())

.onLoad <- function(libname, pkgname) {
  # Merge user-supplied options(epiparameter = ...) with package defaults so
  # that values set before the package is loaded (e.g. in .Rprofile) are not
  # overwritten. See ?epiparameter_default_options.
  set_epiparameter_options()

  # create an in-memory cache
  cache_env$cache <- cachem::cache_mem()

  # suppress DB loading message on package loading
  db <- suppressMessages(epiparameter_db())

  # store epiparameter library in cache
  cache_env$cache$set("multi_epiparameter", db)
}
