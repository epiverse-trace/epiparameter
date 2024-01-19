#' Get parameters from an object
#'
#' Extract the parameters stored in an \R object.
#'
#' @inheritParams base::print
#'
#' @export
get_parameters <- function(x, ...) {
  UseMethod("get_parameters")
}

#' Get parameters from an `<epidist>` object
#'
#' Extract the parameters of the distribution stored in an `<epidist>` object.
#'
#' @details The `<epidist>` object can be unparameterised in which it lacks
#' a probability distribution or parameters of a probability distribution,
#' in this case the `get_parameters.epidist()` method will return `NA`.
#'
#' @inheritParams print.epidist
#' @param ... Extra arguments to be passed to the method.
#'
#' @return A named vector of parameters or `NA` when the `<epidist>` object is
#' unparameterised.
#' @export
#'
#' @examples
#' edist <- epidist_db(
#'   disease = "COVID-19",
#'   epi_dist = "serial interval",
#'   single_epidist = TRUE
#' )
#' get_parameters(edist)
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

#' Extract citation information from `<epidist>` or list of `<epidist>` objects
#'
#' @inheritParams is_parameterised
#'
#' @return A single character string or list of character string citations.
#' Length of list output is equal to number of elements in the `<epidist>`
#' object passed to the function.
#' @export
#'
#' @examples
#' # example with <epidist>
#' edist <- epidist_db(single_epidist = TRUE)
#' get_citation(edist)
#'
#' # example returning bibtex format
#' edist <- epidist_db(disease = "COVID-19", single_epidist = TRUE)
#' cit <- get_citation(edist)
#' format(cit, style = "bibtex")
#'
#' # example with list of <epidist>
#' edist <- epidist_db()
#' get_citation(edist)
get_citation <- function(x, ...) {
  UseMethod("get_citation")
}

#' @export
get_citation.epidist <- function(x, ...) {
  chkDots(...)
  if (!inherits(x$citation, "bibentry")) {
    stop("Citation should be a <bibentry>", call. = FALSE)
  }

  # return citation
  x$citation
}

#' @export
get_citation.multi_epidist <- function(x, ...) {
  chkDots(...)
  citation_list <- lapply(x, get_citation)

  # return citation list
  citation_list
}
