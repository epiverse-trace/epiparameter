# epiparam print & format method works as expected

    Code
      epiparam()
    Output
      Epiparam object
      Number of distributions in library: 118
      Number of diseases: 23
      Number of delay distributions: 95
      Number of offspring distributions: 10
      Number of studies in library: 57
      <Head of library>
            disease         epi_distribution prob_distribution
      1  Adenovirus        incubation_period             lnorm
      2 Chikungunya        incubation_period             lnorm
      3    COVID-19 hospitalisation_to_death           weibull
      4    COVID-19 hospitalisation_to_death             lnorm
      5    COVID-19        incubation_period              <NA>
      6    COVID-19        incubation_period           weibull
      <112 more rows & 55 more cols not shown>

---

    Code
      print(epiparam())
    Output
      Epiparam object
      Number of distributions in library: 118
      Number of diseases: 23
      Number of delay distributions: 95
      Number of offspring distributions: 10
      Number of studies in library: 57
      <Head of library>
            disease         epi_distribution prob_distribution
      1  Adenovirus        incubation_period             lnorm
      2 Chikungunya        incubation_period             lnorm
      3    COVID-19 hospitalisation_to_death           weibull
      4    COVID-19 hospitalisation_to_death             lnorm
      5    COVID-19        incubation_period              <NA>
      6    COVID-19        incubation_period           weibull
      <112 more rows & 55 more cols not shown>

---

    Code
      format(epiparam())
    Output
      Epiparam object
      Number of distributions in library: 118
      Number of diseases: 23
      Number of delay distributions: 95
      Number of offspring distributions: 10
      Number of studies in library: 57
      <Head of library>
            disease         epi_distribution prob_distribution
      1  Adenovirus        incubation_period             lnorm
      2 Chikungunya        incubation_period             lnorm
      3    COVID-19 hospitalisation_to_death           weibull
      4    COVID-19 hospitalisation_to_death             lnorm
      5    COVID-19        incubation_period              <NA>
      6    COVID-19        incubation_period           weibull
      <112 more rows & 55 more cols not shown>

# epiparam head & tails methods works as expected

    Code
      head(epiparam())
    Output
            disease          pathogen         epi_distribution       author
      1  Adenovirus        Adenovirus        incubation_period Lessler_etal
      2 Chikungunya Chikungunya Virus        incubation_period Rudolph_etal
      3    COVID-19        SARS-CoV-2 hospitalisation_to_death  Linton_etal
      4    COVID-19        SARS-CoV-2 hospitalisation_to_death  Linton_etal
      5    COVID-19        SARS-CoV-2        incubation_period   Alene_etal
      6    COVID-19        SARS-CoV-2        incubation_period     Bui_etal
                                                                                                                                                                                 title
      1                                                                                                  Incubation periods of acute respiratory viral infections: a systematic review
      2                                                                                                     Incubation periods of mosquito-borne viral infections: a systematic review
      3 Incubation Period and Other Epidemiological Characteristics of 2019 Novel Coronavirus Infections with Right Truncation: A Statistical Analysis of Publicly Available Case Data
      4 Incubation Period and Other Epidemiological Characteristics of 2019 Novel Coronavirus Infections with Right Truncation: A Statistical Analysis of Publicly Available Case Data
      5                                                                                       Serial interval and incubation period of COVID-19: a systematic review and meta-analysis
      6                                                                                                                     Estimation of the incubation period of COVID-19 in Vietnam
                                                      journal year sample_size
      1                        The Lancet Infectious Diseases 2009          14
      2 The American Journal of Tropical Medicine and Hygiene 2014          21
      3                          Journal of Clinical Medicine 2020          39
      4                          Journal of Clinical Medicine 2020          39
      5                               BMC Infectious Diseases 2021        1453
      6                                              PLoS One 2020          19
         region              transmission_mode           vector extrinsic
      1     USA                   experimental             <NA>     FALSE
      2   Mixed                   vector_borne Aedes albopictus     FALSE
      3   China         natural_human_to_human             <NA>     FALSE
      4   China         natural_human_to_human             <NA>     FALSE
      5   Mixed natural_natural_human_to_human             <NA>     FALSE
      6 Vietnam natural_natural_human_to_human             <NA>     FALSE
        prob_distribution inference_method mean mean_ci_limits mean_ci    sd
      1             lnorm              mle   NA         NA, NA      NA    NA
      2             lnorm              mle   NA         NA, NA      NA    NA
      3           weibull         bayesian  8.9      7.3, 10.4      95  5.70
      4             lnorm         bayesian 13.0      8.7, 20.9      95 12.70
      5              <NA>             <NA>  6.5       5.9, 7.1      95    NA
      6           weibull         bayesian  6.4     4.89, 8.50      95  3.05
        sd_ci_limits sd_ci quantile_2.5 quantile_5 quantile_25 median
      1       NA, NA    NA           NA         NA         4.8    5.6
      2       NA, NA    NA           NA         NA         2.9    3.0
      3     4.3, 7.8    95           NA        1.7          NA    8.0
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
                     disease             pathogen  epi_distribution       author
      113    West Nile Fever      West Nile Virus incubation_period Rudolph_etal
      114    West Nile Fever      West Nile Virus incubation_period Rudolph_etal
      115    West Nile Fever      West Nile Virus incubation_period Rudolph_etal
      116       Yellow Fever Yellow Fever Viruses incubation_period Rudolph_etal
      117       Yellow Fever Yellow Fever Viruses incubation_period Rudolph_etal
      118 Zika Virus Disease           Zika Virus incubation_period Lessler_etal
                                                                                                         title
      113                           Incubation periods of mosquito-borne viral infections: a systematic review
      114                           Incubation periods of mosquito-borne viral infections: a systematic review
      115                           Incubation periods of mosquito-borne viral infections: a systematic review
      116                           Incubation periods of mosquito-borne viral infections: a systematic review
      117                           Incubation periods of mosquito-borne viral infections: a systematic review
      118 Times to key events in Zika virus infection and implications for blood donation: a systematic review
                                                        journal year sample_size
      113 The American Journal of Tropical Medicine and Hygiene 2014          18
      114 The American Journal of Tropical Medicine and Hygiene 2014           8
      115 The American Journal of Tropical Medicine and Hygiene 2014           6
      116 The American Journal of Tropical Medicine and Hygiene 2014          91
      117 The American Journal of Tropical Medicine and Hygiene 2014          80
      118             Bulletin of the World Health Organization 2016          25
          region transmission_mode                             vector extrinsic
      113  Mixed          multiple                               <NA>     FALSE
      114  Mixed      vector_borne                           mosquito     FALSE
      115  Mixed  organ_transplant                               <NA>     FALSE
      116  Mixed          multiple                               <NA>     FALSE
      117  Mixed      vector_borne                           mosquito     FALSE
      118  Mixed      vector_borne Aedes aegypti and Aedes albopictus     FALSE
          prob_distribution inference_method mean mean_ci_limits mean_ci sd
      113             lnorm              mle   NA         NA, NA      NA NA
      114             lnorm              mle   NA         NA, NA      NA NA
      115             lnorm              mle   NA         NA, NA      NA NA
      116             lnorm              mle   NA         NA, NA      NA NA
      117             lnorm              mle   NA         NA, NA      NA NA
      118             lnorm         bayesian   NA         NA, NA      NA NA
          sd_ci_limits sd_ci quantile_2.5 quantile_5 quantile_25 median
      113       NA, NA    NA           NA        1.0         1.7    2.6
      114       NA, NA    NA           NA         NA         2.8    2.9
      115       NA, NA    NA           NA         NA         8.7   10.8
      116       NA, NA    NA           NA        1.9         3.2    4.4
      117       NA, NA    NA           NA        1.9         3.1    4.4
      118       NA, NA    NA           NA        3.2         4.6    5.9
          median_ci_limits median_ci quantile_75 quantile_87.5 quantile_95
      113         1.6, 3.5        95         3.8            NA         7.0
      114         0.5, 3.1        95         3.0            NA          NA
      115        8.4, 14.2        95        13.3            NA          NA
      116             4, 5        95         6.3            NA        10.3
      117         3.9, 5.0        95         6.2            NA        10.3
      118         4.4, 7.6        95         7.6            NA        11.2
          quantile_97.5 lower_range upper_range shape shape_ci_limits shape_ci scale
      113            NA          NA          NA    NA          NA, NA       NA    NA
      114            NA          NA          NA    NA          NA, NA       NA    NA
      115            NA          NA          NA    NA          NA, NA       NA    NA
      116            NA          NA          NA    NA          NA, NA       NA    NA
      117            NA          NA          NA    NA          NA, NA       NA    NA
      118            NA          NA          NA    NA          NA, NA       NA    NA
          scale_ci_limits scale_ci meanlog meanlog_ci_limits meanlog_ci sdlog
      113          NA, NA       NA      NA            NA, NA         NA    NA
      114          NA, NA       NA      NA            NA, NA         NA    NA
      115          NA, NA       NA      NA            NA, NA         NA    NA
      116          NA, NA       NA      NA            NA, NA         NA    NA
      117          NA, NA       NA      NA            NA, NA         NA    NA
      118          NA, NA       NA      NA            NA, NA         NA    NA
          sdlog_ci_limits sdlog_ci dispersion dispersion_ci_limits dispersion_ci
      113          NA, NA       NA       1.82           1.27, 2.67            95
      114          NA, NA       NA       1.04           1.04, 1.29            95
      115          NA, NA       NA       1.35           1.12, 1.47            95
      116          NA, NA       NA       1.66           1.48, 1.82            95
      117          NA, NA       NA       1.67           1.47, 1.84            95
      118          NA, NA       NA       1.50             1.2, 1.9            95
          precision precision_ci_limits precision_ci truncation discretised censored
      113        NA              NA, NA           NA         NA       FALSE     TRUE
      114        NA              NA, NA           NA         NA       FALSE     TRUE
      115        NA              NA, NA           NA         NA       FALSE     TRUE
      116        NA              NA, NA           NA         NA       FALSE     TRUE
      117        NA              NA, NA           NA         NA       FALSE     TRUE
      118        NA              NA, NA           NA         NA       FALSE     TRUE
          right_truncated phase_bias_adjusted
      113           FALSE               FALSE
      114           FALSE               FALSE
      115           FALSE               FALSE
      116           FALSE               FALSE
      117           FALSE               FALSE
      118           FALSE               FALSE
                                                                                                                                                                                 notes
      113                                                                                      Pooled analysis on several data sets, see Rudolph et al 2014 for references of datasets
      114            Pooled analysis on several data sets, see Rudolph et al 2014 for references of datasets. This is a subset of data containing only mosquito-transmitted infections
      115 Pooled analysis on several data sets, see Rudolph et al 2014 for references of datasets. This is a subset of data containing only tramsission by transplant or transfusion. 
      116                                                                                      Pooled analysis on several data sets, see Rudolph et al 2014 for references of datasets
      117            Pooled analysis on several data sets, see Rudolph et al 2014 for references of datasets. This is a subset of data containing only mosquito-transmitted infections
      118                                                                                     Pooled analysis on several data sets, see Lessler et al. 2016 for references of datasets
              PMID                   DOI
      113 24639305 10.4269/ajtmh.13-0403
      114 24639305 10.4269/ajtmh.13-0403
      115 24639305 10.4269/ajtmh.13-0403
      116 24639305 10.4269/ajtmh.13-0403
      117 24639305 10.4269/ajtmh.13-0403
      118 27821887 10.2471/BLT.16.174540

