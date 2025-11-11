# Create `<epiparameter>` object(s) directly from the epiparameter library (database)

Extract `<epiparameter>` object(s) directly from the library of
epidemiological parameters. The epiparameter library of epidemiological
parameters is compiled from primary literature sources. The list output
from `epiparameter_db()` can be subset by the data it contains, for
example by: disease, pathogen, epidemiological distribution, sample
size, region, etc.

If a distribution from a specific study is required, the `author`
argument can be specified.

Multiple entries (`<epiparameter>` objects) can be returned, use the
arguments to subset entries and use `single_epiparameter = TRUE` to
force a single `<epiparameter>` to be returned.

## Usage

``` r
epiparameter_db(
  disease = "all",
  pathogen = "all",
  epi_name = "all",
  author = NULL,
  subset = NULL,
  single_epiparameter = FALSE
)
```

## Arguments

- disease:

  A `character` string specifying the disease.

- pathogen:

  A `character` string specifying the pathogen.

- epi_name:

  A `character` string specifying the epidemiological parameter. See
  details for full list of epidemiological distributions.

- author:

  A `character` string specifying the author of the study reporting the
  distribution. Only the first author will be matched. It is recommended
  to use the family name as first names may or may not be initialised.

- subset:

  Either `NULL` or a valid R expressions that evaluates to logicals to
  subset the list of `<epiparameter>`, or a function that can be applied
  over a list of `<epiparameter>` objects.

  Subsetting (using `subset`) can be combined with the subsetting done
  with the `disease` and `epi_name` arguments (and `author` if
  specified). If left as `NULL` (default) no subsetting is carried out.

  The `subset` argument is similar to subsetting a `<data.frame>`, but
  the difference is that fixed comparisons and not vectorised
  comparisons are needed. For example `sample_size > 10` is a valid
  subset expression, but `sample_size == max(sample_size)`, which would
  be a valid subset expression for a `<data.frame>` does not work. The
  vectorised expression will often not error, but will likely return
  unexpected results. For the `sample_size == max(sample_size)` example
  it will always return `TRUE` (except for `NA`s) as it is a single
  numeric so will be equal to it's max value.

  The expression should be specified without using the data object name
  (e.g. `df$var`) and instead just `var` should be supplied. In other
  words, this argument uses non-standard evaluation, just as the
  `subset` argument in [`subset()`](https://rdrr.io/r/base/subset.html),
  and is similar to `<data-masking>` used by the `dplyr` package.

- single_epiparameter:

  A boolean `logical` determining whether a single `<epiparameter>` or
  multiple entries from the library can be returned if matched by the
  other arguments (`disease`, `epi_name`, `author`). This argument is
  used to prevent multiple sets of parameters being returned when only
  one is wanted.

  **Note**: If multiple entries match the arguments supplied and
  `single_epiparameter = TRUE` then the `<epiparameter>` that is
  parameterised (and accounts for truncation if available) and has the
  largest sample size will be returned (see
  [`is_parameterised()`](https://epiverse-trace.github.io/epiparameter/dev/reference/is_parameterised.md)).
  If multiple entries are equal after this sorting the first entry will
  be returned.

## Value

An `<epiparameter>` object or list of `<epiparameter>` objects.

## Details

`disease`, `epi_name` and `author` are given as individual arguments as
these are the most common variables to subset the parameter library by.
The `subset` argument facilitates all other subsetting of rows to select
the `<epiparameter>` object(s) desired. To subset based on multiple
variables separate each expression with `&`.

List of epidemiological parameters:

- "all" (default, returns all entries in library)

- "incubation period"

- "onset to hospitalisation"

- "onset to death"

- "serial interval"

- "generation time"

- "offspring distribution"

- "hospitalisation to death"

- "hospitalisation to discharge"

- "notification to death"

- "notification to discharge"

- "onset to discharge"

- "onset to ventilation"

## Examples

``` r
epiparameter_db(disease = "influenza", epi_name = "serial_interval")
#> Returning 1 results that match the criteria (1 are parameterised). 
#> Use subset to filter by entry variables or single_epiparameter to return a single entry. 
#> To retrieve the citation for each use the 'get_citation' function
#> Disease: Influenza
#> Pathogen: Influenza-A-H1N1Pdm
#> Epi Parameter: serial interval
#> Study: Ghani A, Baguelin M, Griffin J, Flasche S, van Hoek A, Cauchemez S,
#> Donnelly C, Robertson C, White M, Truscott J, Fraser C, Garske T, White
#> P, Leach S, Hall I, Jenkins H, Ferguson N, Cooper B (2009). “The Early
#> Transmission Dynamics of H1N1pdm Influenza in the United Kingdom.”
#> _PLoS Currents_. doi:10.1371/currents.RRN1130
#> <https://doi.org/10.1371/currents.RRN1130>.
#> Distribution: gamma (days)
#> Parameters:
#>   shape: 2.622
#>   scale: 0.957

# example using custom subsetting
eparam <- epiparameter_db(
  disease = "SARS",
  epi_name = "offspring_distribution",
  subset = sample_size > 40
)
#> Returning 1 results that match the criteria (1 are parameterised). 
#> Use subset to filter by entry variables or single_epiparameter to return a single entry. 
#> To retrieve the citation for each use the 'get_citation' function

# example using functional subsetting
eparam <- epiparameter_db(
  disease = "COVID-19",
  epi_name = "incubation_period",
  subset = is_parameterised
)
#> Returning 11 results that match the criteria (11 are parameterised). 
#> Use subset to filter by entry variables or single_epiparameter to return a single entry. 
#> To retrieve the citation for each use the 'get_citation' function

# example forcing a single <epiparameter> to be returned
eparam <- epiparameter_db(
  disease = "SARS",
  epi_name = "offspring_distribution",
  single_epiparameter = TRUE
)
#> Using Lloyd-Smith J, Schreiber S, Kopp P, Getz W (2005). “Superspreading and
#> the effect of individual variation on disease emergence.” _Nature_.
#> doi:10.1038/nature04153 <https://doi.org/10.1038/nature04153>.. 
#> To retrieve the citation use the 'get_citation' function
```
