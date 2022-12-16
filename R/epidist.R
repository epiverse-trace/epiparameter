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
#' @param notes A character string with additional notes
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
#'   uncertainty = NULL,
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
                        notes = character()) {
  # check input
  stopifnot(
    "A disease is required for the epidist class" =
      !is.null(disease$disease)
  )
  checkmate::assert_list(disease, types = c("character", "null"), len = 2)
  checkmate::assert_character(epi_dist, min.chars = 1)
  checkmate::assert_list(prob_dist)
  lapply(
    prob_dist,
    checkmate::assert_character,
    min.chars = 1,
    min.len = 1,
    max.len = 2
  )
  checkmate::assert_list(prob_dist_params)
  lapply(
    prob_dist_params,
    checkmate::assert_numeric,
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
  checkmate::assert_character(citation, min.len = 1)
  checkmate::assert_list(metadata)
  checkmate::assert_list(method_assessment)
  checkmate::assert_character(notes, null.ok = TRUE)

  is_vector_borne <- is_valid_vector_borne(
    prob_dist = prob_dist,
    prob_dist_params = prob_dist_params,
    summary_stats = summary_stats,
    metadata = metadata
  )

  # case when data is specified for vector-borne but not specified in metadata
  if (!isTRUE(metadata$vector_borne) && (length(prob_dist) == 2 ||
      length(prob_dist_params) == 2 || length(summary_stats) == 2)) {
    stop(
      paste("Two distributions or parameter sets specified but",
            "metadata$vector_borne is not set to TRUE"),
      call. = FALSE
    )
  }

  # if is not valid vector borne entry strip data to single distribution
  if (isFALSE(is_vector_borne)) {
    # if vector-borne is true tell user only first distribution is used
    if (isTRUE(metadata$vector_borne)) {
      message(strwrap(
        "Vector-borne disease specified but data entered not suitable for both
        intrinsic and extrinsic distribution. Only first distribution will be
        returned",
        prefix = "\n"
      ))
    }
    prob_dist <- prob_dist[1]
    prob_dist_params <- prob_dist_params[1]
    if (length(summary_stats) == 2) {
      summary_stats <- summary_stats[[1]]
    }
  }

  # calculate parameters if not provided
  for (i in seq_along(prob_dist_params)) {
    if (length(prob_dist_params[[i]]) == 0) {

      # calculate parameters if not provided
      prob_dist_params[[i]] <- calc_dist_params(
        prob_dist = prob_dist[[i]],
        summary_stats = summary_stats[[i]],
        sample_size = metadata$sample_size[i]
      )
    } else {
      # standardise distribution parameter names
      subset_prob_dist_params <- prob_dist_params[[i]]
      class(subset_prob_dist_params) <- prob_dist[[i]]
      prob_dist_params[[i]] <- clean_epidist_params(
        prob_dist_params = subset_prob_dist_params
      )
    }

    # check parameters if provided
    checkmate::assert_numeric(prob_dist_params[[i]], names = "unique")
    stopifnot(
      "distribution parameters must have valid names,
       use possible_epidist_params() to see valid names" =
        is_epidist_params(prob_dist_params[[i]])
    )

    if (isTRUE(discretise)) {
      prob_dist[[i]] <- switch(
        prob_dist[[i]],
        gamma = distcrete::distcrete(
          name = "gamma",
          interval = 1,
          shape = prob_dist_params[[i]][["shape"]],
          scale = prob_dist_params[[i]][["scale"]],
          w = 1
        ),
        lognormal = distcrete::distcrete(
          name = "lnorm",
          interval = 1,
          meanlog = prob_dist_params[[i]][["mu"]],
          sdlog = prob_dist_params[[i]][["sigma"]],
          w = 1
        ),
        weibull = distcrete::distcrete(
          name = "weibull",
          interval = 1,
          shape = prob_dist_params[[i]][["shape"]],
          scale = prob_dist_params[[i]][["scale"]],
          w = 1
        )
      )

    } else {
      # make the probability distribution object
      prob_dist[[i]] <- switch(
        prob_dist[[i]],
        gamma = distributional::dist_gamma(
          shape = prob_dist_params[[i]][["shape"]],
          rate = 1/prob_dist_params[[i]][["scale"]]
        ),
        lognormal = distributional::dist_lognormal(
          mu = prob_dist_params[[i]][["mu"]],
          sigma = prob_dist_params[[i]][["sigma"]]
        ),
        weibull = distributional::dist_weibull(
          shape = prob_dist_params[[i]][["shape"]],
          scale = prob_dist_params[[i]][["scale"]]
        ),
        negative_binomial = distributional::dist_negative_binomial(
          size = prob_dist_params[[i]][["dispersion"]],
          prob = negative_binomial_meandispersion2probdispersion(
            mean = prob_dist_params[[i]][["mean"]],
            dispersion = prob_dist_params[[i]][["dispersion"]]
          )$prob
        ),
        geometric = distributional::dist_geometric(
          prob = unname(prob_dist_params[[i]])
        )
      )
    }



    # TODO: calculate standard deviation from confidence interval

    # TODO: handle parameter uncertainty


    quants <- c(0.025, 0.05, 0.25, 0.5, 0.75, 0.875, 0.95, 0.975)
    if (isTRUE(discretise)) {
      quantiles <- prob_dist[[i]]$q(quants)
    } else {
      quantiles <- quantile(prob_dist[[i]], quants)[[1]]
    }

    names(quantiles) <- c(
      "q_025",	"q_05",	"q_25",	"q_50", "q_75", "q_875", "q_95", "q_975"
    )
    if (length(summary_stats) == 0) {
      summary_stats$quantiles <- quantiles
    } else {
      summary_stats[[i]]$quantiles <- quantiles
    }

  }

  if (is_vector_borne) {
    names(prob_dist) <- names(summary_stats)
  }

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
#'   uncertainty = NULL,
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
#'   truncation = NULL,
#'   notes = "No notes"
#' )
epidist <- function(disease,
                    pathogen = NULL,
                    epi_distribution,
                    prob_distribution = NULL,
                    prob_distribution_params = NULL,
                    uncertainty = NULL,
                    summary_stats = create_epidist_summary_stats(),
                    citation = create_epidist_citation(),
                    metadata = create_epidist_metadata(),
                    method_assessment = create_epidist_method_assessment(),
                    discretise = FALSE,
                    truncation = NULL,
                    notes = NULL) {
  # put prob_distribution and prob_distribution in list if not already
  if (!is.list(prob_distribution)) {
    prob_distribution <- as.list(prob_distribution)
  }

  if (!is.list(prob_distribution_params)) {
    prob_distribution_params <- list(prob_distribution_params)
  }

  # check input
  checkmate::assert_character(disease, min.len = 1)
  checkmate::assert_character(pathogen, null.ok = TRUE)
  checkmate::assert_character(epi_distribution, len = 1)
  checkmate::assert_list(prob_distribution, null.ok = TRUE)
  lapply(
    prob_distribution,
    checkmate::assert_character,
    min.chars = 1,
    min.len = 1,
    max.len = 2
  )
  checkmate::assert_list(prob_distribution_params, null.ok = TRUE)
  lapply(
    prob_distribution_params,
    checkmate::assert_numeric,
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
  checkmate::assert_number(truncation, null.ok = TRUE)
  checkmate::assert_logical(discretise)
  checkmate::assert_character(notes, null.ok = TRUE)

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
      is.character(epidist$disease$disease) && length(epidist$disease$disease) == 1
  )

  stopifnot(
    "Epidist must contain an epidemiological distribution" =
      is.character(epidist$epi_dist) && length(epidist$epi_dist) == 1
  )

  invisible(epidist)

}

#' @export
print.epidist <- function(x, ...) {
  if (length(x$prob_dist) == 2) {
    writeLines(
      c(
        sprintf("Epidist object \n"),
        sprintf("Disease: %s", x$disease$disease),
        sprintf("Epi Distribution: %s", x$epi_dist),
        sprintf("Instrinsic Distribution: %s", x$prob_dist[[1]]),
        sprintf("Extrinsic Distribution: %s", x$prob_dist[[2]])
      )
    )
  } else {
    writeLines(
      c(
        sprintf("Epidist object \n"),
        sprintf("Disease: %s", x$disease$disease),
        sprintf("Epi Distribution: %s", x$epi_dist),
        sprintf("Distribution: %s", x$prob_dist[[1]])
      )
    )
  }

  invisible(x)
}
