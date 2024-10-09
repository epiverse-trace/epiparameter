#' Package options
#'
#' Options to modify the printing of \pkg{epiparameter} objects.
#' Currently options are only used to modify the printing of the
#' `<multi_epiparameter>` class.
#'
#' Options are set with [options()] and retrieved with [getOption()].
#'
#' If options are changed the \pkg{epiparameter} package will need to be
#' reloaded for new options to be taken into account. Options can be set in
#' the `.Rprofile` to persist across R sessions.
epiparameter_options <- list(
  # Maximum number of <epiparameter> objects to print for <multi_epiparameter>
  print_max = getOption("epiparameter.print_max", default = 5L),
  # Number of <epiparameter> objects to print if <multi_epiparameter> has more
  # than `print_max`
  print_min = getOption("epiparameter.print_min", default = 3L)
)
