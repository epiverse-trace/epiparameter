#' @export
plot_epidist <- function(x, day_range = NULL, cumulative = FALSE, ...) {

  if (!requireNamespace("ggplot2", quietly = TRUE)) {
    stop("{ggplot2} is required to plot <epidist> objects but is not installed.")
  }

  # For R CMD check
  #.data <- NULL

  if (!is_parameterised(x)) {
    stop("Cannot plot an unparameterised <epidist>")
  }

  prob_func <- ifelse(cumulative, cdf, density)

  if (inherits(x$prob_dist, "distcrete")) {

    if (is.null(day_range)) {
      days <- seq(0L, to = quantile(edist, p = 0.999), by = 1L)
    } else {
      days <- seq.int(from = day_range[1], to = day_range[length(day_range)], by = 1)
    }

    dist_df <- data.frame(delay = days, prob = do.call(prob_func, args = list(x, days)))

    dist <- ggplot2::ggplot(
      data = dist_df,
      mapping = ggplot2::aes(x = delay, y = prob)
    ) +
      geom_epidist2(x, cumulative = cumulative)
  } else {

    if (is.null(day_range)) {
      p_limits <- c(0.001, 0.999)
      day_range <- 1:50 # delete
    } else {
      p_limits <- c(cdf(edist, day_range[1]), cdf(edist, day_range[length(day_range)]))
    }


    if (cumulative) {
      dist <- ggplot2::ggplot() +
        geom_epidist2(x, cumulative = cumulative, p_limits = p_limits)
    } else {


      # dist <- ggplot2::ggplot(
      #   data.frame(x_axis = c(day_range[1], day_range[length(day_range)])),
      #   ggplot2::aes(x_axis)
      # ) +
      #   ggplot2::stat_function(
      #     fun = prob_func,
      #     args = list(x, 1:50) # seq(day_range[1], day_range[length(day_range)])
      #   )

      dist <- ggplot2::ggplot() +
        geom_epidist2(x, cumulative = cumulative, p_limits = p_limits)
    }

  }

  dist + ggplot2::scale_x_continuous(name = "Days") +
    ggplot2::scale_y_continuous(name = "Probability density") +
    theme_epiparameter()

}

geom_epidist2 <- function(x, cumulative, p_limits, ...) {

  if (inherits(x$prob_dist, "distcrete")) {
    geom <- ggplot2::geom_col(fill = "#106BA0", ...)
  } else {
    if (cumulative) {
      geom <- ggdist::stat_cdfinterval(
        ggplot2::aes(xdist = x$prob_dist),
        fill = "#106BA0",
        p_limits = p_limits,
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

# StatEpidist <- ggproto("StatEpidist", Stat,
#   compute_group = function(data, scales) {
#     density(data$x, data$at)
#   },
#   required_aes = c("xdist")
# )
#
# stat_epidist <- function(mapping = NULL, data = NULL,
#                          geom = "polygon", position = "identity",
#                          na.rm = FALSE, show.legend = NA,
#                          inherit.aes = TRUE, ...) {
#   layer(
#     stat = StatEpidist,
#     data = data,
#     mapping = mapping,
#     geom = geom,
#     position = position,
#     show.legend = show.legend,
#     inherit.aes = inherit.aes,
#     params = list(na.rm = na.rm, ...)
#   )
# }

#' @importFrom ggplot2 ggproto
#' @importFrom ggdist GeomSlab
GeomEpidistCont <- ggproto("GeomEpidistCont", ggdist::GeomSlab,
  default_aes = ggplot2::aes(
    alpha = 0.5
  )
)

#' @importFrom ggplot2 ggproto GeomCol
GeomEpidistDisc <- ggproto("GeomEpidisDisc", GeomCol,
  default_aes = ggplot2::aes(
    alpha = 0.5
  )
)

geom_epidist <- function(x, mapping = NULL, data = NULL,
                         position = "identity", na.rm = FALSE,
                         show.legend = NA, inherit.aes = TRUE, ...) {
  if (inherits(x$prob_dist, "distcrete")) {
    .geom_epidist_disc()
  } else {
    .geom_epidist_cont()
  }
}

.geom_epidist_cont <- function(mapping = NULL, data = NULL, stat = "identity",
                               position = "identity", na.rm = FALSE,
                               show.legend = NA, inherit.aes = TRUE, ...) {

  layer(
    geom = GeomEpidistCont,
    data = data,
    mapping = mapping,
    stat = stat,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(na.rm = na.rm, ...)
  )
}

.geom_epidist_disc <- function(mapping = NULL, data = NULL, stat = "identity",
                               position = "identity", na.rm = FALSE,
                               show.legend = NA, inherit.aes = TRUE, ...) {
  layer(
    geom = GeomEpidistDisc,
    data = data,
    mapping = mapping,
    stat = stat,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(na.rm = na.rm, ...)
  )
}

#' A custom \pkg{ggplot2} theme for \pkg{epiparameter}
#'
#' @param ... [Dots] Extra arguments to modify [ggplot2::theme_minimal()].
#'
#' @returns A \pkg{ggplot2} [ggplot2::theme] object.
#' @importFrom ggplot2 %+replace%
#' @export
theme_epiparameter <- function(...){

  ether_blue <- "#106BA0"
  aqua <- "#10BED2"
  warm_grey <- "#EBE6E0"

  ggplot2::theme_bw(...) %+replace%
    ggplot2::theme(
      plot.background = ggplot2::element_rect(fill = warm_grey),
      panel.background = ggplot2::element_rect(fill = warm_grey),
      axis.line.x = ggplot2::element_line(),
      axis.line.y = ggplot2::element_line(),
      complete = TRUE
    )

}

