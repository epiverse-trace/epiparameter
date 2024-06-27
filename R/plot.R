#' Plot method for `<epidist>` class
#'
#' @description Plot an `<epidist>` object by displaying the either the
#' probability mass function (PMF), (in the case of discrete distributions)
#' or probability density function (PDF) (in the case of continuous
#' distributions), or the cumulative distribution function (CDF).
#'
#' @details
#' By default if the `xlim` argument is not specified the distribution is
#' plotted between day 0 and the 99th quantile of the distribution.
#' Alternatively, a `numeric` vector of length 2 with the
#' first and last day to plot on the x-axis can be supplied to `xlim`
#' (through [...]).
#'
#'
#' @param x An `<epidist>` object.
#' @param cumulative A boolean `logical`, default is `FALSE`.
#' `cumulative = TRUE` plots the cumulative distribution function (CDF).
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
#' plot(edist, xlim = c(0, 10))
#'
#' # plot CDF
#' plot(edist, cumulative = TRUE)
#'
#' # plot discrete epidist
#' edist <- discretise(edist)
#' plot(edist)
plot.epidist <- function(x,
                         cumulative = FALSE,
                         ...) {
  # check input
  validate_epidist(x)
  checkmate::assert_logical(cumulative, any.missing = FALSE, len = 1)

  # capture dots
  dots <- list(...)

  oldpar <- graphics::par(no.readonly = TRUE)
  on.exit(graphics::par(oldpar))

  if (is_continuous(x)) {
    main <- "Probability Density Function"
  } else {
    main <- "Probability Mass Function"
  }

  if (is.null(dots$xlim)) {
    xlim <- seq(0, quantile(x, p = 0.99), length.out = 1000)
  } else {
    checkmate::assert_numeric(dots$xlim, len = 2)
    xlim <- seq(dots$xlim[1], dots$xlim[2], length.out = 1000)
  }

  xlab <- tools::toTitleCase(x$epi_dist)
  if (x$epi_dist != "offspring distribution") {
    xlab <- paste(xlab, "(Days)")
  }

  if (is_continuous(x)) {
    if (cumulative) {
      # plot CDF
      plot(
        x = xlim,
        y = cdf(x, q = xlim),
        ylab = "",
        xlab = xlab,
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
        x = xlim,
        y = density(x, at = xlim),
        ylab = "",
        xlab = xlab,
        type = "l",
        lwd = 2,
        pch = 16,
        main = main,
        ...
      )
    }
  } else {
    if (cumulative) {
      graphics::barplot(
        height = cdf(x, q = unique(round(xlim))),
        space = 0,
        names.arg = unique(round(xlim)),
        xlab = xlab,
        ylab = "",
        ylim = c(0, 1),
        main = "Cumulative Distribution Function",
        ...
      )
    } else {
      graphics::barplot(
        density(x, at = unique(round(xlim))),
        space = 0,
        names.arg = unique(round(xlim)),
        xlab = xlab,
        ylab = "",
        main = main,
        ...
      )
    }
  }
}
