# Print method for `<multi_epiparameter>` class

Print method for `<multi_epiparameter>` class

## Usage

``` r
# S3 method for class 'multi_epiparameter'
print(x, ..., n = NULL)
```

## Arguments

- x:

  A `<multi_epiparameter>` object.

- ...:

  [dots](https://rdrr.io/r/base/dots.html) Extra arguments to be passed
  to the method.

- n:

  A `numeric` specifying how many `<epiparameter>` objects to print.
  This argument is passed to
  [`head()`](https://rdrr.io/r/utils/head.html) for `list` printing.
  Default is `NULL` and the number of elements to print is controlled by
  package [`options()`](https://rdrr.io/r/base/options.html).

## Value

Invisibly returns a `<multi_epiparameter>`. Called for side-effects.

## Examples

``` r
# entire database
db <- epiparameter_db()
#> Returning 125 results that match the criteria (100 are parameterised). 
#> Use subset to filter by entry variables or single_epiparameter to return a single entry. 
#> To retrieve the citation for each use the 'get_citation' function
db
#> # List of 125 <epiparameter> objects
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
#> # ℹ 122 more elements
#> # ℹ Use `print(n = ...)` to see more elements.
#> # ℹ Use `parameter_tbl()` to see a summary table of the parameters.
#> # ℹ Explore database online at: https://epiverse-trace.github.io/epiparameter/articles/database.html

# a single disease
db <- epiparameter_db(disease = "Ebola")
#> Returning 17 results that match the criteria (17 are parameterised). 
#> Use subset to filter by entry variables or single_epiparameter to return a single entry. 
#> To retrieve the citation for each use the 'get_citation' function
db
#> # List of 17 <epiparameter> objects
#> Number of diseases: 1
#> ❯ Ebola Virus Disease
#> Number of epi parameters: 9
#> ❯ hospitalisation to death ❯ hospitalisation to discharge ❯ incubation period ❯ notification to death ❯ notification to discharge ❯ offspring distribution ❯ onset to death ❯ onset to discharge ❯ serial interval
#> [[1]]
#> Disease: Ebola Virus Disease
#> Pathogen: Ebola Virus
#> Epi Parameter: offspring distribution
#> Study: Lloyd-Smith J, Schreiber S, Kopp P, Getz W (2005). “Superspreading and
#> the effect of individual variation on disease emergence.” _Nature_.
#> doi:10.1038/nature04153 <https://doi.org/10.1038/nature04153>.
#> Distribution: nbinom (No units)
#> Parameters:
#>   mean: 1.500
#>   dispersion: 5.100
#> 
#> [[2]]
#> Disease: Ebola Virus Disease
#> Pathogen: Ebola Virus-Zaire Subtype
#> Epi Parameter: incubation period
#> Study: Eichner M, Dowell S, Firese N (2011). “Incubation period of ebola
#> hemorrhagic virus subtype zaire.” _Osong Public Health and Research
#> Perspectives_. doi:10.1016/j.phrp.2011.04.001
#> <https://doi.org/10.1016/j.phrp.2011.04.001>.
#> Distribution: lnorm (days)
#> Parameters:
#>   meanlog: 2.487
#>   sdlog: 0.330
#> 
#> [[3]]
#> Disease: Ebola Virus Disease
#> Pathogen: Ebola Virus-Zaire Subtype
#> Epi Parameter: onset to death
#> Study: The Ebola Outbreak Epidemiology Team, Barry A, Ahuka-Mundeke S, Ali
#> Ahmed Y, Allarangar Y, Anoko J, Archer B, Abedi A, Bagaria J, Belizaire
#> M, Bhatia S, Bokenge T, Bruni E, Cori A, Dabire E, Diallo A, Diallo B,
#> Donnelly C, Dorigatti I, Dorji T, Waeber A, Fall I, Ferguson N,
#> FitzJohn R, Tengomo G, Formenty P, Forna A, Fortin A, Garske T,
#> Gaythorpe K, Gurry C, Hamblion E, Djingarey M, Haskew C, Hugonnet S,
#> Imai N, Impouma B, Kabongo G, Kalenga O, Kibangou E, Lee T, Lukoya C,
#> Ly O, Makiala-Mandanda S, Mamba A, Mbala-Kingebeni P, Mboussou F,
#> Mlanda T, Makuma V, Morgan O, Mulumba A, Kakoni P, Mukadi-Bamuleka D,
#> Muyembe J, Bathé N, Ndumbi Ngamala P, Ngom R, Ngoy G, Nouvellet P, Nsio
#> J, Ousman K, Peron E, Polonsky J, Ryan M, Touré A, Towner R, Tshapenda
#> G, Van De Weerdt R, Van Kerkhove M, Wendland A, Yao N, Yoti Z, Yuma E,
#> Kalambayi Kabamba G, Mwati J, Mbuy G, Lubula L, Mutombo A, Mavila O,
#> Lay Y, Kitenge E (2018). “Outbreak of Ebola virus disease in the
#> Democratic Republic of the Congo, April–May, 2018: an epidemiological
#> study.” _The Lancet_. doi:10.1016/S0140-6736(18)31387-4
#> <https://doi.org/10.1016/S0140-6736%2818%2931387-4>.
#> Distribution: gamma (days)
#> Parameters:
#>   shape: 2.400
#>   scale: 3.333
#> 
#> # ℹ 14 more elements
#> # ℹ Use `print(n = ...)` to see more elements.
#> # ℹ Use `parameter_tbl()` to see a summary table of the parameters.
#> # ℹ Explore database online at: https://epiverse-trace.github.io/epiparameter/articles/database.html

# a single epi parameter
db <- epiparameter_db(epi_name = "offspring distribution")
#> Returning 10 results that match the criteria (10 are parameterised). 
#> Use subset to filter by entry variables or single_epiparameter to return a single entry. 
#> To retrieve the citation for each use the 'get_citation' function
db
#> # List of 10 <epiparameter> objects
#> Number of diseases: 6
#> ❯ Ebola Virus Disease ❯ Hantavirus Pulmonary Syndrome ❯ Mpox ❯ Pneumonic Plague ❯ SARS ❯ Smallpox
#> Number of epi parameters: 1
#> ❯ offspring distribution
#> [[1]]
#> Disease: SARS
#> Pathogen: SARS-Cov-1
#> Epi Parameter: offspring distribution
#> Study: Lloyd-Smith J, Schreiber S, Kopp P, Getz W (2005). “Superspreading and
#> the effect of individual variation on disease emergence.” _Nature_.
#> doi:10.1038/nature04153 <https://doi.org/10.1038/nature04153>.
#> Distribution: nbinom (No units)
#> Parameters:
#>   mean: 1.630
#>   dispersion: 0.160
#> 
#> [[2]]
#> Disease: SARS
#> Pathogen: SARS-Cov-1
#> Epi Parameter: offspring distribution
#> Study: Lloyd-Smith J, Schreiber S, Kopp P, Getz W (2005). “Superspreading and
#> the effect of individual variation on disease emergence.” _Nature_.
#> doi:10.1038/nature04153 <https://doi.org/10.1038/nature04153>.
#> Distribution: nbinom (No units)
#> Parameters:
#>   mean: 0.940
#>   dispersion: 0.170
#> 
#> [[3]]
#> Disease: Smallpox
#> Pathogen: Smallpox-Variola-Major
#> Epi Parameter: offspring distribution
#> Study: Lloyd-Smith J, Schreiber S, Kopp P, Getz W (2005). “Superspreading and
#> the effect of individual variation on disease emergence.” _Nature_.
#> doi:10.1038/nature04153 <https://doi.org/10.1038/nature04153>.
#> Distribution: nbinom (No units)
#> Parameters:
#>   mean: 3.190
#>   dispersion: 0.370
#> 
#> # ℹ 7 more elements
#> # ℹ Use `print(n = ...)` to see more elements.
#> # ℹ Use `parameter_tbl()` to see a summary table of the parameters.
#> # ℹ Explore database online at: https://epiverse-trace.github.io/epiparameter/articles/database.html
```
