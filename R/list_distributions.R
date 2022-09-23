#' List distributions
#'
#' List distributions included in package
#' @param type A \code{character} defining parameter to be listed: "incubation", "onset_to_admission" or "onset_to_death"
#' @param parameters A \code{logical} defining whether to show parameter values
#' @keywords distributions
#' @export
#' @examples
#' # the default for list_distributions() without any arguments is to return the 
#' # incubation period
#' list_distributions()
#' 
#' # metrics can be chosen using the `type` argument, for example incubation period
#' # or onset to death
#' list_distributions(type = "incubation")
#' list_distributions(type = "onset_to_death")
#' 
#' # by default list_distributions() will return a filtered table, but if the full
#' # table including extra information (e.g. parameters of the distribution) the 
#' # `parameters` argument can be set to `TRUE`
#' list_distributions(type = "onset_to_admission", parameters = TRUE)

list_distributions <- function(type="incubation",parameters=F){
  
  #if(type=="incubation"){ show_values <- incubation_vals }
  #if(type=="onset_to_admission"){ show_values <- onset_to_admission_vals }
  
  # Extract relevant values
  show_values <- read.csv(system.file(
    "extdata", 
    "parameters.csv", 
    package = "epiparameter", 
    mustWork = TRUE
  )) %>% dplyr::filter(type_ID==type)
  
  if(parameters==T){ output <- show_values}
  if(parameters==F){ output <- show_values  %>% dplyr::select(pathogen_ID,study_ID,year,size,distribution)}
  
  output
  
}
