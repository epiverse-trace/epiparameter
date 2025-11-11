# Convert parameters of the negative binomial distribution to summary statistics

Convert the probability (`prob`) and dispersion parameters of the
negative binomial distribution to a number of summary statistics which
can be calculated analytically given the negative binomial parameters.
One exception is the median which is calculated using
[`qnbinom()`](https://rdrr.io/r/stats/NegBinomial.html) as no analytical
form is available.

The parameters are `prob` and `dispersion` (which is also commonly
represented as *r*).

## Usage

``` r
.convert_params_nbinom(...)
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
skewness, and ex_kurtosis.
