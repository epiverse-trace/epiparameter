#' Package options
#'
#' Options to modify the printing of \pkg{epiparameter} objects.
#' Currently options are only used to modify the printing of the
#' `<multi_epiparameter>` class.
#'
#' Options are set with [options()] and retrieved with [getOption()]. The
#' \pkg{epiparameter} options are stored as a single named list under the
#' `"epiparameter"` option. For example:
#'
#' ```r
#' options(epiparameter = list(print_max = 10, print_min = 5))
#' ```
#'
#' Options set before \pkg{epiparameter} is loaded (e.g. in the user's
#' `.Rprofile`) are honoured: when the package is attached, any user-supplied
#' values are merged with the package defaults, and only fields the user has
#' not specified are filled in with defaults. Options can also be changed
#' after the package is loaded and take effect immediately.
epiparameter_default_options <- list(
  # Maximum number of <epiparameter> objects to print for <multi_epiparameter>
  print_max = 5L,
  # Number of <epiparameter> objects to print if <multi_epiparameter> has more
  # than `print_max`
  print_min = 3L,
  # Whether informational messages from `epiparameter_db()` are printed.
  # Used as the default for the `verbose` argument of that function.
  verbose = TRUE
)

#' Merge any user-supplied `options(epiparameter = ...)` with the package
#' defaults and write the result back to `options()`. User-supplied fields take
#' precedence; missing fields fall back to defaults. If the user has set the
#' option to something other than a list it is ignored and defaults are used.
#'
#' @return Invisible `list`, called for [options()] side-effect
#' @keywords internal
#' @noRd
.set_epiparameter_options <- function() {
  user_opts <- getOption("epiparameter", default = list())
  if (!is.list(user_opts)) {
    user_opts <- list()
  }
  merged <- utils::modifyList(epiparameter_default_options, user_opts)
  options(epiparameter = merged) # nolint undesirable_function_linter.
  invisible(merged)
}
