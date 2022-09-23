#' Extract parameters
#'
#' Extract parameters from summary data (e.g. in meta analysis)
#' @param type A \code{character} defining whether summary statistics based around \code{percentiles} (default) or \code{range}
#' @param values A \code{vector}. If \code{type=percentiles}: c(percentile_1, percentile_2); and if \code{type=range}: c(median, min, max)
#' @param distribution A \code{character} specifying distribution to use. Default is \code{lnorm}; also takes \code{gamma} and \code{weibull}.
#' @param percentiles A \code{vector} with two elements specifying the percentiles defined in \code{values} if using \code{type="percentiles"}.
#' @param samples A \code{numeric} specifying the sample size if using \code{type="range"}.
#' @keywords extract
#' @export
#' @examples
#' # extract parameters of a lognormal distribution from the 75 percentiles
#' extract_param(
#'   type = "percentiles", 
#'   values = c(6, 13), 
#'   distribution = "lnorm", 
#'   percentiles = c(0.125, 0.875)
#' )
#' 
#' # extract parameters of a gamma distribution from median and range
#' extract_param(
#'   type = "range", 
#'   values = c(8, 6, 13), 
#'   distribution = "gamma", 
#'   samples = 20
#' )
extract_param <- function(type="percentiles",
                          values,
                          distribution="lnorm",
                          percentiles,
                          samples){ 
  
  # DEBUG:
  # type = "range"; values = c(7,3,20); distribution = "lnorm"; samples=20
  
  # Validate inputs
  if(type=="percentiles"){ if(length(values)!=2){stop("Need 'values' to be vector length 2")} }
  if(type=="range"){ if(length(values)!=3){stop("Need 'values' to be vector length 3")} }
  if(type=="percentiles"){ if(length(percentiles)!=2){stop("Need 'percentiles' to be vector length 2")} }
  
  # Percentile extraction
  # Extract distribution parameters using optimisation for specific distribution
  if(type=="percentiles"){
    
    # Set initial values for optimisation
    param = c(a = 2, b = 0.5) # CHECK: numerical stability
    values_in <- c(values,q1 = percentiles[1], q2 = percentiles[2])
    
    if(distribution == "lnorm"){
      result2 = stats::optim(param, fit_function_lnorm, method="L-BFGS-B", val=values_in, lower=c(-1,0))
    }
    if(distribution == "gamma"){
      result2 = stats::optim(param, fit_function_gamma, method="L-BFGS-B", val=values_in, lower=c(-1,0))
    }
    if(distribution == "weibull"){
      result2 = stats::optim(param, fit_function_weibull, method="L-BFGS-B", val=values_in, lower=c(-1,0))
    }
  
  }
  
  # Range extraction
  
  if(type=="range"){
    
    # Set initial values for optimisation
    param = c(a = 2, b = 0.5) # CHECK: numerical stability
    values_in <- c(values,n = samples)
    
    if(distribution == "lnorm"){
      result2 = stats::optim(param, fit_function_lnorm_range, method="L-BFGS-B", val=values_in, lower=c(-1,0))
    }
    if(distribution == "gamma"){
      result2 = stats::optim(param, fit_function_gamma_range, method="L-BFGS-B", val=values_in, lower=c(-1,0))
    }
    if(distribution == "weibull"){
      result2 = stats::optim(param, fit_function_weibull_range, method="L-BFGS-B", val=values_in, lower=c(-1,0))
    }
    
  }

  # Output parameters
  result2$par
  
}

#' @rdname fit_function_lnorm_range
fit_function_lnorm_range <- function(param, val) {
  
  # Median square residual
  median_sr <- (stats::plnorm(val[1], meanlog = param[["a"]],sdlog = param[["b"]]) - 0.5)^2 

  # Probability of obtaining min, max and range:
  min_p <- stats::dlnorm(val[2], meanlog = param[["a"]],sdlog = param[["b"]])
  max_p <- stats::dlnorm(val[3], meanlog = param[["a"]],sdlog = param[["b"]])
  range_p <- (stats::plnorm(val[3], meanlog = param[["a"]],sdlog = param[["b"]]) - stats::plnorm(val[2], meanlog = param[["a"]],sdlog = param[["b"]]))^(val[["n"]]-2)
  
  # Range likelihood
  range_sr <- -(min_p*max_p*range_p)
  
  # Total value to be minimised
  range_sr + median_sr 
  
}

#' @rdname fit_function_gamma_range
fit_function_gamma_range <- function(param, val) {
  
  # Median square residual
  median_sr <- (stats::pgamma(val[1], shape = param[["a"]], scale = param[["b"]]) - 0.5)^2 
  
  # Probability of obtaining min, max and range:
  min_p <- stats::dgamma(val[2], shape = param[["a"]],scale = param[["b"]])
  max_p <- stats::dgamma(val[3], shape = param[["a"]],scale = param[["b"]])
  range_p <- (stats::pgamma(val[3], shape = param[["a"]],scale = param[["b"]]) - stats::pgamma(val[2], shape = param[["a"]],scale = param[["b"]]))^(val[["n"]]-2)
  
  # Range likelihood
  range_sr <- -(min_p*max_p*range_p)
  
  # Total value to be minimised
  range_sr + median_sr 
  
}

#' @rdname fit_function_weibull_range
fit_function_weibull_range <- function(param, val) {
  
  # Median square residual
  median_sr <- (stats::pweibull(val[1], shape = param[["a"]],scale = param[["b"]]) - 0.5)^2 
  
  # Probability of obtaining min, max and range:
  min_p <- stats::dweibull(val[2], shape = param[["a"]],scale = param[["b"]])
  max_p <- stats::dweibull(val[3], shape = param[["a"]],scale = param[["b"]])
  range_p <- (stats::pweibull(val[3], shape = param[["a"]],scale = param[["b"]]) - stats::pweibull(val[2], shape = param[["a"]],scale = param[["b"]]))^(val[["n"]]-2)
  
  # Range likelihood
  range_sr <- -(min_p*max_p*range_p)
  
  # Total value to be minimised
  range_sr + median_sr 
  
}

#' @rdname fit_function_lnorm
fit_function_lnorm <- function(param, val) {

  (stats::plnorm(val[1], meanlog = param[["a"]],sdlog = param[["b"]]) - val[["q1"]])^2 + (stats::plnorm(val[2], meanlog = param[["a"]],sdlog = param[["b"]]) - val[["q2"]])^2
  
}

#' @rdname fit_function_gamma
fit_function_gamma <- function(param, val) {
  
  (stats::pgamma(val[1], shape = param[["a"]],scale = param[["b"]]) - val[["q1"]])^2 + (stats::pgamma(val[2], shape = param[["a"]],scale = param[["b"]]) - val[["q2"]])^2
  
}

#' @rdname fit_function_weibull
fit_function_weibull <- function(param, val) {
  
  (stats::pweibull(val[1], shape = param[["a"]],scale = param[["b"]]) - val[["q1"]])^2 + (stats::pweibull(val[2], shape = param[["a"]],scale = param[["b"]]) - val[["q2"]])^2
  
}


