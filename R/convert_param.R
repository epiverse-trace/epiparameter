#' Analogue to isTRUE() to check if variable is a single number
#'
#' @param x An R object.
#'
#' @return Boolean logical
#' @keywords internal
#' @noRd
is_number <- function(x) {
  is.numeric(x) && length(x) == 1 && !is.na(x)
}

#' Adds standard deviation to the list if not present or errors
#'
#' @param x A list of summary statistics
#'
#' @return A list of summary statistics
#' @keywords internal
#' @noRd
get_sd <- function(x) {
  if (isTRUE("var" %in% names(x)) && !isTRUE("sd" %in% names(x)))  {
    x$sd <- sqrt(x$var)
  } else if (all(c("mean", "cv") %in% names(x)) &&
             !isTRUE("sd" %in% names(x))) {
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
  stopifnot(
    "at least two summary statistics must be supplied" =
      length(x) >= 2,
    "all arguments must be named" =
      !is.null(names(x)) && isFALSE("" %in% names(x)),
    "all values given must be numeric" =
      all(vapply(x, is.numeric, FUN.VALUE = logical(1))),
    "names of input must match:
    'mean', 'median', 'mode', 'var', 'sd', 'cv', 'skewness', 'kurtosis'" =
      all(names(x) %in%  c(
        "mean", "median", "mode", "var", "sd", "cv", "skewness", "kurtosis"
      ))
  )

  # invisibly return list of summary statistics
  invisible(x)
}

#' Converts the parameters of the lognormal distribution to summary statistics
#'
#' @description Converts the meanlog and sdlog parameters of the lognormal
#' distribution to a number of summary statistics which can be calculated
#' analytically given the lognormal parameters
#'
#' @param meanlog The meanlog parameter (mean of natural logarithm) of the
#' lognormal distribution. Also commonly called and denoted by the mu.
#' @param sdlog The sdlog parameter (standard deviation of the natural
#' logarithm) of the distribution. Also commonly called and denoted by sigma.
#'
#' @return A list of eight elements including: mean, median, mode,
#' variance (`var`), standard deviation (`sd`), coefficient of variation (`cv`),
#' skewness, and kurtosis.
#' @export
#'
#' @examples
#' convert_lnorm_params(meanlog = 1, sdlog = 1)
convert_lnorm_params <- function(meanlog, sdlog) {

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
  kurtosis <- exp(4 * sdlog^2) + 2 * exp(3 * sdlog^2) + 3 * exp(2 * sdlog^2) - 6

  # return list of metrics
  list(
    mean = mean,
    median = median,
    mode = mode,
    var = var,
    sd = sd,
    cv = cv,
    skewness = skewness,
    kurtosis = kurtosis
  )
}

#' Converts the summary statistics to parameters of the lognormal distribution
#'
#' @description Converts the meanlog and sdlog parameters of the lognormal
#' distribution to a number of summary statistics which can be calculated
#' analytically given the lognormal parameters.
#'
#' @details The arguments input are captured and handled by name. Therefore,
#' the names of the arguments must be correct (case-sensitive). Possible input
#' summary statistics are: `mean`, `median`, `mode`, `var`, `sd`, `cv`,
#' `skewness`, `kurtosis`.
#'
#' Not every combination of input statistics is a viable conversion, and may
#' error. Common conversions that are implemented are mean and any measure of
#' spread (`var`, `sd` and `cv`), or `median` and `sd`.
#'
#' @param ... Summary statistics to be used for calculating the lognormal
#' distribution parameters. All arguments must be correctly named, see details
#' for possible input.
#'
#' @return A list of two elements, the meanlog and sdlog
#' @export
#'
#' @examples
#' convert_lnorm_summary_stats(mean = 3, sd = 2)
convert_lnorm_summary_stats <- function(...) {

  # capture input
  x <- list(...)

  # check input
  chk_ss(x)

  # convert var or cv into sd if available
  x <- get_sd(x)

  if (is_number(x$mean) && is_number(x$sd)) {
    # mean and sd to params
    return(lnorm_meansd2meanlogsdlog(mean = x$mean, sd = x$sd))
  } else if (is_number(x$median) && is_number(x$sd)) {
    # median and sd to params
    sdlog <- sqrt(log((x$sd / x$median)^2 + 1))
    meanlog <- log(x$median) - sdlog^2 / 2
  } else if (is_number(x$mean) && is_number(x$median)) {
    # mean and median to params
    sdlog <- sqrt(2 * (log(x$mean) - log(x$median)))
    meanlog <- log(x$median) - x$sdlog^2 / 2
  }

  # if either parameter hasn't been calculated error
  if (!exists("meanlog") || !exists("sdlog")) {
    stop("Cannot calculate lognormal parameters from given input")
  }

  # return list of params
  list(
    meanlog = meanlog,
    sdlog = sdlog
  )
}

#' Converts the meanlog and sdlog parameters of the lognormal distribution to
#' the mean and standard deviation
#'
#' @inheritParams convert_lnorm_params
#'
#' @return A named list with mean and standard deviation
#' @export
#'
#' @examples
#' lnorm_meanlogsdlog2meansd(1.5, 0.9)
lnorm_meanlogsdlog2meansd <- function(meanlog, sdlog) {
  checkmate::assert_number(meanlog)
  checkmate::assert_number(sdlog, lower = 0)
  mean <- exp(meanlog + 0.5 * sdlog^2)
  sd <- exp(meanlog + 0.5 * sdlog^2) * sqrt(exp(sdlog^2) - 1)
  list(mean = mean, sd = sd)
}

#' Converts the mean and standard deviation of a lognormal distribution into the
#' standard parameterisation of meanlog (mu) and sdlog (sigma)
#'
#' @param mean Mean (expectation) of the lognormal distribution
#' @param sd Standard deviation of the lognormal distribution
#'
#' @return A named list with meanlog and sdlog
#' @export
#'
#' @examples
#' lnorm_meansd2meanlogsdlog(1.0, 0.4)
lnorm_meansd2meanlogsdlog <- function(mean, sd) {
  checkmate::assert_number(mean, lower = 0)
  checkmate::assert_number(sd, lower = 0)
  sdlog <- sqrt(log(sd^2 / mean^2 + 1))
  meanlog <- log(mean^2 / sqrt(sd^2 + mean^2))
  list(meanlog = meanlog, sdlog = sdlog)
}

#' Converts the parameters of the gamma distribution to summary statistics
#'
#' @description Converts the shape and scale parameters of the gamma
#' distribution to a number of summary statistics which can be calculated
#' analytically given the gamma parameters. One exception is the median which
#' is calculated using [`qgamma()`] as no analytical form is available.
#'
#' @param shape A single numeric of the shape parameter of the gamma
#' distribution
#' @param scale A single numeric of the scale parameter of the gamma
#' distribution
#'
#' @return A list of eight elements including: mean, median, mode,
#' variance (`var`), standard deviation (`sd`), coefficient of variation (`cv`),
#' skewness, and kurtosis.
#' @export
#'
#' @examples
#' convert_gamma_params(shape = 1, scale = 1)
convert_gamma_params <- function(shape, scale) {

  # check input
  checkmate::assert_number(shape, lower = 0)
  checkmate::assert_number(scale, lower = 0)

  # calculate metrics
  mean <- shape * scale
  median <- stats::qgamma(0.5, shape, scale)
  mode <- ifelse(
    shape >= 1,
    yes = (shape - 1) * scale,
    no = 0
  )
  var <- shape * scale^2
  sd <- sqrt(var)
  cv <- sd / mean
  skewness <- 2 / sqrt(shape)
  kurtosis <- 6 / shape + 3

  # return list of metrics
  list(
    mean = mean,
    median = median,
    mode = mode,
    var = var,
    sd = sd,
    cv = cv,
    skewness = skewness,
    kurtosis = kurtosis
  )
}

#' Converts the summary statistics to parameters of the gamma distribution
#'
#' @description Converts the summary statistics input into the shape and scale
#' parameters of the gamma distribution.
#'
#' @details The arguments input are captured and handled by name. Therefore,
#' the names of the arguments must be correct (case-sensitive). Possible input
#' summary statistics are: `mean`, `median`, `mode`, `var`, `sd`, `cv`,
#' `skewness`, `kurtosis`.
#'
#' Not every combination of input statistics is a viable conversion, and may
#' error. Common conversions that are implemented are mean and any measure of
#' spread (`var`, `sd` and `cv`), or `median` and `sd`.
#'
#' @param ... Summary statistics to be used for calculating the gamma
#' distribution parameters. All arguments must be correctly named, see details
#' for possible input.
#'
#' @return A list of two elements, the shape and scale
#' @export
#'
#' @examples
#' convert_gamma_summary_stats(mean = 3, sd = 2)
convert_gamma_summary_stats <- function(...) {

  # capture input
  x <- list(...)

  # check input
  chk_ss(x)

  # convert var or cv into sd if available
  x <- get_sd(x)

  if (is_number(x$mean) && is_number(x$sd)) {
    # mean and sd to params
    return(gamma_meansd2shapescale(mean = x$mean, sd = x$sd))
  } else if (is_number(x$mode) && is_number(x$sd)) {
    # mode and sd to params
    shape <- (x$mode / x$sd)^2
    scale <- x$mode / (x$sd^2)
  }

  # if either parameter hasn't been calculated, error
  if (!exists("shape") || !exists("scale")) {
    stop("Cannot calculate gamma parameters from given input")
  }

  # return list of params
  list(
    shape = shape,
    scale = scale
  )
}

#' Converts the shape and scale parameters of the gamma distribution to the
#' mean and standard deviation.
#'
#' @inheritParams convert_gamma_params
#'
#' @return A named list with mean and standard deviation
#' @export
#'
#' @examples
#' gamma_shapescale2meansd(shape = 0.5, scale = 0.2)
gamma_shapescale2meansd <- function(shape, scale) {
  checkmate::assert_number(shape, lower = 0)
  checkmate::assert_number(scale, lower = 0)
  mean <- shape * scale
  sd <- sqrt(shape) * scale
  list(mean = mean, sd = sd)
}

#' Converts the mean and standard deviation of the gamma distribution to the
#' shape and scale parameterisation.
#'
#' @param mean The mean of the gamma distribution
#' @param sd The standard deviation of the gamma distribution
#'
#' @return A named list with shape and scale parameters
#' @export
#'
#' @examples
#' gamma_meansd2shapescale(mean = 2.2, sd = 0.9)
gamma_meansd2shapescale <- function(mean, sd) {
  checkmate::assert_number(mean, lower = 0)
  checkmate::assert_number(sd, lower = 0)
  shape <- mean^2 / sd^2
  scale <- sd^2 / mean
  list(shape = shape, scale = scale)
}

#' Converts the parameters of the weibull distribution to summary statistics
#'
#' @description Converts the shape and scale parameters of the weibull
#' distribution to a number of summary statistics which can be calculated
#' analytically given the weibull parameters. Note the conversion uses the
#' [`gamma()`] function.
#'
#' @param shape A single numeric of the shape parameter of the weibull
#' distribution
#' @param scale A single numeric of the scale parameter of the weibull
#' distribution
#'
#' @return A list of eight elements including: mean, median, mode,
#' variance (`var`), standard deviation (`sd`), coefficient of variation (`cv`),
#' skewness, and kurtosis.
#' @export
#'
#' @examples
#' convert_weibull_params(shape = 1, scale = 1)
convert_weibull_params <- function(shape, scale) {

  # check input
  checkmate::assert_number(shape, lower = 0)
  checkmate::assert_number(scale, lower = 0)

  # calculate metrics
  mean <- scale * gamma(1 + 1 / shape)
  median <- scale * (log(2))^(-1 / shape)
  mode <- ifelse(
    shape > 1,
    yes = scale * ((shape - 1) / shape)^(1 / shape),
    no = 0
  )
  var <- scale^2 * (gamma(1 + 2 / shape) - (gamma(1 + 1 / shape))^2)
  sd <- sqrt(var)
  cv <- sd / mean
  skewness <- (gamma(1 + 3 / shape) * scale^3 - 3 *
                 mean * sd^2 - mean^3) / (sd^3)
  kurtosis <- (gamma(1 + 4 / shape) * scale^4 - 4 * mean *
                 (gamma(1 + 3 / shape) * scale^3 - 3 * mean * sd^2 - mean^3) -
                 6 * (mean^2 * sd^2 - gamma(1 + 2 / shape) *
                        scale^2) - mean^4) / (sd^4)


  # return list of metrics
  list(
    mean = mean,
    median = median,
    mode = mode,
    var = var,
    sd = sd,
    cv = cv,
    skewness = skewness,
    kurtosis = kurtosis
  )
}

#' Converts the summary statistics to parameters of the weibull distribution
#'
#' @description Converts the summary statistics input into the shape and scale
#' parameters of the weibull distribution.
#'
#' @details The arguments input are captured and handled by name. Therefore,
#' the names of the arguments must be correct (case-sensitive). Possible input
#' summary statistics are: `mean`, `median`, `mode`, `var`, `sd`, `cv`,
#' `skewness`, `kurtosis`.
#'
#' Not every combination of input statistics is a viable conversion, and may
#' error. Common conversions that are implemented are mean and any measure of
#' spread (`var`, `sd` and `cv`).
#'
#' @param ... Summary statistics to be used for calculating the weibull
#' distribution parameters. All arguments must be correctly named, see details
#' for possible input.
#'
#' @return A list of two elements, the shape and scale
#' @export
#'
#' @examples
#' convert_weibull_summary_stats(mean = 3, sd = 2)
convert_weibull_summary_stats <- function(...) {

  # capture input
  x <- list(...)

  # check input
  chk_ss(x)

  # convert var or cv into sd if available
  x <- get_sd(x)

  if (is_number(x$mean) && is_number(x$sd)) {
    # mean and sd to params
    return(weibull_meansd2shapescale(mean = x$mean, sd = x$sd))
  }

  # if either parameter hasn't been calculated, error
  if (!exists("shape") || !exists("scale")) {
    stop("Cannot calculate weibull parameters from given input")
  }
}

#' Converts the mean and standard deviation of the weibull distribution to the
#' shape and scale parameterisation.
#'
#' @param mean The mean of the weibull distribution
#' @param sd The standard deviation of the weibull distribution
#'
#' @return A named list with shape and scale parameters
#' @export
#'
#' @examples
#' weibull_meansd2shapescale(mean = 1.5, sd = 0.5)
#'
#' # numerical approximations are used to estimate the shape and scale
#' # parameters
#'
#' # converting between the mean and standard deviation and shape and scale does
#' # not recover the original values
#' wss <- weibull_meansd2shapescale(mean = 1.5, sd = 1)
#' weibull_shapescale2meansd(wss[["shape"]], wss[["scale"]])
#' # $mean
#' # [1] 1.5
#' # $sd
#' # [1] 0.4514356
#'
#' # the mean and standard deviation (sqrt(var)) are more accurately recovered
#' # from a larger sample size of weibull random variables
#' set.seed(1)
#' r <- rweibull(n = 1000, shape = wss[["shape"]], scale = wss[["scale"]])
#' mean(r)
#' # 1.491087
#' var(r)
#' # 0.9551043
#' r <- rweibull(n = 1000000, shape = wss[["shape"]], scale = wss[["scale"]])
#' mean(r)
#' # 1.500239
#' var(r)
#' # 0.9995295
weibull_meansd2shapescale <- function(mean, sd) {
  checkmate::assert_number(mean, lower = 0)
  checkmate::assert_number(sd, lower = 0)

  # give warning message about numerical inaccuracies
  message("Numerical approximation used, results may be unreliable.")

  var <- sd^2
  f <- function(k, mean, var) {
    (var / mean^2) - ((gamma(1 + 2 / k)) / (gamma(1 + 1 / k))^2) + 1
  }

  root <- stats::uniroot(f = f, interval = c(0.1, 1000), mean = mean, var = var)
  shape <- root$root
  scale <- mean / gamma(1 + 1 / shape)
  list(shape = shape, scale = scale)
}

#' Converts the shape and scale parameters of the weibull distribution to the
#' mean and standard deviation
#'
#' @inheritParams convert_weibull_params
#'
#' @return A named list with mean and standard deviation
#' @export
#'
#' @examples
#' weibull_shapescale2meansd(shape = 2, scale = 1)
weibull_shapescale2meansd <- function(shape, scale) {
  checkmate::assert_number(shape, lower = 0)
  checkmate::assert_number(scale, lower = 0)
  mean <- scale * gamma(1 + 1 / shape)
  sd <- sqrt(scale^2 * (gamma(1 + 2 / shape) - gamma(1 + 1 / shape))^2)
  list(mean = mean, sd = sd)
}

#' Convert the probability and dispersion (k) parameters of the negative
#' binomial distribution to the mean (expectation) and dispersion
#' parameterisation
#'
#' @description The negative binomial distribution can have several
#' formulations, the one used here assumes the random variable (X) is the number
#' of failures before a specified number of successes. This is the same form as
#' used by `distributional::dist_negative_binomial()`.
#'
#' @param prob The probability parameter (p) of the negative binomial
#' @param dispersion The dispersion parameter (k) of the negative binomial. This
#' parameter is also commonly represented as *r*.
#'
#' @return A named list with mean and dispersion
#' @export
#'
#' @examples
#' nbinom_probdisp2meandisp(prob = 0.3, dispersion = 0.9)
nbinom_probdisp2meandisp <- function(prob, dispersion) {
  checkmate::assert_number(prob)
  checkmate::assert_number(dispersion)
  mean <- dispersion * (1 - prob) / prob
  list(mean = mean, dispersion = dispersion)
}

#' Convert the mean and dispersion (k) parameter of the negative binomial
#' distribution to the probability (p) and dispersion parameters.
#'
#' @description The negative binomial distribution can have several
#' formulations, the one used here assumes the random variable (X) is the number
#' of failures before a specified number of successes. This is the same form as
#' used by `distributional::dist_negative_binomial()`.
#'
#' @param mean The mean (expectation) of the negative binomial distribution
#' @param dispersion The dispersion parameter (k) of the negative binomial. This
#' parameter is also commonly represented as *r*.
#'
#' @return A named list with prob and dispersion
#' @export
#'
#' @examples
#' nbinom_meandisp2probdisp(mean = 3, dispersion = 0.7)
nbinom_meandisp2probdisp <- function(mean, dispersion) {
  checkmate::assert_number(mean)
  checkmate::assert_number(dispersion)
  prob <- 1 / (1 + mean / dispersion)
  list(prob = prob, dispersion = dispersion)
}

#' Converts the parameters of the geometric distribution to summary statistics
#'
#' @description Converts the probability (`prob`) of the geometric distribution
#' to a number of summary statistics which can be calculated analytically given
#' the geometric parameter.
#'
#' @details This conversion function assumes that distribution represents the
#' number of failures before the first success (supported for zero). This is
#' the same form as used by base R and `distributional::dist_geometric()`.
#'
#' @param prob The probability parameter (p) of the geometric distribution.
#'
#' @return A list of eight elements including: mean, median, mode,
#' variance (`var`), standard deviation (`sd`), coefficient of variation (`cv`),
#' skewness, and excess kurtosis (`ex_kurtosis`).
#' @export
#'
#' @examples
#' convert_geom_params(prob = 1)
convert_geom_params <- function(prob) {

  # check input
  checkmate::assert_number(prob, lower = 0, upper = 1)

  # calculate metrics
  mean <- (1 - prob) / prob
  median <- qgeom(p = 0.5, prob = prob)
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

#' Converts the summary statistics to parameters of the geometric distribution
#'
#' @description Converts the summary statistics of the geometric
#' distribution the parameter (`prob`) of the geometric distribution.
#'
#' @details The arguments input are captured and handled by name. Therefore,
#' the names of the arguments must be correct (case-sensitive). Possible input
#' summary statistics are: `mean`, `median`, `mode`, `var`, `sd`, `cv`,
#' `skewness`, `ex_kurtosis`.
#'
#' Not every combination of input statistics is a viable conversion, and may
#' error. Common conversions that are implemented are mean and a measure of
#' spread (`var`, `sd` and `cv`).
#'
#' This conversion function assumes that distribution represents the
#' number of failures before the first success (supported for zero). This is
#' the same form as used by base R and `distributional::dist_geometric()`.
#'
#' @param ... Summary statistics to be used for calculating the geometric
#' distribution parameters. All arguments must be correctly named, see details
#' for possible input.
#'
#' @return A list of one element, the probability parameter
#' @export
#'
#' @examples
#' convert_geom_summary_stats(mean = 3)
convert_geom_summary_stats <- function(...) {

  # capture input
  x <- list(...)

  # check input
  stopifnot(
    "input must be a list" =
      is.list(x),
    "all arguments must be named" =
      !is.null(names(x)) && isFALSE("" %in% names(x)),
    "all values given must be numeric" =
      all(vapply(x, is.numeric, FUN.VALUE = logical(1))),
    "names of input must match:
    'mean', 'median', 'mode', 'var', 'sd', 'cv', 'skewness', 'ex_kurtosis'" =
      all(names(x) %in%  c(
        "mean", "median", "mode", "var", "sd", "cv", "skewness", "ex_kurtosis"
      ))
  )

  # convert var or cv into sd if available
  x <- get_sd(x)

  # calculate mean
  if (is_number(x$mean)) {
    return(geom_mean2prob(mean = x$mean))
  }

  # if either parameter hasn't been calculated error
  if (!exists("prob")) {
    stop("Cannot calculate geometric distribution parameter from given input")
  }
}

#' Converts the mean of the geometric distribution to the probability parameter
#'
#' @description The geometric distribution has two forms. This conversion
#' function assumes that distribution represents the number of failures before
#' the first success (supported for zero). This is the same form as used by
#' `distributional::dist_geometric()`.
#'
#' @param mean The mean (expectation) of the geometric distribution
#'
#' @return A named list with the probability parameter
#' @export
#'
#' @examples
#' geom_mean2prob(mean = 2)
geom_mean2prob <- function(mean) {
  checkmate::assert_number(mean, lower = 0, finite = TRUE)
  prob <- 1 / (1 + mean)
  list(prob = prob)
}

#' Converts the probability parameter of the geometric distribution to the mean
#' (expectation) of the distribution
#'
#' @description The geometric distribution has two forms. This conversion
#' function assumes that distribution represents the number of failures before
#' the first success (supported for zero). This is the same form as used by
#' `distributional::dist_geometric()`.
#'
#' @param prob The probability parameter of the geometric distribution
#'
#' @return A named list with the mean
#' @export
#'
#' @examples
#' geom_prob2mean(prob = 0.2)
geom_prob2mean <- function(prob) {
  checkmate::assert_number(prob, lower = 0, upper = 1)
  mean <- (1 - prob) / prob
  list(mean = mean)
}
