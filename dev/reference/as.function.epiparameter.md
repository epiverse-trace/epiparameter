# [`as.function()`](https://rdrr.io/r/base/as.function.html) method for `<epiparameter>` class

Converts an `<epiparameter>` object to a distribution function (see
[epiparameter_distribution_functions](https://epiverse-trace.github.io/epiparameter/dev/reference/epiparameter_distribution_functions.md)),
either probability density/mass function, (`density`), cumulative
distribution function (`cdf`), random number generator (`generate`), or
quantile (`quantile`).

## Usage

``` r
# S3 method for class 'epiparameter'
as.function(x, func_type = c("density", "cdf", "generate", "quantile"), ...)
```

## Arguments

- x:

  An `<epiparameter>` object.

- func_type:

  A single `character` string specifying which distribution to convert
  `<epiparameter>` object into. Default is `"density"`. Other options
  are `"cdf"`, `"generate"`, or `"quantile"`.

- ...:

  [dots](https://rdrr.io/r/base/dots.html) Extra arguments to be passed
  to the method.

## Value

A [function](https://rdrr.io/r/base/function.html) object.

## Details

The function returned takes a single required argument `x`.

## Examples

``` r
ep <- epiparameter_db(single_epiparameter = TRUE)
#> Using Linton N, Kobayashi T, Yang Y, Hayashi K, Akhmetzhanov A, Jung S, Yuan
#> B, Kinoshita R, Nishiura H (2020). “Incubation Period and Other
#> Epidemiological Characteristics of 2019 Novel Coronavirus Infections
#> with Right Truncation: A Statistical Analysis of Publicly Available
#> Case Data.” _Journal of Clinical Medicine_. doi:10.3390/jcm9020538
#> <https://doi.org/10.3390/jcm9020538>.. 
#> To retrieve the citation use the 'get_citation' function
# by default it will convert to a density function
f <- as.function(ep)
# use function
f(10)
#> [1] 0.01732193

f <- as.function(ep, func_type = "cdf")
f(10)
#> [1] 0.7975232
```
