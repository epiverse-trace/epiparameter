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

list_distributions <- function(
    delay_dist = c("incubation",
                   "onset_to_admission",
                   "onset_to_death",
                   "serial_interval",
                   "generation_time"),
    parameters = FALSE) {

  delay_dist <- match.arg(arg = delay_dist, several.ok = FALSE)

  # Extract relevant values
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

  # filter by delay distribution
  params <- params[params$type_id == delay_dist, ]

  if (parameters == TRUE) {
    output <- params
  }
  if (parameters == FALSE) {
    # return only the important columns
    output <- params[, c(
      "pathogen_id", "study_id", "year", "size", "distribution"
    )]
  }
  output
}
