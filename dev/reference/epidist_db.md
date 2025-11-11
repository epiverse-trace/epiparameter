# Create `<epiparameter>` object(s) directly from the epiparameter library (database)

**\[deprecated\]**

`epidist_db()` has been renamed
[`epiparameter_db()`](https://epiverse-trace.github.io/epiparameter/dev/reference/epiparameter_db.md).
Please use
[`epiparameter_db()`](https://epiverse-trace.github.io/epiparameter/dev/reference/epiparameter_db.md)
instead as the `epidist_db()` alias will be removed from the package in
the future.

## Usage

``` r
epidist_db(
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
