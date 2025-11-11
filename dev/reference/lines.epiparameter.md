# [`lines()`](https://rdrr.io/r/graphics/lines.html) method for `<epiparameter>` class

[`lines()`](https://rdrr.io/r/graphics/lines.html) method for
`<epiparameter>` class

## Usage

``` r
# S3 method for class 'epiparameter'
lines(x, cumulative = FALSE, ...)
```

## Arguments

- x:

  An `<epiparameter>` object.

- cumulative:

  A boolean `logical`, default is `FALSE`. `cumulative = TRUE` plots the
  cumulative distribution function (CDF).

- ...:

  further arguments passed to or from other methods.

## Value

These functions are invoked for their side effect of drawing on the
active graphics device.

## Examples

``` r
ebola_si <- epiparameter_db(disease = "Ebola", epi_name = "serial")
#> Returning 4 results that match the criteria (4 are parameterised). 
#> Use subset to filter by entry variables or single_epiparameter to return a single entry. 
#> To retrieve the citation for each use the 'get_citation' function
plot(ebola_si[[1]])
lines(ebola_si[[2]])
```
