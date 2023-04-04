#' Method for extracting citation information from `<epidist>` or
#' `<epiparam>` objects.
#'
#' @param x An `epidist` or `epiparam` object.
#' @param ... Extra arguments to be passed to the method.
#'
#' @return A single character string or list of character string citations.
#' Length of list output is equal to number of rows in the `epiparam` object
#' passed to the function.
#' @export
#'
#' @examples
#'
#' # example with epidist
#' eparam <- epiparam()
#' edist <- as_epidist(eparam[12, ])
#' get_citation(edist)
#'
#' # example with epiparam
#' eparam <- epiparam()
#' get_citation(eparam)
get_citation <- function(x, ...) {
  UseMethod("get_citation")
}

#' @export
get_citation.epidist <- function(x, ...) {
  # return citation
  x$citation
}

#' @export
get_citation.epiparam <- function(x, ...) {
  citation_list <- apply(x, MARGIN = 1, FUN = function(y) {
    # suppressing message as users do not need reminding of citation when
    # retrieving citation
    suppressMessages(
      create_epidist_citation(
        author = y$author,
        year = y$year,
        PMID = y$PMID,
        DOI = y$DOI
      )
    )
  },
  simplify = FALSE
  )

  # remove names from list
  citation_list <- unname(citation_list)

  # return citation list
  citation_list
}