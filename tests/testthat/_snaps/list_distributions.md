# list_distributions works as expected with defaults

    Code
      list_distributions(epiparam = eparam)
    Output
                       disease  epi_distribution prob_distribution         author
      1             adenovirus incubation_period         lognormal   Lessler_etal
      2            chikungunya incubation_period         lognormal   Rudolph_etal
      3                 dengue incubation_period         lognormal Chan_Johansson
      4                 dengue incubation_period         lognormal Chan_Johansson
      5                 dengue incubation_period         lognormal Chan_Johansson
      6                 dengue incubation_period         lognormal   Rudolph_etal
      7                 dengue incubation_period         lognormal   Rudolph_etal
      8      human coronavirus incubation_period         lognormal   Lessler_etal
      9              influenza incubation_period             gamma     Ghani_etal
      10             influenza incubation_period         lognormal   Lessler_etal
      11             influenza incubation_period         lognormal   Lessler_etal
      12             influenza incubation_period         lognormal   Lessler_etal
      13             influenza incubation_period         lognormal   Lessler_etal
      14             influenza incubation_period             gamma Nishiura_Inaba
      15             influenza incubation_period           weibull Nishiura_Inaba
      16             influenza incubation_period         lognormal     Reich_etal
      17             influenza incubation_period         lognormal     Reich_etal
      18             influenza incubation_period         lognormal     Tuite_etal
      19             influenza incubation_period           weibull Virlogeux_etal
      20             influenza incubation_period             gamma Virlogeux_etal
      21             influenza incubation_period           weibull Virlogeux_etal
      22             influenza incubation_period           weibull Virlogeux_etal
      23             influenza incubation_period           weibull Virlogeux_etal
      24 Japanese encephalitis incubation_period         lognormal   Rudolph_etal
      25 marburg virus disease incubation_period              <NA>         Pavlin
      26 marburg virus disease incubation_period              <NA>         Pavlin
      27               measles incubation_period         lognormal   Lessler_etal
      28         parainfluenza incubation_period         lognormal   Lessler_etal
      29            rhinovirus incubation_period         lognormal   Lessler_etal
      30     Rift Valley fever incubation_period         lognormal   Rudolph_etal
      31                   RSV incubation_period         lognormal   Lessler_etal
      32                   RSV incubation_period         lognormal     Reich_etal
      33                   RSV incubation_period         lognormal     Reich_etal
      34                  SARS incubation_period         lognormal   Lessler_etal
      35       west nile fever incubation_period         lognormal   Rudolph_etal
      36       west nile fever incubation_period         lognormal   Rudolph_etal
      37       west nile fever incubation_period         lognormal   Rudolph_etal
      38          yellow fever incubation_period         lognormal   Rudolph_etal
      39          yellow fever incubation_period         lognormal   Rudolph_etal
      40    zika virus disease incubation_period         lognormal   Lessler_etal
         year sample_size
      1  2009          14
      2  2014          21
      3  2012         146
      4  2012         146
      5  2012         153
      6  2014         169
      7  2014         124
      8  2009          13
      9  2009          16
      10 2009         151
      11 2009          90
      12 2009          78
      13 2009         134
      14 2011          72
      15 2011          72
      16 2009         151
      17 2009         151
      18 2010         316
      19 2015         229
      20 2015         229
      21 2016         395
      22 2016         173
      23 2016         222
      24 2014           6
      25 2014          76
      26 2014          18
      27 2009          55
      28 2009          11
      29 2009          28
      30 2014          23
      31 2009          24
      32 2009          24
      33 2009          24
      34 2009         157
      35 2014          18
      36 2014           8
      37 2014           6
      38 2014          91
      39 2014          80
      40 2016          25

# list_distributions works as expected with subset_db = FALSE

    Code
      list_distributions(epiparam = eparam, subset_db = FALSE)
    Output
                       disease                    pathogen  epi_distribution
      1             adenovirus                  adenovirus incubation_period
      2            chikungunya           chikungunya virus incubation_period
      3                 dengue                dengue virus incubation_period
      4                 dengue                dengue virus incubation_period
      5                 dengue                dengue virus incubation_period
      6                 dengue                dengue virus incubation_period
      7                 dengue                dengue virus incubation_period
      8      human coronavirus                   human_CoV incubation_period
      9              influenza         influenza-A-H1N1pdm incubation_period
      10             influenza                 influenza-A incubation_period
      11             influenza                 influenza-A incubation_period
      12             influenza                 influenza-B incubation_period
      13             influenza            influenza-A-H1N1 incubation_period
      14             influenza            influenza-A-H1N1 incubation_period
      15             influenza            influenza-A-H1N1 incubation_period
      16             influenza                 influenza-A incubation_period
      17             influenza                 influenza-A incubation_period
      18             influenza            influenza-A-H1N1 incubation_period
      19             influenza            influenza-A-H7N9 incubation_period
      20             influenza            influenza-A-H7N9 incubation_period
      21             influenza            influenza-A-H7N9 incubation_period
      22             influenza            influenza-A-H7N9 incubation_period
      23             influenza            influenza-A-H7N9 incubation_period
      24 Japanese encephalitis Japanese encephalitis virus incubation_period
      25 marburg virus disease               marburg virus incubation_period
      26 marburg virus disease               marburg virus incubation_period
      27               measles               measles virus incubation_period
      28         parainfluenza         parainfluenza virus incubation_period
      29            rhinovirus                  rhinovirus incubation_period
      30     Rift Valley fever     Rift Valley fever virus incubation_period
      31                   RSV                         RSV incubation_period
      32                   RSV                         RSV incubation_period
      33                   RSV                         RSV incubation_period
      34                  SARS                  SARS-CoV-1 incubation_period
      35       west nile fever                   West Nile incubation_period
      36       west nile fever                   West Nile incubation_period
      37       west nile fever                   West Nile incubation_period
      38          yellow fever        yellow fever viruses incubation_period
      39          yellow fever        yellow fever viruses incubation_period
      40    zika virus disease                        zika incubation_period
                 author year sample_size        region vector_borne
      1    Lessler_etal 2009          14           USA        FALSE
      2    Rudolph_etal 2014          21         Mixed         TRUE
      3  Chan_Johansson 2012         146         Mixed         TRUE
      4  Chan_Johansson 2012         146         Mixed         TRUE
      5  Chan_Johansson 2012         153         Mixed         TRUE
      6    Rudolph_etal 2014         169         Mixed         TRUE
      7    Rudolph_etal 2014         124         Mixed         TRUE
      8    Lessler_etal 2009          13            UK        FALSE
      9      Ghani_etal 2009          16            UK        FALSE
      10   Lessler_etal 2009         151         Mixed        FALSE
      11   Lessler_etal 2009          90         Mixed        FALSE
      12   Lessler_etal 2009          78           USA        FALSE
      13   Lessler_etal 2009         134 New York, USA        FALSE
      14 Nishiura_Inaba 2011          72         Japan        FALSE
      15 Nishiura_Inaba 2011          72         Japan        FALSE
      16     Reich_etal 2009         151         Mixed        FALSE
      17     Reich_etal 2009         151         Mixed        FALSE
      18     Tuite_etal 2010         316        Canada        FALSE
      19 Virlogeux_etal 2015         229         China        FALSE
      20 Virlogeux_etal 2015         229         China        FALSE
      21 Virlogeux_etal 2016         395         China        FALSE
      22 Virlogeux_etal 2016         173         China        FALSE
      23 Virlogeux_etal 2016         222         China        FALSE
      24   Rudolph_etal 2014           6         Mixed         TRUE
      25         Pavlin 2014          76         Mixed        FALSE
      26         Pavlin 2014          18         Mixed        FALSE
      27   Lessler_etal 2009          55         Mixed        FALSE
      28   Lessler_etal 2009          11         Mixed        FALSE
      29   Lessler_etal 2009          28           USA        FALSE
      30   Rudolph_etal 2014          23         Mixed         TRUE
      31   Lessler_etal 2009          24         Mixed        FALSE
      32     Reich_etal 2009          24         Mixed        FALSE
      33     Reich_etal 2009          24         Mixed        FALSE
      34   Lessler_etal 2009         157         Mixed        FALSE
      35   Rudolph_etal 2014          18         Mixed         TRUE
      36   Rudolph_etal 2014           8         Mixed         TRUE
      37   Rudolph_etal 2014           6         Mixed         TRUE
      38   Rudolph_etal 2014          91         Mixed         TRUE
      39   Rudolph_etal 2014          80         Mixed         TRUE
      40   Lessler_etal 2016          25         Mixed         TRUE
                                     vector extrinsic prob_distribution
      1                                <NA>     FALSE         lognormal
      2                    Aedes albopictus     FALSE         lognormal
      3  Aedes aegypti and Aedes albopictus      TRUE         lognormal
      4  Aedes aegypti and Aedes albopictus      TRUE         lognormal
      5  Aedes aegypti and Aedes albopictus     FALSE         lognormal
      6  Aedes aegypti and Aedes albopictus     FALSE         lognormal
      7  Aedes aegypti and Aedes albopictus     FALSE         lognormal
      8                                <NA>     FALSE         lognormal
      9                                <NA>     FALSE             gamma
      10                               <NA>     FALSE         lognormal
      11                               <NA>     FALSE         lognormal
      12                               <NA>     FALSE         lognormal
      13                               <NA>     FALSE         lognormal
      14                               <NA>     FALSE             gamma
      15                               <NA>     FALSE           weibull
      16                               <NA>     FALSE         lognormal
      17                               <NA>     FALSE         lognormal
      18                               <NA>     FALSE         lognormal
      19                               <NA>     FALSE           weibull
      20                               <NA>     FALSE             gamma
      21                               <NA>     FALSE           weibull
      22                               <NA>     FALSE           weibull
      23                               <NA>     FALSE           weibull
      24                           mosquito     FALSE         lognormal
      25                               <NA>     FALSE              <NA>
      26                               <NA>     FALSE              <NA>
      27                               <NA>     FALSE         lognormal
      28                               <NA>     FALSE         lognormal
      29                               <NA>     FALSE         lognormal
      30                           mosquito     FALSE         lognormal
      31                               <NA>     FALSE         lognormal
      32                               <NA>     FALSE         lognormal
      33                               <NA>     FALSE         lognormal
      34                               <NA>     FALSE         lognormal
      35                           mosquito     FALSE         lognormal
      36                           mosquito     FALSE         lognormal
      37                           mosquito     FALSE         lognormal
      38                           mosquito     FALSE         lognormal
      39                           mosquito     FALSE         lognormal
      40 Aedes aegypti and Aedes albopictus     FALSE         lognormal
         inference_method  mean mean_ci_limits mean_ci   sd sd_ci_limits sd_ci
      1               mle    NA         NA, NA      NA   NA       NA, NA    NA
      2               mle    NA         NA, NA      NA   NA       NA, NA    NA
      3          bayesian 15.00         10, 20      95   NA       NA, NA    NA
      4          bayesian  6.50       4.8, 8.8      95   NA       NA, NA    NA
      5          bayesian  5.97       5.5, 6.4      95 1.64       NA, NA    NA
      6               mle    NA         NA, NA      NA   NA       NA, NA    NA
      7               mle    NA         NA, NA      NA   NA       NA, NA    NA
      8          bayesian    NA         NA, NA      NA   NA       NA, NA    NA
      9               mle  2.05         NA, NA      NA 0.49       NA, NA    NA
      10              mle    NA         NA, NA      NA   NA       NA, NA    NA
      11              mle    NA         NA, NA      NA   NA       NA, NA    NA
      12              mle    NA         NA, NA      NA   NA       NA, NA    NA
      13              mle    NA         NA, NA      NA   NA       NA, NA    NA
      14              mle    NA         NA, NA      NA   NA       NA, NA    NA
      15              mle    NA         NA, NA      NA   NA       NA, NA    NA
      16              mle    NA         NA, NA      NA   NA       NA, NA    NA
      17              mle    NA         NA, NA      NA   NA       NA, NA    NA
      18             <NA>  4.30       2.6, 6.6      95   NA       NA, NA    NA
      19              mle  3.40       3.0, 3.7      95 1.70       NA, NA    NA
      20              mle  4.50      2.8, 16.2      95 3.30       NA, NA    NA
      21         bayesian  3.50       3.2, 3.8      95   NA       NA, NA    NA
      22         bayesian  3.70       3.4, 4.1      95   NA       NA, NA    NA
      23         bayesian  3.30       2.9, 3.6      95   NA       NA, NA    NA
      24              mle    NA         NA, NA      NA   NA       NA, NA    NA
      25             <NA>    NA         NA, NA      NA   NA       NA, NA    NA
      26             <NA>    NA         NA, NA      NA   NA       NA, NA    NA
      27              mle    NA         NA, NA      NA   NA       NA, NA    NA
      28              mle    NA         NA, NA      NA   NA       NA, NA    NA
      29              mle    NA         NA, NA      NA   NA       NA, NA    NA
      30              mle    NA         NA, NA      NA   NA       NA, NA    NA
      31              mle    NA         NA, NA      NA   NA       NA, NA    NA
      32              mle    NA         NA, NA      NA   NA       NA, NA    NA
      33              mle    NA         NA, NA      NA   NA       NA, NA    NA
      34              mle    NA         NA, NA      NA   NA       NA, NA    NA
      35              mle    NA         NA, NA      NA   NA       NA, NA    NA
      36              mle    NA         NA, NA      NA   NA       NA, NA    NA
      37              mle    NA         NA, NA      NA   NA       NA, NA    NA
      38              mle    NA         NA, NA      NA   NA       NA, NA    NA
      39              mle    NA         NA, NA      NA   NA       NA, NA    NA
      40         bayesian    NA         NA, NA      NA   NA       NA, NA    NA
         quantile_025 quantile_05 quantile_25 median median_ci_limits median_ci
      1            NA          NA         4.8   5.60         4.8, 6.3        95
      2            NA          NA         2.9   3.00         0.5, 3.1        95
      3           5.0          NA          NA     NA           NA, NA        NA
      4           2.4          NA          NA     NA           NA, NA        NA
      5           3.4          NA          NA     NA           NA, NA        NA
      6            NA          NA         4.5   5.60         5.3, 6.0        95
      7            NA          NA         4.3   5.30         5.0, 5.7        95
      8            NA          NA         2.9   3.20         2.8, 3.7        95
      9            NA          NA          NA     NA           NA, NA        NA
      10           NA        0.70         1.1   1.40         1.3, 1.5        95
      11           NA        1.40         1.7   1.90         1.8, 2.0        95
      12           NA        0.30         0.4   0.60         0.5, 0.6        95
      13           NA        0.90          NA   1.40         1.0, 1.8        95
      14           NA          NA          NA   1.51       1.47, 1.55        95
      15           NA          NA          NA   1.43       1.21, 1.65        95
      16           NA        0.73          NA   1.46       1.35, 1.57        95
      17           NA        0.73          NA   1.43       1.33, 1.54        95
      18           NA          NA          NA   4.00           NA, NA        NA
      19           NA          NA          NA     NA           NA, NA        NA
      20           NA          NA          NA     NA           NA, NA        NA
      21           NA          NA          NA     NA           NA, NA        NA
      22           NA          NA          NA     NA           NA, NA        NA
      23           NA          NA          NA     NA           NA, NA        NA
      24           NA          NA         8.1   8.40         5.1, 9.4        95
      25           NA          NA          NA     NA           NA, NA        NA
      26           NA          NA          NA   7.00           NA, NA        NA
      27           NA        8.90        10.9  12.50       11.8, 13.3        95
      28           NA          NA         2.1   2.60         2.1, 3.1        95
      29           NA        0.80         1.3   1.90         1.4, 2.4        95
      30           NA          NA         3.1   4.00         3.4, 4.9        95
      31           NA        3.10         3.8   4.40         3.9, 4.9        95
      32           NA        3.05          NA   4.41       3.90, 4.92        95
      33           NA        3.11          NA   4.41       3.89, 4.94        95
      34           NA        1.50         2.7   4.00         3.6, 4.4        95
      35           NA        1.00         1.7   2.60         1.6, 3.5        95
      36           NA          NA         2.8   2.90         0.5, 3.1        95
      37           NA          NA         8.7  10.80        8.4, 14.2        95
      38           NA        1.90         3.2   4.40             4, 5        95
      39           NA        1.90         3.1   4.40         3.9, 5.0        95
      40           NA        3.20         4.6   5.90         4.4, 7.6        95
         quantile_75 quantile_875 quantile_95 quantile_975 lower_range upper_range
      1          6.5           NA          NA           NA          NA          NA
      2          3.0           NA          NA           NA          NA          NA
      3           NA           NA          NA           33          NA          NA
      4           NA           NA          NA           15          NA          NA
      5           NA           NA          NA           10          NA          NA
      6          7.1           NA          NA           NA          NA          NA
      7          6.6           NA          NA           NA          NA          NA
      8          3.5           NA          NA           NA          NA          NA
      9           NA           NA          NA           NA          NA          NA
      10         1.9           NA        2.80           NA          NA          NA
      11         2.2           NA        2.70           NA          NA          NA
      12         0.7           NA        1.10           NA          NA          NA
      13          NA           NA        2.20           NA          NA          NA
      14          NA           NA        3.43           NA          NA          NA
      15          NA           NA        3.18           NA          NA          NA
      16          NA           NA        2.94           NA          NA          NA
      17          NA           NA        2.83           NA          NA          NA
      18          NA           NA          NA           NA          NA          NA
      19          NA           NA        6.50           NA          NA          NA
      20          NA           NA       11.00           NA          NA          NA
      21          NA           NA          NA           NA          NA          NA
      22          NA           NA          NA           NA          NA          NA
      23          NA           NA          NA           NA          NA          NA
      24         8.6           NA          NA           NA          NA          NA
      25          NA           NA          NA           NA           2          26
      26          NA           NA          NA           NA           2          13
      27        14.4           NA       17.70           NA          NA          NA
      28         3.2           NA          NA           NA          NA          NA
      29         2.7           NA        4.50           NA          NA          NA
      30         5.3           NA          NA           NA          NA          NA
      31          NA           NA        6.30           NA          NA          NA
      32          NA           NA        6.39           NA          NA          NA
      33          NA           NA        6.26           NA          NA          NA
      34         5.9           NA       10.60           NA          NA          NA
      35         3.8           NA        7.00           NA          NA          NA
      36         3.0           NA          NA           NA          NA          NA
      37        13.3           NA          NA           NA          NA          NA
      38         6.3           NA       10.30           NA          NA          NA
      39         6.2           NA       10.30           NA          NA          NA
      40         7.6           NA       11.20           NA          NA          NA
         shape shape_ci_limits shape_ci scale scale_ci_limits scale_ci meanlog
      1     NA          NA, NA       NA    NA          NA, NA       NA      NA
      2     NA          NA, NA       NA    NA          NA, NA       NA      NA
      3     NA          NA, NA       NA    NA          NA, NA       NA      NA
      4     NA          NA, NA       NA    NA          NA, NA       NA      NA
      5     NA          NA, NA       NA    NA          NA, NA       NA    1.75
      6     NA          NA, NA       NA    NA          NA, NA       NA      NA
      7     NA          NA, NA       NA    NA          NA, NA       NA      NA
      8     NA          NA, NA       NA    NA          NA, NA       NA      NA
      9     NA          NA, NA       NA    NA          NA, NA       NA      NA
      10    NA          NA, NA       NA    NA          NA, NA       NA      NA
      11    NA          NA, NA       NA    NA          NA, NA       NA      NA
      12    NA          NA, NA       NA    NA          NA, NA       NA      NA
      13    NA          NA, NA       NA    NA          NA, NA       NA      NA
      14  3.27          NA, NA       NA  0.51          NA, NA       NA      NA
      15  1.74          NA, NA       NA  1.83          NA, NA       NA      NA
      16    NA          NA, NA       NA    NA          NA, NA       NA      NA
      17    NA          NA, NA       NA    NA          NA, NA       NA      NA
      18    NA          NA, NA       NA    NA          NA, NA       NA      NA
      19    NA          NA, NA       NA    NA          NA, NA       NA      NA
      20    NA          NA, NA       NA    NA          NA, NA       NA      NA
      21    NA          NA, NA       NA    NA          NA, NA       NA      NA
      22  2.30      1.80, 2.89       95  4.21      3.62, 4.85       95      NA
      23  2.03      1.62, 2.52       95  3.74      3.20, 4.36       95      NA
      24    NA          NA, NA       NA    NA          NA, NA       NA      NA
      25    NA          NA, NA       NA    NA          NA, NA       NA      NA
      26    NA          NA, NA       NA    NA          NA, NA       NA      NA
      27    NA          NA, NA       NA    NA          NA, NA       NA      NA
      28    NA          NA, NA       NA    NA          NA, NA       NA      NA
      29    NA          NA, NA       NA    NA          NA, NA       NA      NA
      30    NA          NA, NA       NA    NA          NA, NA       NA      NA
      31    NA          NA, NA       NA    NA          NA, NA       NA      NA
      32    NA          NA, NA       NA    NA          NA, NA       NA      NA
      33    NA          NA, NA       NA    NA          NA, NA       NA      NA
      34    NA          NA, NA       NA    NA          NA, NA       NA      NA
      35    NA          NA, NA       NA    NA          NA, NA       NA      NA
      36    NA          NA, NA       NA    NA          NA, NA       NA      NA
      37    NA          NA, NA       NA    NA          NA, NA       NA      NA
      38    NA          NA, NA       NA    NA          NA, NA       NA      NA
      39    NA          NA, NA       NA    NA          NA, NA       NA      NA
      40    NA          NA, NA       NA    NA          NA, NA       NA      NA
         meanlog_ci_limits meanlog_ci sdlog sdlog_ci_limits sdlog_ci dispersion
      1             NA, NA         NA    NA          NA, NA       NA       1.26
      2             NA, NA         NA    NA          NA, NA       NA       1.04
      3             NA, NA         NA    NA          NA, NA       NA         NA
      4             NA, NA         NA    NA          NA, NA       NA         NA
      5             NA, NA         NA  0.27          NA, NA       NA         NA
      6             NA, NA         NA    NA          NA, NA       NA       1.41
      7             NA, NA         NA    NA          NA, NA       NA       1.37
      8             NA, NA         NA    NA          NA, NA       NA       1.15
      9             NA, NA         NA    NA          NA, NA       NA         NA
      10            NA, NA         NA    NA          NA, NA       NA       1.51
      11            NA, NA         NA    NA          NA, NA       NA       1.23
      12            NA, NA         NA    NA          NA, NA       NA       1.51
      13            NA, NA         NA    NA          NA, NA       NA         NA
      14            NA, NA         NA    NA          NA, NA       NA         NA
      15            NA, NA         NA    NA          NA, NA       NA         NA
      16            NA, NA         NA    NA          NA, NA       NA       1.53
      17            NA, NA         NA    NA          NA, NA       NA       1.51
      18            NA, NA         NA    NA          NA, NA       NA         NA
      19            NA, NA         NA    NA          NA, NA       NA         NA
      20            NA, NA         NA    NA          NA, NA       NA         NA
      21            NA, NA         NA    NA          NA, NA       NA         NA
      22            NA, NA         NA    NA          NA, NA       NA         NA
      23            NA, NA         NA    NA          NA, NA       NA         NA
      24            NA, NA         NA    NA          NA, NA       NA       1.04
      25            NA, NA         NA    NA          NA, NA       NA         NA
      26            NA, NA         NA    NA          NA, NA       NA         NA
      27            NA, NA         NA    NA          NA, NA       NA       1.23
      28            NA, NA         NA    NA          NA, NA       NA       1.35
      29            NA, NA         NA    NA          NA, NA       NA       1.68
      30            NA, NA         NA    NA          NA, NA       NA       1.50
      31            NA, NA         NA    NA          NA, NA       NA       1.24
      32            NA, NA         NA    NA          NA, NA       NA       1.25
      33            NA, NA         NA    NA          NA, NA       NA       1.24
      34            NA, NA         NA    NA          NA, NA       NA       1.81
      35            NA, NA         NA    NA          NA, NA       NA       1.82
      36            NA, NA         NA    NA          NA, NA       NA       1.04
      37            NA, NA         NA    NA          NA, NA       NA       1.35
      38            NA, NA         NA    NA          NA, NA       NA       1.66
      39            NA, NA         NA    NA          NA, NA       NA       1.67
      40            NA, NA         NA    NA          NA, NA       NA       1.50
         dispersion_ci_limits dispersion_ci precision precision_ci_limits
      1            1.13, 1.38            95        NA              NA, NA
      2            1.04, 1.08            95        NA              NA, NA
      3                NA, NA            NA        NA              NA, NA
      4                NA, NA            NA       4.9            2.8, 7.5
      5                NA, NA            NA      13.7          10.9, 16.9
      6            1.34, 1.50            95        NA              NA, NA
      7            1.27, 1.52            95        NA              NA, NA
      8            1.07, 1.34            95        NA              NA, NA
      9                NA, NA            NA        NA              NA, NA
      10           1.43, 1.60            95        NA              NA, NA
      11           1.17, 1.29            95        NA              NA, NA
      12           1.37, 1.64            95        NA              NA, NA
      13               NA, NA            NA        NA              NA, NA
      14               NA, NA            NA        NA              NA, NA
      15               NA, NA            NA        NA              NA, NA
      16           1.44, 1.61            95        NA              NA, NA
      17           1.43, 1.60            95        NA              NA, NA
      18               NA, NA            NA        NA              NA, NA
      19               NA, NA            NA        NA              NA, NA
      20               NA, NA            NA        NA              NA, NA
      21               NA, NA            NA        NA              NA, NA
      22               NA, NA            NA        NA              NA, NA
      23               NA, NA            NA        NA              NA, NA
      24           1.04, 1.05            95        NA              NA, NA
      25               NA, NA            NA        NA              NA, NA
      26               NA, NA            NA        NA              NA, NA
      27           1.18, 1.28            95        NA              NA, NA
      28           1.16, 1.55            95        NA              NA, NA
      29           1.36, 2.01            95        NA              NA, NA
      30           1.22, 1.82            95        NA              NA, NA
      31           1.13, 1.35            95        NA              NA, NA
      32           1.14, 1.36            95        NA              NA, NA
      33           1.12, 1.35            95        NA              NA, NA
      34           1.67, 1.95            95        NA              NA, NA
      35           1.27, 2.67            95        NA              NA, NA
      36           1.04, 1.29            95        NA              NA, NA
      37           1.12, 1.47            95        NA              NA, NA
      38           1.48, 1.82            95        NA              NA, NA
      39           1.47, 1.84            95        NA              NA, NA
      40             1.2, 1.9            95        NA              NA, NA
         precision_ci truncation discretised censored right_truncated
      1            NA         NA       FALSE     TRUE           FALSE
      2            NA         NA       FALSE     TRUE           FALSE
      3            NA         NA       FALSE     TRUE           FALSE
      4            95         NA       FALSE     TRUE           FALSE
      5            95         NA       FALSE     TRUE           FALSE
      6            NA         NA       FALSE     TRUE           FALSE
      7            NA         NA       FALSE     TRUE           FALSE
      8            NA         NA       FALSE     TRUE           FALSE
      9            NA         NA       FALSE     TRUE           FALSE
      10           NA         NA       FALSE     TRUE           FALSE
      11           NA         NA       FALSE     TRUE           FALSE
      12           NA         NA       FALSE     TRUE           FALSE
      13           NA         NA       FALSE     TRUE           FALSE
      14           NA         NA       FALSE     TRUE           FALSE
      15           NA         NA       FALSE     TRUE           FALSE
      16           NA         NA       FALSE     TRUE           FALSE
      17           NA         NA       FALSE     TRUE           FALSE
      18           NA         NA       FALSE    FALSE           FALSE
      19           NA         NA       FALSE     TRUE           FALSE
      20           NA         NA       FALSE     TRUE           FALSE
      21           NA         NA       FALSE     TRUE           FALSE
      22           NA         NA       FALSE     TRUE           FALSE
      23           NA         NA       FALSE     TRUE           FALSE
      24           NA         NA       FALSE     TRUE           FALSE
      25           NA         NA       FALSE    FALSE           FALSE
      26           NA         NA       FALSE    FALSE           FALSE
      27           NA         NA       FALSE     TRUE           FALSE
      28           NA         NA       FALSE     TRUE           FALSE
      29           NA         NA       FALSE     TRUE           FALSE
      30           NA         NA       FALSE     TRUE           FALSE
      31           NA         NA       FALSE     TRUE           FALSE
      32           NA         NA       FALSE     TRUE           FALSE
      33           NA         NA       FALSE     TRUE           FALSE
      34           NA         NA       FALSE     TRUE           FALSE
      35           NA         NA       FALSE     TRUE           FALSE
      36           NA         NA       FALSE     TRUE           FALSE
      37           NA         NA       FALSE     TRUE           FALSE
      38           NA         NA       FALSE     TRUE           FALSE
      39           NA         NA       FALSE     TRUE           FALSE
      40           NA         NA       FALSE     TRUE           FALSE
         phase_bias_adjusted
      1                FALSE
      2                FALSE
      3                FALSE
      4                FALSE
      5                FALSE
      6                FALSE
      7                FALSE
      8                FALSE
      9                FALSE
      10               FALSE
      11               FALSE
      12               FALSE
      13               FALSE
      14                TRUE
      15                TRUE
      16               FALSE
      17               FALSE
      18               FALSE
      19               FALSE
      20               FALSE
      21               FALSE
      22               FALSE
      23               FALSE
      24               FALSE
      25               FALSE
      26               FALSE
      27               FALSE
      28               FALSE
      29               FALSE
      30               FALSE
      31               FALSE
      32               FALSE
      33               FALSE
      34               FALSE
      35               FALSE
      36               FALSE
      37               FALSE
      38               FALSE
      39               FALSE
      40               FALSE
                                                                                                                                                                                                                                                                                                                                                                                                                                           notes
      1                                                                                                        Analysis on data from Commission on Acute Respiratory Disease. Experimental transmission of minor respiratory illness to human volunteers by filter-passing agents. I. Demonstration of two types of illness characterized by long and short incubation periods and diff erent clinical features. J Clin Invest 1947; 26: 957–82.
      2                                                                                                                                                                                                                                                                                                                                                  Pooled analysis on several data sets, see Rudolph et al 2014 for references of datasets
      3                                                                                                                                                                                                                                                                                                                                                                               Extrinsic incubation period for data at 25 degrees celcius
      4                                                                                                                                                                                                                                                                                                                                                                               Extrinsic incubation period for data at 30 degrees celcius
      5                                                                                                                                                                                                                                                                                                                                     Standard deviation, meanlog and sdlog is taken from Siraj et al. 2017 <10.1371/journal.pntd.0005797>
      6                                                                                                                                                                                                                                                                                                                                                  Pooled analysis on several data sets, see Rudolph et al 2014 for references of datasets
      7                                                                                                                                                                                                                                                                        Pooled analysis on several data sets, see Rudolph et al 2014 for references of datasets. This is a subset of data containing only mosquito-transmitted infections
      8                                                                                                                                                                                                                                                                                          Analysis on data from  Bradburne AF, Bynoe ML, Tyrrell DA. Eff ects of a “new” human respiratory virus in volunteers. Br Med J 1967; 3: 767–69.
      9                                                                                                                                                                                                                                                                                                                                                                                                                     No additional notes.
      10                                                                                                                                                                                                                                                                                                                                                Pooled analysis on several data sets, see Lessler et al. 2009 for references of datasets
      11                                                                                                                                                                   These estimates for the incubation period of influenza A from Lessler et al. 2009 are different from the estimates from the complete data, as they remove Henle et al. 1945 J Immunol, as it is an outlier in the dataset (n=61). Values found at the bottom Table 3.
      12                                                                                                                                                                                                                                                                                                                                                Pooled analysis on several data sets, see Lessler et al. 2009 for references of datasets
      13                                                                                                                                                                                                                                                                                                                                                                                                                    No additional notes.
      14                                                                                                                                                                                                                                                                                                                                                    Gamma and weibull distributions had equally good fit to the data. Gamma, exponential
      15                                                                                                                                                                                                                                                                                                                                                  Gamma and weibull distributions had equally good fit to the data. Weibull, exponential
      16                                                                                                                                                                                                                                                                                                                                                                    Data from Lessler et al 2009 using double interval-censored analysis
      17                                                                                                                                                                                                                                                                                                                                                                    Data from Lessler et al 2009 using single interval-censored analysis
      18                                                                                                            The mid-point of the exposure time was used to approximate an exact exposure time instead of interval-censoring. This can lead to a possible bias (overestimation) in incubation times. It was ambiguously reported whether the mean is the mean of the distribution or the meanlog parameter of the lognormal distribution.
      19                                                                                                                                                                                                                                                                      This study used an original data set and a modified data set. This weibull distribution was fitted to the modified data set and it is recommended to use this one.
      20                                                                                                                                                                                                               This study used an original data set and a modified data set. This gamma distribution was fitted to the original data set and it is recommended to use the weibull distribution that was fitted to the modified data set.
      21                                                                                                                                                                                                        This study fit the weibull distribution to estimate the parameters for the complete data set, those who had a fatal outcome and those with a non-fatal outcome. This is the distribution fit to the complete unpartitioned data.
      22                                                                                                                                                                                                                 This study fit the weibull distribution to estimate the parameters for the complete data set, those who had a fatal outcome and those with a non-fatal outcome. This is the distribution fit to the fatal outcome data.
      23                                                                                                                                                                                                             This study fit the weibull distribution to estimate the parameters for the complete data set, those who had a fatal outcome and those with a non-fatal outcome. This is the distribution fit to the non-fatal outcome data.
      24                                                                                                                                                                                                                                                                                                                                                 Pooled analysis on several data sets, see Rudolph et al 2014 for references of datasets
      25 This paper did not fit a distribution to the incubation period data and only reported a lower and upper range of the data. This is present in the database as there are no other studies that report the incubation period for Marburg virus. There is another incubation period reported from the same paper for a subset of the data which report the median and interquartile range but again do not fit a distribution to the data.
      26                                                                                                        This paper did not fit a distribution to the incubation period data and only reported a median and range for a subset of the data. This is present in the database as there are no other studies that report the incubation period for Marburg virus. This paper also reports the maximum and minimum for the complete data set.
      27                                                                                                                                                                                                                                                                                                                                                Pooled analysis on several data sets, see Lessler et al. 2009 for references of datasets
      28                                                                                                                                                                                                                                                                                                                                                Pooled analysis on several data sets, see Lessler et al. 2009 for references of datasets
      29                                                                                                                                                                                                                                                                                                                                                Pooled analysis on several data sets, see Lessler et al. 2009 for references of datasets
      30                                                                                                                                                                                                                                                                         Pooled analysis on several data sets, see Rudolph et al 2014 for references of datasets. Of the 18 samples at least 17 of them are not trasmitted by mosquitoes
      31                                                                                                                                                                                                                                                                                                                                                Pooled analysis on several data sets, see Lessler et al. 2009 for references of datasets
      32                                                                                                                                                                                                                                                                                                                                                                    Data from Lessler et al 2009 using double interval-censored analysis
      33                                                                                                                                                                                                                                                                                                                                                                    Data from Lessler et al 2009 using single interval-censored analysis
      34                                                                                                                                                                                                                                                                                                                                                Pooled analysis on several data sets, see Lessler et al. 2009 for references of datasets
      35                                                                                                                                                                                                                                                                                                                                                 Pooled analysis on several data sets, see Rudolph et al 2014 for references of datasets
      36                                                                                                                                                                                                                                                                       Pooled analysis on several data sets, see Rudolph et al 2014 for references of datasets. This is a subset of data containing only mosquito-transmitted infections
      37                                                                                                                                                                                                                                                              Pooled analysis on several data sets, see Rudolph et al 2014 for references of datasets. This is a subset of data containing only tramsission by transplant or transfusion
      38                                                                                                                                                                                                                                                                                                                                                 Pooled analysis on several data sets, see Rudolph et al 2014 for references of datasets
      39                                                                                                                                                                                                                                                                       Pooled analysis on several data sets, see Rudolph et al 2014 for references of datasets. This is a subset of data containing only mosquito-transmitted infections
      40                                                                                                                                                                                                                                                                                                                                                Pooled analysis on several data sets, see Lessler et al. 2016 for references of datasets
             PMID                            DOI
      1  19393959  10.1016/S1473-3099(09)70069-6
      2  24639305          10.4269/ajtmh.13-0403
      3  23226436   10.1371/journal.pone.0050972
      4  23226436   10.1371/journal.pone.0050972
      5  23226436   10.1371/journal.pone.0050972
      6  24639305          10.4269/ajtmh.13-0403
      7  24639305          10.4269/ajtmh.13-0403
      8  19393959  10.1016/S1473-3099(09)70069-7
      9  20029668       10.1371/currents.RRN1130
      10 19393959  10.1016/S1473-3099(09)70069-9
      11 19393959 10.1016/S1473-3099(09)70069-10
      12 19393959 10.1016/S1473-3099(09)70069-11
      13 20042754          10.1056/NEJMoa0906089
      14 21168422     10.1016/j.jtbi.2010.12.017
      15 21168422     10.1016/j.jtbi.2010.12.017
      16 19598148               10.1002/sim.3659
      17 19598148               10.1002/sim.3659
      18 19959592            10.1503/cmaj.091807
      19 26409239             10.1093/aje/kwv115
      20 26409239             10.1093/aje/kwv115
      21 26885816   10.1371/journal.pone.0148506
      22 26885816   10.1371/journal.pone.0148506
      23 26885816   10.1371/journal.pone.0148506
      24 24639305          10.4269/ajtmh.13-0403
      25 25495697        10.1186/1756-0500-7-906
      26 25495697        10.1186/1756-0500-7-906
      27 19393959 10.1016/S1473-3099(09)70069-12
      28 19393959 10.1016/S1473-3099(09)70069-13
      29 19393959 10.1016/S1473-3099(09)70069-15
      30 24639305          10.4269/ajtmh.13-0403
      31 19393959 10.1016/S1473-3099(09)70069-14
      32 19598148               10.1002/sim.3659
      33 19598148               10.1002/sim.3659
      34 19393959  10.1016/S1473-3099(09)70069-8
      35 24639305          10.4269/ajtmh.13-0403
      36 24639305          10.4269/ajtmh.13-0403
      37 24639305          10.4269/ajtmh.13-0403
      38 24639305          10.4269/ajtmh.13-0403
      39 24639305          10.4269/ajtmh.13-0403
      40 27821887          10.2471/BLT.16.174540

# list_distributions works for incubation period

    Code
      list_distributions(epiparam = eparam, epi_dist = "incubation_period")
    Output
                       disease  epi_distribution prob_distribution         author
      1             adenovirus incubation_period         lognormal   Lessler_etal
      2            chikungunya incubation_period         lognormal   Rudolph_etal
      3                 dengue incubation_period         lognormal Chan_Johansson
      4                 dengue incubation_period         lognormal Chan_Johansson
      5                 dengue incubation_period         lognormal Chan_Johansson
      6                 dengue incubation_period         lognormal   Rudolph_etal
      7                 dengue incubation_period         lognormal   Rudolph_etal
      8      human coronavirus incubation_period         lognormal   Lessler_etal
      9              influenza incubation_period             gamma     Ghani_etal
      10             influenza incubation_period         lognormal   Lessler_etal
      11             influenza incubation_period         lognormal   Lessler_etal
      12             influenza incubation_period         lognormal   Lessler_etal
      13             influenza incubation_period         lognormal   Lessler_etal
      14             influenza incubation_period             gamma Nishiura_Inaba
      15             influenza incubation_period           weibull Nishiura_Inaba
      16             influenza incubation_period         lognormal     Reich_etal
      17             influenza incubation_period         lognormal     Reich_etal
      18             influenza incubation_period         lognormal     Tuite_etal
      19             influenza incubation_period           weibull Virlogeux_etal
      20             influenza incubation_period             gamma Virlogeux_etal
      21             influenza incubation_period           weibull Virlogeux_etal
      22             influenza incubation_period           weibull Virlogeux_etal
      23             influenza incubation_period           weibull Virlogeux_etal
      24 Japanese encephalitis incubation_period         lognormal   Rudolph_etal
      25 marburg virus disease incubation_period              <NA>         Pavlin
      26 marburg virus disease incubation_period              <NA>         Pavlin
      27               measles incubation_period         lognormal   Lessler_etal
      28         parainfluenza incubation_period         lognormal   Lessler_etal
      29            rhinovirus incubation_period         lognormal   Lessler_etal
      30     Rift Valley fever incubation_period         lognormal   Rudolph_etal
      31                   RSV incubation_period         lognormal   Lessler_etal
      32                   RSV incubation_period         lognormal     Reich_etal
      33                   RSV incubation_period         lognormal     Reich_etal
      34                  SARS incubation_period         lognormal   Lessler_etal
      35       west nile fever incubation_period         lognormal   Rudolph_etal
      36       west nile fever incubation_period         lognormal   Rudolph_etal
      37       west nile fever incubation_period         lognormal   Rudolph_etal
      38          yellow fever incubation_period         lognormal   Rudolph_etal
      39          yellow fever incubation_period         lognormal   Rudolph_etal
      40    zika virus disease incubation_period         lognormal   Lessler_etal
         year sample_size
      1  2009          14
      2  2014          21
      3  2012         146
      4  2012         146
      5  2012         153
      6  2014         169
      7  2014         124
      8  2009          13
      9  2009          16
      10 2009         151
      11 2009          90
      12 2009          78
      13 2009         134
      14 2011          72
      15 2011          72
      16 2009         151
      17 2009         151
      18 2010         316
      19 2015         229
      20 2015         229
      21 2016         395
      22 2016         173
      23 2016         222
      24 2014           6
      25 2014          76
      26 2014          18
      27 2009          55
      28 2009          11
      29 2009          28
      30 2014          23
      31 2009          24
      32 2009          24
      33 2009          24
      34 2009         157
      35 2014          18
      36 2014           8
      37 2014           6
      38 2014          91
      39 2014          80
      40 2016          25

# list_distributions works for incubation, subset_db = FALSE

    Code
      list_distributions(epiparam = eparam, epi_dist = "incubation", subset_db = FALSE)
    Output
                       disease                    pathogen  epi_distribution
      1             adenovirus                  adenovirus incubation_period
      2            chikungunya           chikungunya virus incubation_period
      3                 dengue                dengue virus incubation_period
      4                 dengue                dengue virus incubation_period
      5                 dengue                dengue virus incubation_period
      6                 dengue                dengue virus incubation_period
      7                 dengue                dengue virus incubation_period
      8      human coronavirus                   human_CoV incubation_period
      9              influenza         influenza-A-H1N1pdm incubation_period
      10             influenza                 influenza-A incubation_period
      11             influenza                 influenza-A incubation_period
      12             influenza                 influenza-B incubation_period
      13             influenza            influenza-A-H1N1 incubation_period
      14             influenza            influenza-A-H1N1 incubation_period
      15             influenza            influenza-A-H1N1 incubation_period
      16             influenza                 influenza-A incubation_period
      17             influenza                 influenza-A incubation_period
      18             influenza            influenza-A-H1N1 incubation_period
      19             influenza            influenza-A-H7N9 incubation_period
      20             influenza            influenza-A-H7N9 incubation_period
      21             influenza            influenza-A-H7N9 incubation_period
      22             influenza            influenza-A-H7N9 incubation_period
      23             influenza            influenza-A-H7N9 incubation_period
      24 Japanese encephalitis Japanese encephalitis virus incubation_period
      25 marburg virus disease               marburg virus incubation_period
      26 marburg virus disease               marburg virus incubation_period
      27               measles               measles virus incubation_period
      28         parainfluenza         parainfluenza virus incubation_period
      29            rhinovirus                  rhinovirus incubation_period
      30     Rift Valley fever     Rift Valley fever virus incubation_period
      31                   RSV                         RSV incubation_period
      32                   RSV                         RSV incubation_period
      33                   RSV                         RSV incubation_period
      34                  SARS                  SARS-CoV-1 incubation_period
      35       west nile fever                   West Nile incubation_period
      36       west nile fever                   West Nile incubation_period
      37       west nile fever                   West Nile incubation_period
      38          yellow fever        yellow fever viruses incubation_period
      39          yellow fever        yellow fever viruses incubation_period
      40    zika virus disease                        zika incubation_period
                 author year sample_size        region vector_borne
      1    Lessler_etal 2009          14           USA        FALSE
      2    Rudolph_etal 2014          21         Mixed         TRUE
      3  Chan_Johansson 2012         146         Mixed         TRUE
      4  Chan_Johansson 2012         146         Mixed         TRUE
      5  Chan_Johansson 2012         153         Mixed         TRUE
      6    Rudolph_etal 2014         169         Mixed         TRUE
      7    Rudolph_etal 2014         124         Mixed         TRUE
      8    Lessler_etal 2009          13            UK        FALSE
      9      Ghani_etal 2009          16            UK        FALSE
      10   Lessler_etal 2009         151         Mixed        FALSE
      11   Lessler_etal 2009          90         Mixed        FALSE
      12   Lessler_etal 2009          78           USA        FALSE
      13   Lessler_etal 2009         134 New York, USA        FALSE
      14 Nishiura_Inaba 2011          72         Japan        FALSE
      15 Nishiura_Inaba 2011          72         Japan        FALSE
      16     Reich_etal 2009         151         Mixed        FALSE
      17     Reich_etal 2009         151         Mixed        FALSE
      18     Tuite_etal 2010         316        Canada        FALSE
      19 Virlogeux_etal 2015         229         China        FALSE
      20 Virlogeux_etal 2015         229         China        FALSE
      21 Virlogeux_etal 2016         395         China        FALSE
      22 Virlogeux_etal 2016         173         China        FALSE
      23 Virlogeux_etal 2016         222         China        FALSE
      24   Rudolph_etal 2014           6         Mixed         TRUE
      25         Pavlin 2014          76         Mixed        FALSE
      26         Pavlin 2014          18         Mixed        FALSE
      27   Lessler_etal 2009          55         Mixed        FALSE
      28   Lessler_etal 2009          11         Mixed        FALSE
      29   Lessler_etal 2009          28           USA        FALSE
      30   Rudolph_etal 2014          23         Mixed         TRUE
      31   Lessler_etal 2009          24         Mixed        FALSE
      32     Reich_etal 2009          24         Mixed        FALSE
      33     Reich_etal 2009          24         Mixed        FALSE
      34   Lessler_etal 2009         157         Mixed        FALSE
      35   Rudolph_etal 2014          18         Mixed         TRUE
      36   Rudolph_etal 2014           8         Mixed         TRUE
      37   Rudolph_etal 2014           6         Mixed         TRUE
      38   Rudolph_etal 2014          91         Mixed         TRUE
      39   Rudolph_etal 2014          80         Mixed         TRUE
      40   Lessler_etal 2016          25         Mixed         TRUE
                                     vector extrinsic prob_distribution
      1                                <NA>     FALSE         lognormal
      2                    Aedes albopictus     FALSE         lognormal
      3  Aedes aegypti and Aedes albopictus      TRUE         lognormal
      4  Aedes aegypti and Aedes albopictus      TRUE         lognormal
      5  Aedes aegypti and Aedes albopictus     FALSE         lognormal
      6  Aedes aegypti and Aedes albopictus     FALSE         lognormal
      7  Aedes aegypti and Aedes albopictus     FALSE         lognormal
      8                                <NA>     FALSE         lognormal
      9                                <NA>     FALSE             gamma
      10                               <NA>     FALSE         lognormal
      11                               <NA>     FALSE         lognormal
      12                               <NA>     FALSE         lognormal
      13                               <NA>     FALSE         lognormal
      14                               <NA>     FALSE             gamma
      15                               <NA>     FALSE           weibull
      16                               <NA>     FALSE         lognormal
      17                               <NA>     FALSE         lognormal
      18                               <NA>     FALSE         lognormal
      19                               <NA>     FALSE           weibull
      20                               <NA>     FALSE             gamma
      21                               <NA>     FALSE           weibull
      22                               <NA>     FALSE           weibull
      23                               <NA>     FALSE           weibull
      24                           mosquito     FALSE         lognormal
      25                               <NA>     FALSE              <NA>
      26                               <NA>     FALSE              <NA>
      27                               <NA>     FALSE         lognormal
      28                               <NA>     FALSE         lognormal
      29                               <NA>     FALSE         lognormal
      30                           mosquito     FALSE         lognormal
      31                               <NA>     FALSE         lognormal
      32                               <NA>     FALSE         lognormal
      33                               <NA>     FALSE         lognormal
      34                               <NA>     FALSE         lognormal
      35                           mosquito     FALSE         lognormal
      36                           mosquito     FALSE         lognormal
      37                           mosquito     FALSE         lognormal
      38                           mosquito     FALSE         lognormal
      39                           mosquito     FALSE         lognormal
      40 Aedes aegypti and Aedes albopictus     FALSE         lognormal
         inference_method  mean mean_ci_limits mean_ci   sd sd_ci_limits sd_ci
      1               mle    NA         NA, NA      NA   NA       NA, NA    NA
      2               mle    NA         NA, NA      NA   NA       NA, NA    NA
      3          bayesian 15.00         10, 20      95   NA       NA, NA    NA
      4          bayesian  6.50       4.8, 8.8      95   NA       NA, NA    NA
      5          bayesian  5.97       5.5, 6.4      95 1.64       NA, NA    NA
      6               mle    NA         NA, NA      NA   NA       NA, NA    NA
      7               mle    NA         NA, NA      NA   NA       NA, NA    NA
      8          bayesian    NA         NA, NA      NA   NA       NA, NA    NA
      9               mle  2.05         NA, NA      NA 0.49       NA, NA    NA
      10              mle    NA         NA, NA      NA   NA       NA, NA    NA
      11              mle    NA         NA, NA      NA   NA       NA, NA    NA
      12              mle    NA         NA, NA      NA   NA       NA, NA    NA
      13              mle    NA         NA, NA      NA   NA       NA, NA    NA
      14              mle    NA         NA, NA      NA   NA       NA, NA    NA
      15              mle    NA         NA, NA      NA   NA       NA, NA    NA
      16              mle    NA         NA, NA      NA   NA       NA, NA    NA
      17              mle    NA         NA, NA      NA   NA       NA, NA    NA
      18             <NA>  4.30       2.6, 6.6      95   NA       NA, NA    NA
      19              mle  3.40       3.0, 3.7      95 1.70       NA, NA    NA
      20              mle  4.50      2.8, 16.2      95 3.30       NA, NA    NA
      21         bayesian  3.50       3.2, 3.8      95   NA       NA, NA    NA
      22         bayesian  3.70       3.4, 4.1      95   NA       NA, NA    NA
      23         bayesian  3.30       2.9, 3.6      95   NA       NA, NA    NA
      24              mle    NA         NA, NA      NA   NA       NA, NA    NA
      25             <NA>    NA         NA, NA      NA   NA       NA, NA    NA
      26             <NA>    NA         NA, NA      NA   NA       NA, NA    NA
      27              mle    NA         NA, NA      NA   NA       NA, NA    NA
      28              mle    NA         NA, NA      NA   NA       NA, NA    NA
      29              mle    NA         NA, NA      NA   NA       NA, NA    NA
      30              mle    NA         NA, NA      NA   NA       NA, NA    NA
      31              mle    NA         NA, NA      NA   NA       NA, NA    NA
      32              mle    NA         NA, NA      NA   NA       NA, NA    NA
      33              mle    NA         NA, NA      NA   NA       NA, NA    NA
      34              mle    NA         NA, NA      NA   NA       NA, NA    NA
      35              mle    NA         NA, NA      NA   NA       NA, NA    NA
      36              mle    NA         NA, NA      NA   NA       NA, NA    NA
      37              mle    NA         NA, NA      NA   NA       NA, NA    NA
      38              mle    NA         NA, NA      NA   NA       NA, NA    NA
      39              mle    NA         NA, NA      NA   NA       NA, NA    NA
      40         bayesian    NA         NA, NA      NA   NA       NA, NA    NA
         quantile_025 quantile_05 quantile_25 median median_ci_limits median_ci
      1            NA          NA         4.8   5.60         4.8, 6.3        95
      2            NA          NA         2.9   3.00         0.5, 3.1        95
      3           5.0          NA          NA     NA           NA, NA        NA
      4           2.4          NA          NA     NA           NA, NA        NA
      5           3.4          NA          NA     NA           NA, NA        NA
      6            NA          NA         4.5   5.60         5.3, 6.0        95
      7            NA          NA         4.3   5.30         5.0, 5.7        95
      8            NA          NA         2.9   3.20         2.8, 3.7        95
      9            NA          NA          NA     NA           NA, NA        NA
      10           NA        0.70         1.1   1.40         1.3, 1.5        95
      11           NA        1.40         1.7   1.90         1.8, 2.0        95
      12           NA        0.30         0.4   0.60         0.5, 0.6        95
      13           NA        0.90          NA   1.40         1.0, 1.8        95
      14           NA          NA          NA   1.51       1.47, 1.55        95
      15           NA          NA          NA   1.43       1.21, 1.65        95
      16           NA        0.73          NA   1.46       1.35, 1.57        95
      17           NA        0.73          NA   1.43       1.33, 1.54        95
      18           NA          NA          NA   4.00           NA, NA        NA
      19           NA          NA          NA     NA           NA, NA        NA
      20           NA          NA          NA     NA           NA, NA        NA
      21           NA          NA          NA     NA           NA, NA        NA
      22           NA          NA          NA     NA           NA, NA        NA
      23           NA          NA          NA     NA           NA, NA        NA
      24           NA          NA         8.1   8.40         5.1, 9.4        95
      25           NA          NA          NA     NA           NA, NA        NA
      26           NA          NA          NA   7.00           NA, NA        NA
      27           NA        8.90        10.9  12.50       11.8, 13.3        95
      28           NA          NA         2.1   2.60         2.1, 3.1        95
      29           NA        0.80         1.3   1.90         1.4, 2.4        95
      30           NA          NA         3.1   4.00         3.4, 4.9        95
      31           NA        3.10         3.8   4.40         3.9, 4.9        95
      32           NA        3.05          NA   4.41       3.90, 4.92        95
      33           NA        3.11          NA   4.41       3.89, 4.94        95
      34           NA        1.50         2.7   4.00         3.6, 4.4        95
      35           NA        1.00         1.7   2.60         1.6, 3.5        95
      36           NA          NA         2.8   2.90         0.5, 3.1        95
      37           NA          NA         8.7  10.80        8.4, 14.2        95
      38           NA        1.90         3.2   4.40             4, 5        95
      39           NA        1.90         3.1   4.40         3.9, 5.0        95
      40           NA        3.20         4.6   5.90         4.4, 7.6        95
         quantile_75 quantile_875 quantile_95 quantile_975 lower_range upper_range
      1          6.5           NA          NA           NA          NA          NA
      2          3.0           NA          NA           NA          NA          NA
      3           NA           NA          NA           33          NA          NA
      4           NA           NA          NA           15          NA          NA
      5           NA           NA          NA           10          NA          NA
      6          7.1           NA          NA           NA          NA          NA
      7          6.6           NA          NA           NA          NA          NA
      8          3.5           NA          NA           NA          NA          NA
      9           NA           NA          NA           NA          NA          NA
      10         1.9           NA        2.80           NA          NA          NA
      11         2.2           NA        2.70           NA          NA          NA
      12         0.7           NA        1.10           NA          NA          NA
      13          NA           NA        2.20           NA          NA          NA
      14          NA           NA        3.43           NA          NA          NA
      15          NA           NA        3.18           NA          NA          NA
      16          NA           NA        2.94           NA          NA          NA
      17          NA           NA        2.83           NA          NA          NA
      18          NA           NA          NA           NA          NA          NA
      19          NA           NA        6.50           NA          NA          NA
      20          NA           NA       11.00           NA          NA          NA
      21          NA           NA          NA           NA          NA          NA
      22          NA           NA          NA           NA          NA          NA
      23          NA           NA          NA           NA          NA          NA
      24         8.6           NA          NA           NA          NA          NA
      25          NA           NA          NA           NA           2          26
      26          NA           NA          NA           NA           2          13
      27        14.4           NA       17.70           NA          NA          NA
      28         3.2           NA          NA           NA          NA          NA
      29         2.7           NA        4.50           NA          NA          NA
      30         5.3           NA          NA           NA          NA          NA
      31          NA           NA        6.30           NA          NA          NA
      32          NA           NA        6.39           NA          NA          NA
      33          NA           NA        6.26           NA          NA          NA
      34         5.9           NA       10.60           NA          NA          NA
      35         3.8           NA        7.00           NA          NA          NA
      36         3.0           NA          NA           NA          NA          NA
      37        13.3           NA          NA           NA          NA          NA
      38         6.3           NA       10.30           NA          NA          NA
      39         6.2           NA       10.30           NA          NA          NA
      40         7.6           NA       11.20           NA          NA          NA
         shape shape_ci_limits shape_ci scale scale_ci_limits scale_ci meanlog
      1     NA          NA, NA       NA    NA          NA, NA       NA      NA
      2     NA          NA, NA       NA    NA          NA, NA       NA      NA
      3     NA          NA, NA       NA    NA          NA, NA       NA      NA
      4     NA          NA, NA       NA    NA          NA, NA       NA      NA
      5     NA          NA, NA       NA    NA          NA, NA       NA    1.75
      6     NA          NA, NA       NA    NA          NA, NA       NA      NA
      7     NA          NA, NA       NA    NA          NA, NA       NA      NA
      8     NA          NA, NA       NA    NA          NA, NA       NA      NA
      9     NA          NA, NA       NA    NA          NA, NA       NA      NA
      10    NA          NA, NA       NA    NA          NA, NA       NA      NA
      11    NA          NA, NA       NA    NA          NA, NA       NA      NA
      12    NA          NA, NA       NA    NA          NA, NA       NA      NA
      13    NA          NA, NA       NA    NA          NA, NA       NA      NA
      14  3.27          NA, NA       NA  0.51          NA, NA       NA      NA
      15  1.74          NA, NA       NA  1.83          NA, NA       NA      NA
      16    NA          NA, NA       NA    NA          NA, NA       NA      NA
      17    NA          NA, NA       NA    NA          NA, NA       NA      NA
      18    NA          NA, NA       NA    NA          NA, NA       NA      NA
      19    NA          NA, NA       NA    NA          NA, NA       NA      NA
      20    NA          NA, NA       NA    NA          NA, NA       NA      NA
      21    NA          NA, NA       NA    NA          NA, NA       NA      NA
      22  2.30      1.80, 2.89       95  4.21      3.62, 4.85       95      NA
      23  2.03      1.62, 2.52       95  3.74      3.20, 4.36       95      NA
      24    NA          NA, NA       NA    NA          NA, NA       NA      NA
      25    NA          NA, NA       NA    NA          NA, NA       NA      NA
      26    NA          NA, NA       NA    NA          NA, NA       NA      NA
      27    NA          NA, NA       NA    NA          NA, NA       NA      NA
      28    NA          NA, NA       NA    NA          NA, NA       NA      NA
      29    NA          NA, NA       NA    NA          NA, NA       NA      NA
      30    NA          NA, NA       NA    NA          NA, NA       NA      NA
      31    NA          NA, NA       NA    NA          NA, NA       NA      NA
      32    NA          NA, NA       NA    NA          NA, NA       NA      NA
      33    NA          NA, NA       NA    NA          NA, NA       NA      NA
      34    NA          NA, NA       NA    NA          NA, NA       NA      NA
      35    NA          NA, NA       NA    NA          NA, NA       NA      NA
      36    NA          NA, NA       NA    NA          NA, NA       NA      NA
      37    NA          NA, NA       NA    NA          NA, NA       NA      NA
      38    NA          NA, NA       NA    NA          NA, NA       NA      NA
      39    NA          NA, NA       NA    NA          NA, NA       NA      NA
      40    NA          NA, NA       NA    NA          NA, NA       NA      NA
         meanlog_ci_limits meanlog_ci sdlog sdlog_ci_limits sdlog_ci dispersion
      1             NA, NA         NA    NA          NA, NA       NA       1.26
      2             NA, NA         NA    NA          NA, NA       NA       1.04
      3             NA, NA         NA    NA          NA, NA       NA         NA
      4             NA, NA         NA    NA          NA, NA       NA         NA
      5             NA, NA         NA  0.27          NA, NA       NA         NA
      6             NA, NA         NA    NA          NA, NA       NA       1.41
      7             NA, NA         NA    NA          NA, NA       NA       1.37
      8             NA, NA         NA    NA          NA, NA       NA       1.15
      9             NA, NA         NA    NA          NA, NA       NA         NA
      10            NA, NA         NA    NA          NA, NA       NA       1.51
      11            NA, NA         NA    NA          NA, NA       NA       1.23
      12            NA, NA         NA    NA          NA, NA       NA       1.51
      13            NA, NA         NA    NA          NA, NA       NA         NA
      14            NA, NA         NA    NA          NA, NA       NA         NA
      15            NA, NA         NA    NA          NA, NA       NA         NA
      16            NA, NA         NA    NA          NA, NA       NA       1.53
      17            NA, NA         NA    NA          NA, NA       NA       1.51
      18            NA, NA         NA    NA          NA, NA       NA         NA
      19            NA, NA         NA    NA          NA, NA       NA         NA
      20            NA, NA         NA    NA          NA, NA       NA         NA
      21            NA, NA         NA    NA          NA, NA       NA         NA
      22            NA, NA         NA    NA          NA, NA       NA         NA
      23            NA, NA         NA    NA          NA, NA       NA         NA
      24            NA, NA         NA    NA          NA, NA       NA       1.04
      25            NA, NA         NA    NA          NA, NA       NA         NA
      26            NA, NA         NA    NA          NA, NA       NA         NA
      27            NA, NA         NA    NA          NA, NA       NA       1.23
      28            NA, NA         NA    NA          NA, NA       NA       1.35
      29            NA, NA         NA    NA          NA, NA       NA       1.68
      30            NA, NA         NA    NA          NA, NA       NA       1.50
      31            NA, NA         NA    NA          NA, NA       NA       1.24
      32            NA, NA         NA    NA          NA, NA       NA       1.25
      33            NA, NA         NA    NA          NA, NA       NA       1.24
      34            NA, NA         NA    NA          NA, NA       NA       1.81
      35            NA, NA         NA    NA          NA, NA       NA       1.82
      36            NA, NA         NA    NA          NA, NA       NA       1.04
      37            NA, NA         NA    NA          NA, NA       NA       1.35
      38            NA, NA         NA    NA          NA, NA       NA       1.66
      39            NA, NA         NA    NA          NA, NA       NA       1.67
      40            NA, NA         NA    NA          NA, NA       NA       1.50
         dispersion_ci_limits dispersion_ci precision precision_ci_limits
      1            1.13, 1.38            95        NA              NA, NA
      2            1.04, 1.08            95        NA              NA, NA
      3                NA, NA            NA        NA              NA, NA
      4                NA, NA            NA       4.9            2.8, 7.5
      5                NA, NA            NA      13.7          10.9, 16.9
      6            1.34, 1.50            95        NA              NA, NA
      7            1.27, 1.52            95        NA              NA, NA
      8            1.07, 1.34            95        NA              NA, NA
      9                NA, NA            NA        NA              NA, NA
      10           1.43, 1.60            95        NA              NA, NA
      11           1.17, 1.29            95        NA              NA, NA
      12           1.37, 1.64            95        NA              NA, NA
      13               NA, NA            NA        NA              NA, NA
      14               NA, NA            NA        NA              NA, NA
      15               NA, NA            NA        NA              NA, NA
      16           1.44, 1.61            95        NA              NA, NA
      17           1.43, 1.60            95        NA              NA, NA
      18               NA, NA            NA        NA              NA, NA
      19               NA, NA            NA        NA              NA, NA
      20               NA, NA            NA        NA              NA, NA
      21               NA, NA            NA        NA              NA, NA
      22               NA, NA            NA        NA              NA, NA
      23               NA, NA            NA        NA              NA, NA
      24           1.04, 1.05            95        NA              NA, NA
      25               NA, NA            NA        NA              NA, NA
      26               NA, NA            NA        NA              NA, NA
      27           1.18, 1.28            95        NA              NA, NA
      28           1.16, 1.55            95        NA              NA, NA
      29           1.36, 2.01            95        NA              NA, NA
      30           1.22, 1.82            95        NA              NA, NA
      31           1.13, 1.35            95        NA              NA, NA
      32           1.14, 1.36            95        NA              NA, NA
      33           1.12, 1.35            95        NA              NA, NA
      34           1.67, 1.95            95        NA              NA, NA
      35           1.27, 2.67            95        NA              NA, NA
      36           1.04, 1.29            95        NA              NA, NA
      37           1.12, 1.47            95        NA              NA, NA
      38           1.48, 1.82            95        NA              NA, NA
      39           1.47, 1.84            95        NA              NA, NA
      40             1.2, 1.9            95        NA              NA, NA
         precision_ci truncation discretised censored right_truncated
      1            NA         NA       FALSE     TRUE           FALSE
      2            NA         NA       FALSE     TRUE           FALSE
      3            NA         NA       FALSE     TRUE           FALSE
      4            95         NA       FALSE     TRUE           FALSE
      5            95         NA       FALSE     TRUE           FALSE
      6            NA         NA       FALSE     TRUE           FALSE
      7            NA         NA       FALSE     TRUE           FALSE
      8            NA         NA       FALSE     TRUE           FALSE
      9            NA         NA       FALSE     TRUE           FALSE
      10           NA         NA       FALSE     TRUE           FALSE
      11           NA         NA       FALSE     TRUE           FALSE
      12           NA         NA       FALSE     TRUE           FALSE
      13           NA         NA       FALSE     TRUE           FALSE
      14           NA         NA       FALSE     TRUE           FALSE
      15           NA         NA       FALSE     TRUE           FALSE
      16           NA         NA       FALSE     TRUE           FALSE
      17           NA         NA       FALSE     TRUE           FALSE
      18           NA         NA       FALSE    FALSE           FALSE
      19           NA         NA       FALSE     TRUE           FALSE
      20           NA         NA       FALSE     TRUE           FALSE
      21           NA         NA       FALSE     TRUE           FALSE
      22           NA         NA       FALSE     TRUE           FALSE
      23           NA         NA       FALSE     TRUE           FALSE
      24           NA         NA       FALSE     TRUE           FALSE
      25           NA         NA       FALSE    FALSE           FALSE
      26           NA         NA       FALSE    FALSE           FALSE
      27           NA         NA       FALSE     TRUE           FALSE
      28           NA         NA       FALSE     TRUE           FALSE
      29           NA         NA       FALSE     TRUE           FALSE
      30           NA         NA       FALSE     TRUE           FALSE
      31           NA         NA       FALSE     TRUE           FALSE
      32           NA         NA       FALSE     TRUE           FALSE
      33           NA         NA       FALSE     TRUE           FALSE
      34           NA         NA       FALSE     TRUE           FALSE
      35           NA         NA       FALSE     TRUE           FALSE
      36           NA         NA       FALSE     TRUE           FALSE
      37           NA         NA       FALSE     TRUE           FALSE
      38           NA         NA       FALSE     TRUE           FALSE
      39           NA         NA       FALSE     TRUE           FALSE
      40           NA         NA       FALSE     TRUE           FALSE
         phase_bias_adjusted
      1                FALSE
      2                FALSE
      3                FALSE
      4                FALSE
      5                FALSE
      6                FALSE
      7                FALSE
      8                FALSE
      9                FALSE
      10               FALSE
      11               FALSE
      12               FALSE
      13               FALSE
      14                TRUE
      15                TRUE
      16               FALSE
      17               FALSE
      18               FALSE
      19               FALSE
      20               FALSE
      21               FALSE
      22               FALSE
      23               FALSE
      24               FALSE
      25               FALSE
      26               FALSE
      27               FALSE
      28               FALSE
      29               FALSE
      30               FALSE
      31               FALSE
      32               FALSE
      33               FALSE
      34               FALSE
      35               FALSE
      36               FALSE
      37               FALSE
      38               FALSE
      39               FALSE
      40               FALSE
                                                                                                                                                                                                                                                                                                                                                                                                                                           notes
      1                                                                                                        Analysis on data from Commission on Acute Respiratory Disease. Experimental transmission of minor respiratory illness to human volunteers by filter-passing agents. I. Demonstration of two types of illness characterized by long and short incubation periods and diff erent clinical features. J Clin Invest 1947; 26: 957–82.
      2                                                                                                                                                                                                                                                                                                                                                  Pooled analysis on several data sets, see Rudolph et al 2014 for references of datasets
      3                                                                                                                                                                                                                                                                                                                                                                               Extrinsic incubation period for data at 25 degrees celcius
      4                                                                                                                                                                                                                                                                                                                                                                               Extrinsic incubation period for data at 30 degrees celcius
      5                                                                                                                                                                                                                                                                                                                                     Standard deviation, meanlog and sdlog is taken from Siraj et al. 2017 <10.1371/journal.pntd.0005797>
      6                                                                                                                                                                                                                                                                                                                                                  Pooled analysis on several data sets, see Rudolph et al 2014 for references of datasets
      7                                                                                                                                                                                                                                                                        Pooled analysis on several data sets, see Rudolph et al 2014 for references of datasets. This is a subset of data containing only mosquito-transmitted infections
      8                                                                                                                                                                                                                                                                                          Analysis on data from  Bradburne AF, Bynoe ML, Tyrrell DA. Eff ects of a “new” human respiratory virus in volunteers. Br Med J 1967; 3: 767–69.
      9                                                                                                                                                                                                                                                                                                                                                                                                                     No additional notes.
      10                                                                                                                                                                                                                                                                                                                                                Pooled analysis on several data sets, see Lessler et al. 2009 for references of datasets
      11                                                                                                                                                                   These estimates for the incubation period of influenza A from Lessler et al. 2009 are different from the estimates from the complete data, as they remove Henle et al. 1945 J Immunol, as it is an outlier in the dataset (n=61). Values found at the bottom Table 3.
      12                                                                                                                                                                                                                                                                                                                                                Pooled analysis on several data sets, see Lessler et al. 2009 for references of datasets
      13                                                                                                                                                                                                                                                                                                                                                                                                                    No additional notes.
      14                                                                                                                                                                                                                                                                                                                                                    Gamma and weibull distributions had equally good fit to the data. Gamma, exponential
      15                                                                                                                                                                                                                                                                                                                                                  Gamma and weibull distributions had equally good fit to the data. Weibull, exponential
      16                                                                                                                                                                                                                                                                                                                                                                    Data from Lessler et al 2009 using double interval-censored analysis
      17                                                                                                                                                                                                                                                                                                                                                                    Data from Lessler et al 2009 using single interval-censored analysis
      18                                                                                                            The mid-point of the exposure time was used to approximate an exact exposure time instead of interval-censoring. This can lead to a possible bias (overestimation) in incubation times. It was ambiguously reported whether the mean is the mean of the distribution or the meanlog parameter of the lognormal distribution.
      19                                                                                                                                                                                                                                                                      This study used an original data set and a modified data set. This weibull distribution was fitted to the modified data set and it is recommended to use this one.
      20                                                                                                                                                                                                               This study used an original data set and a modified data set. This gamma distribution was fitted to the original data set and it is recommended to use the weibull distribution that was fitted to the modified data set.
      21                                                                                                                                                                                                        This study fit the weibull distribution to estimate the parameters for the complete data set, those who had a fatal outcome and those with a non-fatal outcome. This is the distribution fit to the complete unpartitioned data.
      22                                                                                                                                                                                                                 This study fit the weibull distribution to estimate the parameters for the complete data set, those who had a fatal outcome and those with a non-fatal outcome. This is the distribution fit to the fatal outcome data.
      23                                                                                                                                                                                                             This study fit the weibull distribution to estimate the parameters for the complete data set, those who had a fatal outcome and those with a non-fatal outcome. This is the distribution fit to the non-fatal outcome data.
      24                                                                                                                                                                                                                                                                                                                                                 Pooled analysis on several data sets, see Rudolph et al 2014 for references of datasets
      25 This paper did not fit a distribution to the incubation period data and only reported a lower and upper range of the data. This is present in the database as there are no other studies that report the incubation period for Marburg virus. There is another incubation period reported from the same paper for a subset of the data which report the median and interquartile range but again do not fit a distribution to the data.
      26                                                                                                        This paper did not fit a distribution to the incubation period data and only reported a median and range for a subset of the data. This is present in the database as there are no other studies that report the incubation period for Marburg virus. This paper also reports the maximum and minimum for the complete data set.
      27                                                                                                                                                                                                                                                                                                                                                Pooled analysis on several data sets, see Lessler et al. 2009 for references of datasets
      28                                                                                                                                                                                                                                                                                                                                                Pooled analysis on several data sets, see Lessler et al. 2009 for references of datasets
      29                                                                                                                                                                                                                                                                                                                                                Pooled analysis on several data sets, see Lessler et al. 2009 for references of datasets
      30                                                                                                                                                                                                                                                                         Pooled analysis on several data sets, see Rudolph et al 2014 for references of datasets. Of the 18 samples at least 17 of them are not trasmitted by mosquitoes
      31                                                                                                                                                                                                                                                                                                                                                Pooled analysis on several data sets, see Lessler et al. 2009 for references of datasets
      32                                                                                                                                                                                                                                                                                                                                                                    Data from Lessler et al 2009 using double interval-censored analysis
      33                                                                                                                                                                                                                                                                                                                                                                    Data from Lessler et al 2009 using single interval-censored analysis
      34                                                                                                                                                                                                                                                                                                                                                Pooled analysis on several data sets, see Lessler et al. 2009 for references of datasets
      35                                                                                                                                                                                                                                                                                                                                                 Pooled analysis on several data sets, see Rudolph et al 2014 for references of datasets
      36                                                                                                                                                                                                                                                                       Pooled analysis on several data sets, see Rudolph et al 2014 for references of datasets. This is a subset of data containing only mosquito-transmitted infections
      37                                                                                                                                                                                                                                                              Pooled analysis on several data sets, see Rudolph et al 2014 for references of datasets. This is a subset of data containing only tramsission by transplant or transfusion
      38                                                                                                                                                                                                                                                                                                                                                 Pooled analysis on several data sets, see Rudolph et al 2014 for references of datasets
      39                                                                                                                                                                                                                                                                       Pooled analysis on several data sets, see Rudolph et al 2014 for references of datasets. This is a subset of data containing only mosquito-transmitted infections
      40                                                                                                                                                                                                                                                                                                                                                Pooled analysis on several data sets, see Lessler et al. 2016 for references of datasets
             PMID                            DOI
      1  19393959  10.1016/S1473-3099(09)70069-6
      2  24639305          10.4269/ajtmh.13-0403
      3  23226436   10.1371/journal.pone.0050972
      4  23226436   10.1371/journal.pone.0050972
      5  23226436   10.1371/journal.pone.0050972
      6  24639305          10.4269/ajtmh.13-0403
      7  24639305          10.4269/ajtmh.13-0403
      8  19393959  10.1016/S1473-3099(09)70069-7
      9  20029668       10.1371/currents.RRN1130
      10 19393959  10.1016/S1473-3099(09)70069-9
      11 19393959 10.1016/S1473-3099(09)70069-10
      12 19393959 10.1016/S1473-3099(09)70069-11
      13 20042754          10.1056/NEJMoa0906089
      14 21168422     10.1016/j.jtbi.2010.12.017
      15 21168422     10.1016/j.jtbi.2010.12.017
      16 19598148               10.1002/sim.3659
      17 19598148               10.1002/sim.3659
      18 19959592            10.1503/cmaj.091807
      19 26409239             10.1093/aje/kwv115
      20 26409239             10.1093/aje/kwv115
      21 26885816   10.1371/journal.pone.0148506
      22 26885816   10.1371/journal.pone.0148506
      23 26885816   10.1371/journal.pone.0148506
      24 24639305          10.4269/ajtmh.13-0403
      25 25495697        10.1186/1756-0500-7-906
      26 25495697        10.1186/1756-0500-7-906
      27 19393959 10.1016/S1473-3099(09)70069-12
      28 19393959 10.1016/S1473-3099(09)70069-13
      29 19393959 10.1016/S1473-3099(09)70069-15
      30 24639305          10.4269/ajtmh.13-0403
      31 19393959 10.1016/S1473-3099(09)70069-14
      32 19598148               10.1002/sim.3659
      33 19598148               10.1002/sim.3659
      34 19393959  10.1016/S1473-3099(09)70069-8
      35 24639305          10.4269/ajtmh.13-0403
      36 24639305          10.4269/ajtmh.13-0403
      37 24639305          10.4269/ajtmh.13-0403
      38 24639305          10.4269/ajtmh.13-0403
      39 24639305          10.4269/ajtmh.13-0403
      40 27821887          10.2471/BLT.16.174540

# list_distributions works for different distribution

    Code
      list_distributions(epiparam = eparam, epi_dist = "serial_interval")
    Output
                      disease epi_distribution prob_distribution        author year
      1             influenza  serial_interval             gamma    Ghani_etal 2009
      2 marburg virus disease  serial_interval             gamma Ajelli_Merler 2012
      3 marburg virus disease  serial_interval              <NA>        Pavlin 2014
        sample_size
      1          58
      2         374
      3          38

# list_distributions works for different dist, subset_db = FALSE

    Code
      list_distributions(epiparam = eparam, epi_dist = "serial_interval", subset_db = FALSE)
    Output
                      disease            pathogen epi_distribution        author year
      1             influenza influenza-A-H1N1pdm  serial_interval    Ghani_etal 2009
      2 marburg virus disease       marburg virus  serial_interval Ajelli_Merler 2012
      3 marburg virus disease       marburg virus  serial_interval        Pavlin 2014
        sample_size region vector_borne vector extrinsic prob_distribution
      1          58     UK        FALSE   <NA>     FALSE             gamma
      2         374 Angola        FALSE   <NA>     FALSE             gamma
      3          38  Mixed        FALSE   <NA>     FALSE              <NA>
        inference_method mean mean_ci_limits mean_ci   sd sd_ci_limits sd_ci
      1              mle 2.51         NA, NA      NA 1.55       NA, NA    NA
      2             <NA> 9.00      8.2, 10.0      95 5.40     3.9, 8.6    95
      3             <NA>   NA         NA, NA      NA   NA       NA, NA    NA
        quantile_025 quantile_05 quantile_25 median median_ci_limits median_ci
      1           NA          NA          NA     NA           NA, NA        NA
      2           NA          NA          NA     NA           NA, NA        NA
      3           NA          NA           8     11           NA, NA        NA
        quantile_75 quantile_875 quantile_95 quantile_975 lower_range upper_range
      1          NA           NA          NA           NA          NA          NA
      2          NA           NA          NA           NA          NA          NA
      3          15           NA          NA           NA          NA          NA
        shape shape_ci_limits shape_ci scale scale_ci_limits scale_ci meanlog
      1    NA          NA, NA       NA    NA          NA, NA       NA      NA
      2    NA          NA, NA       NA    NA          NA, NA       NA      NA
      3    NA          NA, NA       NA    NA          NA, NA       NA      NA
        meanlog_ci_limits meanlog_ci sdlog sdlog_ci_limits sdlog_ci dispersion
      1            NA, NA         NA    NA          NA, NA       NA         NA
      2            NA, NA         NA    NA          NA, NA       NA         NA
      3            NA, NA         NA    NA          NA, NA       NA         NA
        dispersion_ci_limits dispersion_ci precision precision_ci_limits precision_ci
      1               NA, NA            NA        NA              NA, NA           NA
      2               NA, NA            NA        NA              NA, NA           NA
      3               NA, NA            NA        NA              NA, NA           NA
        truncation discretised censored right_truncated phase_bias_adjusted
      1         NA       FALSE     TRUE           FALSE               FALSE
      2         NA       FALSE    FALSE           FALSE               FALSE
      3         NA       FALSE    FALSE           FALSE               FALSE
                                                                                                                                                                                                                                                                                                                                    notes
      1                                                                                                                                                                                                                                                                                                              No additional notes.
      2 The generation time is estimated from non-human viral load data. This paper reports the generation time but assumes the generation time and serial interval are the same it is classified as serial interval here based on Van Kerkove et al. 2015 <10.1038/sdata.2015.19>. The sample size is take from Van Kerkove et al. 2015.
      3                                                                                            This paper did not fit a distribution to the serial interval data and only reported a median and interquartile range. This is present in the database as there are no other studies that report the serial interval for Marburg virus.
            PMID                          DOI
      1 20029668     10.1371/currents.RRN1130
      2 23251407 10.1371/journal.pone.0050948
      3 25495697      10.1186/1756-0500-7-906

