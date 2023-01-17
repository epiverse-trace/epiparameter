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

check_epidist_uncertainty <- function(prob_dist_params, uncertainty) {

  # check whether ci has been provided for each parameter
  stopifnot(
    "uncertainty must be provided for each parameter" =
      any(is.na(uncertainty)) ||
      length(prob_dist_params) == length(uncertainty)
  )

  # check that the parameters and uncertainty names match
  stopifnot(
    "parameters and uncertainty must be named and match" =
      any(is.na(uncertainty)) ||
      identical(names(prob_dist_params), names(uncertainty))
  )

  invisible(uncertainty)
}
