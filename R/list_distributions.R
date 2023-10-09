#' List epidemiological distributions stored in the epiparameter library
#'
#' @description This function subsets the epidemiological parameter library to
#' return only the chosen epidemiological distribution. The results are
#' returned as a data frame containing the disease, epidemiological
#' distribution, probability distribution, author of the study, and the year
#' of publication.
#'
#' @details The `<data.frame>` returned by [list_distributions()] contains some
#' vector columns and some list columns. For example, the `author` column is a
#' list as each paper can contain multiple authors.
#'
#' @inheritParams epidist
#' @param multi_epidist Either an `<epidist>` object or a list of `<epidist>`
#' objects.
#'
#' @author Adam Kucharski, Joshua W. Lambert
#' @export
#' @examples
#' list_distributions(disease = "COVID-19", epi_dist = "incubation_period")
#'
#' # example using list of `<epidist>` objects in memory
#' epidist_lst <- epidist_db(disease = "COVID-19")
#' list_distributions(multi_epidist = epidist_lst)
#'
#' # example filtering an existing list to incubation periods
#' epidist_lst <- epidist_db(disease = "COVID-19")
#' list_distributions(multi_epidist = epidist_lst, epi_dist = "incubation period")
list_distributions <- function(disease = "all",
                               epi_dist = "all",
                               ...,
                               multi_epidist) {
  # read in data if not given
  if (missing(multi_epidist)) {
    multi_epidist <- suppressMessages(
      epidist_db(disease = disease, epi_dist = epi_dist, ...)
    )
  }

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
    epi_dist = epi_dist
  )

  disease <- vapply(
    multi_epidist,
    function(x) x$disease$disease,
    FUN.VALUE = character(1)
  )
  epi_dist <- vapply(
    multi_epidist, "[[", "epi_dist",
    FUN.VALUE = character(1)
  )
  prob_dist <- vapply(
    multi_epidist, function(x) {
      switch(class(x$prob_dist)[1],
        "distcrete" = family(x),
        "distribution" = family(x),
        "character" = x$prob_dist,
        "logical" = NA_character_
      )
    },
    FUN.VALUE = character(1)
  )
  author <- lapply(multi_epidist, function(x) x$citation$author)
  year <- vapply(
    multi_epidist, function(x) as.numeric(x$citation$year),
    FUN.VALUE = numeric(1)
  )

  # return data frame
  data.frame(
    disease = disease,
    epi_distribution = epi_dist,
    prob_distribution = prob_dist,
    author = I(author),
    year = year
  )
}
