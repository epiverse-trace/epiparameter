# Aggregate multiple `<epiparameter>` objects into a single `<epiparameter>` object.

Combine a list of `<epiparameter>` objects into a single
`<epiparameter>` with a mixture distribution \[see
[`distributional::dist_mixture()`](https://pkg.mitchelloharawild.com/distributional/reference/dist_mixture.html)\].

The aggregated `<epiparameter>` returned from
[`aggregate()`](https://rdrr.io/r/stats/aggregate.html) can then be used
with the [`density()`](https://rdrr.io/r/stats/density.html),
[`cdf()`](https://pkg.mitchelloharawild.com/distributional/reference/cdf.html),
[`quantile()`](https://rdrr.io/r/stats/quantile.html) and
[`generate()`](https://generics.r-lib.org/reference/generate.html)
methods for the combined distributions.

## Usage

``` r
# S3 method for class 'multi_epiparameter'
aggregate(x, weighting = c("equal", "sample_size", "custom"), ..., weights)
```

## Arguments

- x:

  A `<multi_epiparameter>` object.

- weighting:

  A `character` string with the type of weighting to use to create the
  mixture distribution. Options are: `"equal"` for equal weighting
  across distributions, `"sample_size"` for using the sample size in
  each `<epiparameter>` object to weight the distribution (the sample
  sizes are normalised), or `"custom"` allows a vector of weights to be
  passed to the `weights` argument for a custom weighting.

- ...:

  [dots](https://rdrr.io/r/base/dots.html) Not used, will warn if extra
  arguments are passed to function.

- weights:

  A `numeric` vector of equal length the number of `<epiparameter>`
  objects passed to `x`. `weights` is only required if
  `weighting = "custom"`.

## Value

An `<epiparameter>` object

## Details

The [`aggregate()`](https://rdrr.io/r/stats/aggregate.html) method
requires that all `<epiparameter>` objects are parameterised with
`<distribution>` objects (from the distributional package). This means
that unparameterised (see
[`is_parameterised()`](https://epiverse-trace.github.io/epiparameter/dev/reference/is_parameterised.md))
or discretised (see
[`discretise()`](https://epiverse-trace.github.io/epiparameter/dev/reference/discretise.md))
distributions cannot be aggregated and the function will error.

## Examples

``` r
ebola_si <- epiparameter_db(epi_name = "serial interval", disease = "ebola")
#> Returning 4 results that match the criteria (4 are parameterised). 
#> Use subset to filter by entry variables or single_epiparameter to return a single entry. 
#> To retrieve the citation for each use the 'get_citation' function
aggregate(ebola_si)
#> Disease: Ebola Virus Disease
#> Pathogen: Ebola Virus
#> Epi Parameter: serial interval
#> Study: WHO Ebola Response Team, Agua-Agum J, Ariyarajah A, Aylward B, Blake I,
#> Brennan R, Cori A, Donnelly C, Dorigatti I, Dye C, Eckmanns T, Ferguson
#> N, Formenty P, Fraser C, Garcia E, Garske T, Hinsley W, Holmes D,
#> Hugonnet S, Iyengar S, Jombart T, Krishnan R, Meijers S, Mills H,
#> Mohamed Y, Nedjati-Gilani G, Newton E, Nouvellet P, Pelletier L,
#> Perkins D, Riley S, Sagrado M, Schnitzler J, Schumacher D, Shah A, Van
#> Kerkhove M, Varsaneux O, Kannangarage N (2015). “West African Ebola
#> Epidemic after One Year — Slowing but Not Yet under Control.” _The New
#> England Journal of Medicine_. doi:10.1056/NEJMc1414992
#> <https://doi.org/10.1056/NEJMc1414992>.
#> Distribution: mixture: gamma, gamma, gamma, gamma (days)
#> Distribution: mixture: gamma, gamma, gamma, gamma (days)
#> Distribution: mixture: gamma, gamma, gamma, gamma (days)
#> Distribution: mixture: gamma, gamma, gamma, gamma (days)
#> Parameters:
#>   dist.shape: 2.188
#>   dist.rate: 0.154
#>   dist.shape: 4.903
#>   dist.rate: 0.316
#>   dist.shape: 2.068
#>   dist.rate: 0.137
#>   dist.shape: 1.898
#>   dist.rate: 0.153
#>   w1: 0.250
#>   w2: 0.250
#>   w3: 0.250
#>   w4: 0.250
```
