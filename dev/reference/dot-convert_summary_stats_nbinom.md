# Convert summary statistics to parameters of the negative binomial distribution

Convert summary statistics of the negative binomial distribution the
parameters (`prob`) and (`dispersion`) of the negative binomial
distribution.

## Usage

``` r
.convert_summary_stats_nbinom(...)
```

## Arguments

- ...:

  \<[`dynamic-dots`](https://rlang.r-lib.org/reference/dyn-dots.html)\>
  `Numeric` named summary statistics used to convert to parameter(s). An
  example is the `mean` and `sd` summary statistics for the lognormal
  (`lnorm`) distribution.

## Value

A list of two elements, the probability and dispersion parameters.
