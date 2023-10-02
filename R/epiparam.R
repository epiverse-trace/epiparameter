#' State column names of an `<epiparam>` object
#'
#' @return `Character` vector.
#' @keywords internal
#' @noRd
epiparam_fields <- function() {
  c(
    "disease", "pathogen", "epi_distribution", "author", "title", "journal",
    "year", "sample_size", "region", "transmission_mode", "vector",
    "extrinsic", "prob_distribution", "inference_method", "mean",
    "mean_ci_limits", "mean_ci", "sd", "sd_ci_limits", "sd_ci", "quantile_2.5",
    "quantile_5", "quantile_25", "median", "median_ci_limits", "median_ci",
    "quantile_75", "quantile_87.5", "quantile_95", "quantile_97.5",
    "lower_range", "upper_range", "shape", "shape_ci_limits", "shape_ci",
    "scale", "scale_ci_limits", "scale_ci", "meanlog", "meanlog_ci_limits",
    "meanlog_ci", "sdlog", "sdlog_ci_limits", "sdlog_ci", "dispersion",
    "dispersion_ci_limits", "dispersion_ci", "precision",
    "precision_ci_limits", "precision_ci", "truncation", "discretised",
    "censored", "right_truncated", "phase_bias_adjusted", "notes", "PMID",
    "DOI"
  )
}

#' State which columns of `<epiparam>` object contain specified data type
#'
#' @return `Numeric` vector.
#' @keywords internal
#' @noRd
epiparam_col_type <- function(epiparam,
                              col_type = c(
                                "numeric",
                                "character",
                                "logical",
                                "list"
                              )) {
  col_type <- match.arg(col_type)

  out <- switch(col_type,
    numeric = which(
      colnames(epiparam) %in% c(
        "year", "sample_size", "mean", "mean_ci", "sd", "sd_ci", "quantile_2.5",
        "quantile_5", "quantile_25", "median", "median_ci", "quantile_75",
        "quantile_87.5", "quantile_95", "quantile_97.5", "lower_range",
        "upper_range", "shape", "shape_ci", "scale", "scale_ci", "meanlog",
        "meanlog_ci", "sdlog", "sdlog_ci", "dispersion", "dispersion_ci",
        "precision", "precision_ci", "truncation", "PMID"
      )
    ),
    character = which(
      colnames(epiparam) %in% c(
        "disease", "pathogen", "epi_distribution", "title", "journal",
        "region", "transmission_mode", "vector", "prob_distribution",
        "inference_method", "notes", "DOI"
      )
    ),
    logical = which(
      colnames(epiparam) %in% c(
        "extrinsic", "discretised", "censored", "right_truncated",
        "phase_bias_adjusted"
      )
    ),
    list = which(
      colnames(epiparam) %in% c(
        "author", "mean_ci_limits", "sd_ci_limits", "median_ci_limits",
        "shape_ci_limits", "scale_ci_limits", "meanlog_ci_limits",
        "sdlog_ci_limits", "dispersion_ci_limits", "precision_ci_limits"
      )
    )
  )
  out
}
