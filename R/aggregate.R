#' Aggregate a `<multi_epiparameter>` object to a single `<epiparameter>`
#'
#' @description
#' Aggregrate multiple epidemiological parameter sets into a single consensus
#' set. Multiple methods for aggregation are available see Details.
#'
#' @details
#' The `"linear-OP"` method is linear opinion pool, which is the combination of
#' distributions by
#'
#' \deqn{p(\theta) = \sum_{i=1}^{n} w_i p_i(\theta)}
#'
#' where \eqn{w_i} are the weights and \eqn{p_i} are the probability
#' distributions. The weights must sum to one so if the weights given to the
#' `weights` argument do not them will be normalised.
#'
#' One potential downside of linear opinion pooling is that it does not preserve
#' the parametric probability distribution of it's input distributions. The
#' output `<epiparameter>` contains a `numeric` vector for the aggregated
#' probability density.
#'
#' The `"log-OP"` method is logarithmic opinion pool, which is the combination
#' of distributions by
#'
#' \deqn{p(\theta) = k \prod_{i=1}^{n} p_i(\theta)^{w_i}}
#'
#' The `"sampling"` method generates a random sample from each input
#' `<epiparameter>` and outputs a `numeric` vector for the density (calculated
#' using [density()]).
#'
#' The `"mean_params"` method calculates the arithmetic mean of the each
#' parameter for each `<epiparameter>`. This method requires that all
#' `<epiparameter>` objects have the same parameterised probability
#' distribution (see [family.epiparameter()]), otherwise it will error.
#'
#' The `"mean_summary_stats"` method calculates the arithmetic mean of the
#' summary statistics for each `<epiparameter>` object. Currently only the mean
#' and standard deviation are accepted summary statistics (see `allowed_pairs`
#' argument). This method requires that all `<epiparameter>` objects contain a
#' mean and standard deviation in `$summary_stats`.
#'
#' @param x A `<multi_epiparameter>` object.
#' @param method The method used to aggregate the estimates. Can be
#' either `"linear-OP"` (default), `"log-OP"`, `"sampling"`, `"mean_params"`,
#' or `"mean_summary_stats"`. See details for more information.
#' @param weights The method used to weight the estimates. Can be either
#' `"unweighted"` (default), or `"sample_size"`, or a `numeric` vector of
#' weights with equal length to the number of `<epiparameter>` objects supplied
#' to `x`.
#' @param ... [dots] Not used, extra arguments supplied will cause a warning.
#' @param allowed_pairs A list of pairs of population-level summary statistics.
#' Currently this is only mean and standard deviation (`c("mean", "sd")`). The
#' `allowed_pairs` argument is only applicable when
#' `method = "mean_summary_stats"`. More combinations of summary statistics
#' will be added in the future.
#' @param domain A `numeric` vector over which to evaluate continuous probability
#' distributions when aggregating. Only applicable when `method` is
#' `"linear-OP"` or `"log-OP"`.
#' @param n_samples A single `numeric` for the number of times to sample each
#' probability distribution when `method = "sampling"`. For weighted aggregation
#' the number of samples for each probability distribution is weighted given
#' `weights`. The total number of samples is always equal to
#' `n_samples * length(x)`.
#'
#' @returns An `<epiparameter>` object with either synthesised parameters or
#' summary statistics, or a density vector.
#' @export
#'
#' @references
#'
#' Clemen, R.T. and Winkler R.L. (2012) Aggregating Probability Distributions.
#' Advances in Decision Analysis.
#'
#' @examples
#' ebola_si <- epiparameter_db(epi_dist = "serial interval", disease = "ebola")
#'
#' aggregate(ebola_si)
#'
#' aggregate(ebola_si, method = "sampling")
#'
#' aggregate(ebola_si, method = "mean_params")
aggregate.multi_epiparameter <- function(x,
                                         method = c("linear-OP", "log-OP",
                                                    "sampling", "mean_params",
                                                    "mean_summary_stats"),
                                         weights = c("unweighted",
                                                     "sample_size"),
                                         ...,
                                         allowed_pairs = list(
                                           c("mean", "sd")
                                         ),
                                         domain = seq(-1e5, 1e5, length.out = 1e3),
                                         n_samples = 1e3) {
  chkDots(...)

  # TODO figure out how to have logic to handle discrete and continuous methods
  if (any(!vapply(x, is_continuous, FUN.VALUE = logical(1)))) {
    stop(
      "aggregate.epiparameter() currently only works on ",
      "continuous distributions",
      call. = FALSE
    )
  }

  # ensure <multi_epiparameter> contains the same pathogen and epi_dist
  disease <- unique(vapply(x, `[[`, FUN.VALUE = character(1), "disease"))
  pathogen <- unique(vapply(x, `[[`, FUN.VALUE = character(1), "pathogen"))
  epi_dist <- unique(vapply(x, `[[`, FUN.VALUE = character(1), "epi_dist"))
  stopifnot(
    "All <epiparameter>s in x must contain the same pathogen" =
      length(pathogen) == 1,
    "All <epiparameter>s in x must contain the same type of epi_dist" =
      length(epi_dist) == 1
  )

  # extract weights if given as string
  if (!is.character(weights)) {
    stopifnot(
      "Number of <epiparameter> objects must equal number of weights supplied" =
        identical(length(x), length(weights)),
      "All weights must be numeric" = is.numeric(weights)
    )
    if (sum(weights) != 1) {
      weights <- weights / sum(weights)
      message("Weights do not sum to 1. Normalising weights.")
    }
  } else {
    weights <- match.arg(weights)
    if (weights == "sample_size") {
      weights <- vapply(
        lapply(x, `[[`, "metadata"), `[[`, FUN.VALUE = numeric(1), "sample_size"
      )
      weights <- weights / sum(weights)
      if (anyNA(weights)) {
        warning(
          "Input distributions ", toString(which(is.na(weights))),
          " have been dropped because they don't report sample size.",
          call. = FALSE
        )
        x <- x[!is.na(weights)]
        if (length(x) == 0) {
          stop("No input distributions have sample sizes.", call. = FALSE)
        }
      }
    } else if (weights == "unweighted") {
      weights <- rep(1, times = length(x))
    }
  }

  method <- match.arg(method)

  if (method == "linear-OP") {
    pooled_pdf <- sapply(domain, function(y) {
      sum(sapply(seq_along(x), function(i) {
        weights[i] * density(x[[i]], y)
      }))
    })
  } else if (method == "log-OP") {
    pooled_pdf <- sapply(domain, function(y) {
      prod(sapply(seq_along(x), function(i) {
        density(x[[i]], y)^weights[i]
      }))
    })
  } else if (method == "sampling") {
    n_samples <- round(n_samples * weights) * length(weights)
    weighted_samples <- unlist(lapply(
      seq_along(x),
      function(i, x, n_samples) generate(x[[i]], times = n_samples[i]),
      x = x,
      n_samples = n_samples
    ))
    # TODO remove chkDots to allow passing `...` to density()
    pooled_pdf <- density(weighted_samples, ...)$y
  } else if (method == "mean_params") {
    stopifnot(
      "All <epiparameter> object must be parameterised to use `method = 'mean_params'`" =
        all(is_parameterised(ebola_si))
    )
    params <- get_parameters(x)
    fam <- vapply(x, family, FUN.VALUE = character(1))
    stopifnot(
      "Probability distribution must be the same across all <epiparameter>s" =
        length(unique(fam)) == 1,
      "Parameterisation must be the same across all <epiparameter>s" =
        length(unique(lapply(params, names))) == 1 &&
        length(unique(lengths(params))) == 1
    )
    params_matrix <- do.call(rbind, params)
    mean_params <- colMeans(params_matrix)
    pooled_prob_dist <- create_prob_dist(
      prob_dist = fam[1],
      prob_dist_params = mean_params
    )
  } else if (method == "mean_summary_stats") {
    # For this method, we need:
    # * one central estimate (converted to mean)
    # * one estimate of population level variability (converted to sd)

    # TODO: OPEN QUESTION:
    # * What precise summary stats can be converted to a central estimate with reasonable assumptions?
    # * What precise summary stats can be converted to an estimate of population level variability with reasonable assumptions?
    # In other words, what pair of summary stats to we accept for this method?

    # Answer: Let the user decide via the`allowed_pairs` argument

    # TODO Homogeneize all `allowed_pairs` by converting everything to `mean` and `sd`

    summary_stats <- lapply(x, `[[`, "summary_stats")
    mean <- mean(vapply(summary_stats, `[[`, FUN.VALUE = numeric(1), "mean"))
    sd <- mean(vapply(summary_stats, `[[`, FUN.VALUE = numeric(1), "sd"))
    pooled_summary_stats <- create_summary_stats(mean = mean, sd = sd)
  }

  #   warning(
  #     "Some estimates have been dropped because they don't report a ",
  #     "central estimate and population level variability estimate as ",
  #     "specified in `allowed_pairs`"
  #   )

  # FUN.VALUE is <bibentry>, easier to get from x than use bibentry() constructor
  citations <- lapply(x, `[[`, "citation")
  notes <- paste(
    "This is an aggregated distribution using", length(x), "<epiparameter>",
    "objects. The citation for each input <epiparameter> can be found in",
    "$citation."
  )

  # This kind of methods loses population-level variability information.
  # We can now only get the central estimate and uncertainty around this central estimate
  ep <- epiparameter(
    disease = disease,
    pathogen = pathogen,
    epi_dist = epi_dist,
    #prob_distribution = NULL,
    #prob_distribution_params = NULL,
    citation = Reduce(f = c, x = citations),
    summary_stats = list(
      mean = synthesised_estimate,
      mean_ci_limits = c(lower_bound, upper_bound),
      mean_ci = c(value1, value2)
    ),
    notes = notes
  )
  if (method == "mean_params") {
    ep$prob_dist <- pooled_prob_dist
  } else if (method == "mean_summary_stats") {
    ep$summary_stats <- pooled_summary_stats
  }

  # return <epiparameter>
  ep
}
