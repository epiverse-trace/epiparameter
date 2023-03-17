# epiparam print & format method works as expected

    Code
      epiparam()
    Output
      Epiparam object
      Number of distributions in library: 106
      Number of diseases: 24
      Number of delay distributions: 83
      Number of offspring distributions: 10
      Number of studies in library: 42
      <Head of library>
            disease         epi_distribution prob_distribution
      1  Adenovirus        incubation_period             lnorm
      2 Chikungunya        incubation_period             lnorm
      3    COVID-19 hospitalisation_to_death           weibull
      4    COVID-19 hospitalisation_to_death             lnorm
      5    COVID-19        incubation_period              <NA>
      6    COVID-19        incubation_period           weibull
      <100 more rows & 53 more cols not shown>

---

    Code
      print(epiparam())
    Output
      Epiparam object
      Number of distributions in library: 106
      Number of diseases: 24
      Number of delay distributions: 83
      Number of offspring distributions: 10
      Number of studies in library: 42
      <Head of library>
            disease         epi_distribution prob_distribution
      1  Adenovirus        incubation_period             lnorm
      2 Chikungunya        incubation_period             lnorm
      3    COVID-19 hospitalisation_to_death           weibull
      4    COVID-19 hospitalisation_to_death             lnorm
      5    COVID-19        incubation_period              <NA>
      6    COVID-19        incubation_period           weibull
      <100 more rows & 53 more cols not shown>

---

    Code
      format(epiparam())
    Output
      Epiparam object
      Number of distributions in library: 106
      Number of diseases: 24
      Number of delay distributions: 83
      Number of offspring distributions: 10
      Number of studies in library: 42
      <Head of library>
            disease         epi_distribution prob_distribution
      1  Adenovirus        incubation_period             lnorm
      2 Chikungunya        incubation_period             lnorm
      3    COVID-19 hospitalisation_to_death           weibull
      4    COVID-19 hospitalisation_to_death             lnorm
      5    COVID-19        incubation_period              <NA>
      6    COVID-19        incubation_period           weibull
      <100 more rows & 53 more cols not shown>

# epiparam head & tails methods works as expected

    Code
      head(epiparam())
    Output
            disease          pathogen         epi_distribution       author year
      1  Adenovirus        Adenovirus        incubation_period Lessler_etal 2009
      2 Chikungunya Chikungunya Virus        incubation_period Rudolph_etal 2014
      3    COVID-19        SARS-CoV-2 hospitalisation_to_death  Linton_etal 2020
      4    COVID-19        SARS-CoV-2 hospitalisation_to_death  Linton_etal 2020
      5    COVID-19        SARS-CoV-2        incubation_period   Alene_etal 2021
      6    COVID-19        SARS-CoV-2        incubation_period     Bui_etal 2020
        sample_size  region              transmission_mode           vector extrinsic
      1          14     USA                   experimental             <NA>     FALSE
      2          21   Mixed                   vector_borne Aedes albopictus     FALSE
      3          39   China         natural_human_to_human             <NA>     FALSE
      4          39   China         natural_human_to_human             <NA>     FALSE
      5        1453   Mixed natural_natural_human_to_human             <NA>     FALSE
      6          19 Vietnam natural_natural_human_to_human             <NA>     FALSE
        prob_distribution inference_method mean mean_ci_limits mean_ci    sd
      1             lnorm              mle   NA         NA, NA      NA    NA
      2             lnorm              mle   NA         NA, NA      NA    NA
      3           weibull         bayesian  8.9      7.3, 10.4      95  5.40
      4             lnorm         bayesian 13.0      8.7, 20.9      95 12.70
      5              <NA>             <NA>  6.5       5.9, 7.1      95    NA
      6           weibull         bayesian  6.4     4.89, 8.50      95  3.05
        sd_ci_limits sd_ci quantile_2.5 quantile_5 quantile_25 median
      1       NA, NA    NA           NA         NA         4.8    5.6
      2       NA, NA    NA           NA         NA         2.9    3.0
      3     4.2, 7.3    95           NA        1.7          NA    8.0
      4    6.4, 26.0    95           NA        2.5          NA    9.1
      5       NA, NA    NA           NA         NA          NA     NA
      6   3.05, 5.30    95         1.35        1.9          NA    6.1
        median_ci_limits median_ci quantile_75 quantile_87.5 quantile_95
      1         4.8, 6.3        95         6.5            NA          NA
      2         0.5, 3.1        95         3.0            NA          NA
      3         6.2, 9.8        95          NA            NA        18.8
      4        6.7, 13.7        95          NA            NA        33.1
      5           NA, NA        NA          NA            NA          NA
      6           NA, NA        NA          NA            NA        11.9
        quantile_97.5 lower_range upper_range shape shape_ci_limits shape_ci scale
      1            NA          NA          NA    NA          NA, NA       NA    NA
      2            NA          NA          NA    NA          NA, NA       NA    NA
      3            NA          NA          NA    NA          NA, NA       NA    NA
      4            NA          NA          NA    NA          NA, NA       NA    NA
      5            NA          NA          NA    NA          NA, NA       NA    NA
      6         13.04          NA          NA    NA          NA, NA       NA    NA
        scale_ci_limits scale_ci meanlog meanlog_ci_limits meanlog_ci sdlog
      1          NA, NA       NA      NA            NA, NA         NA    NA
      2          NA, NA       NA      NA            NA, NA         NA    NA
      3          NA, NA       NA      NA            NA, NA         NA    NA
      4          NA, NA       NA      NA            NA, NA         NA    NA
      5          NA, NA       NA      NA            NA, NA         NA    NA
      6          NA, NA       NA      NA            NA, NA         NA    NA
        sdlog_ci_limits sdlog_ci dispersion dispersion_ci_limits dispersion_ci
      1          NA, NA       NA       1.26           1.13, 1.38            95
      2          NA, NA       NA       1.04           1.04, 1.08            95
      3          NA, NA       NA         NA               NA, NA            NA
      4          NA, NA       NA         NA               NA, NA            NA
      5          NA, NA       NA         NA               NA, NA            NA
      6          NA, NA       NA         NA               NA, NA            NA
        precision precision_ci_limits precision_ci truncation discretised censored
      1        NA              NA, NA           NA         NA       FALSE     TRUE
      2        NA              NA, NA           NA         NA       FALSE     TRUE
      3        NA              NA, NA           NA         NA       FALSE     TRUE
      4        NA              NA, NA           NA         NA       FALSE     TRUE
      5        NA              NA, NA           NA         NA       FALSE    FALSE
      6        NA              NA, NA           NA         NA       FALSE     TRUE
        right_truncated phase_bias_adjusted
      1           FALSE               FALSE
      2           FALSE               FALSE
      3           FALSE               FALSE
      4            TRUE                TRUE
      5           FALSE               FALSE
      6           FALSE               FALSE
                                                                                                                                                                                                                                                                                                                                    notes
      1 Analysis on data from Commission on Acute Respiratory Disease. Experimental transmission of minor respiratory illness to human volunteers by filter-passing agents. I. Demonstration of two types of illness characterized by long and short incubation periods and diff erent clinical features. J Clin Invest 1947; 26: 957–82.
      2                                                                                                                                                                                                                                           Pooled analysis on several data sets, see Rudolph et al 2014 for references of datasets
      3                                                                                                                                                                                                                     This method does not apply right-truncation, but does compare the gamma, weibull and lognormal distributions.
      4                                                                                                                                                                                                                                                      This method applies right-truncation but only fits a lognormal distribution.
      5                                                                                                This estimated mean incubation period is from a meta-analysis of 14 other incubation period estimates. Only the mean is reported and a distribution cannot be specified as the meta-mean is estimated from a random-effects model.
      6                                                                                                                                                                                                                                                                                                               No additional notes
            PMID                           DOI
      1 19393959 10.1016/S1473-3099(09)70069-6
      2 24639305         10.4269/ajtmh.13-0403
      3 32079150            10.3390/jcm9020538
      4 32079150            10.3390/jcm9020538
      5 33706702    10.1186/s12879-021-05950-x
      6 33362233  10.1371/journal.pone.0243889

---

    Code
      tail(epiparam())
    Output
                     disease             pathogen  epi_distribution       author year
      101    West Nile Fever      West Nile Virus incubation_period Rudolph_etal 2014
      102    West Nile Fever      West Nile Virus incubation_period Rudolph_etal 2014
      103    West Nile Fever      West Nile Virus incubation_period Rudolph_etal 2014
      104       Yellow Fever Yellow Fever Viruses incubation_period Rudolph_etal 2014
      105       Yellow Fever Yellow Fever Viruses incubation_period Rudolph_etal 2014
      106 Zika Virus Disease           Zika Virus incubation_period Lessler_etal 2016
          sample_size region transmission_mode                             vector
      101          18  Mixed          multiple                               <NA>
      102           8  Mixed      vector_borne                           mosquito
      103           6  Mixed  organ_transplant                               <NA>
      104          91  Mixed          multiple                               <NA>
      105          80  Mixed      vector_borne                           mosquito
      106          25  Mixed      vector_borne Aedes aegypti and Aedes albopictus
          extrinsic prob_distribution inference_method mean mean_ci_limits mean_ci sd
      101     FALSE             lnorm              mle   NA         NA, NA      NA NA
      102     FALSE             lnorm              mle   NA         NA, NA      NA NA
      103     FALSE             lnorm              mle   NA         NA, NA      NA NA
      104     FALSE             lnorm              mle   NA         NA, NA      NA NA
      105     FALSE             lnorm              mle   NA         NA, NA      NA NA
      106     FALSE             lnorm         bayesian   NA         NA, NA      NA NA
          sd_ci_limits sd_ci quantile_2.5 quantile_5 quantile_25 median
      101       NA, NA    NA           NA        1.0         1.7    2.6
      102       NA, NA    NA           NA         NA         2.8    2.9
      103       NA, NA    NA           NA         NA         8.7   10.8
      104       NA, NA    NA           NA        1.9         3.2    4.4
      105       NA, NA    NA           NA        1.9         3.1    4.4
      106       NA, NA    NA           NA        3.2         4.6    5.9
          median_ci_limits median_ci quantile_75 quantile_87.5 quantile_95
      101         1.6, 3.5        95         3.8            NA         7.0
      102         0.5, 3.1        95         3.0            NA          NA
      103        8.4, 14.2        95        13.3            NA          NA
      104             4, 5        95         6.3            NA        10.3
      105         3.9, 5.0        95         6.2            NA        10.3
      106         4.4, 7.6        95         7.6            NA        11.2
          quantile_97.5 lower_range upper_range shape shape_ci_limits shape_ci scale
      101            NA          NA          NA    NA          NA, NA       NA    NA
      102            NA          NA          NA    NA          NA, NA       NA    NA
      103            NA          NA          NA    NA          NA, NA       NA    NA
      104            NA          NA          NA    NA          NA, NA       NA    NA
      105            NA          NA          NA    NA          NA, NA       NA    NA
      106            NA          NA          NA    NA          NA, NA       NA    NA
          scale_ci_limits scale_ci meanlog meanlog_ci_limits meanlog_ci sdlog
      101          NA, NA       NA      NA            NA, NA         NA    NA
      102          NA, NA       NA      NA            NA, NA         NA    NA
      103          NA, NA       NA      NA            NA, NA         NA    NA
      104          NA, NA       NA      NA            NA, NA         NA    NA
      105          NA, NA       NA      NA            NA, NA         NA    NA
      106          NA, NA       NA      NA            NA, NA         NA    NA
          sdlog_ci_limits sdlog_ci dispersion dispersion_ci_limits dispersion_ci
      101          NA, NA       NA       1.82           1.27, 2.67            95
      102          NA, NA       NA       1.04           1.04, 1.29            95
      103          NA, NA       NA       1.35           1.12, 1.47            95
      104          NA, NA       NA       1.66           1.48, 1.82            95
      105          NA, NA       NA       1.67           1.47, 1.84            95
      106          NA, NA       NA       1.50             1.2, 1.9            95
          precision precision_ci_limits precision_ci truncation discretised censored
      101        NA              NA, NA           NA         NA       FALSE     TRUE
      102        NA              NA, NA           NA         NA       FALSE     TRUE
      103        NA              NA, NA           NA         NA       FALSE     TRUE
      104        NA              NA, NA           NA         NA       FALSE     TRUE
      105        NA              NA, NA           NA         NA       FALSE     TRUE
      106        NA              NA, NA           NA         NA       FALSE     TRUE
          right_truncated phase_bias_adjusted
      101           FALSE               FALSE
      102           FALSE               FALSE
      103           FALSE               FALSE
      104           FALSE               FALSE
      105           FALSE               FALSE
      106           FALSE               FALSE
                                                                                                                                                                                 notes
      101                                                                                      Pooled analysis on several data sets, see Rudolph et al 2014 for references of datasets
      102            Pooled analysis on several data sets, see Rudolph et al 2014 for references of datasets. This is a subset of data containing only mosquito-transmitted infections
      103 Pooled analysis on several data sets, see Rudolph et al 2014 for references of datasets. This is a subset of data containing only tramsission by transplant or transfusion. 
      104                                                                                      Pooled analysis on several data sets, see Rudolph et al 2014 for references of datasets
      105            Pooled analysis on several data sets, see Rudolph et al 2014 for references of datasets. This is a subset of data containing only mosquito-transmitted infections
      106                                                                                     Pooled analysis on several data sets, see Lessler et al. 2016 for references of datasets
              PMID                   DOI
      101 24639305 10.4269/ajtmh.13-0403
      102 24639305 10.4269/ajtmh.13-0403
      103 24639305 10.4269/ajtmh.13-0403
      104 24639305 10.4269/ajtmh.13-0403
      105 24639305 10.4269/ajtmh.13-0403
      106 27821887 10.2471/BLT.16.174540

