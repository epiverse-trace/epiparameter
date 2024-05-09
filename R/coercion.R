#' [as.function()] method for `<epidist>` class
#'
#' @description Converts an `<epidist>` object to a distribution function
#' (see [epidist_distribution_functions]), either probability density/mass
#' function, (`density`), cumulative distribution function (`cdf`), random
#' number generator (`generate`), or quantile (`quantile`).
#'
#' @details The function returned takes a single required argument `x`.
#'
#' @inheritParams print.epidist
#' @inheritParams base::as.function
#' @param func_type A single `character` string specifying which distribution to
#' convert `<epidist>` object into. Default is `"density"`. Other options are
#' `"cdf"`, `"generate"`, or `"quantile"`.
#'
#' @return A [function] object.
#' @export
as.function.epidist <- function(x,
                                func_type = c(
                                  "density", "cdf", "generate", "quantile"
                                ),
                                ...) {
  chkDots(...)
  func_type <- match.arg(func_type)
  if (!is_parameterised(x)) {
    stop(
      "Cannot convert unparameterised <epidist> to distribution function",
      call. = FALSE
    )
  }
  epidist <- x
  x <- switch(func_type,
              density = function(x) density(x = epidist, at = x),
              cdf = function(x) epiparameter::cdf(x = epidist, q = x),
              generate = function(x) epiparameter::generate(x = epidist, times = x),
              quantile = function(x) quantile(x = epidist, p = x)
  )

  # return distribution function
  x
}


#' [as.data.frame()] method for `<epidist>` class
#'
#' @details
#' The `<data.frame>` returned will contain some atomic columns (i.e. one
#' object per row), and other columns that are lists (i.e. multiple objects per
#' row). The list columns can contain lists or S3 objects (e.g. `<bibentry>`
#' object in the `citation` column).
#'
#'
#' @inheritParams print.epidist
#' @param ... [dots] Not used, extra arguments supplied will cause a warning.
#'
#' @return A `<data.frame>` with a single row.
#' @export
as.data.frame.epidist <- function(x, ...) {
  chkDots(...)
  # check object as could be invalidated by user
  validate_epidist(x)

  # make data frame
  df <- data.frame(
    disease = x$disease,
    pathogen = x$pathogen,
    epi_distribution = x$epi_dist,
    prob_distribution = I(list(prob_dist = x$prob_dist)),
    uncertainty = I(list(uncertainty = x$uncertainty)),
    summary_stats = I(list(summary_stats = x$summary_stats)),
    citation = I(x$citation),
    metadata = I(list(metadata = x$metadata)),
    method_assess = I(list(method_assess = x$method_assess)),
    notes = x$notes
  )
  row.names(df) <- NULL

  # return data frame
  df
}

#' [as.data.frame()] method for `<multi_epidist>` class
#'
#' @inherit as.data.frame.epidist details
#'
#' @inheritParams print.multi_epidist
#' @param ... [dots] Not used, extra arguments supplied will cause a warning.
#'
#' @return A `<data.frame>` with as many rows as length of input list.
#' @export
as.data.frame.multi_epidist <- function(x, ...) {
  chkDots(...)
  do.call(rbind, lapply(x, as.data.frame))
}
