#' Calculate the parameters of a parametric probability distribution from
#' reported values of percentiles, or median and range
#'
#' Summary data of distributions, as provided by reports and meta-analyses, can
#' be used to extract the parameters of a chosen distribution. Currently
#' available distributions are: lognormal, gamma and weibull. The extracting
#' from a lognormal return the meanlog and sdlog parameters, and extracting from
#' the gamma and weibull return the shape and scale parameters.
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
#' @return A named `numeric` vector with the parameter values of the
#' distribution. If the `distribution = lnorm` then the parameters returned are
#' the meanlog and sdlog; if the `distribution = gamma` or `distribution =
#' weibull` then the parameters returned are the shape and scale.
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

  # intialise the for the loop
  optim_conv <- FALSE
  optim_params_list <- list()
  i <- 0

  # Switch for which extract_param_* to use
  fn_extract_param <- switch(type,
    percentiles = extract_param_percentile,
    range = extract_param_range
  )

  # Switch for whether percentiles or samples are passed
  data_ <- switch(type,
    percentiles = percentiles,
    range = samples
  )

  # check numerical stability of results with different starting parameters
  while (!optim_conv) {
    # Extract the value requested
    optim_params <- do.call(
      fn_extract_param,
      list(
        values,
        distribution,
        data_
      )
    )

    # add last optimisation to list
    optim_params_list[[i + 1]] <- optim_params

    optim_conv <- check_optim_conv(
      optim_params_list = optim_params_list,
      optim_params = optim_params,
      optim_conv = optim_conv
    )
    i <- i + 1
  }

  # warn about local optima
  message(
    "Stochastic numerical optimisation used. \n",
    "Rerun function multiple times to check global optimum is found"
  )

  # return parameters that repeatedly converge
  optim_params_list[[length(optim_params_list)]]$par
}

#' Optimises the parameters for a specified probability distribution given the
#' percentiles of a distribution and the values at those percentiles
#'
#' @inheritParams extract_param
#'
#' @return A list with output from stats::optim. See ?optim for more details
#' @export
#'
#' @examples
#' # extract parameters of a lognormal distribution from the 75 percentiles
#' extract_param_percentile(
#'   values = c(6, 13),
#'   distribution = "lnorm",
#'   percentiles = c(0.125, 0.875)
#' )
extract_param_percentile <- function(values,
                                     distribution,
                                     percentiles) {

  # check input
  distribution <- match.arg(
    arg = distribution,
    choices = c("lnorm", "gamma", "weibull"),
    several.ok = FALSE
  )
  checkmate::assert_numeric(values)
  checkmate::assert_numeric(percentiles)

  # Set initial values for optimisation
  param <- stats::runif(n = 2, min = 0, max = 5)
  names(values) <- c("lower", "upper")
  values_in <- c(values, q1 = percentiles[1], q2 = percentiles[2])

  # Switch parameter names based on distribution
  param_names <- switch(distribution,
    lnorm = c("meanlog", "sdlog"),
    gamma = c("shape", "scale"),
    weibull = c("shape", "scale")
  )
  names(param) <- param_names

  # Switch function and lower bounds based on distribution
  optim_args <- switch(distribution,
    lnorm = list(
      fn = fit_function_lnorm,
      lower = c(-1e5, 1e-10)
    ),
    gamma = list(
      fn = fit_function_gamma,
      lower = c(1e-10, 1e-10)
    ),
    weibull = list(
      fn = fit_function_weibull,
      lower = c(1e-10, 1e-10)
    )
  )

  # Run optim
  optim_params <- do.call(
    stats::optim,
    c(
      list(
        par = param,
        method = "L-BFGS-B",
        val = values_in
      ),
      optim_args
    )
  )
  optim_params
}

#' Optimises the parameters for a specified probability distribution given the
#' median and range of a sample and the number of samples
#'
#' @inheritParams extract_param
#'
#' @return A list with output from stats::optim. See ?optim for more details
#' @export
#'
#' @examples
#' # extract parameters of a gamma distribution from median and range
#' extract_param_range(
#'   values = c(8, 6, 13),
#'   distribution = "gamma",
#'   samples = 20
#' )
extract_param_range <- function(values,
                                distribution,
                                samples) {

  # check input
  distribution <- match.arg(
    arg = distribution,
    choices = c("lnorm", "gamma", "weibull"),
    several.ok = FALSE
  )
  checkmate::assert_numeric(values)
  checkmate::assert_numeric(samples, lower = 1)

  # Set initial values for optimisation
  param <- stats::runif(n = 2, min = 0, max = 5)
  names(values) <- c("median", "lower", "upper")
  values_in <- c(values, n = samples)

  # Switch parameter names based on distribution
  param_names <- switch(distribution,
    lnorm = c("meanlog", "sdlog"),
    gamma = c("shape", "scale"),
    weibull = c("shape", "scale")
  )
  names(param) <- param_names

  # Switch function and lower bounds based on distribution
  optim_args <- switch(distribution,
    lnorm = list(
      fn = fit_function_lnorm_range,
      lower = c(-1e5, 1e-10)
    ),
    gamma = list(
      fn = fit_function_gamma_range,
      lower = c(1e-10, 1e-10)
    ),
    weibull = list(
      fn = fit_function_weibull_range,
      lower = c(1e-10, 1e-10)
    )
  )

  # Run optim
  optim_params <- do.call(
    stats::optim,
    c(
      list(
        par = param,
        method = "L-BFGS-B",
        val = values_in
      ),
      optim_args
    )
  )
  optim_params
}

#' Checks whether the optimisation of distribution parameters has converged to
#' stable value for the parameters and function output for multiple iterations
#'
#' @description This function is a try and prevent optimisation to a local
#' optim and thus checks whether multiple optimisation routines are consistently
#' finding parameter values to within a set tolerance of 1e-5.
#'
#' @param optim_params_list A list, where each element is the output of
#' stats::optim. See ?optim for more details
#' @param optim_params A list given by the output of stats::optim
#' @param optim_conv A boolean value indicating whether the optimisation has
#' converged over multiple iterations
#'
#' @return Boolean
check_optim_conv <- function(optim_params_list,
                             optim_params,
                             optim_conv) {

  # no pairwise comparison on first iterations
  if (length(optim_params_list) > 1) {

    # extract parameters from list
    params <- lapply(optim_params_list, "[[", "par")

    # calculate pairwise comparison across all iterations
    param_a_dist <- stats::dist(sapply(params, "[[", 1))
    param_b_dist <- stats::dist(sapply(params, "[[", 2))

    # any convergence within tolerance for parameters
    res_diff <- length(which(param_a_dist < 1e-5)) &&
      length(which(param_b_dist < 1e-5))

    # any convergence within tolerance for function value
    res_diff <- res_diff &&
      (abs(optim_params_list[[length(optim_params_list)]]$value -
        min(sapply(optim_params_list, "[[", "value"))) < 1e-5)
    optim_conv <- res_diff && optim_params$convergence == 0
  }
  optim_conv
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
    val[["median"]],
    meanlog = param[["meanlog"]],
    sdlog = param[["sdlog"]]) - 0.5)^2

  # Probability of obtaining min, max and range:
  min_p <- stats::dlnorm(
    val[["lower"]],
    meanlog = param[["meanlog"]],
    sdlog = param[["sdlog"]]
  )
  max_p <- stats::dlnorm(
    val[["upper"]],
    meanlog = param[["meanlog"]],
    sdlog = param[["sdlog"]]
  )
  range_p <- (stats::plnorm(
    val[["upper"]],
    meanlog = param[["meanlog"]],
    sdlog = param[["sdlog"]]) -
      stats::plnorm(
        val[["lower"]],
        meanlog = param[["meanlog"]],
        sdlog = param[["sdlog"]]))^(val[["n"]] - 2)

  # Range likelihood
  range_sr <- -(min_p * max_p * range_p)

  # Total value to be minimised
  range_sr + median_sr
}

#' @rdname fit_function_lnorm_range
fit_function_gamma_range <- function(param, val) {

  # Median square residual
  median_sr <- (stats::pgamma(
    val[["median"]],
    shape = param[["shape"]],
    scale = param[["scale"]]) - 0.5)^2

  # Probability of obtaining min, max and range:
  min_p <- stats::dgamma(
    val[["lower"]],
    shape = param[["shape"]],
    scale = param[["scale"]]
  )
  max_p <- stats::dgamma(
    val[["upper"]],
    shape = param[["shape"]],
    scale = param[["scale"]]
  )
  range_p <- (stats::pgamma(
    val[["upper"]],
    shape = param[["shape"]],
    scale = param[["scale"]]) -
      stats::pgamma(
        val[["lower"]],
        shape = param[["shape"]],
        scale = param[["scale"]]))^(val[["n"]] - 2)

  # Range likelihood
  range_sr <- -(min_p * max_p * range_p)

  # Total value to be minimised
  range_sr + median_sr
}

#' @rdname fit_function_lnorm_range
fit_function_weibull_range <- function(param, val) {

  # Median square residual
  median_sr <- (stats::pweibull(
    val[["median"]],
    shape = param[["shape"]],
    scale = param[["scale"]]
  ) - 0.5)^2

  # Probability of obtaining min, max and range:
  min_p <- stats::dweibull(
    val[["lower"]],
    shape = param[["shape"]],
    scale = param[["scale"]]
  )
  max_p <- stats::dweibull(
    val[["upper"]],
    shape = param[["shape"]],
    scale = param[["scale"]]
  )
  range_p <- (stats::pweibull(
    val[["upper"]],
    shape = param[["shape"]],
    scale = param[["scale"]]) -
      stats::pweibull(
        val[["lower"]],
        shape = param[["shape"]],
        scale = param[["scale"]]))^(val[["n"]] - 2)

  # Range likelihood
  range_sr <- -(min_p * max_p * range_p)

  # Total value to be minimised
  out <- range_sr + median_sr

  # return unnamed result
  unname(out)
}

#' @rdname fit_function_lnorm_range
fit_function_lnorm <- function(param, val) {

  out <- (stats::plnorm(
    val[["lower"]],
    meanlog = param[["meanlog"]],
    sdlog = param[["sdlog"]]) - val[["q1"]])^2 +
    (stats::plnorm(
      val[["upper"]],
      meanlog = param[["meanlog"]],
      sdlog = param[["sdlog"]]) - val[["q2"]])^2

  # return unnamed result
  unname(out)
}

#' @rdname fit_function_lnorm_range
fit_function_gamma <- function(param, val) {

  out <- (stats::pgamma(
    val[["lower"]],
    shape = param[["shape"]],
    scale = param[["scale"]]) - val[["q1"]])^2 +
    (stats::pgamma(
      val[["upper"]],
      shape = param[["shape"]],
      scale = param[["scale"]]) - val[["q2"]])^2

  # return unnamed result
  unname(out)
}

#' @rdname fit_function_lnorm_range
fit_function_weibull <- function(param, val) {

  out <- (stats::pweibull(
    val[["lower"]],
    shape = param[["shape"]],
    scale = param[["scale"]]) - val[["q1"]])^2 +
    (stats::pweibull(
      val[["upper"]],
      shape = param[["shape"]],
      scale = param[["scale"]]) - val[["q2"]])^2

  # return unnamed result
  unname(out)
}
