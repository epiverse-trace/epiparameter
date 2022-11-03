#' Calculate the quantiles of a probability distribution based on the vector
#' of probabilities and time data (e.g. time since infection)
#'
#' @description This function can be used in cases where the data on a fitted
#' distribution is not openly available and the summary statistics of the
#' distribution are not reported so the data are scraped from the plot and
#' the quantiles are needed in order use the `extract_param()` function
#'
#' @param prob A numeric vector of probabilities
#' @param days A numeric vector of days
#' @param quantile A single numeric or vector of numerics specifying which
#' quantiles to extract from the distribution
#'
#' @return A named vector of quantiles
#' @export
#'
#' @examples
#' prob <- dgamma(seq(0, 10, length.out = 21), shape = 2, scale = 2)
#' days <- seq(0, 10, 0.5)
#' quantiles <- c(0.025, 0.975)
#' calc_disc_dist_quantile(prob = prob, days = days, quantile = quantiles)
calc_disc_dist_quantile <- function(prob, days, quantile) {

  # check inputs
  checkmate::assert_numeric(prob)
  checkmate::assert_numeric(days)
  checkmate::assert_numeric(quantile, lower = 0, upper = 1)

  csum_prob <- cumsum(prob)
  sum_prob <- sum(prob)
  q_value <- quantile * sum_prob
  q_index <- vector(mode = "numeric", length = length(quantile))
  for (i in seq_along(quantile)) {
    q_index[i] <- which.min(abs(q_value[i] - csum_prob))
  }
  quantiles <- days[q_index]
  names(quantiles) <- as.character(quantile)
  quantiles
}
