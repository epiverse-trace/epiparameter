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

  pathogen <- match.arg(
    arg = pathogen,
    choices = c(
      "adenovirus", "ebola", "human_CoV", "influenza_A_seasonal",
      "influenza_B_seasonal", "influenza_H1N1p", "influenza_H7N9", "marburg",
      "measles", "MERS_CoV", "parainfluenza", "rhinovirus", "RSV", "SARS_CoV",
      "SARS_CoV_2_wildtype", "monkeypox"
    ),
    several.ok = FALSE
  )

  # Extract pathogen and parameter type
  pathogen_data <- utils::read.csv(file = system.file(
    "extdata",
    "parameters.csv",
    package = "epiparameter",
    mustWork = TRUE
  ))

  # filter based on pathogen
  pathogen_data <- pathogen_data[pathogen_data$pathogen_id == pathogen, ]

  mean_sd <- apply(pathogen_data, 1, FUN = function(x) {
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
    pathogen_data$pathogen_id,
    pathogen_data$type_id,
    pathogen_data$distribution,
    mean_sd_df,
    pathogen_data$study_id,
    pathogen_data$DOI
  )
  colnames(pathogen_tbl) <- c(
    "pathogen", "delay_dist", "distribution", "mean", "sd", "study", "DOI"
  )

  pathogen_tbl
}
