# Parameter extraction and conversion in {epiparameter}

The reporting of parameters of distributions in the epidemiological
literature is varied. In some instances the parameters themselves will
be given, in others, summary statistics of the distribution are
provided, such as mean, standard deviation, variance, among others.

When working with epidemiological parameters it can be useful to have
the values of the parameters for common parameterisations of the
distribution. For example, shape and scale parameters for the gamma and
Weibull distribution, and the meanlog and sdlog parameters for the
lognormal distribution.

In {epiparameter} we provide a range of conversion and extraction
functions in order to obtain distribution parameters from summary
statistics and vice versa.

Here we differentiate between conversion and extraction as what can be
analytically converted, as conversions, and those that require
optimisation as extraction. This vignette aims to describe the
functionality of these conversions and extractions provided by the
{epiparameter} package.

### Conversion versus extraction

Use conversion when possible over extraction to avoid possible
limitations associated with numerical optimisation used in the
extraction function
[`extract_param()`](https://epiverse-trace.github.io/epiparameter/dev/reference/extract_param.md).

``` r
library(epiparameter)
```

## Conversions

There are two conversion functions in {epiparameter}:
[`convert_params_to_summary_stats()`](https://epiverse-trace.github.io/epiparameter/dev/reference/convert_params_to_summary_stats.md)
and
[`convert_summary_stats_to_params()`](https://epiverse-trace.github.io/epiparameter/dev/reference/convert_summary_stats_to_params.md).
[`convert_params_to_summary_stats()`](https://epiverse-trace.github.io/epiparameter/dev/reference/convert_params_to_summary_stats.md)
converts one set of statistical distribution parameters to common
summary statistics, and
[`convert_summary_stats_to_params()`](https://epiverse-trace.github.io/epiparameter/dev/reference/convert_summary_stats_to_params.md)
converts summary statistics to a set of parameters.

### Conversion functions

The conversion functions can take two types of inputs as the first
argument: a `character` string of the distribution or an
`<epiparameter>` object.

The conversion functions have two arguments. The first (`x`) defines
which distribution you want to use and the second (`...`) lets you put
as many named parameters or summary statistics as required. The
arguments passed into `...` are matched by name, and therefore need to
match exactly to the names expected. See the function documentation
([`?convert_params_to_summary_stats`](https://epiverse-trace.github.io/epiparameter/dev/reference/convert_params_to_summary_stats.md)
and
[`?convert_summary_stats_to_params`](https://epiverse-trace.github.io/epiparameter/dev/reference/convert_summary_stats_to_params.md)
for names). In the case that an `<epiparameter>` object is supplied, if
it has the parameters or summary statistics required for conversion then
nothing needs to be given as extra arguments (i.e. `...`).

All currently supported summary statistic conversions in {epiparameter}
are given below for each distribution.

#### Gamma distribution

#### Using a `character` string to name distribution

``` r
convert_params_to_summary_stats("gamma", shape = 2.5, scale = 1.5)
#> $mean
#> [1] 3.75
#> 
#> $median
#> [1] 1.450487
#> 
#> $mode
#> [1] 2.25
#> 
#> $var
#> [1] 5.625
#> 
#> $sd
#> [1] 2.371708
#> 
#> $cv
#> [1] 0.6324555
#> 
#> $skewness
#> [1] 1.264911
#> 
#> $ex_kurtosis
#> [1] 2.4
```

``` r
convert_summary_stats_to_params("gamma", mean = 2, sd = 2)
#> $shape
#> [1] 1
#> 
#> $scale
#> [1] 2
convert_summary_stats_to_params("gamma", mean = 2, var = 2)
#> $shape
#> [1] 2
#> 
#> $scale
#> [1] 1
convert_summary_stats_to_params("gamma", mean = 2, cv = 2)
#> $shape
#> [1] 0.25
#> 
#> $scale
#> [1] 8
```

#### Using an `<epiparameter>`

An example with parameters provided by `<epiparameter>`

``` r
ep <- epiparameter(
  disease = "<Disease name>",
  pathogen = "<Pathogen name>",
  epi_name = "<Epidemilogical Distribution name>",
  prob_distribution = create_prob_distribution(
    prob_distribution = "gamma",
    prob_distribution_params = c(shape = 2.5, scale = 1.5)
  )
)
#> Citation cannot be created as author, year, journal or title is missing
convert_params_to_summary_stats(ep)
#> $mean
#> [1] 3.75
#> 
#> $median
#> [1] 1.450487
#> 
#> $mode
#> [1] 2.25
#> 
#> $var
#> [1] 5.625
#> 
#> $sd
#> [1] 2.371708
#> 
#> $cv
#> [1] 0.6324555
#> 
#> $skewness
#> [1] 1.264911
#> 
#> $ex_kurtosis
#> [1] 2.4
```

An example with `<epiparameter>` missing parameters and supplied through
`...`

``` r
ep <- epiparameter(
  disease = "<Disease name>",
  pathogen = "<Pathogen name>",
  epi_name = "<Epidemilogical Distribution name>",
  prob_distribution = "gamma"
)
#> Citation cannot be created as author, year, journal or title is missing
#> No adequate summary statistics available to calculate the parameters of the gamma distribution
#> Unparameterised <epiparameter> object
convert_params_to_summary_stats(ep, shape = 2.5, scale = 1.5)
#> $mean
#> [1] 3.75
#> 
#> $median
#> [1] 1.450487
#> 
#> $mode
#> [1] 2.25
#> 
#> $var
#> [1] 5.625
#> 
#> $sd
#> [1] 2.371708
#> 
#> $cv
#> [1] 0.6324555
#> 
#> $skewness
#> [1] 1.264911
#> 
#> $ex_kurtosis
#> [1] 2.4
```

An example with summary statistics provided by `<epiparameter>`

``` r
ep <- epiparameter(
  disease = "<Disease name>",
  pathogen = "<Pathogen name>",
  epi_name = "<Epidemilogical Distribution name>",
  prob_distribution = "gamma",
  summary_stats = create_summary_stats(mean = 3.75, sd = 2.37)
)
#> Citation cannot be created as author, year, journal or title is missing
#> Parameterising the probability distribution with the summary statistics.
#>  Probability distribution is assumed not to be discretised or truncated.
convert_summary_stats_to_params(ep)
#> $shape
#> [1] 2.503605
#> 
#> $scale
#> [1] 1.49784
```

An example with `<epiparameter>` missing summary statistics and supplied
through `...`

``` r
ep <- epiparameter(
  disease = "<Disease name>",
  pathogen = "<Pathogen name>",
  epi_name = "<Epidemilogical Distribution name>",
  prob_distribution = "gamma"
)
#> Citation cannot be created as author, year, journal or title is missing
#> No adequate summary statistics available to calculate the parameters of the gamma distribution
#> Unparameterised <epiparameter> object
convert_summary_stats_to_params(ep, mean = 3.75, sd = 2.37)
#> $shape
#> [1] 2.503605
#> 
#> $scale
#> [1] 1.49784
```

The usage of `<epiparameter>` is not repeated for every distribution
conversion available in {epiparameter}. The conversions shown below for
each distribution are also available when using an `<epiparameter>`
object, by either having the parameters or summary statistics stored in
the `<epiparameter>` or supplied via named arguments.

#### Lognormal distribution

``` r
convert_params_to_summary_stats("lnorm", meanlog = 2.5, sdlog = 1.5)
#> $mean
#> [1] 37.52472
#> 
#> $median
#> [1] 12.18249
#> 
#> $mode
#> [1] 1.284025
#> 
#> $var
#> [1] 11951.62
#> 
#> $sd
#> [1] 109.3235
#> 
#> $cv
#> [1] 2.913372
#> 
#> $skewness
#> [1] 33.46805
#> 
#> $ex_kurtosis
#> [1] 10075.25
```

``` r
convert_summary_stats_to_params("lnorm", mean = 2, sd = 2)
#> $meanlog
#> [1] 0.3465736
#> 
#> $sdlog
#> [1] 0.8325546
convert_summary_stats_to_params("lnorm", mean = 2, var = 2)
#> $meanlog
#> [1] 0.4904146
#> 
#> $sdlog
#> [1] 0.6367614
convert_summary_stats_to_params("lnorm", mean = 2, cv = 2)
#> $meanlog
#> [1] -0.1115718
#> 
#> $sdlog
#> [1] 1.268636
convert_summary_stats_to_params("lnorm", median = 2, sd = 2)
#> $meanlog
#> [1] 0.3465736
#> 
#> $sdlog
#> [1] 0.8325546
convert_summary_stats_to_params("lnorm", median = 2, var = 2)
#> $meanlog
#> [1] 0.4904146
#> 
#> $sdlog
#> [1] 0.6367614
```

#### Weibull distribution

``` r
convert_params_to_summary_stats("weibull", shape = 2.5, scale = 1.5)
#> $mean
#> [1] 1.330896
#> 
#> $median
#> [1] 1.295452
#> 
#> $mode
#> [1] 1.22279
#> 
#> $var
#> [1] 0.3243301
#> 
#> $sd
#> [1] 0.5694998
#> 
#> $cv
#> [1] 0.4279072
#> 
#> $skewness
#> [1] 0.3586318
#> 
#> $ex_kurtosis
#> [1] -0.1432169
```

``` r
convert_summary_stats_to_params("weibull", mean = 2, sd = 2)
#> Numerical approximation used, results may be unreliable.
#> $shape
#> [1] 1.000016
#> 
#> $scale
#> [1] 2.000014
convert_summary_stats_to_params("weibull", mean = 2, var = 2)
#> Numerical approximation used, results may be unreliable.
#> $shape
#> [1] 1.435521
#> 
#> $scale
#> [1] 2.202641
convert_summary_stats_to_params("weibull", mean = 2, cv = 2)
#> Numerical approximation used, results may be unreliable.
#> $shape
#> [1] 0.5427068
#> 
#> $scale
#> [1] 1.150547
```

#### Negative binomial distribution

``` r
convert_params_to_summary_stats("nbinom", prob = 0.5, dispersion = 0.5)
#> $mean
#> [1] 0.5
#> 
#> $median
#> [1] 0
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
#> [1] 2
#> 
#> $skewness
#> [1] 3
#> 
#> $ex_kurtosis
#> [1] 12.25
```

``` r
convert_summary_stats_to_params("nbinom", mean = 1, sd = 1)
#> $prob
#> [1] 1
#> 
#> $dispersion
#> [1] Inf
convert_summary_stats_to_params("nbinom", mean = 1, var = 1)
#> $prob
#> [1] 1
#> 
#> $dispersion
#> [1] Inf
convert_summary_stats_to_params("nbinom", mean = 1, cv = 1)
#> $prob
#> [1] 1
#> 
#> $dispersion
#> [1] Inf
```

#### Geometric distribution

``` r
convert_params_to_summary_stats("geom", prob = 0.5)
#> $mean
#> [1] 1
#> 
#> $median
#> [1] 0
#> 
#> $mode
#> [1] 0
#> 
#> $var
#> [1] 2
#> 
#> $sd
#> [1] 1.414214
#> 
#> $cv
#> [1] 1.414214
#> 
#> $skewness
#> [1] 2.12132
#> 
#> $ex_kurtosis
#> [1] 6.5
```

``` r
convert_summary_stats_to_params("geom", mean = 1)
#> $prob
#> [1] 0.5
```

## Extraction

There are two methods of extraction implemented in {epiparameter}. One
is to estimate the parameters given the values of two percentiles, and
the other is to estimate the parameters given the median and the range
of the data. Both of these extractions are implemented in the
[`extract_param()`](https://epiverse-trace.github.io/epiparameter/dev/reference/extract_param.md)
function.

Here we demonstrate extraction using percentiles. The `type` should be
`"percentiles"`, the `values` are the values reported at the
percentiles, given as a vector. The percentiles, given between 0 and 1,
are specified as a vector in `percentiles`. The example below uses
values 1 and 10 at the 2.5th and 97.5th percentile, respectively.

``` r
extract_param(
  type = "percentiles",
  values = c(1, 10),
  distribution = "gamma",
  percentiles = c(0.025, 0.975)
)
#> Stochastic numerical optimisation used. 
#> Rerun function multiple times to check global optimum is found
#>    shape    scale 
#> 3.358202 1.284186
```

In the above example we estimate parameters of the gamma distribution,
but extraction is also implemented for the lognormal, normal and Weibull
distributions, but specifying `"lnorm"`, `"norm"` or `"weibull"`.

A message is shown when running
[`extract_param()`](https://epiverse-trace.github.io/epiparameter/dev/reference/extract_param.md)
to make the user aware that the estimates are not completely reliable
due to the use of numerical optimisation. Rerunning the function to and
finding the same parameters are returned indicates that they have
successfully converged. This issue is mostly overcome by the internal
setup of the
[`extract_param()`](https://epiverse-trace.github.io/epiparameter/dev/reference/extract_param.md)
function which searches for convergence to consistent parameter
estimates before returning these to the user.

The alternative extraction, by median and range, can be achieved by
specifying `type = "range"` and using the `samples` argument instead of
the `percentiles` argument. When using `type = "percentiles"` the
`samples` argument is ignored and when using `type = "range"` the
`percentiles` argument is ignored.

``` r
extract_param(
  type = "range",
  values = c(10, 5, 15),
  distribution = "lnorm",
  samples = 25
)
#> Stochastic numerical optimisation used. 
#> Rerun function multiple times to check global optimum is found
#>  meanlog    sdlog 
#> 2.302584 3.939920
```

In the above section it was mentioned that
[`extract_param()`](https://epiverse-trace.github.io/epiparameter/dev/reference/extract_param.md)
has an internal mechanism to check that the parameters have consistently
converged to the same estimates over several optimisation iterations.
The tolerance of this convergence and number of times the optimisation
can be repeated is specified in the `control` argument of
[`extract_param()`](https://epiverse-trace.github.io/epiparameter/dev/reference/extract_param.md).
This is set by default (`tolerance = 1e-5` and `max_iter = 1000`), and
thus does not need to be specified by the user (as shown in the above
examples). In the case that the maximum number of optimisation
iterations is reached, the calculation terminates returning the most
recent optimisation result to the user along with a warning message.

``` r
# set seed to ensure warning is produced
set.seed(1)

# lower maximum iteration to show warning
extract_param(
  type = "range",
  values = c(10, 1, 25),
  distribution = "lnorm",
  samples = 100,
  control = list(max_iter = 100)
)
#> Warning: Maximum optimisation iterations reached, returning result early. 
#> Result may not be reliable.
#> Stochastic numerical optimisation used. 
#> Rerun function multiple times to check global optimum is found
#>   meanlog     sdlog 
#> 2.3025851 0.7942061
```

The reasoning for the default maximum number of iterations is to limit
the computation time and prevent the function cycling through
optimisation routines without converging on a consistent answer. If the
runtime is not important and parameter accuracy is paramount then the
maximum number of iterations can be increased and tolerance decreased.
These `control` settings work identically for extracting from
percentiles or median and range.

### Use cases

Here we present examples of published epidemiological parameters and
distributions where the functions outlined above can be applied to get
the parameters of the distribution.

The 75th percentiles reported for a lognormal distribution from Nolen et
al. ([2016](#ref-nolenExtendedHumantoHumanTransmission2016)) for the
incubation period for mpox (monkeypox).

``` r
# Mpox lnorm from 75th percentiles in WHO data
extract_param(
  type = "percentiles",
  values = c(6, 13),
  distribution = "lnorm",
  percentiles = c(0.125, 0.875)
)
#> Stochastic numerical optimisation used. 
#> Rerun function multiple times to check global optimum is found
#>   meanlog     sdlog 
#> 2.1783544 0.3360684
```

The median and range are provided by Thornhill et al.
([2022](#ref-thornhillMonkeypoxVirusInfection2022)) for mpox, and we
want to calculate the parameters of a lognormal distribution.

``` r
# Mpox lnorm from median and range in 2022:
extract_param(
  type = "range",
  values = c(7, 3, 20),
  distribution = "lnorm",
  samples = 23
)
#> Stochastic numerical optimisation used. 
#> Rerun function multiple times to check global optimum is found
#>  meanlog    sdlog 
#> 1.945910 4.735285
```

### Assuming distributions

It can be the case that a study will report summary statistics for an
unspecified distribution or just for the raw data. In these cases if a
parameterised distribution is required for downstream analysis a
functional, parametric, form may have to be assumed.

If the distribution is a delay distribution (i.e. serial interval or
incubation period) it can often be sensible to assume a right-skewed
distribution such as: gamma, lognormal or Weibull distributions. These
are also the most commonly fit distributions in epidemiological analysis
of delay distributions.

However, one should take care when assuming a distribution as this may
drastically influence the interpretation and application of the
epidemiological parameters.

Donnelly et al.
([2003](#ref-donnellyEpidemiologicalDeterminantsSpread2003)) provides
the mean and variance of the gamma distribution for the incubation
period of SARS. This conversion can be achieved by using the general
conversion function
([`convert_summary_stats_to_params()`](https://epiverse-trace.github.io/epiparameter/dev/reference/convert_summary_stats_to_params.md)).

``` r
# SARS gamma mean and var to shape and scale
convert_summary_stats_to_params("gamma", mean = 6.37, var = 16.7)
#> $shape
#> [1] 2.429754
#> 
#> $scale
#> [1] 2.621664
```

## References

Donnelly, Christl A, Azra C Ghani, Gabriel M Leung, Anthony J Hedley,
Christophe Fraser, Steven Riley, Laith J Abu-Raddad, et al. 2003.
“Epidemiological Determinants of Spread of Causal Agent of Severe Acute
Respiratory Syndrome in Hong Kong.” *The Lancet* 361 (9371): 1761–66.
<https://doi.org/10.1016/S0140-6736(03)13410-1>.

Nolen, Leisha Diane, Lynda Osadebe, Jacques Katomba, Jacques Likofata,
Daniel Mukadi, Benjamin Monroe, Jeffrey Doty, et al. 2016. “Extended
Human-to-Human Transmission During a Monkeypox Outbreak in the
Democratic Republic of the Congo.” *Emerging Infectious Diseases* 22
(6): 1014–21. <https://doi.org/10.3201/eid2206.150579>.

Thornhill, John P., Sapha Barkati, Sharon Walmsley, Juergen Rockstroh,
Andrea Antinori, Luke B. Harrison, Romain Palich, et al. 2022.
“Monkeypox Virus Infection in Humans Across 16 Countries — April–June
2022.” *New England Journal of Medicine* 387 (8): 679–91.
<https://doi.org/10.1056/NEJMoa2207323>.
