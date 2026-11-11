# Create message reporting `<epiparameter>` objects that are estimates from the same study

When a single study reports several estimates that are all loaded from
the database, they are indistinguishable from each other, so this
function writes a message that is printed in
[`print.multi_epiparameter()`](https://epiverse-trace.github.io/epiparameter/dev/reference/print.multi_epiparameter.md)
notifying the user of multiple parameters from the same study.

## Usage

``` r
.same_study_msg(x)
```

## Arguments

- x:

  A `<multi_epiparameter>` object.

## Value

A `character` string for the
[`print.multi_epiparameter()`](https://epiverse-trace.github.io/epiparameter/dev/reference/print.multi_epiparameter.md)
footer. Empty `character` string when no entries from the same study.

## Details

Entries are grouped by disease, epidemiological parameter name and study
(DOI, when available). Entries without an identifiable study are never
grouped together. The study is named in the message when all the entries
come from one study, otherwise the number of studies is given.
