#' Plot method for `<epidist>` class
#'
#' @description Plot an `<epidist>` object by displaying the either the
#' probability mass function (PMF), (in the case of discrete distributions)
#' or probability density function (PDF) (in the case of continuous
#' distributions) and the cumulative distribution function (CDF). Resulting in
#' a 1x2 grid plot.
#'
#' @param x An `<epidist>` object.
#' @param day_range A vector with the sequence of days to be plotted on the
#' x-axis of the distribution.
#' @param vb A boolean logical determining whether the `epidist` being plotted
#' has come from a `vb_epidist` object.
#' @param title Either a character string or `NULL`. If not null the character
#' string will be printed as a title to the plot.
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
#'
#' plot(edist, day_range = 0:10)
#'
#' # plot CDF
#' plot(edist, day_range = 0:10, cumulative = TRUE)
#'
#' # plot discrete epidist
#' edist <- epidist(
#'   disease = "ebola",
#'   epi_dist = "incubation_period",
#'   prob_distribution = "gamma",
#'   prob_distribution_params = c(shape = 2, scale = 1),
#'   discretise = TRUE
#' )
#'
#' plot(edist, day_range = 0:10)
plot.epidist <- function(x,
                         day_range = 0:10,
                         cumulative = FALSE,
                         ...,
                         vb = FALSE,
                         title = NULL) {
  # check input
  validate_epidist(x)
  checkmate::assert_numeric(day_range, min.len = 2)
  checkmate::assert_logical(cumulative, any.missing = FALSE, len = 1)

  if (isFALSE(vb)) {
    oldpar <- graphics::par(no.readonly = TRUE)
    on.exit(graphics::par(oldpar))
  }

  if (inherits(x$prob_dist, "distcrete")) {
    main <- "Probability Mass Function"
  } else {
    main <- "Probability Density Function"
  }

  if (cumulative) {
    # plot CDF
    plot(
      day_range,
      distributional::cdf(x, q = day_range),
      ylab = "",
      xlab = "Time since infection",
      type = "b",
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
      type = "b",
      pch = 16,
      main = main,
      ...
    )
  }

  if (!is.null(title)) {
    if (grepl(pattern = "intrinsic", x = title, ignore.case = TRUE)) {
      line <- -1
    } else {
      line <- -15
    }
    # add a plot title
    graphics::title(title, outer = TRUE, line = line)
  }
}