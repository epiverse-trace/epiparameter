#' Convert a vector of named percentiles into correct format and selects two
#' values for parameter extraction
#'
#' @description Parameters of a probability distribution can be extracted using
#' the values given at percentiles of the distribution and the percentiles using
#' [extract_param()]. [.get_percentiles()] takes a named vector of percentiles
#' (names) and values at those percentiles (elements in the vector) and selects
#' two values as lower and upper percentiles to be used in extraction. If a
#' lower and upper percentile are not available `NA` is returned.
#'
#' It also formats the vector names so that they can be correctly converted to
#' numeric using `as.numeric()`.
#'
#' @details  The name format is a character of the value of the percentile.
#' Numbers with decimal places should have the decimal point in the name. For
#' example the 5th and 95th percentile can be given as
#'
#' ```r
#' .get_percentiles(c("5" = 1, "95" = 10))
#' ```
#'
#' or the 2.5th and 97.5th percentile can be given as
#'
#' ```r
#' .get_percentiles(c("2.5" = 1, "97.5" = 10))
#' ```
#'
#' @param percentiles A named vector of values at percentiles with the names the
#' percentiles. See Details for the accepted vector name format.
#'
#' @return A named `numeric` vector of percentiles.
#' @keywords internal
.get_percentiles <- function(percentiles) {
  # check input
  checkmate::assert_numeric(percentiles, names = "unique")
  checkmate::assert_numeric(
    as.numeric(names(percentiles)),
    lower = 0,
    upper = 100
  )

  # extract a lower and an upper percentile
  percentiles <- .get_sym_percentiles(percentiles)

  # return percentiles
  percentiles
}

#' Get the lower and upper percentiles with a preference for symmetrical
#' percentiles
#'
#' @param percentiles A named vector of percentiles. The names are in the
#' correct format to be converted to their numeric value using `as.numeric()`.
#'
#' @return A named `numeric` vector of two elements with the lower
#' (first element) and upper (second element) percentiles.
#' @keywords internal
.get_sym_percentiles <- function(percentiles) {
  # make a copy of percentiles
  percentiles_ <- percentiles

  # remove NA values
  percentiles <- percentiles[!is.na(percentiles)]

  # get percentiles names for percentiles with and without NAs
  intervals <- as.numeric(names(percentiles))

  # split lower and upper percentiles
  lower_intervals <- intervals[intervals <= 50]
  upper_intervals <- intervals[intervals > 50]

  # if upper or lower percentiles are not available return percentiles
  if (identical(length(lower_intervals), 0L) ||
    identical(length(upper_intervals), 0L)) {
    return(NA)
  }

  # calc differences of lower and upper percentiles from bounds
  lw_interval_diff <- abs(0 - lower_intervals)
  up_interval_diff <- abs(100 - upper_intervals)

  # calc distance between lower and upper percentiles
  outer_diff <- abs(outer(lw_interval_diff, up_interval_diff, FUN = "-"))

  # get indices of symmetrical or most symmetrical lower and upper percentiles
  idx <- as.vector(arrayInd(which.min(outer_diff), .dim = dim(outer_diff)))

  # extract lower and upper percentiles from non-NA percentiles
  lower_percentile <- lower_intervals[idx[1]]
  upper_percentile <- upper_intervals[idx[2]]

  # extract lower and upper percentiles from all percentiles
  lower_percentile_idx <- which(names(percentiles_) %in% lower_percentile)
  upper_percentile_idx <- which(names(percentiles_) %in% upper_percentile)

  # return vector of percentiles
  percentiles_[c(lower_percentile_idx, upper_percentile_idx)]
}
