#' Parameter probability mass function
#'
#' Parameter probability distribution by day
#' @param pathogen A \code{character} specifying pathogen of interest
#' @param pathogen A \code{character} specifying type of parameter: "incubation", "onset_to_admission", "onset_to_death"
#' @param study A \code{character} specifying dataset to use. Defaults to study with largest sample size.
#' @param pmf A \code{logical} specifying whether to output probability mass function (\code{TRUE}) or cumulative mass function (\code{FALSE}). Defaults to \code{TRUE}.
#' @keywords incubation
#' @export
#' @examples
#' prob_f()

prob_f <- function(pathogen, type, study = NULL, pmf = T){
  
  # DEBUG
  # pathogen="influenza_H7N9"; type="incubation"; study=NULL; pmf = T
  
  # Extract pathogen and parameter type
  pick_path <- param_vals %>% dplyr::filter(pathogen_ID==pathogen & type_ID==type)  

  # Extract study or default to largest sample size
  if( is.null(study) ){pick_study <- pick_path %>% dplyr::filter(size==max(size))}
  if(!is.null(study) ){pick_study <- pick_path %>% dplyr::filter(study_ID==study)}

  # Define distribution
  if(pick_study$distribution=="lnorm"){
    p_function <- function(x){plnorm(x,meanlog = pick_study$meanlog,sdlog = pick_study$sdlog)}
    if(pmf==T){ out_function <- function(x){p_function(x+1)-p_function(x)} }
    if(pmf==F){ out_function <- p_function }
  }
  
  if(pick_study$distribution=="gamma"){
    p_function <- function(x){pgamma(x,shape = pick_study$shape,scale = pick_study$scale)}
    if(pmf==T){ out_function <- function(x){p_function(x+1)-p_function(x)} }
    if(pmf==F){ out_function <- p_function }
  }
  
  out_function
  
}
