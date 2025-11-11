# Specify reported summary statistics

A helper function when creating an `<epiparameter>` object to create a
summary statistics list with sensible defaults, type checking and
arguments to help remember which summary statistics can be accepted in
the list.

## Usage

``` r
create_summary_stats(
  mean = NA_real_,
  mean_ci_limits = c(NA_real_, NA_real_),
  mean_ci = NA_real_,
  sd = NA_real_,
  sd_ci_limits = c(NA_real_, NA_real_),
  sd_ci = NA_real_,
  median = NA_real_,
  median_ci_limits = c(NA_real_, NA_real_),
  median_ci = NA_real_,
  dispersion = NA_real_,
  dispersion_ci_limits = c(NA_real_, NA_real_),
  dispersion_ci = NA_real_,
  lower_range = NA_real_,
  upper_range = NA_real_,
  quantiles = NA_real_
)
```

## Arguments

- mean:

  A `numeric` of the mean (expectation) of the probability distribution.

- mean_ci_limits:

  A `numeric` vector of length two of the confidence interval around the
  mean.

- mean_ci:

  A `numeric` specifying the confidence interval width, e.g. `95` would
  be the 95% CI

- sd:

  A `numeric` of the standard deviation of the probability distribution.

- sd_ci_limits:

  A `numeric` vector of length 2 of the confidence interval around the
  standard deviation.

- sd_ci:

  A `numeric` specifying the confidence interval width, e.g. `95` would
  be 95% confidence interval.

- median:

  A `numeric` of the median of the probability distribution.

- median_ci_limits:

  A `numeric` vector of length two of the confidence interval around the
  median.

- median_ci:

  A `numeric` specifying the confidence interval width of the median.

- dispersion:

  A `numeric` of the dispersion of the probability distribution.
  **Important** this is the dispersion for probability distributions
  that are not usually parameterised by a dispersion parameter, for
  example a lognormal distribution. If a probability distribution is
  usually parameterised with a dispersion parameter, e.g. negative
  binomial distribution, then this should be considered a parameter and
  not a summary statistic and should go in the `prob_distribution`
  argument when constructing an `<epiparameter>` object with
  [`epiparameter()`](https://epiverse-trace.github.io/epiparameter/dev/reference/epiparameter.md)
  (see
  [`create_prob_distribution()`](https://epiverse-trace.github.io/epiparameter/dev/reference/create_prob_distribution.md)).

- dispersion_ci_limits:

  A `numeric` vector of length 2 of the confidence interval around the
  dispersion.

- dispersion_ci:

  A `numeric` specifying the confidence interval width, e.g. `95` would
  be 95% confidence interval.

- lower_range:

  The lower range of the data, used to infer the parameters of the
  distribution when not provided.

- upper_range:

  The upper range of the data, used to infer the parameters of the
  distribution when not provided.

- quantiles:

  A `numeric` vector of the quantiles for the distribution. If quantiles
  are not provided a default empty vector with the 2.5th, 5th, 25th,
  75th, 95th, 97.5th quantiles are supplied.

## Value

A list of summary statistics. The output list has element names equal to
the function arguments:

    $mean
    $mean_ci_limits
    $mean_ci
    $sd
    $sd_ci_limits
    $sd_ci
    $median
    $median_ci_limits
    $median_ci
    $dispersion
    $dispersion_ci_limits
    $dispersion_ci
    $lower_range
    $upper_range
    $quantiles

## Examples

``` r
# mean and standard deviation
create_summary_stats(mean = 5, sd = 2)
#> $mean
#> [1] 5
#> 
#> $mean_ci_limits
#> [1] NA NA
#> 
#> $mean_ci
#> [1] NA
#> 
#> $sd
#> [1] 2
#> 
#> $sd_ci_limits
#> [1] NA NA
#> 
#> $sd_ci
#> [1] NA
#> 
#> $median
#> [1] NA
#> 
#> $median_ci_limits
#> [1] NA NA
#> 
#> $median_ci
#> [1] NA
#> 
#> $dispersion
#> [1] NA
#> 
#> $dispersion_ci_limits
#> [1] NA NA
#> 
#> $dispersion_ci
#> [1] NA
#> 
#> $quantiles
#> [1] NA
#> 
#> $range
#> [1] NA NA
#> 

# mean and standard deviation with uncertainty
create_summary_stats(
  mean = 4,
  mean_ci_limits = c(2.1, 5.7),
  mean_ci = 95,
  sd = 0.7,
  sd_ci_limits = c(0.3, 1.1),
  sd_ci = 95
)
#> $mean
#> [1] 4
#> 
#> $mean_ci_limits
#> [1] 2.1 5.7
#> 
#> $mean_ci
#> [1] 95
#> 
#> $sd
#> [1] 0.7
#> 
#> $sd_ci_limits
#> [1] 0.3 1.1
#> 
#> $sd_ci
#> [1] 95
#> 
#> $median
#> [1] NA
#> 
#> $median_ci_limits
#> [1] NA NA
#> 
#> $median_ci
#> [1] NA
#> 
#> $dispersion
#> [1] NA
#> 
#> $dispersion_ci_limits
#> [1] NA NA
#> 
#> $dispersion_ci
#> [1] NA
#> 
#> $quantiles
#> [1] NA
#> 
#> $range
#> [1] NA NA
#> 

# median and range
create_summary_stats(
  median = 5,
  lower_range = 1,
  upper_range = 13
)
#> $mean
#> [1] NA
#> 
#> $mean_ci_limits
#> [1] NA NA
#> 
#> $mean_ci
#> [1] NA
#> 
#> $sd
#> [1] NA
#> 
#> $sd_ci_limits
#> [1] NA NA
#> 
#> $sd_ci
#> [1] NA
#> 
#> $median
#> [1] 5
#> 
#> $median_ci_limits
#> [1] NA NA
#> 
#> $median_ci
#> [1] NA
#> 
#> $dispersion
#> [1] NA
#> 
#> $dispersion_ci_limits
#> [1] NA NA
#> 
#> $dispersion_ci
#> [1] NA
#> 
#> $quantiles
#> [1] NA
#> 
#> $range
#> [1]  1 13
#> 
```
