# Check if `<data.frame>` input is from epireview

Check if `<data.frame>` input is from epireview

## Usage

``` r
.is_epireview(x)
```

## Arguments

- x:

  A `<data.frame>`.

## Value

A single `logical` boolean.

## Details

Identifies an epireview parameter table by checking that it contains all
of the columns required to convert an entry into an `<epiparameter>`
(see
[epireview_core_cols](https://epiverse-trace.github.io/epiparameter/dev/reference/epireview_core_cols.md)).
This intentionally checks only the columns the converter uses, so
detection is robust to epireview adding, removing or renaming columns
that are not needed for conversion.
