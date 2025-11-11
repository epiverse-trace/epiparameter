# Convert the parameter(s) of a distribution to summary statistics

Convert the parameters for a range of distributions to a number of
summary statistics. All summary statistics are calculated analytically
given the parameters.

## Usage

``` r
convert_params_to_summary_stats(x, ...)

# S3 method for class 'character'
convert_params_to_summary_stats(
  x = c("lnorm", "gamma", "weibull", "nbinom", "geom"),
  ...
)

# S3 method for class 'epiparameter'
convert_params_to_summary_stats(x, ...)
```

## Arguments

- x:

  An R object.

- ...:

  \<[`dynamic-dots`](https://rlang.r-lib.org/reference/dyn-dots.html)\>
  `Numeric` named parameter(s) used to convert to summary statistics. An
  example is the `meanlog` and `sdlog` parameters of the lognormal
  (`lnorm`) distribution.

## Value

A list of eight elements including: mean, median, mode, variance
(`var`), standard deviation (`sd`), coefficient of variation (`cv`),
skewness, and excess kurtosis (`ex_kurtosis`).

## Details

The distribution names and parameter names follow the style of
distributions in R, for example the lognormal distribution is `lnorm`,
and its parameters are `meanlog` and `sdlog`.

## See also

[`convert_summary_stats_to_params()`](https://epiverse-trace.github.io/epiparameter/dev/reference/convert_summary_stats_to_params.md)

## Examples

``` r
# example using characters
convert_params_to_summary_stats("lnorm", meanlog = 1, sdlog = 2)
#> $mean
#> [1] 20.08554
#> 
#> $median
#> [1] 2.718282
#> 
#> $mode
#> [1] 0.04978707
#> 
#> $var
#> [1] 21623.04
#> 
#> $sd
#> [1] 147.0477
#> 
#> $cv
#> [1] 7.321076
#> 
#> $skewness
#> [1] 414.3593
#> 
#> $ex_kurtosis
#> [1] 9220557
#> 
convert_params_to_summary_stats("gamma", shape = 1, scale = 1)
#> $mean
#> [1] 1
#> 
#> $median
#> [1] 0.6931472
#> 
#> $mode
#> [1] 0
#> 
#> $var
#> [1] 1
#> 
#> $sd
#> [1] 1
#> 
#> $cv
#> [1] 1
#> 
#> $skewness
#> [1] 2
#> 
#> $ex_kurtosis
#> [1] 6
#> 
convert_params_to_summary_stats("nbinom", prob = 0.5, dispersion = 2)
#> $mean
#> [1] 2
#> 
#> $median
#> [1] 1
#> 
#> $mode
#> [1] 1
#> 
#> $var
#> [1] 4
#> 
#> $sd
#> [1] 2
#> 
#> $cv
#> [1] 1
#> 
#> $skewness
#> [1] 1.5
#> 
#> $ex_kurtosis
#> [1] 4
#> 

# example using <epiparameter>
epiparameter <- epiparameter_db(single_epiparameter = TRUE)
#> Using Linton N, Kobayashi T, Yang Y, Hayashi K, Akhmetzhanov A, Jung S, Yuan
#> B, Kinoshita R, Nishiura H (2020). “Incubation Period and Other
#> Epidemiological Characteristics of 2019 Novel Coronavirus Infections
#> with Right Truncation: A Statistical Analysis of Publicly Available
#> Case Data.” _Journal of Clinical Medicine_. doi:10.3390/jcm9020538
#> <https://doi.org/10.3390/jcm9020538>.. 
#> To retrieve the citation use the 'get_citation' function
convert_params_to_summary_stats(epiparameter)
#> $mean
#> [1] 9.7
#> 
#> $median
#> [1] 2.576957
#> 
#> $mode
#> [1] 0.1818772
#> 
#> $var
#> [1] 1239.04
#> 
#> $sd
#> [1] 35.2
#> 
#> $cv
#> [1] 3.628866
#> 
#> $skewness
#> [1] 58.67393
#> 
#> $ex_kurtosis
#> [1] 46586.04
#> 

# example using <epiparameter> and specifying parameters
epiparameter <- epiparameter_db(
  disease = "Influenza",
  author = "Virlogeux",
  subset = prob_dist == "weibull"
)
#> Returning 4 results that match the criteria (3 are parameterised). 
#> Use subset to filter by entry variables or single_epiparameter to return a single entry. 
#> To retrieve the citation for each use the 'get_citation' function
convert_params_to_summary_stats(epiparameter[[2]], shape = 1, scale = 1)
#> $mean
#> [1] 1
#> 
#> $median
#> [1] 0.6931472
#> 
#> $mode
#> [1] 0
#> 
#> $var
#> [1] 1
#> 
#> $sd
#> [1] 1
#> 
#> $cv
#> [1] 1
#> 
#> $skewness
#> [1] 2
#> 
#> $ex_kurtosis
#> [1] 6
#> 
```
