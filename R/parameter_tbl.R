#' Provide epidemiological distributions in a tabular format
#'
#' @description This function subsets the epidemiological parameter library to
#' return only the chosen epidemiological distribution. The results are
#' returned as a data frame containing the disease, epidemiological
#' distribution, probability distribution, author of the study, and the year
#' of publication.
#'
#' @details The `<data.frame>` returned by [parameter_tbl()] contains some
#' vector columns and some list columns. For example, the `author` column is a
#' list as each paper can contain multiple authors.
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

  disease <- vapply(
    multi_epidist,
    function(x) x$disease,
    FUN.VALUE = character(1)
  )
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
  author <- lapply(multi_epidist, function(x) x$citation$author)
  year <- vapply(
    multi_epidist, function(x) as.numeric(x$citation$year), # nolint lambda
    FUN.VALUE = numeric(1)
  )
  sample_size <- vapply(
    multi_epidist,
    function(x) x$metadata$sample_size,
    FUN.VALUE = numeric(1)
  )

  # return data frame
  data.frame(
    disease = disease,
    epi_distribution = epi_dist,
    prob_distribution = prob_dist,
    author = I(author),
    year = year,
    sample_size
  )
}
