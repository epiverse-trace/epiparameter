#' Converts the mu (mean log) and sigma (standard deviation log) parameters of
#' the lognormal distribution to the mean and standard deviation
#'
#' @param mu The mu parameter (mean of natural logarithm) of the lognormal
#' distribution
#' @param sigma The sigma parameter (standard deviation of the natural
#' logarithm) of the distribution
#'
#' @return A named list with mean and standard deviation
#' @export
#'
#' @examples
#' lnorm_musigma2meansd(1.5, 0.9)
lnorm_musigma2meansd <- function(mu, sigma) {
  mean <- exp(mu + 0.5 * sigma^2)
  sd <- exp(mu + 0.5 * sigma^2) * sqrt(exp(sigma^2) - 1)
  list(mean = mean, sd = sd)
}

#' Converts the mean and standard deviation of a lognormal distribution into the
#' standard parameterisation of mu (mean log) and sigma (standard deviation log)
#'
#' @param mean Mean (expectation) of the lognormal distribution
#' @param sd Standard deviation of the lognormal distribution
#'
#' @return A named list with mu and sigma
#' @export
#'
#' @examples
#' lnorm_meansd2musigma(1.0, 0.4)
lnorm_meansd2musigma <- function(mean, sd) {
  sigma <- sqrt(log(sd^2 / mean^2 + 1))
  mu <- log(mean^2 / sqrt(sd^2 + mean^2))
  list(mu = mu, sigma = sigma)
}

#' Converts the shape and scale parameters of the gamma distribution to the
#' mean and standard deviation.
#'
#' @param shape The shape parameter of the gamma distribution
#' @param scale The scale parameter of the gamma distribution
#'
#' @return A named list with mean and standard deviation
#' @export
#'
#' @examples
#' gamma_shapescale2meansd(shape = 0.5, scale = 0.2)
gamma_shapescale2meansd <- function(shape, scale) {
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
  shape <- mean^2 / sd^2
  scale <- sd^2 / mean
  list(shape = shape, scale = scale)
}
