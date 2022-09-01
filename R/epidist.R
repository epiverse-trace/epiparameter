#' Parameter probability mass function
#'
#' Parameter probability distribution by day
#' @param pathogen A \code{character} specifying pathogen of interest
#' @param pathogen A \code{character} specifying type of parameter: "incubation", "onset_to_admission", "onset_to_death"
#' @param study A \code{character} specifying dataset to use. Defaults to study with largest sample size.
#' @keywords incubation
#' @export
#' @examples
#' epidist()

epidist  <- function(pathogen, type, study = NULL){
  
  # DEBUG
  # pathogen="SARS1"; type="incubation"; study=NULL; pmf = T
  
  # Extract pathogen and parameter type
  pick_path <- epiparameter:::param_vals %>% dplyr::filter(pathogen_ID==pathogen & type_ID==type)  
  
  if(nrow(pick_path)==0){stop("Need to select pathogen and distribution in the dataset")}
  
  # Extract study or default to largest sample size
  if( is.null(study) ){pick_study <- pick_path %>% dplyr::filter(size==max(size))}
  if(!is.null(study) ){pick_study <- pick_path %>% dplyr::filter(study_ID==study)}

  # Define distribution
  if(pick_study$distribution=="lnorm"){
    param_vector <- c(meanlog = pick_study$meanlog, sdlog = pick_study$sdlog)
    cdf_function <- function(x){plnorm(x,meanlog = pick_study$meanlog,sdlog = pick_study$sdlog)}
    pmf_function <- function(x){cdf_function(x+1)-cdf_function(x)} 
    pdf_function <- function(x){dlnorm(x,meanlog = pick_study$meanlog,sdlog = pick_study$sdlog)} 
  }
  
  if(pick_study$distribution=="gamma"){
    param_vector <- c(shape = pick_study$shape,scale = pick_study$scale)
    cdf_function <- function(x){pgamma(x,shape = pick_study$shape,scale = pick_study$scale)}
    pmf_function <- function(x){cdf_function(x+1)-cdf_function(x)} 
    pdf_function <- function(x){dgamma(x,shape = pick_study$shape,scale = pick_study$scale)} 
  }
  
  if(pick_study$distribution=="weibull"){
    param_vector <- c(shape = pick_study$shape,scale = pick_study$scale)
    cdf_function <- function(x){pweibull(x,shape = pick_study$shape,scale = pick_study$scale)}
    pmf_function <- function(x){cdf_function(x+1)-cdf_function(x)} 
    pdf_function <- function(x){dweibull(x,shape = pick_study$shape,scale = pick_study$scale)} 
  }
  
  out <- list(pathogen = pathogen,
              dist = pick_study$distribution,
              type = type,
              param = param_vector,
              pmf = pmf_function,
              pdf = pdf_function,
              cdf = cdf_function)
  
  class(out) <- "epidist"
  out
  
}

##' @export
print.epidist <- function(x, ...){

  cat(sprintf("Pathogen: %s\n", x$pathogen))
  cat(sprintf("Type: %s\n", x$type))
  cat(sprintf("Distribution: %s\n", x$dist))
  p_vals <- x$param
  cat(sprintf("Parameters:\n"))
  cat(sprintf("  %s: %s\n",names(p_vals),as.character(p_vals)))

  invisible(x)
}


