#' Check if `<epidist>` or list of `<epidist>` objects contains a distribution
#' and distribution parameters
#'
#' @param x An `<epidist>` or list of `<epidist>` objects.
#' @param ... [dots] Extra arguments to be passed to the method.
#'
#' @return A single boolean `logical` for `<epidist>` or vector of `logical`s
#' equal in length to the list of `<epidist>` objects input. If the `<epidist>`
#' object is missing either a probability distribution or parameters for
#' the probability distribution returns `FALSE`, otherwise it returns `TRUE`.
#' @export
#'
#' @examples
#' # parameterised <epidist>
#' edist <- epidist(
#'   disease = "ebola",
#'   epi_dist = "incubation",
#'   prob_distribution = "gamma",
#'   prob_distribution_params = c(shape = 1, scale = 1)
#' )
#' is_parameterised(edist)
#'
#' # unparameterised <epidist>
#' edist <- epidist(
#'   disease = "ebola",
#'   epi_dist = "incubation"
#' )
#' is_parameterised(edist)
#'
#' # list of <epidist>
#' edist <- epidist_db()
#' is_parameterised(edist)
is_parameterised <- function(x, ...) {
  UseMethod("is_parameterised")
}

#' @rdname is_parameterised
#' @export
is_parameterized <- is_parameterised

#' @export
is_parameterised.epidist <- function(x, ...) {
  chkDots(...)
  # probability distribution object
  return(is.object(x$prob_dist))
}

#' @export
is_parameterised.multi_epidist <- function(x, ...) {
  chkDots(...)

  # return logical vector
  vapply(x, is_parameterised, FUN.VALUE = logical(1))
}
