# Convert parameters of the Weibull distribution to summary statistics

Convert the shape and scale parameters of the Weibull distribution to a
number of summary statistics which can be calculated analytically given
the Weibull parameters. Note the conversion uses the
[`gamma()`](https://rdrr.io/r/base/Special.html) function.

## Usage

``` r
.convert_params_weibull(...)
```

## Arguments

- ...:

  \<[`dynamic-dots`](https://rlang.r-lib.org/reference/dyn-dots.html)\>
  `Numeric` named parameter(s) used to convert to summary statistics. An
  example is the `meanlog` and `sdlog` parameters of the lognormal
  (`lnorm`) distribution.

## Value

A list of eight elements including: mean, median, mode, variance
(`var`), standard deviation (`sd`), coefficient of variation (`cv`),
skewness, and excess kurtosis (`ex_kurtosis`).
