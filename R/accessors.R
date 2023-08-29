#' Parameters method for `epidist` object
#'
#' Extracts the parameters of the distribution stored in an `epidist` object.
#'
#' @details The <epidist> object can be unparameterised in which it lacks
#' a probability distribution or parameters of a probability distribution.
#' In this can the `parameters.epidist()` method with return `NA`.
#'
#' @param x An `epidist` object
#' @param ... Extra arguments to be passed to the method.
#'
#' @return A named vector of parameters or `NA` when the `<epidist>` object is
#' unparameterised
#' @export
get_parameters <- function(x, ...) {
  UseMethod("get_parameters")
}

#' @export
get_parameters.epidist <- function(x, ...) {

  # extract parameters depending on prob distribution class
  if (inherits(x$prob_dist, "distcrete")) {
    params <- unlist(x$prob_dist$parameters)
  } else if (inherits(x$prob_dist, "distribution")) {
    params <- unlist(distributional::parameters(x$prob_dist))

    # if dist is truncated clean names
    if (is_truncated(x)) {
      names(params) <- gsub(
        pattern = "dist.",
        replacement = "",
        x = names(params),
        fixed = TRUE
      )
    }

    # convert to meanlog and sdlog names
    class(params) <- family(x)
    params <- clean_epidist_params(prob_dist_params = params)
  } else {
    return(NA)
  }

  # return parameters
  params
}

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
  if (!inherits(x$citation, "bibentry")) {
    stop("Citation should be a <bibentry>", call. = FALSE)
  }

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
        title = y$title,
        journal = y$journal,
        DOI = y$DOI,
        PMID = y$PMID
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
