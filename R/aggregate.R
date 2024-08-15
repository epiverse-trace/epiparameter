#' Convert a `<multi_epiparameter>` object to a single `<epiparameter>`
#'
#' @param x A `<multi_epiparameter>` object.
#' @param synthesis_method The method used to aggregate the estimates. Can be
#' either `"meta_analysis"` (default) or `"naive"`.
#' @param weights The method used to weight the estimates. Can be either
#' `"sample_size"` (default) or `"unweighted"`.
#' @param allowed_pairs A list of pairs of population-level summary statistics.
#' to
#' @param ... [dots] Not used, extra arguments supplied will cause a warning.
#'
#' @returns An `<epiparameter>` object with synthetised central estimate value
#' and uncertainty
#'
#' @examples
#' epiparameter_db(epi_dist = "serial interval", disease = "ebola")
#'
#' @export
aggregate.multi_epiparameter <- function(x,
                                         synthesis_method = c("meta_analysis",
                                                              "naive"),
                                         weights = c("sample_size",
                                                     "unweighted"),
                                         allowed_pairs = list(
                                           c("mean", "sd"),
                                           c("median", "sd"),
                                           c("median", "IQR")
                                         ),
                                         ...) {

  chkDots(...)

  # Control that the multi_epiparameter object contains only the same type of
  # epi_dist, on the same pathogen
  stopifnot(
    "All <epiparameter>s in x must refer to the same pathogen" =
      length(unique(vapply(x, `[[`, "pathogen", character(1)))) == 1,
    "All epidists in x must refer to the same type of epi_dist" =
      length(unique(vapply(x, `[[`, "epi_dist", character(1)))) == 1
  )

  synthesis_method <- match.arg(synthesis_method)
  weights <- match.arg(weights)

  if (weights == "sample_size") {
    warning(
      "Some estimates have been dropped because they don't report sample size"
    )
  }

  if (synthesis_method == "meta_analysis") {
    # For this method, we need:
    # * one central estimate (converted to mean)
    # * one estimate of population level variability (converted to sd)

    # TODO: OPEN QUESTION:
    # * What precise summary stats can be converted to a central estimate with reasonable assumptions?
    # * What precise summary stats can be converted to an estimate of population level variability with reasonable assumptions?
    # In other words, what pair of summary stats to we accept for this method?

    # Answer: Let the user decide via the`allowed_pairs` argument

    # Homogeneize all `allowed_pairs` by converting everything to `mean` and `sd`

    warning(
      "Some estimates have been dropped because they don't report a central estimate and population level variability estimate as specified in `allowed_pairs`"
    )
    synthesised_central_estimate
  }

  if (synthesis_method == "naive") {
    synthesised_central_estimate
  }

  # This kind of methods loses population-level variability information.
  # We can now only get the central estimate and uncertainty around this central estimate
  epiparameter(
    summary_stats = list(
      mean = synthesised_estimate,
      mean_ci_limits = c(lower_bound, upper_bound),
      mean_ci = c(value1, value2)
    )
  )
}
