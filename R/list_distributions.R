#' List distributions
#'
#' List distributions included in package
#' @keywords distributions
#' @export
#' @examples
#' list_distributions()

list_distributions <- function(){
  
  output <- incubation_vals %>% select(pathogen_ID,study_ID,year,size,distribution)
  output
  
}
