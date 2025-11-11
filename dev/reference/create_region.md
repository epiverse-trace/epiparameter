# Specify the geography of the data entry

The geography of the data set can be a single geographical region at
either continent, country, region or city level. By specifying the level
of the geography the other fields may be deduced.

## Usage

``` r
create_region(
  continent = NA_character_,
  country = NA_character_,
  region = NA_character_,
  city = NA_character_
)
```

## Arguments

- continent:

  A `character` string specifying the continent.

- country:

  A `character` string specifying the country.

- region:

  A `character` string specifying the region.

- city:

  A `character` string specifying the city.

## Value

A named list.

## Examples

``` r
create_region(country = "UK")
#> $continent
#> [1] NA
#> 
#> $country
#> [1] "UK"
#> 
#> $region
#> [1] NA
#> 
#> $city
#> [1] NA
#> 
```
