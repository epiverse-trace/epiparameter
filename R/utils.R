#' Calculate the quantiles of a probability distribution based on the vector
#' of probabilities and time data (e.g. time since infection)
#'
#' @description This function can be used in cases where the data on a fitted
#' distribution is not openly available and the summary statistics of the
#' distribution are not reported so the data are scraped from the plot and
#' the quantiles are needed in order use the [extract_param()] function.
#'
#' @param prob A `numeric` vector of probabilities.
#' @param days A `numeric` vector of days.
#' @param quantile A single `numeric` or vector of `numerics` specifying which
#' quantiles to extract from the distribution.
#'
#' @return A named vector of quantiles.
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

#' Format short citation from `<bibentry>` object
#'
#' @description
#' Output is equivalent to the `\citet{}` function in the \pkg{natbib} LaTeX
#' package.
#'
#' @param x A `<bibentry>` object, see [bibentry()].
#'
#' @return A `character` string with the short citation.
#' @keywords internal
.citet <- function(x) {
  stopifnot(inherits(x, "bibentry"))
  cite <- vapply(
    x,
    function(y) {
      num_author <- length(y$author)
      # check if first author is an organisation
      is_org_author <- is.null(y$author[1]$family)
      # this covers single author entries
      if (is_org_author) {
        # organisation name stored in $given
        cit <- y$author[1]$given
      } else {
        cit <- y$author[1]$family
      }
      # append second author or et al for multi-author entries
      if (num_author == 2) {
        cit <- paste(cit, "&", y$author[2]$family)
      } else if (num_author > 2) {
        cit <- paste(cit, "et al.")
      }
      cit <- paste0(cit, " (", y$year, ")")
    },
    FUN.VALUE = character(1)
  )
  cite
}

`%||%` <- function(x, y) if (is.null(x)) y else x
