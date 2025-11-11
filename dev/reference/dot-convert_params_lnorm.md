# Converts the parameters of the lognormal distribution to summary statistics

Converts the meanlog and sdlog parameters of the lognormal distribution
to a number of summary statistics which can be calculated analytically
given the lognormal parameters.

## Usage

``` r
.convert_params_lnorm(...)
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
