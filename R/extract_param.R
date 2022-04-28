#' Extract parameters
#'
#' Extract parameters from summary data (e.g. in meta analysis)
#' @param type A \code{character} defining whether summary statistics based around \code{median} and 95% CI (default) or \code{mean} and variance.
#' @param values A \code{vector} with three elements if \code{type=median}: c(median, lower 25% CI, upper 75% CI); and with two elements if \code{type=mean}: c(mean, variance)
#' @param distribution A \code{character} specifying distribution to use. Default is \code{lognormal}; also takes \code{gamma}. 
#' @keywords extract
#' @export
#' @examples
#' extract_param()

extract_param <- function(type,values,distribution){
  
  # Validate inputs
  if(type=="median" & length(values)!=3){stop("Need 'values' to be vector length 3")}
  if(type=="mean" & length(values)!=2){stop("Need 'values' to be vector length 2")}

  # Extract distribution parameters using optimisation
  
}
