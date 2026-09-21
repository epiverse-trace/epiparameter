# Calculate the parameters of a parametric probability distribution from reported values of percentiles, or median and range

Summary data of distributions, as provided by reports and meta-analyses,
can be used to extract the parameters of a chosen distribution.
Currently available distributions are: lognormal, gamma, Weibull and
normal. Extracting from a lognormal returns the meanlog and sdlog
parameters, extracting from the gamma and Weibull returns the shape and
scale parameters, and extracting from the normal returns the mean and sd
parameters.

## Usage

``` r
extract_param(
  type = c("percentiles", "range"),
  values,
  distribution = c("lnorm", "gamma", "weibull", "norm"),
  percentiles,
  samples,
  control = list(max_iter = 1000, tolerance = 1e-05)
)
```

## Arguments

- type:

  A `character` defining whether summary statistics based around
  `percentiles` (default) or `range`.

- values:

  A `vector`. If `type = percentiles`: `c(percentile_1, percentile_2)`;
  and if `type = range`: `c(median, min, max)`.

- distribution:

  A `character` specifying distribution to use. Default is `lnorm`; also
  takes `gamma`, `weibull` and `norm`.

- percentiles:

  A `vector` with two elements specifying the percentiles defined in
  `values` if using `type = "percentiles"`. Percentiles should be
  specified between 0 and 1. For example 2.5th and 97.5th percentile is
  given as `c(0.025, 0.975)`.

- samples:

  A `numeric` specifying the sample size if using `type = "range"`.

- control:

  A named list containing options for the optimisation. List element
  `$max_iter` is a `numeric` specifying the maximum number of times the
  parameter extraction will run optimisation before returning result
  early. This prevents overly long optimisation loops if optimisation is
  unstable and does not converge over multiple iterations. Default is
  1000 iterations. List element `$tolerance` is passed to
  [`.check_optim_conv()`](https://epiverse-trace.github.io/epiparameter/dev/reference/dot-check_optim_conv.md)
  for tolerance on parameter convergence over iterations of
  optimisation. Elements of in the control list are not passed to
  [`optim()`](https://rdrr.io/r/stats/optim.html).

## Value

A named `numeric` vector with the parameter values of the distribution.
If the `distribution = lnorm` then the parameters returned are the
meanlog and sdlog; if the `distribution = gamma` or
`distribution = weibull` then the parameters returned are the shape and
scale; if `distribution = norm` then the parameters returned are mean
and sd.

## Details

For `gamma`, `lnorm` and `weibull`, `extract_param()` works only for
strictly positive values at the percentiles of a distribution or the
median and range of data (numerics supplied to the `values` argument).
This means that negative values at the lower percentile or lower range
will not work with this function although they may present themselves in
epidemiological data (e.g. negative serial interval). For the `norm`
distribution negative values are allowed.

## Author

Adam Kucharski, Joshua W. Lambert

## Examples

``` r
# set seed to control for stochasticity
set.seed(1)

# extract parameters of a lognormal distribution from the 75 percentiles
extract_param(
  type = "percentiles",
  values = c(6, 13),
  distribution = "lnorm",
  percentiles = c(0.125, 0.875)
)
#> Stochastic numerical optimisation used. 
#> Rerun function multiple times to check global optimum is found
#>   meanlog     sdlog 
#> 2.1783557 0.3360688 

# extract parameters of a gamma distribution from median and range
extract_param(
  type = "range",
  values = c(10, 3, 18),
  distribution = "gamma",
  samples = 20
)
#> Stochastic numerical optimisation used. 
#> Rerun function multiple times to check global optimum is found
#>    shape    scale 
#> 5.342206 1.994304 
```
