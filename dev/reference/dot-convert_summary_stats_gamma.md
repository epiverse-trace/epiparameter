# Convert summary statistics to parameters of the gamma distribution

Convert the summary statistics input into the shape and scale parameters
of the gamma distribution.

## Usage

``` r
.convert_summary_stats_gamma(...)
```

## Arguments

- ...:

  \<[`dynamic-dots`](https://rlang.r-lib.org/reference/dyn-dots.html)\>
  `Numeric` named summary statistics used to convert to parameter(s). An
  example is the `mean` and `sd` summary statistics for the lognormal
  (`lnorm`) distribution.

## Value

A list of two elements, the shape and scale
