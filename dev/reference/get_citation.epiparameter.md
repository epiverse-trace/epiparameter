# Get citation from an `<epiparameter>` object

Extract the citation stored in an `<epiparameter>` object.

## Usage

``` r
# S3 method for class 'epiparameter'
get_citation(x, ...)
```

## Arguments

- x:

  An `<epiparameter>` object.

- ...:

  [dots](https://rdrr.io/r/base/dots.html) Not used, extra arguments
  supplied will cause a warning.

## Value

A `<bibentry>` object.

## Examples

``` r
# example with <epiparameter>
ep <- epiparameter_db(single_epiparameter = TRUE)
#> Using Linton N, Kobayashi T, Yang Y, Hayashi K, Akhmetzhanov A, Jung S, Yuan
#> B, Kinoshita R, Nishiura H (2020). “Incubation Period and Other
#> Epidemiological Characteristics of 2019 Novel Coronavirus Infections
#> with Right Truncation: A Statistical Analysis of Publicly Available
#> Case Data.” _Journal of Clinical Medicine_. doi:10.3390/jcm9020538
#> <https://doi.org/10.3390/jcm9020538>.. 
#> To retrieve the citation use the 'get_citation' function
get_citation(ep)
#> Linton N, Kobayashi T, Yang Y, Hayashi K, Akhmetzhanov A, Jung S, Yuan
#> B, Kinoshita R, Nishiura H (2020). “Incubation Period and Other
#> Epidemiological Characteristics of 2019 Novel Coronavirus Infections
#> with Right Truncation: A Statistical Analysis of Publicly Available
#> Case Data.” _Journal of Clinical Medicine_. doi:10.3390/jcm9020538
#> <https://doi.org/10.3390/jcm9020538>.

# example returning bibtex format
ep <- epiparameter_db(disease = "COVID-19", single_epiparameter = TRUE)
#> Using Linton N, Kobayashi T, Yang Y, Hayashi K, Akhmetzhanov A, Jung S, Yuan
#> B, Kinoshita R, Nishiura H (2020). “Incubation Period and Other
#> Epidemiological Characteristics of 2019 Novel Coronavirus Infections
#> with Right Truncation: A Statistical Analysis of Publicly Available
#> Case Data.” _Journal of Clinical Medicine_. doi:10.3390/jcm9020538
#> <https://doi.org/10.3390/jcm9020538>.. 
#> To retrieve the citation use the 'get_citation' function
cit <- get_citation(ep)
format(cit, style = "bibtex")
#> [1] "@Article{,\n  author = {Natalie M. Linton and Tetsuro Kobayashi and Yichi Yang and Katsuma Hayashi and Andrei R. Akhmetzhanov and Sung-mok Jung and Baoyin Yuan and Ryo Kinoshita and Hiroshi Nishiura},\n  year = {2020},\n  title = {Incubation Period and Other Epidemiological Characteristics of 2019 Novel Coronavirus Infections with Right Truncation: A Statistical Analysis of Publicly Available Case Data},\n  journal = {Journal of Clinical Medicine},\n  doi = {10.3390/jcm9020538},\n  pmid = {32079150},\n}"
```
