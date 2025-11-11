# Specify metadata associated with data set

A helper function when creating an `<epiparameter>` object to create a
metadata list with sensible defaults, type checking and arguments to
help remember metadata list structure (element names).

## Usage

``` r
create_metadata(
  units = NA_character_,
  sample_size = NA_integer_,
  region = NA_character_,
  transmission_mode = NA_character_,
  vector = NA_character_,
  extrinsic = FALSE,
  inference_method = NA_character_
)
```

## Arguments

- units:

  A `character` for the units of the epidemiological parameter.

- sample_size:

  The sample of the data used to fit the delay distribution. This is
  usually the number of people with data on a primary and possibly
  secondary event of interest. In cases where the sample size is not
  stated NA can be used.

- region:

  The geographical location the data was collected. This can either be
  given at sub-national, national, continental. Multiple nested regions
  can be given and are comma separated. When the region is not specified
  NA can be given.

- transmission_mode:

  A character string specifying how the pathogen is transmitted. This
  information is used to determine whether the epidemiological
  parameters are from a vector-borne disease (i.e. is transmitted
  between humans through an intermediate vector), this is specified by
  `transmission_mode = "vector_borne"`.

- vector:

  The name of the vector transmitting the vector-borne disease. This can
  be a common name, or a latin binomial name of a specific vector
  species. Both the common name and taxonomic name can be given with one
  given in parentheses. When a disease is not vector-borne NA should be
  given.

- extrinsic:

  A boolean value defining whether the data entry is an extrinsic delay
  distribution, such as the extrinsic incubation period. This field is
  required because intrinsic and extrinsic delay distributions are
  stored as separate entries in the database and can be linked. When the
  disease is not vector-borne FALSE should be given. See Details for
  explanation of extrinsic distribution.

- inference_method:

  The type of inference used to fit the delay distribution to the data.
  Abbreviations of model fitting techniques can be specified as long as
  they are non-ambiguous. This field is only used to determine whether
  the uncertainty intervals possibly specified in the other fields are:
  confidence intervals (in the case of maximum likelihood), or credible
  intervals (in the case of bayesian inference). Uncertainty bounds for
  another types of inference methods, or if the inference method is
  unstated are assumed to be confidence intervals. When the inference
  method is unknown or a disease does not have a probability
  distribution NA can be given.

## Value

A named list containing information on the sample size of the study,
geography, whether the disease is vector-borne and if so whether it is
the intrinsic or extrinsic distribution as well as method of
distribution parameter estimation.

## Details

In vector-borne diseases the transmissibility of a disease is dependent
on both the time taken for a host (i.e. human) to become infectious, but
also on the time it takes the vector to become infectious. Therefore,
the extrinsic delay, in which the vector has been infected by is not yet
infectious can have a role in the spread of a disease.

## Examples

``` r
# it will automatically populate the fields with defaults if left empty
create_metadata()
#> $units
#> [1] NA
#> 
#> $sample_size
#> [1] NA
#> 
#> $region
#> [1] NA
#> 
#> $transmission_mode
#> [1] NA
#> 
#> $vector
#> [1] NA
#> 
#> $extrinsic
#> [1] FALSE
#> 
#> $inference_method
#> [1] NA
#> 

# supplying each field
create_metadata(
  units = "days",
  sample_size = 10,
  region = "UK",
  transmission_mode = "vector_borne",
  vector = "mosquito",
  extrinsic = FALSE,
  inference_method = "MLE"
)
#> $units
#> [1] "days"
#> 
#> $sample_size
#> [1] 10
#> 
#> $region
#> [1] "UK"
#> 
#> $transmission_mode
#> [1] "vector_borne"
#> 
#> $vector
#> [1] "mosquito"
#> 
#> $extrinsic
#> [1] FALSE
#> 
#> $inference_method
#> [1] "MLE"
#> 
```
