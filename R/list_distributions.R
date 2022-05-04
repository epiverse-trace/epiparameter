#' List distributions
#'
#' List distributions included in package
#' @param type A \code{character} defining parameter to be listed
#' @keywords distributions
#' @export
#' @examples
#' list_distributions()

list_distributions <- function(type="incubation"){
  
  if(type=="incubation"){
    output <- incubation_vals %>% select(pathogen_ID,study_ID,year,size,distribution)
  }
  output
  
}
