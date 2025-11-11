# Check if `<epiparameter>` or list of `<epiparameter>` objects contains a distribution and distribution parameters

Check if `<epiparameter>` or list of `<epiparameter>` objects contains a
distribution and distribution parameters

## Usage

``` r
is_parameterised(x, ...)

is_parameterized(x, ...)

# S3 method for class 'epiparameter'
is_parameterised(x, ...)

# S3 method for class 'multi_epiparameter'
is_parameterised(x, ...)
```

## Arguments

- x:

  An `<epiparameter>` or list of `<epiparameter>` objects.

- ...:

  [dots](https://rdrr.io/r/base/dots.html) Extra arguments to be passed
  to the method.

## Value

A single boolean `logical` for `<epiparameter>` or vector of `logical`s
equal in length to the list of `<epiparameter>` objects input. If the
`<epiparameter>` object is missing either a probability distribution or
parameters for the probability distribution returns `FALSE`, otherwise
it returns `TRUE`.

## Examples

``` r
# parameterised <epiparameter>
ep <- epiparameter(
  disease = "ebola",
  epi_name = "incubation",
  prob_distribution = create_prob_distribution(
    prob_distribution = "gamma",
    prob_distribution_params = c(shape = 1, scale = 1)
  )
)
#> Citation cannot be created as author, year, journal or title is missing
is_parameterised(ep)
#> [1] TRUE

# unparameterised <epiparameter>
ep <- epiparameter(
  disease = "ebola",
  epi_name = "incubation"
)
#> Citation cannot be created as author, year, journal or title is missing
#> No adequate summary statistics available to calculate the parameters of the NA distribution
#> Unparameterised <epiparameter> object
is_parameterised(ep)
#> [1] FALSE

# list of <epiparameter>
db <- epiparameter_db()
#> Returning 125 results that match the criteria (100 are parameterised). 
#> Use subset to filter by entry variables or single_epiparameter to return a single entry. 
#> To retrieve the citation for each use the 'get_citation' function
is_parameterised(db)
#>   [1]  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
#>  [13]  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE FALSE  TRUE  TRUE FALSE  TRUE  TRUE
#>  [25]  TRUE  TRUE FALSE FALSE FALSE FALSE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
#>  [37]  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
#>  [49]  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
#>  [61]  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
#>  [73]  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE FALSE FALSE FALSE  TRUE
#>  [85] FALSE  TRUE FALSE FALSE FALSE FALSE  TRUE  TRUE  TRUE  TRUE FALSE  TRUE
#>  [97]  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
#> [109]  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE
#> [121] FALSE FALSE FALSE  TRUE FALSE
```
