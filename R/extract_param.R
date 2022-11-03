#' Calculate the parameters of a parametric probability distribution from
#' reported values of percentiles, or median and range
#'
#' Summary data of distributions, as provided by reports and meta-analyses, can
#' be used to extract the parameters of a chosen distribution. Currently
#' available distributions are: lognormal, gamma and weibull.
#'
#' @param type A `character` defining whether summary statistics based
#' around `percentiles` (default) or `range`
#' @param values A `vector`. If `type = percentiles`: `c(percentile_1,
#' percentile_2)`; and if `type = range`: `c(median, min, max)`
#' @param distribution A `character` specifying distribution to use.
#' Default is `lnorm`; also takes `gamma` and `weibull`.
#' @param percentiles A `vector` with two elements specifying the
#' percentiles defined in `values` if using `type = "percentiles"`.
#' @param samples A `numeric` specifying the sample size if using
#' `type = "range"`.
#'
#' @return A `numeric` vector with the parameter values of the distribution
#' @keywords extract
#' @author Adam Kucharski
#' @export
#' @examples
#' # extract parameters of a lognormal distribution from the 75 percentiles
#' extract_param(
#'   type = "percentiles",
#'   values = c(6, 13),
#'   distribution = "lnorm",
#'   percentiles = c(0.125, 0.875)
#' )
#'
#' # extract parameters of a gamma distribution from median and range
#' extract_param(
#'   type = "range",
#'   values = c(8, 6, 13),
#'   distribution = "gamma",
#'   samples = 20
#' )
extract_param <- function(type = c("percentiles", "range"),
                          values,
                          distribution = c("lnorm", "gamma", "weibull"),
                          percentiles,
                          samples) {

  # check string arguments
  type <- match.arg(arg = type, several.ok = FALSE)
  distribution <- match.arg(arg = distribution, several.ok = FALSE)

  # check numeric arguments
  checkmate::assert_numeric(values)
  if (!missing(percentiles)) {
    checkmate::assert_numeric(percentiles)
  }
  if (!missing(samples)) {
    checkmate::assert_numeric(samples, lower = 1)
  }

  # Validate inputs
  switch(
    type,
    "percentiles" = stopifnot( #nolint
      "'values' and 'percentiles' need to be a vector of length 2" =
        type == "percentiles" && length(values) == 2 || length(percentiles) == 2
    ),
    "range" = stopifnot(
      "'values need to be a vector of length 3" =
        type == "range" && length(values) == 3
    )
  )

  # Percentile extraction
  # Extract distribution parameters using optimisation for specific distribution
  if (type == "percentiles") {

    # Set initial values for optimisation
    param <- c(a = 2, b = 0.5) # CHECK: numerical stability
    values_in <- c(values, q1 = percentiles[1], q2 = percentiles[2])

    if (distribution == "lnorm") {
      result2 <- stats::optim(
        param,
        fit_function_lnorm,
        method = "L-BFGS-B",
        val = values_in,
        lower = c(-1, 0)
      )
    }
    if (distribution == "gamma") {
      result2 <- stats::optim(
        param,
        fit_function_gamma,
        method = "L-BFGS-B",
        val = values_in,
        lower = c(-1, 0)
      )
    }
    if (distribution == "weibull") {
      result2 <- stats::optim(
        param,
        fit_function_weibull,
        method = "L-BFGS-B",
        val = values_in,
        lower = c(-1, 0)
      )
    }
  }

  # Range extraction

  if (type == "range") {

    # Set initial values for optimisation
    param <- c(a = 2, b = 0.5) # CHECK: numerical stability
    values_in <- c(values, n = samples)

    if (distribution == "lnorm") {
      result2 <- stats::optim(
        param,
        fit_function_lnorm_range,
        method = "L-BFGS-B",
        val = values_in,
        lower = c(-1, 0)
      )
    }
    if (distribution == "gamma") {
      result2 <- stats::optim(
        param,
        fit_function_gamma_range,
        method = "L-BFGS-B",
        val = values_in,
        lower = c(-1, 0)
      )
    }
    if (distribution == "weibull") {
      result2 <- stats::optim(
        param,
        fit_function_weibull_range,
        method = "L-BFGS-B",
        val = values_in,
        lower = c(-1, 0)
      )
    }
  }

  # Output parameters
  result2$par
}

#' Set of functions that can be used to estimate the parameters of a
#' distribution (lognormal, gamma, weibull) via optimisation from either the
#' percentiles or the median and ranges.
#'
#' @param param Named numeric vector of the distribution parameters to be
#' optimised
#' @param val Numeric vector, in the case of using percentiles it contains the
#' values at the percentiles and the percentiles, in the case of median and
#' range it contains the median, lower range, upper range and the number of
#' sample points to evaluate the function at
#' @keywords internal
#' @author Adam Kucharski
fit_function_lnorm_range <- function(param, val) {

  # Median square residual
  median_sr <- (stats::plnorm(
    val[1],
    meanlog = param[["a"]],
    sdlog = param[["b"]]) - 0.5)^2

  # Probability of obtaining min, max and range:
  min_p <- stats::dlnorm(val[2], meanlog = param[["a"]], sdlog = param[["b"]])
  max_p <- stats::dlnorm(val[3], meanlog = param[["a"]], sdlog = param[["b"]])
  range_p <- (stats::plnorm(
    val[3],
    meanlog = param[["a"]],
    sdlog = param[["b"]]) -
      stats::plnorm(
        val[2],
        meanlog = param[["a"]],
        sdlog = param[["b"]]))^(val[["n"]] - 2)

  # Range likelihood
  range_sr <- -(min_p * max_p * range_p)

  # Total value to be minimised
  range_sr + median_sr
}

#' @rdname fit_function_lnorm_range
fit_function_gamma_range <- function(param, val) {

  # Median square residual
  median_sr <- (stats::pgamma(
    val[1],
    shape = param[["a"]],
    scale = param[["b"]]) - 0.5)^2

  # Probability of obtaining min, max and range:
  min_p <- stats::dgamma(val[2], shape = param[["a"]], scale = param[["b"]])
  max_p <- stats::dgamma(val[3], shape = param[["a"]], scale = param[["b"]])
  range_p <- (stats::pgamma(
    val[3],
    shape = param[["a"]],
    scale = param[["b"]]) -
      stats::pgamma(
        val[2],
        shape = param[["a"]],
        scale = param[["b"]]))^(val[["n"]] - 2)

  # Range likelihood
  range_sr <- -(min_p * max_p * range_p)

  # Total value to be minimised
  range_sr + median_sr
}

#' @rdname fit_function_lnorm_range
fit_function_weibull_range <- function(param, val) {

  # Median square residual
  median_sr <- (stats::pweibull(
    val[1],
    shape = param[["a"]],
    scale = param[["b"]]
  ) - 0.5)^2

  # Probability of obtaining min, max and range:
  min_p <- stats::dweibull(val[2], shape = param[["a"]], scale = param[["b"]])
  max_p <- stats::dweibull(val[3], shape = param[["a"]], scale = param[["b"]])
  range_p <- (stats::pweibull(
    val[3],
    shape = param[["a"]],
    scale = param[["b"]]) -
      stats::pweibull(
        val[2],
        shape = param[["a"]],
        scale = param[["b"]]))^(val[["n"]] - 2)

  # Range likelihood
  range_sr <- -(min_p * max_p * range_p)

  # Total value to be minimised
  range_sr + median_sr
}

#' @rdname fit_function_lnorm_range
fit_function_lnorm <- function(param, val) {

  (stats::plnorm(
    val[1],
    meanlog = param[["a"]],
    sdlog = param[["b"]]) - val[["q1"]])^2 +
    (stats::plnorm(
      val[2],
      meanlog = param[["a"]],
      sdlog = param[["b"]]) - val[["q2"]])^2
}

#' @rdname fit_function_lnorm_range
fit_function_gamma <- function(param, val) {

  (stats::pgamma(
    val[1],
    shape = param[["a"]],
    scale = param[["b"]]) - val[["q1"]])^2 +
    (stats::pgamma(
      val[2],
      shape = param[["a"]],
      scale = param[["b"]]) - val[["q2"]])^2
}

#' @rdname fit_function_lnorm_range
fit_function_weibull <- function(param, val) {

  (stats::pweibull(
    val[1],
    shape = param[["a"]],
    scale = param[["b"]]) - val[["q1"]])^2 +
    (stats::pweibull(
      val[2],
      shape = param[["a"]],
      scale = param[["b"]]) - val[["q2"]])^2
}
