#' Constructor for epidist class
#'
#' @description Create an epidist object and provides input checking. The
#' constructor will search whether parameters of the probability distribution
#' are supplied and if not look to see whether they can be inferred/extracted/
#' converted from summary statistics provided.
#'
#' @param disease A list contains the `$disease` a character string of the
#' infectious disease specified in the study, and the `4pathogen` a character
#' string or NULL of the causative agent of disease specified in study.
#' @param epi_dist A character string with the name of the epidemiological
#' distribution type
#' @param prob_dist A character string specifying the probability distribution
#' @param prob_dist_params A named vector of probability distribution parameters
#' @param uncertainty Either a list of named vectors with the uncertainty around
#' the probability distribution parameters or NULL when uncertainty around the
#' parameter estimates is unknown
#' @param summary_stats A list of summary statistics
#' @param citation A character string with the short form citation
#' @param metadata A list of metadata
#' @param method_assessment A list of methodological aspects assessed
#' @param discretise A boolean logical whether the distribution is discretised.
#' Default is FALSE which assumes a continuous probability distribution
#' @param truncation A numeric specifying the truncation point if the inferred
#' distribution was truncated, NULL if not or unknown.
#' @param notes A character string with additional notes
#' @param auto_calc_params
#'
#' @return epidist object
#' @keywords internal
#'
#' @examples
#' epiparameter:::new_epidist(
#'   disease = list(
#'     disease = "ebola",
#'     pathogen = "ebola_virus"
#'   ),
#'   epi_dist = "incubation_period",
#'   prob_dist = list("gamma"),
#'   prob_dist_params = list(c(shape = 1.4, scale = 0.5)),
#'   uncertainty = NA,
#'   summary_stats = create_epidist_summary_stats(),
#'   metadata = create_epidist_metadata(
#'     sample_size = 83
#'   ),
#'   method_assessment = create_epidist_method_assessment(),
#'   citation = "Smith et al (2010) <10.19832/j.1366-9516.2012.09147.x>",
#'   notes = "No additional notes"
#' )
new_epidist <- function(disease = list(),
                        epi_dist = character(),
                        prob_dist = list(),
                        prob_dist_params = numeric(),
                        uncertainty = list(),
                        summary_stats = list(),
                        citation = character(),
                        metadata = list(),
                        method_assessment = list(),
                        discretise = logical(),
                        truncation = numeric(),
                        notes = character(),
                        auto_calc_params = TRUE) {

  check_epidist_uncertainty(
    prob_dist_params = prob_dist_params,
    uncertainty = uncertainty
  )

  # calculate parameters if not provided
  if (all(is.na(prob_dist_params)) && auto_calc_params) {
    # calculate parameters if not provided
    prob_dist_params <- calc_dist_params(
        prob_dist = prob_dist,
        summary_stats = summary_stats,
        sample_size = metadata$sample_size
      )
  }

  # standardise distribution parameter names
  class(prob_dist_params) <- prob_dist
  prob_dist_params <- clean_epidist_params(
    prob_dist_params = prob_dist_params
  )

  check_epidist_params(
    prob_dist = prob_dist,
    prob_dist_params = prob_dist_params
  )

  # create a S3 object holding the probability distribution
  prob_dist <- create_prob_dist(
    prob_dist = prob_dist,
    prob_dist_params = prob_dist_params,
    discretise = discretise,
    truncation = truncation
  )

  # calculate distribution quantiles and add to epidist
  quants <- c(0.025, 0.05, 0.25, 0.5, 0.75, 0.875, 0.95, 0.975)
  if (isTRUE(discretise)) {
    quantiles <- prob_dist$q(quants)
  } else {
    quantiles <- stats::quantile(prob_dist, quants)[[1]]
  }
  names(quantiles) <- c(
    "q_025",	"q_05",	"q_25",	"q_50", "q_75", "q_875", "q_95", "q_975"
  )
  summary_stats$quantiles <- quantiles

  if (epi_dist == "offspring_distribution") {
    method_assessment <- paste(
      "There is currently no method assessment for offspring distributions",
      "stored in epiparameter"
    )
  }

  if (is.null(notes)) {
    notes <- "No additional notes"
  }

  # create and return epidist class
  structure(
    list(
      disease = disease,
      epi_dist = epi_dist,
      prob_dist = prob_dist,
      uncertainty = uncertainty,
      summary_stats = summary_stats,
      citation = citation,
      metadata = metadata,
      method_assessment = method_assessment,
      notes = notes
    ),
    class = "epidist"
  )
}

#' Create an `epidist` object
#'
#' @description The `epidist` class is used to store epidemiological parameters
#' for a single disease. These epidemiological parameters cover a variety of
#' aspects including delay distributions (e.g. incubation periods and serial
#' intervals, among others) and offspring distributions.
#'
#' @param disease A character string with name of the infectious disease
#' @param pathogen A character string with the name of the causative agent of
#' disease, or NULL if not known
#' @param epi_distribution A character string with the name of the
#' epidemiological distribution type
#' @param prob_distribution A character string specifying the probability
#' distribution
#' @param prob_distribution_params A named vector of probability distribution
#' parameters
#' @param uncertainty Either a list of named vectors with the uncertainty around
#' the probability distribution parameters or NULL when uncertainty around the
#' parameter estimates is unknown
#' @param summary_stats A list of summary statistics
#' @param citation A character string with the citation of the source of the
#' data or the paper that inferred the distribution parameters
#' @param metadata A list of metadata, this can include: sample size, whether
#' the disease is vector-borne, etc. It is assumed that the disease is not
#' vector-borne and that the distribution is intrinsic (e.g. not an extrinsic
#' delay distribution such as extrinsic incubation period) unless
#' `vector_borne = TRUE` is contained in the metadata
#' @param method_assessment A list of methodological aspects assessed
#' @param discretise A boolean logical whether the distribution is discretised.
#' Default is FALSE which assumes a continuous probability distribution
#' @param truncation A numeric specifying the truncation point if the inferred
#' distribution was truncated, NULL if not or unknown.
#' @param notes A character string with any additional information about the
#' data, inference method or disease.
#'
#' @return An `epidist` object
#' @export
#'
#' @examples
#' ebola_incubation <- epidist(
#'   disease = "ebola",
#'   pathogen = "ebola_virus",
#'   epi_distribution = "incubation",
#'   prob_distribution = "gamma",
#'   prob_distribution_params = c(shape = 1, scale = 1),
#'   uncertainty = NA,
#'   summary_stats = create_epidist_summary_stats(
#'     mean = 2,
#'     sd = 1
#'   ),
#'   citation = create_epidist_citation(
#'     author = "Smith_etal",
#'     year = 2010,
#'     DOI = "10.19832/j.1366-9516.2012.09147.x"
#'   ),
#'   metadata = create_epidist_metadata(
#'     sample_size = 10,
#'     region = "UK",
#'     vector_borne = FALSE,
#'     inference_method = "MLE"
#'   ),
#'   method_assessment = create_epidist_method_assessment(
#'     censorred = TRUE
#'   ),
#'   discretise = FALSE,
#'   truncation = NA,
#'   notes = "No notes"
#' )
epidist <- function(disease,
                    pathogen = NA_character_,
                    epi_distribution,
                    prob_distribution = NA_character_,
                    prob_distribution_params = NA_real_,
                    uncertainty = create_epidist_uncertainty(),
                    summary_stats = create_epidist_summary_stats(),
                    citation = create_epidist_citation(),
                    metadata = create_epidist_metadata(),
                    method_assessment = create_epidist_method_assessment(),
                    discretise = FALSE,
                    truncation = NA_real_,
                    notes = NULL) {

  # check input
  checkmate::assert_character(
    disease,
    min.len = 1,
    any.missing = FALSE,
    null.ok = FALSE
  )
  checkmate::assert_character(pathogen)
  checkmate::assert_character(epi_distribution, len = 1)
  checkmate::assert_character(
    prob_distribution,
    min.chars = 1,
    min.len = 1,
    max.len = 2
  )
  checkmate::assert_numeric(
    prob_distribution_params,
    min.len = 1,
    max.len = 2,
    names = "unique",
    null.ok = TRUE
  )
  checkmate::assert_list(
    summary_stats,
    types = c("list", "double", "null"),
    names = "unique"
  )
  checkmate::assert_character(citation, len = 1)
  checkmate::assert_list(metadata)
  checkmate::assert_list(method_assessment)
  checkmate::assert_number(truncation, na.ok = TRUE)
  checkmate::assert_logical(discretise)
  checkmate::assert_character(notes, null.ok = TRUE)

  # check whether ci has been provided for each parameter
  stopifnot(
    "uncertainty must be provided for each parameter" =
      any(is.na(uncertainty)) ||
      length(prob_distribution_params) == length(uncertainty)
  )

  # call epidist constructor
  epidist <- new_epidist(
    disease = list(
      disease = disease,
      pathogen = pathogen
    ),
    epi_dist = epi_distribution,
    prob_dist = prob_distribution,
    prob_dist_params = prob_distribution_params,
    uncertainty = uncertainty,
    summary_stats = summary_stats,
    citation = citation,
    metadata = metadata,
    method_assessment = method_assessment,
    discretise = discretise,
    truncation = truncation,
    notes = notes
  )

  # call epidist validator
  validate_epidist(epidist = epidist)

  # return epidist object
  epidist
}

#' `epidist` class validator
#'
#' @param epidist An `epidist` object
#'
#' @return Nothing, errors when invalid `epidist` object is provided
#' @export
validate_epidist <- function(epidist) {

  if (!inherits(epidist, "epidist")) {
    stop("Object should be of class epidist")
  }

  # check for class invariants
  stopifnot(
    "epidist object does not contain the correct attributes" =
      c("disease", "epi_dist", "prob_dist", "uncertainty", "summary_stats",
        "citation", "metadata", "method_assessment", "notes") %in%
      attributes(epidist)$names
  )

  stopifnot(
    "Epidist must contains a disease (single character string)" =
      is.character(epidist$disease$disease) &&
      length(epidist$disease$disease) == 1
  )

  stopifnot(
    "Epidist must contain an epidemiological distribution" =
      is.character(epidist$epi_dist) && length(epidist$epi_dist) == 1
  )

  invisible(epidist)
}

}

#' @export
print.epidist <- function(x, ...) {

  epi_dist <- clean_epidist_name(x$epi_dist)
  writeLines(
    c(
      sprintf("Epidist object \n"),
      sprintf("Disease: %s", x$disease$disease),
      sprintf("Epi Distribution: %s", epi_dist)
    )
  )
  if (inherits(x$prob_dist[[1]], "distcrete")) {
    writeLines(
      c(
        sprintf("Distribution: discrete %s", x$prob_dist[[1]]$name),
        sprintf("Parameters:"),
        sprintf(
          "  %s: %s",
          names(x$prob_dist[[1]]$parameters),
          as.character(x$prob_dist[[1]]$parameters)
        )
      )
    )
  } else {
    writeLines(
      c(
        sprintf("Distribution: %s", x$prob_dist[[1]]),
        sprintf("Parameters:"),
        sprintf(
          "  %s: %s",
          names(unlist(distributional::parameters(x$prob_dist[[1]]))),
          as.character(unlist(distributional::parameters(x$prob_dist[[1]])))
        )
      )
    )
  }
  if (length(x$prob_dist) == 2) {
    if (inherits(x$prob_dist[[2]], "distcrete")) {
      writeLines(
        c(
          sprintf("Distribution: discrete %s", x$prob_dist[[2]]$name),
          sprintf(
            "  %s: %s",
            names(x$prob_dist[[2]]$parameters),
            as.character(x$prob_dist[[2]]$parameters)
          )
        )
      )
    } else {
      writeLines(
        c(
          sprintf("Extrinsic Distribution: %s", x$prob_dist[[2]]),
          sprintf("Parameters:"),
          sprintf(
            "  %s: %s",
            names(unlist(distributional::parameters(x$prob_dist[[2]]))),
            as.character(unlist(distributional::parameters(x$prob_dist[[2]])))
          )
        )
      )
    }
  }

  invisible(x)
}

#' @export
density <- function(x, ...) UseMethod("density")

#' PDF, CDF, PMF, quantiles and random number generation for epidist objects
#'
#' @description The epidist object holds a probability distribution which can
#' either be a continuous or discrete distribution. These are the density,
#' cumulative distribution, quantile and random number generation functions.
#' These operate on any distribution that can be included in an epidist object.
#'
#' @param x An epidist object
#' @param at The quantiles to evaluate at
#'
#' @rdname epidist_distribution_functions
#'
#' @return Numeric vector
#' @export
density.epidist <- function(x, at, ...) {
  unlist <- ifelse(test = length(x$prob_dist) == 1, yes = TRUE, no = FALSE)
  if (inherits(x$prob_dist[[1]], "distcrete")) {
    out <- lapply(x$prob_dist, function(y, at) { y$d(at) }, at = at)
  } else {
    out <- lapply(x$prob_dist, stats::density, at = at)
  }
  out <- if (unlist) unlist(out, recursive = FALSE) else out
  out
}

#' @export
cdf <- function(x, ...) UseMethod("cdf")

#' @param x An epidist object
#' @param q The quantiles to evaluate at
#' @rdname epidist_distribution_functions
#' @export
cdf.epidist <- function(x, q, ...) {
  unlist <- ifelse(test = length(x$prob_dist) == 1, yes = TRUE, no = FALSE)
  if (inherits(x$prob_dist[[1]], "distcrete")) {
    out <- lapply(x$prob_dist, function(y, q) { y$p(q)}, q = q)
  } else {
    out <- lapply(x$prob_dist, distributional::cdf, q)
  }
  out <- if (unlist) unlist(out, recursive = FALSE) else out
  out
}

#' @export
quantile <- function(x, ...) UseMethod("quantile")

#' @param x An epidist object
#' @param p The probabilities to evaluate at
#' @rdname epidist_distribution_functions
#' @export
quantile.epidist <- function(x, p, ...) {
  unlist <- ifelse(test = length(x$prob_dist) == 1, yes = TRUE, no = FALSE)
  if (inherits(x$prob_dist[[1]], "distcrete")) {
    out <- lapply(x$prob_dist, function(y, p) { y$q(p) }, p = p)
  } else {
    out <- lapply(x$prob_dist, stats::quantile, p)
  }
  out <- if (unlist) unlist(out, recursive = FALSE) else out
  out
}

#' @export
generate <- function(x, ...) UseMethod("generate")

#' @param x An epidist object
#' @param time The number of random samples
#' @rdname epidist_distribution_functions
#' @export
generate.epidist <- function(x, times, ...) {
  if (inherits(x$prob_dist[[1]], "distcrete")) {
    unlist <- ifelse(test = length(x$prob_dist) == 1, yes = TRUE, no = FALSE)
    out <- lapply(
      x$prob_dist, function(y, times) { y$r(n = times) }, times = times
    )
    out <- if (unlist) unlist(out, recursive = FALSE) else out
  } else {
    recursive <- ifelse(test = length(x$prob_dist) == 1, yes = TRUE, no = FALSE)
    out <- unlist(
      lapply(x$prob_dist, distributional::generate, times),
      recursive = recursive
    )
  }
  out
}
