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

#' Create message reporting `<epiparameter>` objects that are estimates from
#' the same study
#'
#' @description
#' When a single study reports several estimates that all loaded from the
#' database, they indistinguishable from each other, so this function
#' writes a message that is printed in [print.multi_epiparameter()] notifying
#' the user of multiple parameters from the same study.
#'
#' @details
#' Entries are grouped by disease, epidemiological parameter name and study
#' (DOI, when available), Entries without an identifiable study are never
#' grouped together. The study is named in the message when all the entries
#' come from one study.
#'
#' @param x A `<multi_epiparameter>` object.
#'
#' @return A `character` string for the [print.multi_epiparameter()] footer.
#' Empty `character` string when no entries from the same study.
#' @keywords internal
.same_study_msg <- function(x) {
  browser()
  if (length(x) < 2L) {
    return("")
  }
  key <- vapply(
    seq_along(x),
    function(i) .study_key(x[[i]], i),
    FUN.VALUE = character(1)
  )
  groups <- split(seq_along(x), key)
  # keep only the groups holding more than one entry
  groups <- unname(groups[lengths(groups) > 1L])
  if (length(groups) == 0L) {
    return("")
  }

  n_same <- sum(lengths(groups))
  if (length(groups) == 1L) {
    study <- .citet(x[[groups[[1L]][1L]]]$citation)
    msg <- sprintf(
      tr_("%s entries are different estimates from %s, see `$notes`.\n"),
      n_same, study
    )
  } else {
    msg <- sprintf(
      tr_("%s entries are different estimates from the same study, see `$notes`.\n"), # nolint: line_length_linter.
      n_same
    )
  }
  # prefix to match the other elements of the print footer
  paste0("# ", cli::symbol$info, " ", msg)
}

#' Key identifying the disease, parameter and study of an `<epiparameter>`
#'
#' @inheritParams .same_study_msg
#' @param i The index of `x` in the `<multi_epiparameter>`, used to keep
#' entries without an identifiable study from being grouped together.
#'
#' @return A `character` string.
#' @keywords internal
.study_key <- function(x, i) {
  browser()
  doi <- x$citation$doi
  if (length(doi) == 1L && !is.na(doi) && nzchar(doi)) {
    study <- doi
  } else {
    study <- tryCatch(.citet(x$citation), error = function(e) NA_character_)
    # an empty citation gives a string with no author or year, which does not
    # identify a study, so the entry is given a key of its own
    if (length(study) != 1L || is.na(study) || !grepl("[[:alnum:]]", study)) {
      study <- paste0("no study ", i)
    }
  }
  # \r cannot appear in the fields so is safe as a separator
  paste(x$disease, x$epi_name, study, sep = "\r")
}

`%||%` <- function(x, y) if (is.null(x)) y else x # nolint: coalesce_linter.
