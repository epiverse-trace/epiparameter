#' Checks the probability distribution name and parameters to be used in an
#' `epidist` object
#'
#' @inheritParams new_epidist
#'
#' @return Invisibly returns a named vector of probability distribution
#' parameters. Usually called for side-effects.
#' @keywords internal
#' @noRd
#'
#' @examples
#' epiparameter:::check_epidist_params(
#'   prob_dist = "gamma",
#'   prob_dist_params = c(shape = 1, scale = 1)
#' )
check_epidist_params <- function(prob_dist, prob_dist_params) {
  # check parameters if provided
  checkmate::assert_numeric(prob_dist_params, names = "unique")

  stopifnot(
    "distribution parameters must have valid names,
       use possible_epidist_params() to see valid names" =
      is_epidist_params(prob_dist_params)
  )

  # return probability distribution parameters
  invisible(prob_dist_params)
}

#' Checks the parameter uncertainty list in an `epidist` object
#'
#' @inheritParams new_epidist
#' @inheritParams epidist
#'
#' @return Invisibly returns a named list of probability distribution
#' parameters uncertainty (either confidence interval or credible interval).
#' Usually called for side-effects.
#' @keywords internal
#' @noRd
#'
#' @examples
#' epiparameter:::check_epidist_uncertainty(
#'   prob_dist_params = c(shape = 1, scale = 1),
#'   uncertainty = list(
#'     shape = create_epidist_uncertainty(
#'       ci_limits = c(0.5, 1),
#'       ci = 95,
#'       ci_type = "confidence interval"
#'     ),
#'     scale = create_epidist_uncertainty(
#'       ci_limits = c(0.5, 1),
#'       ci = 95,
#'       ci_type = "confidence interval"
#'     )
#'   )
#' )
check_epidist_uncertainty <- function(prob_dist_params, uncertainty) {
  # check whether ci has been provided for each parameter
  # check that the parameters and uncertainty names match
  stopifnot(
    "uncertainty must be provided for each parameter" =
      anyNA(uncertainty) ||
        length(prob_dist_params) == length(uncertainty),
    "parameters and uncertainty must be named and match" =
      anyNA(uncertainty) ||
        identical(names(prob_dist_params), names(uncertainty))
  )

  invisible(uncertainty)
}
