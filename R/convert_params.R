#' Convert the summary statistics of a distribution to parameters
#'
#' @description Convert the summary statistics for a range of distributions to
#' the distribution's parameters. Most summary statistics are calculated
#' analytically given the parameters. An exception is the Weibull distribution
#' which uses a root finding numerical method.
#'
#' @details Summary statistics should be named accordingly (case-sensitive):
#'
#' * mean: `mean`
#' * median: `median`
#' * mode: `mode`
#' * variance: `var`
#' * standard deviation: `sd`
#' * coefficient of variation: `cv`
#' * skewness: `skewness`
#' * excess kurtosis: `ex_kurtosis`
#'
#' **Note**: Not all combinations of summary statistics can be converted into
#' distribution parameters. In this case the function will error stating that
#' the parameters cannot be calculated from the given input.
#'
#' The distribution names and parameter names follow the style of
#' distributions in \R, for example the lognormal distribution is `lnorm`,
#' and its parameters are `meanlog` and `sdlog`.
#'
#' @param distribution A `character` string specifying distribution to use.
#' Default is `lnorm`; also takes `gamma` and `weibull`, `nbinom` and `geom`.
#' @param ... [dots] `Numeric` named summary statistics used to convert to
#' parameter(s). An example is the `mean` and `sd` parameters of the
#' lognormal (`lnorm`) distribution.
#'
#' @return A list of either one or two elements (depending on how many
#' parameters the distribution has).
#' @export
#'
#' @examples
#' convert_summary_stats_to_params(distribution = "lnorm", mean = 1, sd = 1)
#' convert_summary_stats_to_params(distribution = "weibull", mean = 2, var = 2)
#' convert_summary_stats_to_params(distribution = "geom", mean = 2)
convert_summary_stats_to_params <- function(distribution = c( # nolint
                                              "lnorm", "gamma",
                                              "weibull",
                                              "nbinom", "geom"
                                            ),
                                            ...) {
  # check input
  distribution <- match.arg(distribution)
  if (!checkmate::test_list(list(...), min.len = 1, names = "unique")) {
    stop(
      "Summary statistics need to be named and supplied to the function",
      call. = FALSE
    )
  }

  # dispatch to function based on distribution specified
  func <- switch(distribution,
    lnorm = convert_summary_stats_lnorm,
    gamma = convert_summary_stats_gamma,
    weibull = convert_summary_stats_weibull,
    nbinom = convert_summary_stats_nbinom,
    geom = convert_summary_stats_geom
  )

  # call selected function
  out <- do.call(func, list(...))

  # return output
  out
}

#' Convert the parameter(s) of a distribution to summary statistics
#'
#' @description Convert the parameters for a range of distributions to a
#' number of summary statistics. All summary statistics are calculated
#' analytically given the parameters.
#'
#' @details The distribution names and parameter names follow the style of
#' distributions in \R, for example the lognormal distribution is `lnorm`,
#' and its parameters are `meanlog` and `sdlog`.
#'
#' @inheritParams convert_summary_stats_to_params
#' @param ... [dots] `Numeric` named parameter(s) used to convert to summary
#' statistics. An example is the `meanlog` and `sdlog` parameters of the
#' lognormal (`lnorm`) distribution.
#'
#' @return A list of eight elements including: mean, median, mode,
#' variance (`var`), standard deviation (`sd`), coefficient of variation (`cv`),
#' skewness, and excess kurtosis (`ex_kurtosis`).
#' @export
#'
#' @examples
#' convert_params_to_summary_stats(
#'   distribution = "lnorm", meanlog = 1, sdlog = 2
#' )
#' convert_params_to_summary_stats(
#'   distribution = "gamma", shape = 1, scale = 1
#' )
#' convert_params_to_summary_stats(
#'   distribution = "nbinom", prob = 0.5, dispersion = 2
#' )
convert_params_to_summary_stats <- function(distribution = c( # nolint
                                              "lnorm", "gamma", "weibull",
                                              "nbinom", "geom"
                                            ),
                                            ...) {
  # check input
  distribution <- match.arg(distribution)
  if (!checkmate::test_list(list(...), min.len = 1, names = "unique")) {
    stop(
      "Parameter(s) need to be named and supplied to the function",
      call. = FALSE
    )
  }

  # dispatch to function based on distribution specified
  func <- switch(distribution,
    lnorm = convert_params_lnorm,
    gamma = convert_params_gamma,
    weibull = convert_params_weibull,
    nbinom = convert_params_nbinom,
    geom = convert_params_geom
  )

  # call selected function
  out <- do.call(func, list(...))

  # return output
  out
}

#' Adds standard deviation to the list if not present or errors
#'
#' @param x A list of summary statistics
#'
#' @return A list of summary statistics
#' @keywords internal
#' @noRd
get_sd <- function(x) {
  if ("sd" %in% names(x)) {
    return(x)
  }
  if ("var" %in% names(x)) {
    x$sd <- sqrt(x$var)
  } else if (all(c("mean", "cv") %in% names(x))) {
    x$sd <- x$cv * x$mean
  }
  # return list of summary statistics
  x
}

#' Checks list of summary statistics is valid for conversion
#'
#' @inheritParams get_sd
#'
#' @return Invisibly returns a list of summary statistics
#' @keywords internal
#' @noRd
chk_ss <- function(x) {
  checkmate::assert_list(
    x = x,
    types = "numeric",
    any.missing = FALSE,
    all.missing = FALSE,
    min.len = 2,
    names = "unique"
  )
  checkmate::assert_subset(
    x = names(x),
    choices = c(
      "mean", "median", "mode", "var", "sd", "cv", "skewness", "ex_kurtosis",
      "dispersion"
    )
  )
  # invisibly return list of summary statistics
  invisible(x)
}

#' Converts the parameters of the lognormal distribution to summary statistics
#'
#' @description Converts the meanlog and sdlog parameters of the lognormal
#' distribution to a number of summary statistics which can be calculated
#' analytically given the lognormal parameters.
#'
#' @inheritParams convert_params_to_summary_stats
#'
#' @return A list of eight elements including: mean, median, mode,
#' variance (`var`), standard deviation (`sd`), coefficient of variation (`cv`),
#' skewness, and excess kurtosis (`ex_kurtosis`).
#' @keywords internal
convert_params_lnorm <- function(...) {
  # capture input
  x <- list(...)

  # check input params
  if (all(c("meanlog", "sdlog") %in% names(x))) {
    meanlog <- x[["meanlog"]]
    sdlog <- x[["sdlog"]]
  } else {
    stop("lnorm parameters must be named 'meanlog' and 'sdlog'", call. = FALSE)
  }

  # check input
  checkmate::assert_number(meanlog)
  checkmate::assert_number(sdlog, lower = 0)

  # calculate metrics
  mean <- exp(meanlog + sdlog^2 / 2)
  median <- exp(meanlog)
  mode <- exp(meanlog - sdlog^2)
  var <- (exp(sdlog^2) - 1) * exp(2 * meanlog + sdlog^2)
  sd <- sqrt(var)
  cv <- sd / mean
  skewness <- (exp(sdlog^2) + 2) * sqrt(exp(sdlog^2) - 1)
  ex_kurtosis <- exp(4 * sdlog^2) + 2 *
    exp(3 * sdlog^2) + 3 * exp(2 * sdlog^2) - 6

  # return list of metrics
  list(
    mean = mean,
    median = median,
    mode = mode,
    var = var,
    sd = sd,
    cv = cv,
    skewness = skewness,
    ex_kurtosis = ex_kurtosis
  )
}

#' Convert summary statistics to parameters of the lognormal distribution
#'
#' @description Convert the summary statistics input into the meanlog and sdlog
#' parameters of the lognormal distribution.
#'
#' @inheritParams convert_summary_stats_to_params
#'
#' @return A list of two elements: meanlog and sdlog
#' @keywords internal
convert_summary_stats_lnorm <- function(...) {
  # capture input
  x <- list(...)

  # check input
  chk_ss(x)

  # convert var or cv into sd if available
  x <- get_sd(x)

  if (checkmate::test_number(x$mean) && checkmate::test_number(x$sd)) {
    # mean and sd to params
    checkmate::assert_number(x$mean, lower = 0)
    checkmate::assert_number(x$sd, lower = 0)
    sdlog <- sqrt(log(x$sd^2 / x$mean^2 + 1))
    meanlog <- log(x$mean^2 / sqrt(x$sd^2 + x$mean^2))
    return(list(meanlog = meanlog, sdlog = sdlog))
  }

  if (!(checkmate::test_number(x$median) && checkmate::test_number(x$sd))) {
    stop("Cannot calculate lognormal parameters from given input")
  }

  # median and sd to params
  sdlog <- sqrt(log(1 + (x$sd / x$median)^2))
  meanlog <- log(x$median) - sdlog^2 / 2

  # return list of params
  list(
    meanlog = meanlog,
    sdlog = sdlog
  )
}

#' Convert parameters of the gamma distribution to summary statistics
#'
#' @description Convert the shape and scale parameters of the gamma
#' distribution to a number of summary statistics which can be calculated
#' analytically given the gamma parameters. One exception is the median which
#' is calculated using [qgamma()] as no analytical form is available.
#'
#' @inheritParams convert_params_to_summary_stats
#'
#' @return A list of eight elements including: mean, median, mode,
#' variance (`var`), standard deviation (`sd`), coefficient of variation (`cv`),
#' skewness, and excess kurtosis (`ex_kurtosis`).
#' @keywords internal
convert_params_gamma <- function(...) {
  # capture input
  x <- list(...)

  # check input params
  if (all(c("shape", "scale") %in% names(x))) {
    shape <- x[["shape"]]
    scale <- x[["scale"]]
  } else {
    stop("gamma parameters must be named 'shape' and 'scale'", call. = FALSE)
  }

  # check input
  checkmate::assert_number(shape, lower = 0)
  checkmate::assert_number(scale, lower = 0)

  # calculate metrics
  mean <- shape * scale
  median <- stats::qgamma(0.5, shape, scale)
  mode <- max((shape - 1) * scale, 0)
  var <- shape * scale^2
  sd <- sqrt(var)
  cv <- sd / mean
  skewness <- 2 / sqrt(shape)
  ex_kurtosis <- 6 / shape

  # return list of metrics
  list(
    mean = mean,
    median = median,
    mode = mode,
    var = var,
    sd = sd,
    cv = cv,
    skewness = skewness,
    ex_kurtosis = ex_kurtosis
  )
}

#' Convert summary statistics to parameters of the gamma distribution
#'
#' @description Convert the summary statistics input into the shape and scale
#' parameters of the gamma distribution.
#'
#' @inheritParams convert_summary_stats_to_params
#'
#' @return A list of two elements, the shape and scale
#' @keywords internal
convert_summary_stats_gamma <- function(...) {
  # capture input
  x <- list(...)

  # check input
  chk_ss(x)

  # convert var or cv into sd if available
  x <- get_sd(x)

  if (checkmate::test_number(x$mean) && checkmate::test_number(x$sd)) {
    # mean and sd to params
    checkmate::assert_number(x$mean, lower = 0)
    checkmate::assert_number(x$sd, lower = 0)
    shape <- (x$mean)^2 / x$sd^2
    scale <- x$sd^2 / abs(x$mean)
    checkmate::assert_number(shape, lower = 0)
    checkmate::assert_number(scale, lower = 0)
    return(list(shape = shape, scale = scale))
  }

  # if either parameter hasn't been calculated, error
  stop("Cannot calculate gamma parameters from given input")
}

#' Convert parameters of the Weibull distribution to summary statistics
#'
#' @description Convert the shape and scale parameters of the Weibull
#' distribution to a number of summary statistics which can be calculated
#' analytically given the Weibull parameters. Note the conversion uses the
#' [gamma()] function.
#'
#' @inheritParams convert_params_to_summary_stats
#'
#' @return A list of eight elements including: mean, median, mode,
#' variance (`var`), standard deviation (`sd`), coefficient of variation (`cv`),
#' skewness, and excess kurtosis (`ex_kurtosis`).
#' @keywords internal
convert_params_weibull <- function(...) {
  # capture input
  x <- list(...)

  # check input params
  if (all(c("shape", "scale") %in% names(x))) {
    shape <- x[["shape"]]
    scale <- x[["scale"]]
  } else {
    stop("weibull parameters must be named 'shape' and 'scale'", call. = FALSE)
  }

  # check input
  checkmate::assert_number(shape, lower = 0)
  checkmate::assert_number(scale, lower = 0)

  # calculate metrics
  mean <- scale * gamma(1 + 1 / shape)
  median <- scale * (log(2))^(1 / shape)
  mode <- ifelse(shape > 1, scale * ((shape - 1) / shape)^(1 / shape), 0)
  var <- scale^2 * (gamma(1 + 2 / shape) - (gamma(1 + 1 / shape))^2)
  sd <- sqrt(var)
  cv <- sd / mean
  skewness <- (gamma(1 + 3 / shape) * scale^3 - 3 *
    mean * sd^2 - mean^3) / (sd^3)
  ex_kurtosis <- ((gamma(1 + 4 / shape) * scale^4 - 4 * skewness * mean *
    sd^3 -  6 * mean^2 * sd^2 - mean^4) / (sd^4)) - 3


  # return list of metrics
  list(
    mean = mean,
    median = median,
    mode = mode,
    var = var,
    sd = sd,
    cv = cv,
    skewness = skewness,
    ex_kurtosis = ex_kurtosis
  )
}

#' Convert summary statistics to parameters of the Weibull distribution
#'
#' @description Convert summary statistics input into the shape and scale
#' parameters of the Weibull distribution.
#'
#' @inheritParams convert_summary_stats_to_params
#'
#' @return A list of two elements, the shape and scale.
#' @keywords internal
convert_summary_stats_weibull <- function(...) {
  # capture input
  x <- list(...)

  # check input
  chk_ss(x)

  # convert var or cv into sd if available
  x <- get_sd(x)

  if (checkmate::test_number(x$mean) && checkmate::test_number(x$sd)) {
    # mean and sd to params
    checkmate::assert_number(x$mean, lower = 0)
    checkmate::assert_number(x$sd, lower = 0)
    # give warning message about numerical inaccuracies
    message("Numerical approximation used, results may be unreliable.")
    f <- function(k, mean, var) {
      (var / mean^2) - ((gamma(1 + 2 / k)) / (gamma(1 + 1 / k))^2) + 1
    }
    root <- stats::uniroot(
      f = f,
      interval = c(0.1, 1000),
      mean = x$mean,
      var = x$sd^2
    )
    shape <- root$root
    scale <- x$mean / gamma(1 + 1 / shape)
    return(list(shape = shape, scale = scale))
  }

  # if either parameter hasn't been calculated, error
  stop("Cannot calculate Weibull parameters from given input")
}

#' Convert parameters of the negative binomial distribution to summary
#' statistics
#'
#' @description Convert the probability (`prob`) and dispersion parameters of
#' the negative binomial distribution to a number of summary statistics which
#' can be calculated analytically given the negative binomial parameters.
#' One exception is the median which is calculated using [qnbinom()] as no
#' analytical form is available.
#'
#' The parameters are `prob` and `dispersion` (which is also commonly
#' represented as *r*).
#'
#' @inheritParams convert_params_to_summary_stats
#'
#' @return A list of eight elements including: mean, median, mode,
#' variance (`var`), standard deviation (`sd`), coefficient of variation (`cv`),
#' skewness, and ex_kurtosis.
#' @keywords internal
convert_params_nbinom <- function(...) {
  # capture input
  x <- list(...)

  # check input params
  if (all(c("prob", "dispersion") %in% names(x))) {
    prob <- x[["prob"]]
    dispersion <- x[["dispersion"]]
  } else {
    stop(
      "nbinom parameters must be named 'prob' and 'dispersion'",
      call. = FALSE
    )
  }

  # check input
  checkmate::assert_number(prob, lower = 0, upper = 1)
  checkmate::assert_number(dispersion, lower = 0)

  # calculate metrics
  mean <- dispersion * (1 - prob) / prob
  median <- stats::qnbinom(p = 0.5, prob = prob, size = dispersion)
  mode <- max((dispersion - 1) * (1 - prob) / prob, 0)
  var <- dispersion * (1 - prob) / prob^2
  sd <- sqrt(var)
  cv <- sd / mean
  skewness <- (2 - prob) / sqrt((1 - prob) * dispersion)
  ex_kurtosis <- 6 / dispersion + prob^2 / (1 - prob) * dispersion

  # return list of metrics
  list(
    mean = mean,
    median = median,
    mode = mode,
    var = var,
    sd = sd,
    cv = cv,
    skewness = skewness,
    ex_kurtosis = ex_kurtosis
  )
}

#' Convert summary statistics to parameters of the negative binomial
#' distribution
#'
#' @description Convert summary statistics of the negative binomial
#' distribution the parameters (`prob`) and (`dispersion`) of the negative
#' binomial distribution.
#'
#' @inheritParams convert_summary_stats_to_params
#'
#' @return A list of two elements, the probability and dispersion parameters.
#' @keywords internal
convert_summary_stats_nbinom <- function(...) {
  # capture input
  x <- list(...)

  # check input
  chk_ss(x)

  # convert var or cv into sd if available
  x <- get_sd(x)

  if (checkmate::test_number(x$mean) && checkmate::test_number(x$dispersion)) {
    prob <- 1 / (1 + x$mean / x$dispersion)
    dispersion <- x$dispersion
  } else if (checkmate::test_number(x$mean) && checkmate::test_number(x$sd)) {
    prob <- x$mean / x$sd^2
    dispersion <- x$mean^2 / (x$sd^2 - x$mean)
  } else {
    # if either parameter hasn't been calculated error
    stop(
      "Cannot calculate negative binomial distribution ",
      "parameters from given input"
    )
  }

  # ensure variance-to-mean ratio > 1
  if (prob > 1 || dispersion < 0) {
    stop(
      "Negative binomial has a variance-to-mean ratio of greater ",
      "than one, check input"
    )
  }

  return(
    list(
      prob = prob,
      dispersion = dispersion
    )
  )
}

#' Convert parameter of the geometric distribution to summary statistics
#'
#' @description Convert the probability (`prob`) of the geometric distribution
#' to a number of summary statistics which can be calculated analytically given
#' the geometric parameter. One exception is the median which is calculated
#' using [stats::qgeom()] as the analytical form is not always unique.
#'
#' @details This conversion function assumes that distribution represents the
#' number of failures before the first success (supported for zero). This is
#' the same form as used by base R and [distributional::dist_geometric()].
#'
#' @inheritParams convert_params_to_summary_stats
#'
#' @return A list of eight elements including: mean, median, mode,
#' variance (`var`), standard deviation (`sd`), coefficient of variation (`cv`),
#' skewness, and excess kurtosis (`ex_kurtosis`).
#' @keywords internal
convert_params_geom <- function(...) {
  # capture input
  x <- list(...)

  # check input params
  if (all("prob" %in% names(x))) {
    prob <- x[["prob"]]
  } else {
    stop("geom parameter must be named 'prob'", call. = FALSE)
  }

  # check input
  checkmate::assert_number(prob, lower = 0, upper = 1)

  # calculate metrics
  mean <- (1 - prob) / prob
  median <- stats::qgeom(p = 0.5, prob = prob)
  mode <- 0
  var <- (1 - prob) / prob^2
  sd <- sqrt(var)
  cv <- sd / mean
  skewness <- (2 - prob) / sqrt(1 - prob)
  ex_kurtosis <- 6 + prob^2 / (1 - prob)

  # return list of metrics
  list(
    mean = mean,
    median = median,
    mode = mode,
    var = var,
    sd = sd,
    cv = cv,
    skewness = skewness,
    ex_kurtosis = ex_kurtosis
  )
}

#' Convert summary statistics to parameters of the geometric distribution
#'
#' @description Convert summary statistics of the geometric
#' distribution the parameter (`prob`) of the geometric distribution.
#'
#' @details This conversion function assumes that distribution represents the
#' number of failures before the first success (supported for zero). This is
#' the same form as used by base R and [distributional::dist_geometric()].
#'
#' @inheritParams convert_summary_stats_to_params
#'
#' @return A list of one element, the probability parameter.
#' @keywords internal
convert_summary_stats_geom <- function(...) {
  # capture input
  x <- list(...)

  # check input
  checkmate::assert_list(
    x = x,
    types = "numeric",
    any.missing = FALSE,
    all.missing = FALSE,
    min.len = 1,
    names = "unique"
  )
  checkmate::assert_subset(
    x = names(x),
    choices = c(
      "mean", "median", "mode", "var", "sd", "cv", "skewness", "ex_kurtosis"
    )
  )

  # convert var or cv into sd if available
  x <- get_sd(x)

  # calculate mean
  if (checkmate::test_number(x$mean)) {
    checkmate::assert_number(x$mean, lower = 0, finite = TRUE)
    prob <- 1 / (1 + x$mean)
    return(list(prob = prob))
  }

  # if either parameter hasn't been calculated error
  stop("Cannot calculate geometric distribution parameter from given input")
}
