# Convert summary statistics to parameters of the Weibull distribution

Convert summary statistics input into the shape and scale parameters of
the Weibull distribution.

## Usage

``` r
.convert_summary_stats_weibull(...)
```

## Arguments

- ...:

  \<[`dynamic-dots`](https://rlang.r-lib.org/reference/dyn-dots.html)\>
  `Numeric` named summary statistics used to convert to parameter(s). An
  example is the `mean` and `sd` summary statistics for the lognormal
  (`lnorm`) distribution.

## Value

A list of two elements, the shape and scale.
