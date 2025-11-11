# Create a citation for an `<epiparameter>` object

A helper function when creating an `<epiparameter>` object to create a
citation list with sensible defaults, type checking and arguments to
help remember which citation information is accepted in the list.

## Usage

``` r
create_citation(
  author = utils::person(),
  year = NA_integer_,
  title = NA_character_,
  journal = NA_character_,
  doi = NA_character_,
  pmid = NA_integer_
)
```

## Arguments

- author:

  Either a `<person>`, a `character` string, or a vector or list of
  `characters` in the case of multiple authors. Specify the full name
  (`"<given name>" "<family name>"`). When using `characters` make sure
  the name can be converted to a `<person>` (see
  [`as.person()`](https://rdrr.io/r/utils/person.html)). Use white space
  separation between names. Multiple names can be stored within a single
  `<person>` (see [`person()`](https://rdrr.io/r/utils/person.html)).

- year:

  A `numeric` of the year of publication.

- title:

  A `character` string with the title of the article that published the
  epidemiological parameters.

- journal:

  A `character` string with the name of the journal that published the
  article that published the epidemiological parameters. This can also
  be a pre-print server, e.g., medRxiv.

- doi:

  A `character` string of the Digital Object Identifier (DOI) assigned
  to papers which are unique to each paper.

- pmid:

  A `character` string with the PubMed unique identifier number (PMID)
  assigned to papers to give them a unique identifier within PubMed.

## Value

A `<bibentry>` object of the citation

## Details

This function acts as a wrapper around
[`bibentry()`](https://rdrr.io/r/utils/bibentry.html) to create
citations for sources reporting epidemiological parameters.

## Examples

``` r
create_citation(
  author = person(given = "John", family = "Smith"),
  year = 2002,
  title = "COVID-19 incubation period",
  journal = "Epi Journal",
  doi = "10.19832/j.1366-9516.2012.09147.x"
)
#> Using Smith J (2002). “COVID-19 incubation period.” _Epi Journal_.
#> doi:10.19832/j.1366-9516.2012.09147.x
#> <https://doi.org/10.19832/j.1366-9516.2012.09147.x>. 
#> To retrieve the citation use the 'get_citation' function
#> Smith J (2002). “COVID-19 incubation period.” _Epi Journal_.
#> doi:10.19832/j.1366-9516.2012.09147.x
#> <https://doi.org/10.19832/j.1366-9516.2012.09147.x>.
```
