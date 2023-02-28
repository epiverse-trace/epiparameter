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
        test = grepl(pattern = "_0", x = x),
        yes = gsub(
          pattern = "(.*)_0",
          replacement = "0.",
          x = x
        ),
        no = gsub(
          pattern = "q_",
          replacement = "",
          x = x
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
  # TODO: write function that searches for symmetrical percentiles
  lower_percentile <-
    percentiles[which(as.numeric(names(percentiles)) <= 50)][1]
  upper_percentile <- percentiles[which(as.numeric(names(percentiles)) > 50)][1]

  # use the first numeric quantile in the set to calculate the parameters
  percentiles <- vapply(c(lower_percentile, upper_percentile), function(x) {
    if (length(x) == 0) {
      NA_real_
    } else {
      x
    }
  }, FUN.VALUE = numeric(1))

  if (anyNA(percentiles)) {
    percentiles <- NA
  }

  # return percentiles
  percentiles
}