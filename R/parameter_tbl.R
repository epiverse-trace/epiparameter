#' Table of epidemiological distributions
#'
#' @description This function subsets the epidemiological parameter library to
#' return only the chosen epidemiological distribution. The results are
#' returned as a data frame containing the disease, epidemiological
#' distribution, probability distribution, author of the study, and the year
#' of publication.
#'
#' @inheritParams epiparameter
#' @param multi_epiparameter Either an `<epiparameter>` object or a list of
#' `<epiparameter>` objects.
#'
#' @author Joshua W. Lambert, Adam Kucharski
#' @export
#' @examples
#' epiparameter_list <- epiparameter_db(disease = "COVID-19")
#' parameter_tbl(multi_epiparameter = epiparameter_list)
#'
#' # example filtering an existing list to incubation periods
#' epiparameter_list <- epiparameter_db(disease = "COVID-19")
#' parameter_tbl(
#'   multi_epiparameter = epiparameter_list,
#'   epi_dist = "incubation period"
#' )
parameter_tbl <- function(multi_epiparameter,
                          disease = "all",
                          pathogen = "all",
                          epi_dist = "all") {
  # wrap <epiparameter> in list for apply functions
  if (is_epiparameter(multi_epiparameter)) {
    multi_epiparameter <- list(multi_epiparameter)
  }

  # check data
  stopifnot(
    "List of <epiparameter> objects should be supplied to multi_epiparameter" =
      all(
        vapply(multi_epiparameter, is_epiparameter, FUN.VALUE = logical(1))
      ) && length(multi_epiparameter) != 0
  )

  multi_epiparameter <- .filter_epiparameter_db(
    multi_epiparameter = multi_epiparameter,
    disease = disease,
    pathogen = pathogen,
    epi_dist = epi_dist
  )

  disease <- vapply(
    multi_epiparameter, "[[", "disease", FUN.VALUE = character(1)
  )
  pathogen <- vapply(
    multi_epiparameter, "[[", "pathogen", FUN.VALUE = character(1)
  )
  epi_dist <- vapply(
    multi_epiparameter, "[[", "epi_dist",
    FUN.VALUE = character(1)
  )
  prob_dist <- vapply(
    multi_epiparameter, function(x) {
      switch(class(x$prob_distribution)[1],
        distcrete = family(x),
        distribution = family(x),
        character = x$prob_distribution,
        logical = NA_character_
      )
    },
    FUN.VALUE = character(1)
  )

  short_author <- vapply(multi_epiparameter, function(x) {
    x <- x$citation$author
    first_author <- x[1]$family
    # organisation first author
    if (is.null(first_author)) {
      return(x[1]$given)
    }
    # multiple or single authors
    if (length(x) > 1) {
      return(paste(first_author, "et al."))
    }
    first_author
  }, FUN.VALUE = character(1))

  year <- vapply(
    multi_epiparameter, function(x) as.numeric(x$citation$year),
    FUN.VALUE = numeric(1)
  )
  sample_size <- vapply(
    multi_epiparameter,
    function(x) x$metadata$sample_size,
    FUN.VALUE = numeric(1)
  )

  # make data frame
  df <- data.frame(
    disease = disease,
    pathogen = pathogen,
    epi_distribution = epi_dist,
    prob_distribution = prob_dist,
    author = short_author,
    year = year,
    sample_size
  )
  class(df) <- c("parameter_tbl", class(df))

  # return data
  df
}

#' @export
print.parameter_tbl <- function(x, ...) {
  # p_tbl subclass needed see https://github.com/tidyverse/ggplot2/issues/4786
  class(x) <- c("p_tbl", "tbl", "data.frame")
  print(x, ...)
}

#' @importFrom pillar tbl_sum
#' @export
tbl_sum.p_tbl <- function(x, ...) {
  default_header <- NextMethod()
  c("Parameter table" = "", default_header)
}
