#' Package options
#'
#' Options to modify the printing of \pkg{epiparameter} objects.
#' Currently options are only used to modify the printing of the
#' `<multi_epidist>` class.
#'
#' Options are set with [options()] and retrieved with [getOption()].
epiparameter_options <- list(
  # Maximum number of <epidist> objects to print for <multi_epidist>
  print_max = getOption("epiparameter.print_max", default = 5L),
  # Number of <epidist> objects to print if <multi_epidist> has more than
  # `print_max`
  print_min = getOption("epiparameter.print_min", default = 3L)
)
