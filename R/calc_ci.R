#' Calculates the parametric bootstrap confidence intervals for a data set 
#' simulated under a known probability distribution and parameters
#'
#' @param data A numeric vector 
#' @param distribution A character string, either "lnorm", "gamma", or "weibull"
#' @param params The parameters of the distribution
#' @param summary_stat A character string, either "mean", "median", "sd"
#' @param n_boot A numeric specifying the number of bootstrap iterations
#' @param ci A numeric specifying the confidence interval to calculate
#' @param out_bootci A boolean determining whether the `bootci` class is 
#' returned from the function or just a named vector with the confidence 
#' intervals
#'
#' @return Numeric vector by default, or `bootci` object when `out_bootci` is 
#' `TRUE`
#' @export
#'
#' @examples
#' dat <- rgamma(n = 100, shape = 1.5, scale = 1)
#' calc_ci(
#'   data = dat, 
#'   distribution = "gamma", 
#'   params = c(1.5, 1), 
#'   summary_stat = "mean", 
#'   n_boot = 1000, 
#'   ci = 0.95
#' )
calc_ci <- function(data,
                    distribution = c("lnorm", "gamma", "weibull"),
                    params,
                    summary_stat = c("mean", "median", "sd"),
                    n_boot = 1000,
                    ci = 0.95,
                    out_bootci = FALSE) {
  
  # function to generate random variables
  rand <- function(data, mle) {
    do.call(
      paste0("r", distribution), 
      list(n = length(data), shape = params[1], scale = params[2])
    )
  }
  
  # function to calculate bootstrap statistic
  if (summary_stat == "mean") {
    stat_func <- function(data) {
      mean(data)
    }  
  } else if (summary_stat == "median") {
    stat_func <- function(data) {
      stats::median(data)
    }
  } else if (summary_stat == "sd") {
    stat_func <- function(data) {
      stats::sd(data)
    }
  }
  
  # bootstrapping
  boot_samples <- boot::boot(
    data = data,
    statistic = stat_func,
    R = n_boot,
    sim = "parametric",
    ran.gen = rand,
    mle = params
  )
  
  # calculate confidence intervals
  boot_ci <- boot::boot.ci(
    boot.out = boot_samples,
    conf = ci,
    type = "norm"
  )
  
  # return bootstrap confidence intervals
  if (out_bootci) {
    boot_ci
  } else {
    out <- (boot_ci$normal[1, c(2, 3)])
    ci_names <- as.character(c(0 + ((1 - ci) / 2), 1 - ((1 - ci) / 2)))
    names(out) <- ci_names
    out
  }
}