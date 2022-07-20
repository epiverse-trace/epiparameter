#' Extract parameters
#'
#' Extract parameters from summary data (e.g. in meta analysis)
#' @param type A \code{character} defining whether summary statistics based around \code{median} and 95% quantile (default) or \code{mean} and variance.
#' @param values A \code{vector} with two elements. If \code{type=median}: c(median, upper quantile); and if \code{type=mean}: c(mean, variance)
#' @param distribution A \code{character} specifying distribution to use. Default is \code{lognormal}; also takes \code{gamma} and \code{weibull}.
#' @param percentiles A \code{vector} with two elements specifying the quantiles to compare to if using \code{type="median"}.
#' @keywords extract
#' @export
#' @examples
#' extract_param()

extract_param <- function(type="median",
                          values,
                          distribution,
                          percentiles=c(0.5,0.95)){ # percentile range
  
  # DEBUG:
  # type = "median"; values = c(5.9,21.4); distribution = "lnorm"; percentiles = c(0.025,0.975)
  
  # Validate inputs
  #if(type=="median" & length(values)!=3){stop("Need 'values' to be vector length 3")}
  if(length(values)!=2){stop("Need 'values' to be vector length 2")}

  # Extract distribution parameters using optimisation for specific distribution
  param = c(a = 2, b = 0.5) # CHECK: numerical stability
  values_in <- c(values,q1 = percentiles[1], q2 = percentiles[2])
  
  if(distribution == "lnorm"){
    result2 = optim(param, fit_function_lnorm, method="L-BFGS-B", val=values_in, lower=c(-1,0))
  }
  if(distribution == "gamma"){
    result2 = optim(param, fit_function_gamma, method="L-BFGS-B", val=values_in, lower=c(-1,0))
  }
  if(distribution == "weibull"){
    result2 = optim(param, fit_function_weibull, method="L-BFGS-B", val=values_in, lower=c(-1,0))
  }

  # Output parameters
  result2$par
  
}

#' @rdname fit_function_lnorm
fit_function_lnorm <- function(param, val) {

  (plnorm(val[1], meanlog = param[["a"]],sdlog = param[["b"]]) - val[["q1"]])^2 + (plnorm(val[2], meanlog = param[["a"]],sdlog = param[["b"]]) - val[["q2"]])^2
  
}

#' @rdname fit_function_gamma
fit_function_gamma <- function(param, val) {
  
  (pgamma(val[1], shape = param[["a"]],scale = param[["b"]]) - val[["q1"]])^2 + (pgamma(val[2], shape = param[["a"]],scale = param[["b"]]) - val[["q2"]])^2
  
}

#' @rdname fit_function_weibull
fit_function_weibull <- function(param, val) {
  
  (pweibull(val[1], shape = param[["a"]],scale = param[["b"]]) - val[["q1"]])^2 + (pweibull(val[2], shape = param[["a"]],scale = param[["b"]]) - val[["q2"]])^2
  
}

# TO DO - add function to fit to raw data?

