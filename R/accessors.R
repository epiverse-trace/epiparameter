#' Get parameters from an object
#'
#' Extract the parameters stored in an \R object.
#'
#' @inheritParams base::print
#' @param ... [dots] Extra arguments to be passed to the method.
#'
#' @return A named vector of parameters or `NA` when the `<epiparameter>`
#' object is unparameterised, or a list where each element is a named vectors
#' or `NA`.
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
#'   epi_name = "serial interval",
#'   single_epiparameter = TRUE
#' )
#' get_parameters(ep)
get_parameters.epiparameter <- function(x, ...) {

  chkDots(...)
  # extract parameters depending on prob distribution class
  if (inherits(x$prob_distribution, "distcrete")) {
    params <- unlist(x$prob_distribution$parameters)
  } else if (inherits(x$prob_distribution, "distribution")) {
    params <- unlist(distributional::parameters(x$prob_distribution))

    # if dist is truncated clean names
    if (is_truncated(x)) {
      names(params) <- gsub(
        pattern = "dist.",
        replacement = "",
        x = names(params),
        fixed = TRUE
      )
    }

    # if truncated get underlying distribution type
    params <- .clean_params(
      prob_distribution = family(x, base_dist = is_truncated(x)),
      prob_distribution_params = params
    )
  } else {
    return(NA)
  }

  # return parameters
  params
}

#' @rdname get_parameters.epiparameter
#' @export
get_parameters.multi_epiparameter <- function(x, ...) {
  params <- lapply(x, get_parameters)
  # return list of parameters
  params
}

#' Get citation from an object
#'
#' Extract the citation stored in an \R object.
#'
#' @inheritParams base::print
#' @param ... [dots] Extra arguments to be passed to the method.
#'
#' @return A `<bibentry>` object or list of `<bibentry>` objects.
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

#' Get the underlying distributions names from a `<distribution>` object from
#' the \pkg{distributional} package in \R distribution naming convention.
#'
#' @details Get and standardise distribution name. For untransformed
#' distributions (e.g. [distributional::dist_gamma()]) it will return the
#' distribution name. For transformed distributions (e.g.
#' [distributional::dist_mixture()]) it will get the name of the underlying
#' distribution(s) by default (`base_dist = TRUE`). Distribution names are
#' returned in the \R naming style (e.g. lognormal is `"lnorm"`). When
#' `base_dist = FALSE` transformed distributions return the name of the
#' transformation (e.g. `"mixture"`).
#'
#' @param x An `<distribution>` object.
#' @param base_dist A boolean `logical` for whether to return the name of a
#' transformed distribution (e.g. `"mixture"` or `"truncated"`) or the
#' underlying distribution type (e.g. `"gamma"` or `"lnorm"`). Default is
#' `TRUE`.
#'
#' @return A `character` vector.
#' @keywords internal
.distributional_family <- function(x, base_dist = TRUE) {
  if (family(x) %in% c("mixture", "truncated") && base_dist) {
    fam <- vapply(
      distributional::parameters(x)$dist[[1]],
      family,
      FUN.VALUE = character(1),
      USE.NAMES = FALSE
    )
  } else {
    fam <- family(x)
  }
  fam <- vapply(
    fam, function(x) {
      switch(x,
        lognormal = "lnorm",
        negbin = "nbinom",
        geometric = "geom",
        poisson = "pois",
        normal = "norm",
        exponential = "exp",
        x
      )
    },
    FUN.VALUE = character(1)
  )
  return(unname(fam))
}
