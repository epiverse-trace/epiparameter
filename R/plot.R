#' Plot method for `<epidist>` class
#'
#' @description Plot an `<epidist>` object by displaying the either the
#' probability mass function (PMF), (in the case of discrete distributions)
#' or probability density function (PDF) (in the case of continuous
#' distributions), or the cumulative distribution function (CDF).
#'
#' @param x An `<epidist>` object.
#' @param day_range Either `NULL` or a `numeric` vector of length 2 with the
#' first and last day to plot on the x-axis. If `NULL` the distribution is
#' plotted between day 0 and the 99th quantile of the distribution.
#' @inheritParams base::print
#'
#' @author Joshua W. Lambert
#' @export
#'
#' @examples
#' # plot continuous epidist
#' edist <- epidist(
#'   disease = "ebola",
#'   epi_dist = "incubation_period",
#'   prob_distribution = "gamma",
#'   prob_distribution_params = c(shape = 2, scale = 1)
#' )
#' plot(edist)
#'
#' # plot different day range (x-axis)
#' plot(edist, day_range = c(0, 10))
#'
#' # plot CDF
#' plot(edist, cumulative = TRUE)
#'
#' # plot discrete epidist
#' edist <- discretise(edist)
#' plot(edist)
plot.epidist <- function(x,
                         day_range = NULL,
                         cumulative = FALSE,
                         ...) {
  # check input
  validate_epidist(x)
  checkmate::assert_numeric(day_range, len = 2, null.ok = TRUE)
  checkmate::assert_logical(cumulative, any.missing = FALSE, len = 1)

  oldpar <- graphics::par(no.readonly = TRUE)
  on.exit(graphics::par(oldpar))

  if (inherits(x$prob_dist, "distcrete")) {
    main <- "Probability Mass Function"
  } else {
    main <- "Probability Density Function"
  }

  if (is.null(day_range)) {
    day_range <- seq(0, quantile(x, p = 0.99), length.out = 1000)
  } else {
    day_range <- seq(day_range[1], day_range[2], length.out = 1000)
  }

  if (cumulative) {
    # plot CDF
    plot(
      day_range,
      distributional::cdf(x, q = day_range),
      ylab = "",
      xlab = "Time since infection",
      type = "l",
      lwd = 2,
      pch = 16,
      ylim = c(0, 1),
      main = "Cumulative Distribution Function",
      ...
    )
  } else {
    # plot either PDF or PMF
    plot(
      day_range,
      stats::density(x, at = day_range),
      ylab = "",
      xlab = "Time since infection",
      type = "l",
      lwd = 2,
      pch = 16,
      main = main,
      ...
    )
  }
}