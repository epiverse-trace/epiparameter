# A vector of `character` strings with the core column names of the epidemiological parameter data exported by the epireview R package.

A vector of `character` strings with the core column names of the
epidemiological parameter data exported by the epireview R package.

## Usage

``` r
epireview_core_cols
```

## Format

### `epireview_core_cols`

A `character` vector with 21 elements.

These are the columns of the epireview epidemiological parameter table
(`load_epidata(<pathogen>)$params`) that are required to convert an
epireview entry into an `<epiparameter>` object with
[`as_epiparameter()`](https://epiverse-trace.github.io/epiparameter/dev/reference/as_epiparameter.md).
They are used to identify an epireview parameter table and to check that
the columns needed for conversion are present.

## Source

<https://github.com/mrc-ide/epireview>
