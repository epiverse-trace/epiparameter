#' Converts a vector of named percentiles into correct format and selects two
#' values for parameter extraction
#'
#' @description Parameters of a probability distribution can be extracted using
#' the values given at percentiles of the distribution and the percentiles using
#' [`extract_param()`]. `get_percentiles()` takes a named vector of percentiles
#' (names) and values at those percentiles (elements in the vector) and selects
#' two values as lower and upper percentiles to be used in extraction.
#'
#' It also formats the vector names so that they can be correctly converted to
#' numeric using `as.numeric()`.
#'
#' @details  The name format is "q_" followed by the value. Decimal points
#' are not used an should have a zero infront of the number to represent
#' decimal places, e.g. q_05 is 0.5. Numbers with decimal places after non-zero
#' values are given as q_975 which is 97.5.
#'
#' @param percentiles A named vector of values at percentiles with the names the
#' percentiles. See Details for the accepted vector name format.
#'
#' @return A named vector of percentiles
#' @keywords internal
#'
#' @examples
#' \dontrun{
#'   # 90th interval
#'   get_percentiles(c(q_05 = 1, q_95 = 10))
#'   # 95th interval
#'   get_percentiles(c(q_025 = 1, q_975 = 10))
#' }
get_percentiles <- function(percentiles) {

  # check input
  checkmate::assert_numeric(percentiles, names = "unique")

  # change percentile names to give correct numbers
  names(percentiles) <- unname(vapply(
    names(percentiles), function(x) {
      ifelse(
        test = grepl(pattern = "_0", x = x, fixed = TRUE),
        yes = gsub(
          pattern = "(.*)_0",
          replacement = "0.",
          x = x
        ),
        no = gsub(
          pattern = "q_",
          replacement = "",
          x = x,
          fixed = TRUE
        )
      )
    },
    FUN.VALUE = character(1)
  ))

  # insert decimal point when necessary
  names(percentiles) <- unname(vapply(
    names(percentiles), function(x) {
      ifelse(
        test = as.numeric(x) >= 100,
        yes = gsub(
          pattern = "^(.{2})(.*)$",
          replacement = "\\1.\\2",
          x = x
        ),
        no = x
      )
    },
    FUN.VALUE = character(1)
  ))

  # extract a lower and an upper percentile
  percentiles <- get_sym_percentiles(percentiles)

  # if any percentiles are NA return NA
  if (anyNA(percentiles)) {
    percentiles <- NA
  }

  # return percentiles
  percentiles
}

#' Get the lower and upper percentiles with a preference for symmetrical
#' percentiles
#'
#' @param percentiles A named vector of percentiles. The names are in the
#' correct format to be converted to their numeric value using `as.numeric()`.
#'
#' @return A named numeric vector of two elements with the lower (first element)
#' and upper (second element) percentiles
#' @keywords internal
get_sym_percentiles <- function(percentiles) {

  # check input
  stopifnot("all percentiles are missing" = !all(is.na(percentiles)))

  # make a copy of percentiles
  percentiles_ <- percentiles

  # remove NA values
  percentiles <- percentiles[!is.na(percentiles)]

  # get percentiles names for percentiles with and without NAs
  intervals <- as.numeric(names(percentiles))

  # split lower and upper percentiles
  lower_intervals <- intervals[intervals <= 50]
  upper_intervals <- intervals[intervals > 50]

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
  lower_percentile_idx = which(names(percentiles_) %in% lower_percentile)
  upper_percentile_idx = which(names(percentiles_) %in% upper_percentile)

  # return vector of percentiles
  percentiles_[c(lower_percentile_idx, upper_percentile_idx)]
}
