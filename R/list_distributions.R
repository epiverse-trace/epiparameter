#' List distributions
#'
#' List distributions included in package
#' @param type A \code{character} defining parameter to be listed
#' @param parameters A \code{logical} defining whether to show parameter values
#' @keywords distributions
#' @export
#' @examples
#' list_distributions()

list_distributions <- function(type="incubation",parameters=F){
  
  if(type=="incubation"){
    show_values <- incubation_vals
  }
  
  if(parameters==T){ output <- show_values}
  if(parameters==F){ output <- show_values  %>% select(pathogen_ID,study_ID,year,size,distribution)}
  
  output
  
}
