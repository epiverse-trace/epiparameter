#' List distributions
#'
#' List distributions included in package
#' @param delay_dist A character defining parameter to be listed:
#' `"incubation"`, `"onset_to_admission"`, `"onset_to_death"`, or 
#' `"serial_interval"`
#' @param parameters A logical defining whether to show parameter values,
#' default is `FALSE`
#' @keywords distributions
#' @author Adam Kucharski
#' @export
#' @examples
#' # the default for list_distributions() without any arguments is to return the
#' # incubation period
#' list_distributions()
#'
#' # metrics can be chosen using the `delay_dist` argument, for example
#' # incubation period or onset to death
#' list_distributions(delay_dist = "incubation")
#' list_distributions(delay_dist = "onset_to_death")
#'
#' # by default list_distributions() will return a filtered table, but if the
#' # full table including extra information (e.g. parameters of the
#' # distribution) the `parameters` argument can be set to `TRUE`
#' list_distributions(delay_dist = "onset_to_admission", parameters = TRUE)

list_distributions <- function(delay_dist = "incubation", parameters = FALSE) {

  delay_dist <- match.arg(
    arg = delay_dist, 
    choices = c(
      "incubation", "onset_to_admission", "onset_to_death", "serial_interval"
    ), 
    several.ok = FALSE
  )
  
  type_id <- NULL # remove global variable note
  pathogen_id <- NULL # remove global variable note
  study_id <- NULL # remove global variable note
  year <- NULL # remove global variable note
  size <- NULL # remove global variable note
  distribution <- NULL # remove global variable note

  # Extract relevant values
  show_values <- utils::read.csv(system.file(
    "extdata",
    "parameters.csv",
    package = "epiparameter",
    mustWork = TRUE
  )) 
  
  # filter by delay distribution
  show_values <- show_values[show_values$type_id == delay_dist, ]

  if (parameters == TRUE) {
    output <- show_values
  }
  if (parameters == FALSE) {
    # return only the important columns
    output <- show_values[, c(
      "pathogen_id", "study_id", "year", "size", "distribution"
    )]
  }
  output
}
