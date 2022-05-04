#' Extract parameters
#'
#' Extract parameters from summary data (e.g. in meta analysis)
#' @param type A \code{character} defining whether summary statistics based around \code{median} and 95% CI (default) or \code{mean} and variance.
#' @param values A \code{vector} with two elements. If \code{type=median}: c(median, upper 75% CI); and if \code{type=mean}: c(mean, variance)
#' @param distribution A \code{character} specifying distribution to use. Default is \code{lognormal}; also takes \code{gamma}. 
#' @keywords extract
#' @export
#' @examples
#' extract_param()

extract_param <- function(type,values,distribution){
  
  # DEBUG:
  # type = "median"; values = c(0.6,0.7); distribution = "lnorm"
  
  # Validate inputs
  #if(type=="median" & length(values)!=3){stop("Need 'values' to be vector length 3")}
  if(length(values)!=2){stop("Need 'values' to be vector length 2")}

  # Extract distribution parameters using optimisation
  param = c(a = 1, b = 1)
  result2 = optim(param, fit_function, method="L-BFGS-B", val=values, lower=c(-1,0), hessian=FALSE) #, control=list(trace=1))
  
  # Output parameters
  result2$par
  
}

#' @rdname fit_function
fit_function <- function(param, val) {

  (plnorm(val[1], meanlog = param[["a"]],sdlog = param[["b"]]) - 0.5)^2 + (plnorm(val[2], meanlog = param[["a"]],sdlog = param[["b"]]) - 0.75)^2
  
}

# TO DO - add function to fit to raw data?

