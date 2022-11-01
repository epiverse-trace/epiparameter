#' Provides information on the delay distributions for a specific pathogen
#' stored in the `epiparameter` library.
#'
#' @inheritParams epidist
#'
#' @return An instance of a `epidist_tbl` class
#' @export
#'
#' @examples
#' # summary of delay distributions available for ebola
#' pathogen_summary(pathogen = "ebola")
#'
#' # summary of delay distributions available for SARS CoV
#' pathogen_summary(pathogen = "SARS_CoV")
pathogen_summary <- function(pathogen) {

  # read the data to get possible pathogen names
  params <- utils::read.csv(system.file(
    "extdata",
    "parameters.csv",
    package = "epiparameter",
    mustWork = TRUE
  ))
  
  # order params by pathogen, delay dist and study
  params <- params[order(
    tolower(params$pathogen_id), 
    tolower(params$type_id), 
    tolower(params$study_id), 
    method = "radix"
  ), ]

  # match pathogen names against data
  pathogen <- match.arg(
    arg = pathogen,
    choices = unique(params$pathogen_id),
    several.ok = FALSE
  )

  # filter based on pathogen
  params <- params[params$pathogen_id == pathogen, ]

  mean_sd <- apply(params, 1, FUN = function(x) {
    if (x[["distribution"]] == "gamma") {
      parameters <- gamma_shapescale2meansd(
        shape = as.numeric(x[["shape"]]),
        scale = as.numeric(x[["scale"]])
      )
    } else if (x[["distribution"]] == "lnorm") {
      parameters <- lnorm_musigma2meansd(
        mu = as.numeric(x[["meanlog"]]),
        sigma = as.numeric(x[["sdlog"]])
      )
    } else if (x[["distribution"]] == "weibull") {
      parameters <- weibull_shapescale2meansd(
        shape = as.numeric(x[["shape"]]), 
        scale = as.numeric(x[["scale"]])
      )
    }
    parameters
  })

  mean_sd <- lapply(mean_sd, unlist)

  mean_sd_df <- data.frame(
    matrix(
      unlist(mean_sd),
      nrow = length(mean_sd),
      byrow = TRUE
    )
  )

  pathogen_tbl <- data.frame(
    params$pathogen_id,
    params$type_id,
    params$distribution,
    mean_sd_df,
    params$study_id,
    params$DOI
  )
  colnames(pathogen_tbl) <- c(
    "pathogen", "delay_dist", "distribution", "mean", "sd", "study", "DOI"
  )

  pathogen_tbl
}
