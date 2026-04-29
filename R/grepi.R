#' Reads in parameter library from ***grEPI*** and formats data to <epiparameter>
#'
#' @inheritParams epiparameter_db
#'
#' @return `<multi_epiparameter>` object (i.e. a list of `<epiparameter>` with
#' nicer printing)
#' @keywords internal
#' @noRd
.read_grepi <- function(disease = "all", pathogen = "all") {

  req <- httr2::request(
    "https://collaboratory.who.int/grepi/api/EpiParameterEstimates"
  )
  if (!identical(disease, "all")) {
    req <- httr2::req_url_query(req, Disease_Name_Preferred = disease)
  }
  if (!identical(pathogen, "all")) {
    req <- httr2::req_url_query(req, pathogen_Species_Name_Preferred = pathogen)
  }
  resp <- tryCatch(
    httr2::req_perform(req),
    error = function(cnd) {
      warning(
        "Could not reach the grEPI API: ", conditionMessage(cnd),
        call. = FALSE
      )
      NULL
    }
  )
  if (is.null(resp)) {
    return(structure(list(), class = "multi_epiparameter"))
  }
  grepi_params <- httr2::resp_body_json(resp, simplifyVector = TRUE)
  if (!is.data.frame(grepi_params) || nrow(grepi_params) == 0L) {
    return(structure(list(), class = "multi_epiparameter"))
  }
  ep_list <- lapply(
    seq_len(nrow(grepi_params)),
    function(i) .grepi_to_epiparameter(grepi_params[i, , drop = FALSE])
  )
  ep_list <- Filter(Negate(is.null), ep_list)
  structure(ep_list, class = "multi_epiparameter")
}

#' Convert `<data.frame>` from \pkg{grEPI} to `<epiparameter>`
#'
#' @param x A `<data.frame>`.
#' @param ... [dots] Extra arguments to pass to [epiparameter()].
#'
#' @inherit epiparameter return
#' @keywords internal
#' @noRd
.grepi_to_epiparameter <- function(x, ...) {

  # parameterised-distribution support for 2-parameter families. To add a new
  # family, extend dist_lookup; the rest of the branch is family-agnostic.
  dist_lookup <- c(Weibull = "weibull", Gamma = "gamma",
                   "Log-normal" = "lnorm")
  dist_raw <- x$epiParameter_Distribution_Type
  if (!is.null(dist_raw) && !is.na(dist_raw) &&
      dist_raw %in% names(dist_lookup)) {
    dist <- unname(dist_lookup[[dist_raw]])
    prob_distribution_params <- setNames(
      c(x$epiParameter_Distribution_Parameter1_Value,
        x$epiParameter_Distribution_Parameter2_Value),
      tolower(c(x$epiParameter_Distribution_Parameter1_Value_Type,
                x$epiParameter_Distribution_Parameter2_Value_Type))
    )
    # lnorm in grEPI is sometimes parameterised as (mean, variance);
    # convert to the canonical (meanlog, sdlog) via the package's converter.
    if (dist == "lnorm" &&
        setequal(names(prob_distribution_params), c("mean", "variance"))) {
      prob_distribution_params <- unlist(convert_summary_stats_to_params(
        "lnorm",
        mean = prob_distribution_params[["mean"]],
        var = prob_distribution_params[["variance"]]
      ))
    }
    prob_distribution <- create_prob_distribution(
      prob_distribution = dist,
      prob_distribution_params = prob_distribution_params,
      discretise = isTRUE(x$epi_Parameter_Method_Inference_DataIsDiscretised)
    )
    uncertainty <- setNames(
      lapply(seq_along(prob_distribution_params),
             function(.) create_uncertainty()),
      names(prob_distribution_params)
    )
  } else if (x$epiParameter_Estimate_IsPoint) {
    prob_distribution <- create_prob_distribution(
      prob_distribution = "norm",
      prob_distribution_params = c(
        mean = x$epiParameter_Estimate_Point_Value,
        sd = 0
      )
    )
    uncertainty <- list(mean = create_uncertainty(), sd = create_uncertainty())
  } else {
    warning("Skipping grEPI record ", x$grEPI_ID,
            ": unsupported distribution and not a point estimate",
            call. = FALSE)
    return(NULL)
  }

  # format citation
  citation <- suppressMessages(
    create_citation(
      author = as.person(x$article_Authors[[1]]),
      year = x$article_Publication_Year,
      title = x$article_Title,
      journal = x$literature_Source_Name,
      doi = x$article_DOI
    )
  )

  # format epi_name
  subtype <- x$epiParameter_Estimate_Subtype
  subtype[is.na(subtype)] <- ""
  if (subtype == "Other") {
    subtype <- paste(x$epiParameter_EventFrom, "to", x$epiParameter_EventTo)
  }
  epi_name <- trimws(paste(subtype, x$epiParameter_Estimate_Type))

  # handle entries missing Country info
  if (is.null(x$epi_Parameter_Population_Country_list[[1]]$country_Name)) {
    region <- NA_character_
  } else {
    region <- x$epi_Parameter_Population_Country_list[[1]]$country_Name
  }

  # return <epiparameter>
  epiparameter(
    disease = x$disease_Name_Preferred,
    pathogen = x$pathogen_Species_Name_Preferred,
    epi_name = epi_name,
    prob_distribution = prob_distribution,
    uncertainty = uncertainty,
    summary_stats = create_summary_stats(),
    citation = citation,
    metadata = create_metadata(
      units = x$epiParameter_Estimate_Unit,
      sample_size = x$epi_Parameter_Population_Sample_Size,
      inference_method = x$epi_Parameter_Method_Inference,
      region = region,
    ),
    method_assess = create_method_assess(
      censored = x$epi_Parameter_Method_Inference_DataIsCensored,
      right_truncated = x$epi_Parameter_Method_Inference_DataIsTruncated,
      phase_bias_adjusted = x$epi_Parameter_Method_Inference_DataIsBiasAdjusted
    ),
    notes = paste0(
      "Loaded from the ", x$epi_Parameter_DataSource_Name, " (",
      x$epi_Parameter_DataSource_Location, ").",
      "The data was extracted by",
      x$epi_Parameter_Data_ExtractedBy_OrganizationGroup_Name, ".",
      x$epi_Parameter_DataSource_Primary_Import_Comment, ": ",
      x$epi_Parameter_DataSource_Primary_ImportedFrom_Project
    )
  )
}
