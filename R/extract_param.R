#' Calculate the parameters of a parametric probability distribution from
#' reported values of percentiles, or median and range
#'
#' Summary data of distributions, as provided by reports and meta-analyses, can
#' be used to extract the parameters of a chosen distribution. Currently
#' available distributions are: lognormal, gamma, Weibull and normal.
#' Extracting from a lognormal returns the meanlog and sdlog parameters,
#' extracting from the gamma and Weibull returns the shape and scale parameters,
#' and extracting from the normal returns the mean and sd parameters.
#'
#' @details For `gamma`, `lnorm` and `weibull`, `extract_param()` works only
#' for strictly positive values at the percentiles of a distribution or the
#' median and range of data (numerics supplied to the `values` argument).
#' This means that negative values at the lower percentile or lower range
#' will not work with this function although they may present themselves in
#' epidemiological data (e.g. negative serial interval). For the `norm`
#' distribution negative values are allowed.
#'
#' @param type A `character` defining whether summary statistics based
#' around `percentiles` (default) or `range`.
#' @param values A `vector`. If `type = percentiles`: `c(percentile_1,
#' percentile_2)`; and if `type = range`: `c(median, min, max)`.
#' @param distribution A `character` specifying distribution to use.
#' Default is `lnorm`; also takes `gamma`, `weibull` and `norm`.
#' @param percentiles A `vector` with two elements specifying the
#' percentiles defined in `values` if using `type = "percentiles"`.
#' Percentiles should be specified between 0 and 1. For example 2.5th and 97.5th
#' percentile is given as `c(0.025, 0.975)`.
#' @param samples A `numeric` specifying the sample size if using
#' `type = "range"`.
#' @param control A named list containing options for the optimisation. List
#' element `$max_iter` is a `numeric` specifying the maximum number of times
#' the parameter extraction will run optimisation before returning result early.
#' This prevents overly long optimisation loops if optimisation is unstable and
#' does not converge over multiple iterations. Default is 1000 iterations. List
#' element `$tolerance` is passed to [check_optim_conv()] for tolerance on
#' parameter convergence over iterations of optimisation. Elements of in the
#' control list are not passed to [optim()].
#'
#' @return A named `numeric` vector with the parameter values of the
#' distribution. If the `distribution = lnorm` then the parameters returned are
#' the meanlog and sdlog; if the `distribution = gamma` or `distribution =
#' weibull` then the parameters returned are the shape and scale; if
#' `distribution = norm` then the parameters returned are mean and sd.
#' @keywords extract
#' @author Adam Kucharski, Joshua W. Lambert
#' @export
#' @examples
#' # set seed to control for stochasticity
#' set.seed(1)
#'
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
#'   values = c(10, 3, 18),
#'   distribution = "gamma",
#'   samples = 20
#' )
extract_param <- function(type = c("percentiles", "range"),
                          values,
                          distribution = c("lnorm", "gamma", "weibull", "norm"),
                          percentiles,
                          samples,
                          control = list(
                            max_iter = 1000,
                            tolerance = 1e-5
                          )) {
  # check string arguments
  type <- match.arg(arg = type, several.ok = FALSE)
  distribution <- match.arg(arg = distribution, several.ok = FALSE)

  # check numeric arguments
  if (distribution == "norm") {
    checkmate::assert_numeric(values)
  } else {
    checkmate::assert_numeric(values, lower = 1e-10)
  }

  if (type == "percentiles") {
    stopifnot(
      "percentiles need to be given for type = 'percentiles'" =
        !missing(percentiles),
      "values vector should be c(lower, upper) check values" =
        values[1] < values[2]
    )
    checkmate::assert_numeric(values, len = 2)
    checkmate::assert_numeric(percentiles, lower = 0, upper = 1, len = 2)
  }
  if (identical(type, "range")) {
    stopifnot(
      "samples need to be given for type = 'range'" =
        !missing(samples),
      "values vector should be c(median, min, max) check values" =
        values[2] < values[1] && values[1] < values[3]
    )
    checkmate::assert_number(samples, lower = 2)
  }

  # prepare default control list
  ctrl <- list(
    max_iter = 1000,
    tolerance = 1e-5
  )
  # pass user solver options to default control list
  ctrl[names(control)] <- control

  stopifnot(
    "control list requires max_iter and tolerance elements" =
      identical(names(ctrl), c("max_iter", "tolerance"))
  )

  # Validate inputs
  switch(type,
    percentiles = stopifnot( # nolint
      "'values' and 'percentiles' need to be a vector of length 2" =
        type == "percentiles" && length(values) == 2 || length(percentiles) == 2
    ),
    range = stopifnot(
      "'values need to be a vector of length 3" =
        type == "range" && length(values) == 3
    )
  )

  # initialise for the loop
  optim_conv <- FALSE
  optim_params_list <- list()
  i <- 0

  # check numerical stability of results with different starting parameters
  while (!optim_conv && i < ctrl$max_iter) {
    # Extract distribution parameters by optimising for specific distribution
    optim_params <- .extract_param(
      values = values,
      distribution = distribution,
      percentiles = percentiles,
      samples = samples
    )

    # add last optimisation to list
    optim_params_list[[i + 1]] <- optim_params
    i <- i + 1

    optim_conv <- check_optim_conv(
      optim_params_list = optim_params_list,
      optim_params = optim_params,
      tolerance = ctrl$tolerance
    )
  }

  # if convergence after maximum iterations is not reached
  if (i >= ctrl$max_iter) {
    warning(
      "Maximum optimisation iterations reached, returning result early. \n",
      "Result may not be reliable.",
      call. = FALSE
    )

    # choose best parameter estimates from lowest optimisation value
    best_iter <- which.min(unlist(lapply(optim_params_list, "[[", "value")))
  } else {
    # if optimsation converged use last iteration
    best_iter <- length(optim_params_list)
  }

  # warn about local optima
  message(
    "Stochastic numerical optimisation used. \n",
    "Rerun function multiple times to check global optimum is found"
  )

  # return parameters that repeatedly converge
  optim_params_list[[best_iter]]$par
}

#' Optimises the parameters for a specified probability distribution given the
#' percentiles of a distribution and the values at those percentiles, or the
#' median and range of a sample and the number of samples.
#'
#' @inheritParams extract_param
#'
#' @return A list with output from [stats::optim()].
#' @keywords internal
.extract_param <- function(values,
                           distribution,
                           percentiles,
                           samples) {
  # Set initial values for optimisation
  if (distribution == "norm") {
    param <- c(stats::median(values), (stats::sd(values) / 3))
  } else {
    param <- stats::runif(n = 2, min = 0, max = 5)
  }

  if (!missing(percentiles)) {
    names(values) <- c("lower", "upper")
    values_in <- c(values, q1 = percentiles[1], q2 = percentiles[2])
    fit_func <- fit_percentiles
  } else if (!missing(samples)) {
    names(values) <- c("median", "lower", "upper")
    values_in <- c(values, n = samples)
    fit_func <- fit_range
  } else {
    stop("percentiles or samples arguments must be specified", call. = FALSE)
  }

  if (distribution == "lnorm") {
    names(param) <- c("meanlog", "sdlog")
    lower <- c(-1e5, 1e-10)
    upper <- c(1e10, 1e10)
  }
  if (distribution == "gamma") {
    names(param) <- c("shape", "scale")
    lower <- c(1e-10, 1e-10)
    upper <- c(1e10, 1e10)
  }
  if (distribution == "weibull") {
    names(param) <- c("shape", "scale")
    lower <- c(1e-3, 1e-3)
    upper <- c(1e10, 1e10)
  }
  if (distribution == "norm") {
    names(param) <- c("mean", "sd")
    lower <- c(-1e5, 1e-10)
    upper <- c(1e10, 1e10)
  }

  optim_params <- tryCatch(stats::optim(
    param,
    fit_func,
    method = "L-BFGS-B",
    val = values_in,
    dist = distribution,
    lower = lower,
    upper = upper
  ), error = function(e) {
    stop("found inf value in ", distribution)
  })

  optim_params
}

#' Check whether the optimisation of distribution parameters has converged to
#' stable value for the parameters and function output for multiple iterations
#'
#' @description This function is to try and prevent optimisation to a local
#' optimum and thus checks whether multiple optimisation routines are
#' consistently finding parameter values to within a set tolerance.
#'
#' @param optim_params_list A list, where each element is the output of
#' [stats::optim()]. See `?optim` for more details.
#' @param optim_params A list given by the output of [stats::optim()].
#' @param tolerance A `numeric` specifying within which disparity convergence
#' of parameter estimates and function minimisation is accepted.
#'
#' @return Boolean
#' @keywords internal
check_optim_conv <- function(optim_params_list,
                             optim_params,
                             tolerance) {
  optim_conv <- FALSE
  # no pairwise comparison on first iterations
  if (length(optim_params_list) > 1) {
    # extract parameters from list
    params <- lapply(optim_params_list, "[[", "par")

    # calculate pairwise comparison across all iterations
    param_a_dist <- stats::dist(unlist(lapply(params, "[[", 1)))
    param_b_dist <- stats::dist(unlist(lapply(params, "[[", 2)))

    # any convergence within tolerance for parameters
    res_diff <- any(param_a_dist < tolerance) &&
      any(param_b_dist < tolerance)

    # any convergence within tolerance for function value
    res_diff <- res_diff &&
      (abs(optim_params_list[[length(optim_params_list)]]$value -
        min(unlist(lapply(optim_params_list, "[[", "value")))) < tolerance)
    optim_conv <- res_diff && optim_params$convergence == 0
  }
  optim_conv
}

#' Function for extracting distribution parameters
#'
#' Set of functions that can be used to estimate the parameters of a
#' distribution (lognormal, gamma, Weibull, normal) via optimisation from
#' either the percentiles or the median and ranges.
#'
#' @param param Named `numeric` vector of the distribution parameters to be
#' optimised.
#' @param val `Numeric` vector, in the case of using percentiles it contains
#' the values at the percentiles and the percentiles, in the case of median and
#' range it contains the median, lower range, upper range and the number of
#' sample points to evaluate the function at.
#' @param dist A `character` string with the name of the distribution for
#' fitting. Naming follows the base R distribution names (e.g. `lnorm` for
#' lognormal).
#'
#' @keywords internal
#' @author Adam Kucharski, Joshua W. Lambert
#' @name extraction_functions
fit_range <- function(param,
                      val,
                      dist = c("lnorm", "gamma", "weibull", "norm")) {
  # check input
  dist <- match.arg(dist)

  cumulative <- switch(dist,
    lnorm = stats::plnorm,
    gamma = stats::pgamma,
    weibull = stats::pweibull,
    norm = stats::pnorm
  )
  density <- switch(dist,
    lnorm = stats::dlnorm,
    gamma = stats::dgamma,
    weibull = stats::dweibull,
    norm = stats::dnorm
  )

  param_names <- switch(dist,
    lnorm = c("meanlog", "sdlog"),
    gamma = c("shape", "scale"),
    weibull = c("shape", "scale"),
    norm = c("mean", "sd")
  )

  args <- list(
    val[["median"]],
    param[[param_names[1]]],
    param[[param_names[[2]]]]
  )
  names(args)[2:3] <- param_names
  names(args)[1] <- ""

  # Median square residual
  median_sr <- (do.call(cumulative, args = args) - 0.5)^2

  args[[1]] <- val[["lower"]]
  # Probability of obtaining min, max and range:
  min_p <- do.call(density, args = args)

  args[[1]] <- val[["upper"]]
  max_p <- do.call(density, args = args)

  args[[1]] <- val[["upper"]]
  range_p_upper <- do.call(cumulative, args = args)
  args[[1]] <- val[["lower"]]
  range_p_lower <- do.call(cumulative, args = args)
  range_p <- (range_p_lower - range_p_upper)^(val[["n"]] - 2)

  # Range likelihood
  range_sr <- -(min_p * max_p * range_p)

  # Total value to be minimised
  range_sr + median_sr
}

#' @rdname extraction_functions
fit_percentiles <- function(param,
                            val,
                            dist = c("lnorm", "gamma", "weibull", "norm")) {
  # check input
  dist <- match.arg(dist)

  cumulative <- switch(dist,
    lnorm = stats::plnorm,
    gamma = stats::pgamma,
    weibull = stats::pweibull,
    norm = stats::pnorm
  )
  param_names <- switch(dist,
    lnorm = c("meanlog", "sdlog"),
    gamma = c("shape", "scale"),
    weibull = c("shape", "scale"),
    norm = c("mean", "sd")
  )

  args <- list(
    val[["lower"]],
    param[[param_names[1]]],
    param[[param_names[[2]]]]
  )
  names(args)[2:3] <- param_names
  names(args)[1] <- ""

  lower <- (do.call(cumulative, args = args) - val[["q1"]])^2

  args[[1]] <- val[["upper"]]
  upper <- (do.call(cumulative, args = args) - val[["q2"]])^2

  lower + upper
}
