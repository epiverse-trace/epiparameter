# [`plot()`](https://rdrr.io/r/graphics/plot.default.html) method for `<multi_epiparameter>` class

Plots a list of `<epiparameter>` objects by overlaying their
distributions.

## Usage

``` r
# S3 method for class 'multi_epiparameter'
plot(x, cumulative = FALSE, ...)
```

## Arguments

- x:

  A `<multi_epiparameter>` object.

- cumulative:

  A boolean `logical`, default is `FALSE`. `cumulative = TRUE` plots the
  cumulative distribution function (CDF).

- ...:

  further arguments passed to or from other methods.

## Value

These functions are invoked for their side effect of drawing on the
active graphics device.

## Details

Unparameterised and discrete `<epiparameter>` objects are not plotted
(see
[`is_parameterised()`](https://epiverse-trace.github.io/epiparameter/dev/reference/is_parameterised.md)
and
[`is_continuous()`](https://epiverse-trace.github.io/epiparameter/dev/reference/is_continuous.md)).

## Author

Joshua W. Lambert

## Examples

``` r
ebola_si <- epiparameter_db(disease = "Ebola", epi_name = "serial")
#> Returning 4 results that match the criteria (4 are parameterised). 
#> Use subset to filter by entry variables or single_epiparameter to return a single entry. 
#> To retrieve the citation for each use the 'get_citation' function
plot(ebola_si)
```
