#' Aggregate multiple `<epiparameter>` objects into a single `<epiparameter>`
#' object.
#'
#' @description
#' Combine a list of `<epiparameter>` objects into a single `<epiparameter>`
#' with a mixture distribution [see [distributional::dist_mixture()]].
#'
#' The aggregated `<epiparameter>` returned from `aggregate()` can then be used
#' with the `density()`, `cdf()`, `quantile()` and `generate()` methods for the
#' combined distributions.
#'
#' @details
#' The `aggregate()` method requires that all `<epiparameter>` objects are
#' parameterised with `<distribution>` objects (from the \pkg{distributional}
#' package). This means that unparameterised (see [is_parameterised()]) or
#' discretised (see [discretise()]) distributions cannot be aggregated and the
#' function will error.
#'
#' @param x A `<multi_epiparameter>` object.
#' @param weighting A `character` string with the type of weighting to use to
#' create the mixture distribution. Options are: `"equal"` for equal weighting
#' across distributions, `"sample_size"` for using the sample size in each
#' `<epiparameter>` object to weight the distribution (the sample sizes are
#' normalised), or `"custom"` allows a vector of weights to be passed to the
#' `weights` argument for a custom weighting.
#' @param weights A `numeric` vector of equal length the number of
#' `<epiparameter>` objects passed to `x`. `weights` is only required if
#' `weighting = "custom"`.
#' @param ... [dots] Not used, will warn if extra arguments are passed to
#' function.
#'
#' @return An `<epiparameter>` object
#' @importFrom stats aggregate
#' @export
#'
#' @examples
#' ebola_si <- epiparameter_db(epi_dist = "serial interval", disease = "ebola")
#' aggregate(ebola_si)
aggregate.multi_epiparameter <- function(x,
                                         weighting = c(
                                           "equal", "sample_size", "custom"),
                                         ...,
                                         weights) {
  chkDots(...)
  weighting <- match.arg(weighting)

  # ensure <multi_epiparameter> contains the same pathogen and epi_dist
  disease <- unique(vapply(x, `[[`, FUN.VALUE = character(1), "disease"))
  pathogen <- unique(vapply(x, `[[`, FUN.VALUE = character(1), "pathogen"))
  epi_dist <- unique(vapply(x, `[[`, FUN.VALUE = character(1), "epi_dist"))
  stopifnot(
    "All <epiparameter>s in x must contain the same disease" =
      length(disease) == 1,
    "All <epiparameter>s in x must contain the same pathogen" =
      length(pathogen) == 1,
    "All <epiparameter>s in x must contain the same type of epi_dist" =
      length(epi_dist) == 1
  )

  if (!all(vapply(x, is_parameterised, FUN.VALUE = logical(1)))) {
    stop(
      "aggregate() requires all <epiparameter> objects to be parameterised",
      call. = FALSE
    )
  }

  is_distributional <- vapply(
    x,
    function(y) inherits(y$prob_distribution, "distribution"),
    FUN.VALUE = logical(1)
  )

  if (!all(is_distributional)) {
    stop(
      "`aggregate()` only works with distributions that are not discretised",
      call. = FALSE
    )
  }

  if (weighting == "custom") {
    if (missing(weights)) {
      stop(
        "`weights` are required for each distribution when ",
        "`weighting = custom`.",
        call. = FALSE
      )
    }
    if (length(weights) != length(x)) {
      stop(
        "The number of weights must equal the number of <epiparameter> ",
        "objects.",
        call. = FALSE
      )
    }
  } else if (weighting == "equal") {
    weights <- rep(1 / length(x), times = length(x))
  } else if (weighting == "sample_size") {
    weights <- vapply(
      lapply(x, `[[`, "metadata"), `[[`, FUN.VALUE = numeric(1), "sample_size"
    )
    weights <- weights / sum(weights, na.rm = TRUE)
    if (anyNA(weights)) {
      cit <- get_citation(x)
      cit <- unique(.citet(cit[is.na(weights)]))
      warning(
        cli::pluralize(
          "Input distribution{?s} {cit} {?has/have} been dropped ",
          "because they don't report sample size."
        ),
        call. = FALSE
      )
      x <- x[!is.na(weights)]
      if (length(x) == 0) {
        stop("No input distributions have sample sizes.", call. = FALSE)
      }
      weights <- weights[!is.na(weights)]
    }
  }

  dists <- lapply(x, `[[`, "prob_distribution")
  # weights summing to 1 and negative weights is checked in dist_mixture()
  # dist_mixture() accepts dynamic dots
  prob_dist <- distributional::dist_mixture(!!!dists, weights = weights)

  # combine summary statistics
  ss <- create_summary_stats()
  ss_empty <- vector(mode = "list", length = length(ss))
  names(ss_empty) <- names(ss)
  metadata <- create_metadata()
  metadata_empty <- vector(mode = "list", length = length(metadata))
  names(metadata_empty) <- names(metadata)
  method_assess <- create_method_assess()
  method_assess_empty <- vector(mode = "list", length = length(method_assess))
  names(method_assess_empty) <- names(method_assess)
  for (i in seq_along(x)) {
    # add list elements not in <epiparameter> to keep consistent struct
    ss_ <- c(
      x[[i]]$summary_stats,
      ss[!names(ss) %in% names(x[[i]]$summary_stats)]
    )
    metadata_ <- c(
      x[[i]]$metadata,
      metadata[!names(metadata) %in% names(x[[i]]$metadata)]
    )
    method_assess_ <- c(
      x[[i]]$method_assess,
      method_assess[!names(method_assess) %in% names(x[[i]]$method_assess)]
    )
    # bind empty summary status in first iteration to avoid extra NAs
    if (i == 1) {
      aggr_ss <- Map(f = c, ss_empty, ss_)
      aggr_metadata <- Map(f = c, metadata_empty, metadata_)
      aggr_method_assess <- Map(f = c, method_assess_empty, method_assess_)
    } else {
      aggr_ss <- Map(f = c, aggr_ss, ss_)
      aggr_metadata <- Map(f = c, aggr_metadata, metadata_)
      aggr_method_assess <- Map(f = c, aggr_method_assess, method_assess_)
    }
  }

  citations <- lapply(x, `[[`, "citation")
  notes <- paste(
    "This is an aggregated distribution using", length(x), "<epiparameter>",
    "objects. The citation for each input <epiparameter> can be found in",
    "$citation."
  )

  epiparameter(
    disease = disease,
    pathogen = pathogen,
    epi_dist = epi_dist,
    prob_distribution = prob_dist,
    citation = Reduce(f = c, x = citations),
    summary_stats = aggr_ss,
    metadata = aggr_metadata,
    method_assess = aggr_method_assess,
    notes = notes
  )
}
