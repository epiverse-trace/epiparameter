#' Plot method for `<epidist>` class
#'
#' @description Plot an `<epidist>` object by displaying the either the
#' probability density function (PDF) (in the case of continuous
#' distributions) or the probability mass function (PMF), (in the
#' case of discrete distributions) or , or the cumulative distribution
#' function (CDF), when `cumulative = TRUE`.
#'
#' @param x An `<epidist>` object.
#' @param day_range Either `NULL` or a numeric vector of length 2 with the
#' first and last day to plot on the x-axis.
#' @param cumulative A boolean `logical`, default is `FALSE`.
#' `cumulative = TRUE` plots the cumulative distribution function (CDF).
#' @param ... [dots] extra arguments to plotting method, currently not used and
#' will produce warning if extra arguments are supplied.
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
#' plot(edist)
#' plot(edist, day_range = c(5, 15))
#' plot(edist, cumulative = TRUE)
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
#' plot(edist)
#' plot(edist, day_range = c(5, 15))
#' plot(edist, cumulative = TRUE)
plot.epidist <- function(x, day_range = NULL, cumulative = FALSE, ...) {

  if (!requireNamespace("ggplot2", quietly = TRUE)) {
    stop(
      "{ggplot2} is required to plot <epidist> objects but is not installed.",
      call. = FALSE
    )
  }

  # check input
  chkDots(...)
  validate_epidist(x)
  checkmate::assert_numeric(day_range, len = 2, null.ok = TRUE)
  checkmate::assert_logical(cumulative, len = 1)

  # For R CMD check
  delay <- NULL
  prob <- NULL

  if (!is_parameterised(x)) {
    stop("Cannot plot an unparameterised <epidist>")
  }

  prob_func <- ifelse(cumulative, cdf, density)

  if (inherits(x$prob_dist, "distcrete")) {
    if (is.null(day_range)) {
      days <- seq(0L, to = quantile(x, p = 0.999), by = 1L)
    } else {
      days <- seq.int(from = day_range[1], to = day_range[2], by = 1)
    }

    dist_df <- data.frame(
      delay = days,
      prob = do.call(prob_func, args = list(x, days))
    )

    dist <- ggplot2::ggplot(
      data = dist_df,
      mapping = ggplot2::aes(x = delay, y = prob)
    ) +
      geom_epidist(x, cumulative = cumulative)
  } else {

    if (is.null(day_range)) {
      p_limits <- c(0.001, 0.999)
    } else {
      p_limits <- c(cdf(x, day_range[1]), cdf(x, day_range[2]))
    }

    if (cumulative) {
      dist <- ggplot2::ggplot() +
        geom_epidist(x, cumulative = cumulative, p_limits = p_limits)
    } else {
      dist <- ggplot2::ggplot() +
        geom_epidist(x, cumulative = cumulative, p_limits = p_limits)
    }

  }

  if (inherits(x$prob_dist, "distcrete")) {
    y_axis_name <- "Probability Mass"
  } else {
    y_axis_name <- "Probability Density"
  }

  dist + ggplot2::scale_x_continuous(name = "Days") +
    ggplot2::scale_y_continuous(name = y_axis_name) +
    theme_epiparameter()
}

geom_epidist <- function(x, cumulative, p_limits, ...) {

  if (inherits(x$prob_dist, "distcrete")) {
    geom <- ggplot2::geom_col(fill = "#106BA0", ...)
  } else {
    if (cumulative) {
      geom <- ggdist::stat_cdfinterval(
        ggplot2::aes(xdist = x$prob_dist),
        fill = "#106BA0",
        p_limits = p_limits,
        point_interval = NULL,
        ...
      )
    } else {
      geom <- ggdist::stat_slab(
        ggplot2::aes(xdist = x$prob_dist),
        fill = "#106BA0",
        p_limits = p_limits,
        ...
      )
    }
  }
  geom
}

#' Plot method for `<vb_epidist>` class
#'
#' @description Plot a `<vb_epidist>` object by displaying the either the
#' probability density function (PDF) (in the case of continuous
#' distributions) or the probability mass function (PMF), (in the case of
#' discrete distributions), or the cumulative distribution function (CDF),
#' for both the intrinsic and extrinsic distributions.
#'
#' @param x A `<vb_epidist>` object.
#' @param ... [dots] extra arguments to be passed to either
#' [epiparameter::plot.epidist()].
#'
#' @author Joshua W. Lambert
#' @export
#'
#' @examples
#' # plot vb_epidist
#' dengue_dist <- vb_epidist(
#'   intrinsic_epidist = epidist(
#'     disease = "dengue",
#'     epi_dist = "incubation",
#'     prob_distribution = "gamma",
#'     prob_distribution_params = c(shape = 1, scale = 1),
#'     metadata = create_epidist_metadata(
#'       transmission_mode = "vector_borne",
#'       extrinsic = FALSE
#'     )
#'   ),
#'   extrinsic_epidist = epidist(
#'     disease = "dengue",
#'     epi_dist = "incubation",
#'     prob_distribution = "gamma",
#'     prob_distribution_params = c(shape = 2, scale = 2),
#'     metadata = create_epidist_metadata(
#'       transmission_mode = "vector_borne",
#'       extrinsic = TRUE
#'     )
#'   )
#' )
#'
#' plot(dengue_dist)
plot.vb_epidist <- function(x, ...) {
  # check input
  validate_vb_epidist(x)

  if (!any(...names() %in% c("day_range", "cumulative")) && ...length() > 0) {
    stop("Incorrect arguments passed to plot.epidist", call. = FALSE)
  }

  gridExtra::grid.arrange(
    plot(x$intrinsic, ...),
    plot(x$extrinsic, ...)
  )
}

#' A custom \pkg{ggplot2} theme for \pkg{epiparameter}
#'
#' @param ... [dots] Extra arguments to modify [ggplot2::theme_minimal()].
#'
#' @returns A \pkg{ggplot2} [ggplot2::theme] object.
#' @importFrom ggplot2 %+replace%
#' @export
theme_epiparameter <- function(...) {

  ggplot2::theme_bw(...) %+replace%
    ggplot2::theme(
      plot.background = ggplot2::element_rect(),
      panel.background = ggplot2::element_rect(),
      axis.line.x = ggplot2::element_line(),
      axis.line.y = ggplot2::element_line(),
      complete = TRUE
    )
}
