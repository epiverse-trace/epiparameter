#' Checks whether <epidist> or <epiparam> object contains a distribution and
#' parameters for that distribution.
#'
#' @description If the <epidist> object or a row in the <epiparam> data frame
#' is missing either a probability distribution or parameters for the
#' probability distribution, `is_parameterised` returns `FALSE`, otherwise
#' it returns `TRUE`.
#'
#' @param x An `epidist` or `epiparam` object.
#' @param ... [`dots`] not used, extra arguments supplied will cause a warning.
#'
#' @return A boolean logical for <epidist> or vector of boolean for each entry
#' in the <epiparam>.
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
is_parameterised <- function(x, ...) {
  UseMethod("is_parameterised")
}

#' @export
is_parameterised.epiparam <- function(x, ...) {
  chkDots(...)

  has_params <- vapply(
    as.data.frame(t(x)),
    FUN = function(y) {
      if (is.na(y$prob_distribution)) {
        return(FALSE)
      }
      if (y$prob_distribution %in% c("gamma", "weibull")) {
        out <- !is.na(y$shape) && !is.na(y$scale)
        return(out)
      }
      if (y$prob_distribution == "lnorm") {
        out <- !is.na(y$meanlog) && !is.na(y$sdlog)
        return(out)
      }
      if (y$prob_distribution == "nbinom") {
        out <- !is.na(y$mean) && !is.na(y$dispersion)
        return(out)
      }
      if (y$prob_distribution %in% c("geom", "pois")) {
        out <- !is.na(y$mean)
        return(out)
      }
      return(FALSE)
    },
    FUN.VALUE = logical(1),
    USE.NAMES = FALSE
  )

  # return result
  has_params
}

#' @export
is_parameterised.epidist <- function(x, ...) {
  chkDots(...)

  # probability distribution object
  if (is.object(x$prob_dist)) {
    return(TRUE)
  }

  return(FALSE)
}
