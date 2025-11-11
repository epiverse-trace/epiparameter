# Calculate the quantiles of a probability distribution based on the vector of probabilities and time data (e.g. time since infection)

This function can be used in cases where the data on a fitted
distribution is not openly available and the summary statistics of the
distribution are not reported so the data are scraped from the plot and
the quantiles are needed in order use the
[`extract_param()`](https://epiverse-trace.github.io/epiparameter/dev/reference/extract_param.md)
function.

## Usage

``` r
calc_disc_dist_quantile(prob, days, quantile)
```

## Arguments

- prob:

  A `numeric` vector of probabilities.

- days:

  A `numeric` vector of days.

- quantile:

  A single `numeric` or vector of `numerics` specifying which quantiles
  to extract from the distribution.

## Value

A named vector of quantiles.

## Examples

``` r
prob <- dgamma(seq(0, 10, length.out = 21), shape = 2, scale = 2)
days <- seq(0, 10, 0.5)
quantiles <- c(0.025, 0.975)
calc_disc_dist_quantile(prob = prob, days = days, quantile = quantiles)
#> 0.025 0.975 
#>     0     9 
```
