#' Table of epidemiological distributions
#'
#' @description This function subsets the epidemiological parameter library to
#' return only the chosen epidemiological distribution. The results are
#' returned as a data frame containing the disease, epidemiological
#' distribution, probability distribution, author of the study, and the year
#' of publication.
#'
#' @inheritParams epidist
#' @param multi_epidist Either an `<epidist>` object or a list of `<epidist>`
#' objects.
#'
#' @author Joshua W. Lambert, Adam Kucharski
#' @export
#' @examples
#' epidist_list <- epidist_db(disease = "COVID-19")
#' parameter_tbl(multi_epidist = epidist_list)
#'
#' # example filtering an existing list to incubation periods
#' epidist_list <- epidist_db(disease = "COVID-19")
#' parameter_tbl(
#'   multi_epidist = epidist_list,
#'   epi_dist = "incubation period"
#' )
parameter_tbl <- function(multi_epidist,
                          disease = "all",
                          pathogen = "all",
                          epi_dist = "all") {
  # wrap <epidist> in list for apply functions
  if (is_epidist(multi_epidist)) {
    multi_epidist <- list(multi_epidist)
  }

  # check data
  stopifnot(
    "List of <epidist> objects should be supplied to multi_epidist" =
      all(vapply(multi_epidist, is_epidist, FUN.VALUE = logical(1))) &&
        length(multi_epidist) != 0
  )

  multi_epidist <- .filter_epidist_db(
    multi_epidist = multi_epidist,
    disease = disease,
    pathogen = pathogen,
    epi_dist = epi_dist
  )

  disease <- vapply(multi_epidist, "[[", "disease", FUN.VALUE = character(1))
  pathogen <- vapply(multi_epidist, "[[", "pathogen", FUN.VALUE = character(1))
  epi_dist <- vapply(
    multi_epidist, "[[", "epi_dist",
    FUN.VALUE = character(1)
  )
  prob_dist <- vapply(
    multi_epidist, function(x) {
      switch(class(x$prob_dist)[1],
        distcrete = family(x),
        distribution = family(x),
        character = x$prob_dist,
        logical = NA_character_
      )
    },
    FUN.VALUE = character(1)
  )

  short_author <- vapply(multi_epidist, function(x) {
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
    multi_epidist, function(x) as.numeric(x$citation$year),
    FUN.VALUE = numeric(1)
  )
  sample_size <- vapply(
    multi_epidist,
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
