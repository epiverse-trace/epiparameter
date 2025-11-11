# Convert the summary statistics of a distribution to parameters

Convert the summary statistics for a range of distributions to the
distribution's parameters. Most summary statistics are calculated
analytically given the parameters. An exception is the Weibull
distribution which uses a root finding numerical method.

## Usage

``` r
convert_summary_stats_to_params(x, ...)

# S3 method for class 'character'
convert_summary_stats_to_params(
  x = c("lnorm", "gamma", "weibull", "nbinom", "geom"),
  ...
)

# S3 method for class 'epiparameter'
convert_summary_stats_to_params(x, ...)
```

## Arguments

- x:

  An R object.

- ...:

  \<[`dynamic-dots`](https://rlang.r-lib.org/reference/dyn-dots.html)\>
  `Numeric` named summary statistics used to convert to parameter(s). An
  example is the `mean` and `sd` summary statistics for the lognormal
  (`lnorm`) distribution.

## Value

A list of either one or two elements (depending on how many parameters
the distribution has).

## Details

Summary statistics should be named accordingly (case-sensitive):

- mean: `mean`

- median: `median`

- mode: `mode`

- variance: `var`

- standard deviation: `sd`

- coefficient of variation: `cv`

- skewness: `skewness`

- excess kurtosis: `ex_kurtosis`

**Note**: Not all combinations of summary statistics can be converted
into distribution parameters. In this case the function will error
stating that the parameters cannot be calculated from the given input.

The distribution names and parameter names follow the style of
distributions in R, for example the lognormal distribution is `lnorm`,
and its parameters are `meanlog` and `sdlog`.

## See also

[`convert_params_to_summary_stats()`](https://epiverse-trace.github.io/epiparameter/dev/reference/convert_params_to_summary_stats.md)

## Examples

``` r
# examples using characters
convert_summary_stats_to_params("lnorm", mean = 1, sd = 1)
#> $meanlog
#> [1] -0.3465736
#> 
#> $sdlog
#> [1] 0.8325546
#> 
convert_summary_stats_to_params("weibull", mean = 2, var = 2)
#> Numerical approximation used, results may be unreliable.
#> $shape
#> [1] 1.435521
#> 
#> $scale
#> [1] 2.202641
#> 
convert_summary_stats_to_params("geom", mean = 2)
#> $prob
#> [1] 0.3333333
#> 

# examples using <epiparameter>
epiparameter <- epiparameter_db(single_epiparameter = TRUE)
#> Using Linton N, Kobayashi T, Yang Y, Hayashi K, Akhmetzhanov A, Jung S, Yuan
#> B, Kinoshita R, Nishiura H (2020). “Incubation Period and Other
#> Epidemiological Characteristics of 2019 Novel Coronavirus Infections
#> with Right Truncation: A Statistical Analysis of Publicly Available
#> Case Data.” _Journal of Clinical Medicine_. doi:10.3390/jcm9020538
#> <https://doi.org/10.3390/jcm9020538>.. 
#> To retrieve the citation use the 'get_citation' function
convert_summary_stats_to_params(epiparameter)
#> $meanlog
#> [1] 0.9466094
#> 
#> $sdlog
#> [1] 1.628199
#> 

# example using <epiparameter> and specifying summary stats
epiparameter$summary_stats <- list()
convert_summary_stats_to_params(epiparameter, mean = 10, sd = 2)
#> $meanlog
#> [1] 2.282975
#> 
#> $sdlog
#> [1] 0.1980422
#> 
```
