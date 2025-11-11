# Function for extracting distribution parameters

Set of functions that can be used to estimate the parameters of a
distribution (lognormal, gamma, Weibull, normal) via optimisation from
either the percentiles or the median and ranges.

## Usage

``` r
.fit_range(param, val, dist = c("lnorm", "gamma", "weibull", "norm"))

.fit_percentiles(param, val, dist = c("lnorm", "gamma", "weibull", "norm"))
```

## Arguments

- param:

  Named `numeric` vector of the distribution parameters to be optimised.

- val:

  `Numeric` vector, in the case of using percentiles it contains the
  values at the percentiles and the percentiles, in the case of median
  and range it contains the median, lower range, upper range and the
  number of sample points to evaluate the function at.

- dist:

  A `character` string with the name of the distribution for fitting.
  Naming follows the base R distribution names (e.g. `lnorm` for
  lognormal).

## Author

Adam Kucharski, Joshua W. Lambert
