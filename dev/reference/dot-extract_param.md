# Optimises the parameters for a specified probability distribution given the percentiles of a distribution and the values at those percentiles, or the median and range of a sample and the number of samples.

Optimises the parameters for a specified probability distribution given
the percentiles of a distribution and the values at those percentiles,
or the median and range of a sample and the number of samples.

## Usage

``` r
.extract_param(values, distribution, percentiles, samples)
```

## Arguments

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

## Value

A list with output from
[`stats::optim()`](https://rdrr.io/r/stats/optim.html).
