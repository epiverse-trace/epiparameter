#' Reads in parameter library from ***grEPI*** and formats data to <epiparameter>
#'
#' @inheritParams epiparameter_db
#'
#' @return `<multi_epiparameter>` object (i.e. a list of `<epiparameter>` with
#' nicer printing)
#' @keywords internal
#' @noRd
.read_grepi <- function(disease,
                        pathogen,
                        epi_name,
                        author,
                        subset,
                        single_epiparameter) {

  if (!is.null(author)) {
    warning(
      "Subsetting the grEPI database by `author` is not yet implemented. \n",
      "Returning all studies that match disease/pathogen and epidemiological ",
      "parameter",
      call. = FALSE
    )
  }
  if (!is.null(subset)) {
    warning(
      "Subsetting the grEPI database using `subset` is not yet implemented. \n",
      "Returning all studies that match disease/pathogen and epidemiological ",
      "parameter",
      call. = FALSE
    )
  }
  if (single_epiparameter) {
    warning(
      "`single_epiparameter` is not yet implemented for the grEPI database. \n",
      "Returning all studies that match disease/pathogen and epidemiological ",
      "parameter",
      call. = FALSE
    )
  }

  req <- httr2::request(
    "https://collaboratory.who.int/grepi/api/EpiParameterEstimates"
  )
  if (!identical(disease, "all")) {
    req <- httr2::req_url_query(req, Disease_Name_Preferred = disease)
  }
  if (!identical(pathogen, "all")) {
    req <- httr2::req_url_query(req, pathogen_Species_Name_Preferred = pathogen)
  }

  message("Loading epidemiological parameters from grEPI...")
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
    stop(
      "No grEPI entries could be converted to <epiparameter> objects.",
      call. = FALSE
    )
  }
  grepi_params <- httr2::resp_body_json(resp, simplifyVector = TRUE)
  if (!is.data.frame(grepi_params) || nrow(grepi_params) == 0L) {
    stop(
      "No grEPI entries could be converted to <epiparameter> objects.",
      call. = FALSE
    )
  }

  # epi_name is filtered locally: the grEPI API ignores the
  # epiParameter_Estimate_Type query parameter
  # matched case-insensitively against either the
  # broad Estimate_Type category (e.g. "Human Delay") or the specific Subtype
  # (e.g. "Incubation period").
  if (!identical(epi_name, "all")) {
    en <- .clean_string(epi_name)
    grepi_types <- c(
      tolower(grepi_params$epiParameter_Estimate_Type),
      tolower(grepi_params$epiParameter_Estimate_Subtype)
    )
    tryCatch(
      {
        en <- match.arg(
          arg = en,
          choices = unique(grepi_types),
          several.ok = FALSE
        )
      },
      error = function(cnd) {
        msg <- character(0)
        if (disease  != "all") msg <- c(msg, cli::style_bold(disease))
        if (pathogen != "all") msg <- c(msg, cli::style_bold(pathogen))
        msg_str <- paste(msg, collapse = " & ")

        if (epi_name != "all" && length(msg) > 0L) {
          stop(
            cli::style_bold(epi_name), " not available for ",
            msg_str, " in the grEPI database. \n Please check the spelling of ",
            "the disease/pathogen and epiparameter name.", # nolint
            "\n", cli::symbol$info, " If the epidemiological parameter name ",
            "partially matches multiple \n parameter types in the grEPI ",
            "database please specify the full name.",
            call. = FALSE
          )
        } else if (epi_name != "all") {
          stop(
            cli::style_bold(epi_name),
            " not available in the database grEPI. \n Please ",
            "check the spelling of the epiparameter name.",
            "\n", cli::symbol$info, " If the epidemiological parameter name ",
            "partially matches multiple \n parameter types in the grEPI ",
            "database please specify the full name.",
            call. = FALSE
          )
        } else {
          stop(
            msg_str, " not found as a disease/pathogen in the grEPI database. ",
            "\n Please check the spelling of the disease/pathogen name.", # nolint
            call. = FALSE
          )
        }
      }
    )
    keep <- tolower(grepi_params$epiParameter_Estimate_Type) == en |
            tolower(grepi_params$epiParameter_Estimate_Subtype) == en
    keep[is.na(keep)] <- FALSE
    grepi_params <- grepi_params[keep, , drop = FALSE]
    if (nrow(grepi_params) == 0L) {
      stop(
        "No grEPI entries could be converted to <epiparameter> objects.",
        call. = FALSE
      )
    }
  }
  ep_list <- lapply(
    seq_len(nrow(grepi_params)),
    function(i) .grepi_to_epiparameter(grepi_params[i, , drop = FALSE])
  )
  ep_list <- Filter(Negate(is.null), ep_list)
  if (length(ep_list) == 0L) {
    stop(
      "No grEPI entries could be converted to <epiparameter> objects.",
      call. = FALSE
    )
  }
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
    if (!isTRUE(x$epiParameter_Distribution_Parameter1_IsValueAvailable) ||
        !isTRUE(x$epiParameter_Distribution_Parameter2_IsValueAvailable)) {
      warning("Skipping grEPI record ", x$grEPI_ID, ": ", dist_raw,
              " distribution declared but parameter values not available",
              call. = FALSE)
      return(NULL)
    }
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
    summary_stats <- create_summary_stats()
  } else if (x$epiParameter_Estimate_IsPoint) {
    # Unparameterised entry: encode the typed point value as a summary stat
    # rather than fabricating a degenerate distribution.
    prob_distribution <- create_prob_distribution(
      prob_distribution = NA_character_
    )
    uncertainty <- list(uncertainty = create_uncertainty())
    pv <- x$epiParameter_Estimate_Point_Value
    is_ci <- isTRUE(grepl("Confidence|Credible",
                          x$epiParameter_Uncertainty_Value_Type %||% ""))
    ci <- if (is_ci) c(x$epiParameter_Uncertainty_Range_Lower_Bound_Value,
                       x$epiParameter_Uncertainty_Range_Upper_Bound_Value)
          else c(NA_real_, NA_real_)
    ci_level <- if (is_ci) 95 else NA_real_
    # Range comes from either Uncertainty_Range_* (when UT=Range) or from the
    # parallel Estimate_Range_* field grEPI also carries.
    range_src <- if (identical(x$epiParameter_Uncertainty_Value_Type, "Range"))
      c(x$epiParameter_Uncertainty_Range_Lower_Bound_Value %||% NA_real_,
        x$epiParameter_Uncertainty_Range_Upper_Bound_Value %||% NA_real_)
    else c(x$epiParameter_Estimate_Range_Lower_Bound_Value %||% NA_real_,
           x$epiParameter_Estimate_Range_Upper_Bound_Value %||% NA_real_)
    summary_stats <- switch(
      as.character(x$epiParameter_Estimate_Value_Type),
      "Mean" = create_summary_stats(
        mean = pv, mean_ci_limits = ci, mean_ci = ci_level
      ),
      "Median" = create_summary_stats(
        median = pv, median_ci_limits = ci, median_ci = ci_level
      ),
      "Standard deviation (SD)" = create_summary_stats(
        sd = pv, sd_ci_limits = ci, sd_ci = ci_level
      ),
      create_summary_stats()
    )
    summary_stats$range <- range_src
  } else {
    warning("Skipping grEPI record ", x$grEPI_ID,
            ": unsupported distribution and not a point estimate",
            call. = FALSE)
    return(NULL)
  }

  # Drop empty (all-NA) summary_stats slots so format.epiparameter() doesn't
  # print uninformative "NA" lines, matching the epiparameterDB convention.
  summary_stats <- Filter(function(x) !all(is.na(x)), summary_stats)

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
    summary_stats = summary_stats,
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
    ),
    auto_calc_params = FALSE
  )
}
