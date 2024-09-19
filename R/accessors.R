#' Get parameters from an object
#'
#' Extract the parameters stored in an \R object.
#'
#' @inheritParams base::print
#' @param ... [dots] Extra arguments to be passed to the method.
#'
#' @export
get_parameters <- function(x, ...) {
  UseMethod("get_parameters")
}

#' Get parameters from an `<epiparameter>` object
#'
#' Extract the parameters of the distribution stored in an `<epiparameter>`
#' object.
#'
#' @details The `<epiparameter>` object can be unparameterised in which it lacks
#' a probability distribution or parameters of a probability distribution,
#' in this case the `get_parameters.epiparameter()` method will return `NA`.
#'
#' @inheritParams print.epiparameter
#' @param ... [dots] Not used, extra arguments supplied will cause a warning.
#'
#' @return A named vector of parameters or `NA` when the `<epiparameter>`
#' object is unparameterised.
#' @export
#'
#' @examples
#' ep <- epiparameter_db(
#'   disease = "COVID-19",
#'   epi_dist = "serial interval",
#'   single_epiparameter = TRUE
#' )
#' get_parameters(ep)
get_parameters.epiparameter <- function(x, ...) {
  chkDots(...)
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
    params <- .clean_params(
      prob_distribution = family(x),
      prob_distribution_params = params
    )
  } else {
    return(NA)
  }

  # return parameters
  params
}

#' Get citation from an object
#'
#' Extract the citation stored in an \R object.
#'
#' @inheritParams base::print
#' @param ... [dots] Extra arguments to be passed to the method.
#'
#' @export
get_citation <- function(x, ...) {
  UseMethod("get_citation")
}

#' Get citation from an `<epiparameter>` object
#'
#' Extract the citation stored in an `<epiparameter>` object.
#'
#' @inheritParams print.epiparameter
#' @param ... [dots] Not used, extra arguments supplied will cause a warning.
#'
#' @return A `<bibentry>` object.
#' @export
#'
#' @examples
#' # example with <epiparameter>
#' ep <- epiparameter_db(single_epiparameter = TRUE)
#' get_citation(ep)
#'
#' # example returning bibtex format
#' ep <- epiparameter_db(disease = "COVID-19", single_epiparameter = TRUE)
#' cit <- get_citation(ep)
#' format(cit, style = "bibtex")
get_citation.epiparameter <- function(x, ...) {
  chkDots(...)
  if (!inherits(x$citation, "bibentry")) {
    stop("Citation should be a <bibentry>", call. = FALSE)
  }

  # return citation
  x$citation
}

#' Get citation from a list of `<epiparameter>` objects
#'
#' Extract the citation stored in a list of `<epiparameter>` objects.
#'
#' @inheritParams print.epiparameter
#' @param ... [dots] Not used, extra arguments supplied will cause a warning.
#'
#' @return A `<bibentry>` object containing multiple references. The length of
#' output `<bibentry>` is equal to the length of the list of `<epiparameter>`
#' objects supplied.
#' @export
#'
#' @examples
#' # example with list of <epiparameter>
#' db <- epiparameter_db()
#' get_citation(db)
get_citation.multi_epiparameter <- function(x, ...) {
  chkDots(...)
  # dispatches to get_citation.epiparameter method
  citation_list <- lapply(x, get_citation)
  # dispatches to c.bibentry method
  multi_bibentry <- Reduce(f = c, x = citation_list)
  # return <bibentry>
  multi_bibentry
}
