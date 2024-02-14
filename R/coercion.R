#' Convert an \R object to an `<epidist>` object
#'
#' Creates an `<epidist>` object from another object with distribution class or
#' list.
#'
#' @inheritParams base::print
#'
#' @return An `<epidist>` object.
#'
#' @export
as_epidist <- function(x, ...) {
  UseMethod("as_epidist")
}

#' @export
as_epidist.epidist <- function(x, ...) {
  chkDots(...)
  validate_epidist(x)
  x
}

#' Convert an \R list to an `<epidist>` object
#'
#' Creates an `<epidist>` object from a list containing valid elements for an
#' `<epidist>` object. Validation is checked with
#' [epiparameter::validate_epidist()].
#'
#' @param x A list.
#' @param ... [dots] Not used, will warn if extra arguments are provided.
#'
#' @return An `<epidist>` object.
#' @export
as_epidist.list <- function(x, ...) {
  if (inherits(x, "dist_spec")) {
    # dist_spec is a superclass of list
    NextMethod()
  } else {
    chkDots(...)
    # non-classed list
    class(x) <- "epidist"
    validate_epidist(x)
    x
  }
}

#' Convert a `<dist_spec>` object to an `<epidist>` object
#'
#' Extract distribution parameters and information stored in a `<dist_spec>`
#' object and store and return in an `<epidist>` object.
#'
#' @param x A `<dist_spec>` object.
#' @inheritParams epidist
#' @param ... [dots] Extra arguments to be passed to [epiparameter::epidist()].
#'
#' @return An `<epidist>` object.
#' @export
#'
#' @examples
#' if (requireNamespace("EpiNow2", quietly = TRUE)) {
#'   gamma_dist_spec <- EpiNow2::dist_spec(
#'     mean = 3, sd = 2, mean_sd = 0.5, sd_sd = 0.5, max = 20,
#'     distribution = "gamma"
#'   )
#'   as_epidist(
#'     gamma_dist_spec,
#'     disease = "Ebola virus disease",
#'     epi_dist = "serial interval"
#'   )
#'
#'   # example passing extra information to <epidist>
#'   as_epidist(
#'     gamma_dist_spec,
#'     disease = "Ebola virus disease",
#'     epi_dist = "serial interval",
#'     pathogen = "Ebola virus",
#'     metadata = create_epidist_metadata(
#'       sample_size = 100,
#'       inference_method = "MLE"
#'     )
#'   )
#' }
as_epidist.dist_spec <- function(x,
                                 disease,
                                 epi_dist,
                                 ...) {
  stopifnot(
    "disease required to convert <dist_spec> to <epidist>" =
      !missing(disease),
    "epi distribution required to convert <dist_spec> to <epidist>" =
      !missing(epi_dist)
  )

  if (x$fixed == 0) {
    warning("uncertainty from <dist_spec> is currently dropped", call. = FALSE)
  }

  prob_distribution <- switch(x$dist,
    lognormal = "lnorm",
    gamma = "gamma"
  )

  prob_distribution_params <- do.call(
    convert_summary_stats_to_params,
    args = list(prob_distribution, mean = x$mean_mean, sd = x$sd_mean)
  )

  truncation <- ifelse(test = length(x$max) > 0, yes = x$max, no = NA_real_)

  # return <epidist>
  epidist(
    disease = disease,
    epi_dist = epi_dist,
    prob_distribution = prob_distribution,
    prob_distribution_params = unlist(prob_distribution_params),
    truncation = truncation,
    ...
  )
}

#' @export
as_epidist.default <- function(x, ...) {
  stop(
    paste0("as_epidist() not implemented for class <", class(x), ">"),
    call. = FALSE
  )
}
