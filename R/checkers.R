#' Check if `<epiparameter>` or list of `<epiparameter>` objects contains a
#' distribution and distribution parameters
#'
#' @param x An `<epiparameter>` or list of `<epiparameter>` objects.
#' @param ... [dots] Extra arguments to be passed to the method.
#'
#' @return A single boolean `logical` for `<epiparameter>` or vector of
#' `logical`s equal in length to the list of `<epiparameter>` objects input.
#' If the `<epiparameter>` object is missing either a probability distribution
#' or parameters for the probability distribution returns `FALSE`, otherwise it
#' returns `TRUE`.
#' @export
#'
#' @examples
#' # parameterised <epiparameter>
#' ep <- epiparameter(
#'   disease = "ebola",
#'   epi_name = "incubation",
#'   prob_distribution = create_prob_distribution(
#'     prob_distribution = "gamma",
#'     prob_distribution_params = c(shape = 1, scale = 1)
#'   )
#' )
#' is_parameterised(ep)
#'
#' # unparameterised <epiparameter>
#' ep <- epiparameter(
#'   disease = "ebola",
#'   epi_name = "incubation"
#' )
#' is_parameterised(ep)
#'
#' # list of <epiparameter>
#' db <- epiparameter_db()
#' is_parameterised(db)
is_parameterised <- function(x, ...) {
  UseMethod("is_parameterised")
}

#' @rdname is_parameterised
#' @export
is_parameterized <- is_parameterised

#' @export
is_parameterised.epiparameter <- function(x, ...) {
  chkDots(...)
  # probability distribution object
  return(is.object(x$prob_distribution))
}

#' @export
is_parameterised.multi_epiparameter <- function(x, ...) {
  chkDots(...)

  # return logical vector
  vapply(x, is_parameterised, FUN.VALUE = logical(1))
}
