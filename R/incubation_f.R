#' Incubation period
#'
#' Incubation period probability distribution (i.e. exposure-to-onset by day)
#' @param pathogen A \code{character} specifying pathogen of interest
#' @param study A \code{character} specifying dataset to use. Defaults to study with largest sample size.
#' @param pmf A \code{logical} specifying whether to output probability mass function (\code{TRUE}) or cumulative mass function (\code{FALSE}). Defaults to \code{TRUE}.
#' @keywords incubation
#' @export
#' @examples
#' incubation_f()

incubation_f <- function(pathogen,study = NULL, pmf = T){
  
  # DEBUG
  # pathogen="influenza_H7N9"; study=NULL; pmf = T
  
  #inc_vals <- load("data/inc_params.rds")
  
  # Extract pathogen
  pick_path <- incubation_vals %>% filter(pathogen_ID==pathogen)
  
  # Extract study or default to largest sample size
  if( is.null(study) ){pick_study <- pick_path %>% filter(size==max(size))}
  if(!is.null(study) ){pick_study <- pick_path %>% filter(study_ID==study)}

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

# incubation_mers <- incubation_f(pathogen="influenza_H7N9", study=NULL, pmf = F)
