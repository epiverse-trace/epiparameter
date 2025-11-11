# [`c()`](https://rdrr.io/r/base/c.html) method for `<epiparameter>` class

[`c()`](https://rdrr.io/r/base/c.html) method for `<epiparameter>` class

## Usage

``` r
# S3 method for class 'epiparameter'
c(...)

# S3 method for class 'multi_epiparameter'
c(...)
```

## Arguments

- ...:

  [dots](https://rdrr.io/r/base/dots.html) Objects to be concatenated.

## Value

An `<epiparameter>` or list of `<epiparameter>` objects.

## Examples

``` r
db <- epiparameter_db()
#> Returning 125 results that match the criteria (100 are parameterised). 
#> Use subset to filter by entry variables or single_epiparameter to return a single entry. 
#> To retrieve the citation for each use the 'get_citation' function

# combine two <epiparameter> objects into a list
c(db[[1]], db[[2]])
#> # List of 2 <epiparameter> objects
#> Number of diseases: 2
#> ❯ Adenovirus ❯ Human Coronavirus
#> Number of epi parameters: 1
#> ❯ incubation period
#> [[1]]
#> Disease: Adenovirus
#> Pathogen: Adenovirus
#> Epi Parameter: incubation period
#> Study: Lessler J, Reich N, Brookmeyer R, Perl T, Nelson K, Cummings D (2009).
#> “Incubation periods of acute respiratory viral infections: a systematic
#> review.” _The Lancet Infectious Diseases_.
#> doi:10.1016/S1473-3099(09)70069-6
#> <https://doi.org/10.1016/S1473-3099%2809%2970069-6>.
#> Distribution: lnorm (days)
#> Parameters:
#>   meanlog: 1.723
#>   sdlog: 0.231
#> 
#> [[2]]
#> Disease: Human Coronavirus
#> Pathogen: Human_Cov
#> Epi Parameter: incubation period
#> Study: Lessler J, Reich N, Brookmeyer R, Perl T, Nelson K, Cummings D (2009).
#> “Incubation periods of acute respiratory viral infections: a systematic
#> review.” _The Lancet Infectious Diseases_.
#> doi:10.1016/S1473-3099(09)70069-7
#> <https://doi.org/10.1016/S1473-3099%2809%2970069-7>.
#> Distribution: lnorm (days)
#> Parameters:
#>   meanlog: 1.163
#>   sdlog: 0.140
#> 
#> # ℹ Use `parameter_tbl()` to see a summary table of the parameters.
#> # ℹ Explore database online at: https://epiverse-trace.github.io/epiparameter/articles/database.html

# combine a list of <epiparameter> objects and a single <epiparameter> object
c(db, db[[1]])
#> # List of 126 <epiparameter> objects
#> Number of diseases: 23
#> ❯ Adenovirus ❯ COVID-19 ❯ Chikungunya ❯ Dengue ❯ Ebola Virus Disease ❯ Hantavirus Pulmonary Syndrome ❯ Human Coronavirus ❯ Influenza ❯ Japanese Encephalitis ❯ MERS ❯ Marburg Virus Disease ❯ Measles ❯ Mpox ❯ Parainfluenza ❯ Pneumonic Plague ❯ RSV ❯ Rhinovirus ❯ Rift Valley Fever ❯ SARS ❯ Smallpox ❯ West Nile Fever ❯ Yellow Fever ❯ Zika Virus Disease
#> Number of epi parameters: 13
#> ❯ case fatality risk ❯ generation time ❯ hospitalisation to death ❯ hospitalisation to discharge ❯ incubation period ❯ notification to death ❯ notification to discharge ❯ offspring distribution ❯ onset to death ❯ onset to discharge ❯ onset to hospitalisation ❯ onset to ventilation ❯ serial interval
#> [[1]]
#> Disease: Adenovirus
#> Pathogen: Adenovirus
#> Epi Parameter: incubation period
#> Study: Lessler J, Reich N, Brookmeyer R, Perl T, Nelson K, Cummings D (2009).
#> “Incubation periods of acute respiratory viral infections: a systematic
#> review.” _The Lancet Infectious Diseases_.
#> doi:10.1016/S1473-3099(09)70069-6
#> <https://doi.org/10.1016/S1473-3099%2809%2970069-6>.
#> Distribution: lnorm (days)
#> Parameters:
#>   meanlog: 1.723
#>   sdlog: 0.231
#> 
#> [[2]]
#> Disease: Human Coronavirus
#> Pathogen: Human_Cov
#> Epi Parameter: incubation period
#> Study: Lessler J, Reich N, Brookmeyer R, Perl T, Nelson K, Cummings D (2009).
#> “Incubation periods of acute respiratory viral infections: a systematic
#> review.” _The Lancet Infectious Diseases_.
#> doi:10.1016/S1473-3099(09)70069-7
#> <https://doi.org/10.1016/S1473-3099%2809%2970069-7>.
#> Distribution: lnorm (days)
#> Parameters:
#>   meanlog: 1.163
#>   sdlog: 0.140
#> 
#> [[3]]
#> Disease: SARS
#> Pathogen: SARS-Cov-1
#> Epi Parameter: incubation period
#> Study: Lessler J, Reich N, Brookmeyer R, Perl T, Nelson K, Cummings D (2009).
#> “Incubation periods of acute respiratory viral infections: a systematic
#> review.” _The Lancet Infectious Diseases_.
#> doi:10.1016/S1473-3099(09)70069-8
#> <https://doi.org/10.1016/S1473-3099%2809%2970069-8>.
#> Distribution: lnorm (days)
#> Parameters:
#>   meanlog: 1.386
#>   sdlog: 0.593
#> 
#> # ℹ 123 more elements
#> # ℹ Use `print(n = ...)` to see more elements.
#> # ℹ Use `parameter_tbl()` to see a summary table of the parameters.
#> # ℹ Explore database online at: https://epiverse-trace.github.io/epiparameter/articles/database.html
```
