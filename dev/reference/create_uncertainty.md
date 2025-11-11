# Specify distribution parameter uncertainty

A helper function when creating uncertainty for the parameters of the
distribution for the `<epiparameter>` object.

## Usage

``` r
create_uncertainty(ci_limits = NA_real_, ci, ci_type)
```

## Arguments

- ci_limits:

  A numeric vector of length two with the lower and upper bound of the
  confidence interval or credible interval.

- ci:

  A numeric specifying the interval for the ci, e.g. 95 is 95% ci.

- ci_type:

  A character string, either `"confidence interval"` or
  `"credible interval"`.

## Value

List of three elements:

1.  `$ci_limits` is the upper and lower bounds of the CI (either
    confidence interval or credible interval) (i.e. a two element
    numeric vector).

2.  `$ci` the interval (e.g. 95 is 95% CI) given by a single numeric.

3.  `$ci_type` a character string specifying the type of uncertainty
    (can be either `"confidence interval"` or `"credible interval"`).

## Examples

``` r
# example with uncertainty for a single parameter
create_uncertainty(
  ci_limits = c(1, 3),
  ci = 95,
  ci_type = "confidence interval"
)
#> $ci_limits
#> [1] 1 3
#> 
#> $ci
#> [1] 95
#> 
#> $ci_type
#> [1] "confidence interval"
#> 

# example for multiple parameters
# lengh of list should match number of parameters
list(
  shape = create_uncertainty(
    ci_limits = c(1, 3),
    ci = 95,
    ci_type = "confidence interval"
  ),
  scale = create_uncertainty(
    ci_limits = c(2, 4),
    ci = 95,
    ci_type = "confidence interval"
  )
)
#> $shape
#> $shape$ci_limits
#> [1] 1 3
#> 
#> $shape$ci
#> [1] 95
#> 
#> $shape$ci_type
#> [1] "confidence interval"
#> 
#> 
#> $scale
#> $scale$ci_limits
#> [1] 2 4
#> 
#> $scale$ci
#> [1] 95
#> 
#> $scale$ci_type
#> [1] "confidence interval"
#> 
#> 

# example with unknown uncertainty
# the function can be called without arguments
create_uncertainty()
#> $ci_limits
#> [1] NA
#> 
#> $ci
#> [1] NA NA
#> 
#> $ci_type
#> [1] NA
#> 
# or give NA as the first argument
create_uncertainty(NA)
#> $ci_limits
#> [1] NA
#> 
#> $ci
#> [1] NA NA
#> 
#> $ci_type
#> [1] NA
#> 
```
