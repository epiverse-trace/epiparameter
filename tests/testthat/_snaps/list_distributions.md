# list_distributions works for incubation, params = FALSE

    Code
      list_distributions(delay_dist = "incubation", parameters = FALSE)
    Output
                  pathogen_id        study_id year size distribution
      1            adenovirus    Lessler_etal 2009   14        lnorm
      3                 ebola        WHO_team 2014  500        gamma
      6             human_CoV    Lessler_etal 2009   13        lnorm
      7  influenza_A_seasonal    Lessler_etal 2009  122        lnorm
      8  influenza_B_seasonal    Lessler_etal 2009   76        lnorm
      9       influenza_H1N1p      Ghani_etal 2009   16        gamma
      10      influenza_H1N1p      Tuite_etal 2010  316        lnorm
      12       influenza_H7N9    Cowling_etal 2013   32      weibull
      14       influenza_H5N1    Cowling_etal 2013   27      weibull
      16              marburg          Pavlin 2014   18        gamma
      17              measles    Lessler_etal 2009   56        lnorm
      18             MERS_CoV     Assiri_etal 2013   23        lnorm
      21             MERS_CoV Cauchemez_et_al 2014    7        lnorm
      22            monkeypox           Nolen 2016   16        lnorm
      23            monkeypox  Thornhill_etal 2022   23        lnorm
      25        parainfluenza    Lessler_etal 2009   11        lnorm
      26           rhinovirus    Lessler_etal 2009   28        lnorm
      27                  RSV    Lessler_etal 2009   24        lnorm
      28             SARS_CoV   Donnelly_etal 2003   57        gamma
      30             SARS_CoV    Lessler_etal 2009  157        lnorm
      34  SARS_CoV_2_wildtype    McAloon_etal 2020 1269        lnorm

# list_distributions works for incubation, params = TRUE

    Code
      list_distributions(delay_dist = "incubation", parameters = TRUE)
    Output
                  pathogen_id    type_id        study_id year size distribution mean
      1            adenovirus incubation    Lessler_etal 2009   14        lnorm   NA
      3                 ebola incubation        WHO_team 2014  500        gamma 9.10
      6             human_CoV incubation    Lessler_etal 2009   13        lnorm   NA
      7  influenza_A_seasonal incubation    Lessler_etal 2009  122        lnorm   NA
      8  influenza_B_seasonal incubation    Lessler_etal 2009   76        lnorm   NA
      9       influenza_H1N1p incubation      Ghani_etal 2009   16        gamma 2.05
      10      influenza_H1N1p incubation      Tuite_etal 2010  316        lnorm 4.30
      12       influenza_H7N9 incubation    Cowling_etal 2013   32      weibull 3.10
      14       influenza_H5N1 incubation    Cowling_etal 2013   27      weibull 3.30
      16              marburg incubation          Pavlin 2014   18        gamma   NA
      17              measles incubation    Lessler_etal 2009   56        lnorm   NA
      18             MERS_CoV incubation     Assiri_etal 2013   23        lnorm   NA
      21             MERS_CoV incubation Cauchemez_et_al 2014    7        lnorm 5.50
      22            monkeypox incubation           Nolen 2016   16        lnorm 9.60
      23            monkeypox incubation  Thornhill_etal 2022   23        lnorm   NA
      25        parainfluenza incubation    Lessler_etal 2009   11        lnorm   NA
      26           rhinovirus incubation    Lessler_etal 2009   28        lnorm   NA
      27                  RSV incubation    Lessler_etal 2009   24        lnorm   NA
      28             SARS_CoV incubation   Donnelly_etal 2003   57        gamma 6.40
      30             SARS_CoV incubation    Lessler_etal 2009  157        lnorm   NA
      34  SARS_CoV_2_wildtype incubation    McAloon_etal 2020 1269        lnorm   NA
                sd quantile_025    median quantile_75 quantile_875 quantile_95
      1         NA           NA  5.600000    6.500000           NA          NA
      3  7.3000000           NA        NA          NA           NA          NA
      6         NA           NA  3.200000    3.500000           NA          NA
      7         NA           NA  1.400000    1.900000           NA          NA
      8         NA           NA  0.600000    0.700000           NA          NA
      9  0.4898979           NA        NA          NA           NA          NA
      10        NA           NA  4.000000          NA           NA          NA
      12 1.4000000    0.6870932  2.887973    3.888880           NA    5.489237
      14 1.5000000    0.6870932  3.088366    4.288508           NA    5.989652
      16        NA           NA  7.000000          NA           NA          NA
      17        NA           NA 12.500000   14.400000           NA   17.700000
      18        NA           NA  5.200000          NA           NA   12.400000
      21 2.5000000           NA        NA          NA           NA          NA
      22        NA           NA  9.000000          NA           13          NA
      23        NA           NA  7.000000          NA           NA          NA
      25        NA           NA  2.600000    3.200000           NA          NA
      26        NA           NA  1.900000    2.700000           NA          NA
      27        NA           NA  4.400000    5.100000           NA          NA
      28 4.0800000           NA        NA          NA           NA   14.220000
      30        NA           NA  4.000000    5.900000           NA          NA
      34        NA           NA  5.100000          NA           NA   11.700000
         quantile_975 lower_range upper_range     shape     scale    meanlog
      1            NA          NA          NA        NA        NA  1.7227644
      3            NA          NA          NA  1.553950 5.8560440         NA
      6            NA          NA          NA        NA        NA  1.1631463
      7            NA          NA          NA        NA        NA  0.3364708
      8            NA          NA          NA        NA        NA -0.5108280
      9            NA          NA          NA 17.503120 0.1171220         NA
      10     6.600000          NA          NA        NA        NA  1.3862944
      12     5.989652          NA          NA  2.309241 3.3759410         NA
      14     6.589681          NA          NA  2.185908 3.6932670         NA
      16           NA           2          13  1.946138 0.5324265         NA
      17           NA          NA          NA        NA        NA  2.5257260
      18    14.700000          NA          NA        NA        NA  1.6486586
      21           NA          NA          NA        NA        NA  1.6108401
      22           NA          NA          NA        NA        NA  2.1783545
      23           NA          NA          NA        NA        NA         NA
      25           NA          NA          NA        NA        NA  0.9555123
      26           NA          NA          NA        NA        NA  0.6418529
      27           NA          NA          NA        NA        NA  1.4816021
      28           NA          NA          NA  2.431210 2.6200900         NA
      30           NA          NA          NA        NA        NA  1.3862935
      34           NA          NA          NA        NA        NA  1.6300000
             sdlog extracted discretised phase_bias_adjusted
      1  0.2209673       yes          no                  no
      3         NA       yes        <NA>                <NA>
      6  0.1328705       yes          no                  no
      7  0.4527634       yes          no                  no
      8  0.2285515       yes          no                  no
      9         NA       yes        <NA>                <NA>
      10 0.2554986       yes        <NA>                <NA>
      12        NA       yes          no                  no
      14        NA       yes          no                  no
      16        NA       yes          no                  no
      17 0.2097952       yes          no                  no
      18 0.5283368       yes        <NA>                <NA>
      21 0.4333775       yes        <NA>                <NA>
      22 0.3360684       yes          no                <NA>
      23        NA       yes          no                  no
      25 0.3078528       yes          no                  no
      26 0.5209872       yes          no                  no
      27 0.2188927       yes          no                  no
      28        NA       yes          no                  no
      30 0.5762278       yes          no                  no
      34 0.5000000        no          no                  no
                                                   notes     PMID
      1                                             <NA> 19393959
      3                 Extracted using single exposures 25564903
      6                                             <NA> 19393959
      7                                             <NA> 19393959
      8                                             <NA> 19393959
      9                                             <NA> 20029668
      10                                            <NA> 19959592
      12    extraction used quantile_025 and quantile_75 23803488
      14    extraction used quantile_025 and quantile_75 23803488
      16                    gamma assumed, range 2 to 13 25495697
      17                                            <NA> 19393959
      18     extracted using quantile_5 and quantile_975 23782161
      21                                            <NA> 24239323
      22   Extracted taking c(6,13) as central 75% range 27191380
      23 Extracted from range 3 to 21, lognormal assumed 35866746
      25                                            <NA> 19393959
      26                                            <NA> 19393959
      27                                            <NA> 19393959
      28                                            <NA> 12781533
      30                                            <NA> 19393959
      34                                            <NA> 32801208
                                     DOI       added_by
      1    10.1016/S1473-3099(09)70069-6 Adam Kucharski
      3            10.1056/nejmoa1411100 Adam Kucharski
      6    10.1016/S1473-3099(09)70069-6 Adam Kucharski
      7    10.1016/S1473-3099(09)70069-6 Adam Kucharski
      8    10.1016/S1473-3099(09)70069-6 Adam Kucharski
      9         10.1371/currents.RRN1130 Adam Kucharski
      10             10.1503/cmaj.091807 Adam Kucharski
      12   10.1016/S0140-6736(13)61171-X Adam Kucharski
      14   10.1016/S0140-6736(13)61171-X Adam Kucharski
      16 10.1186/1756-0500-7-906         Adam Kucharski
      17   10.1016/S1473-3099(09)70069-6 Adam Kucharski
      18           10.1056/NEJMoa1306742 Adam Kucharski
      21   10.1016/S1473-3099(13)70304-9 Adam Kucharski
      22          10.3201/eid2206.150579       Seb Funk
      23           10.1056/NEJMoa2207323               
      25   10.1016/S1473-3099(09)70069-6 Adam Kucharski
      26   10.1016/S1473-3099(09)70069-6 Adam Kucharski
      27   10.1016/S1473-3099(09)70069-6 Adam Kucharski
      28   10.1016/S0140-6736(03)13410-1 Adam Kucharski
      30   10.1016/S1473-3099(09)70069-6 Adam Kucharski
      34     10.1136/bmjopen-2020-039652 Adam Kucharski

# list_distributions works for onset_to_admission, params = FALSE

    Code
      list_distributions(delay_dist = "onset_to_admission", parameters = FALSE)
    Output
                 pathogen_id      study_id year size distribution
      4                ebola      WHO_team 2014  500        gamma
      11     influenza_H1N1p     Jain_etal 2009  272        lnorm
      13      influenza_H7N9  Cowling_etal 2013  123        gamma
      15      influenza_H5N1  Cowling_etal 2013   43      weibull
      19            MERS_CoV   Assiri_etal 2013   23        lnorm
      29            SARS_CoV Donnelly_etal 2003   57        gamma
      32 SARS_CoV_2_wildtype   Linton_etal 2020  155        lnorm

# list_distributions works for onset_to_admission, params = TRUE

    Code
      list_distributions(delay_dist = "onset_to_admission", parameters = TRUE)
    Output
                 pathogen_id            type_id      study_id year size distribution
      4                ebola onset_to_admission      WHO_team 2014  500        gamma
      11     influenza_H1N1p onset_to_admission     Jain_etal 2009  272        lnorm
      13      influenza_H7N9 onset_to_admission  Cowling_etal 2013  123        gamma
      15      influenza_H5N1 onset_to_admission  Cowling_etal 2013   43      weibull
      19            MERS_CoV onset_to_admission   Assiri_etal 2013   23        lnorm
      29            SARS_CoV onset_to_admission Donnelly_etal 2003   57        gamma
      32 SARS_CoV_2_wildtype onset_to_admission   Linton_etal 2020  155        lnorm
         mean    sd quantile_025 median quantile_75 quantile_875 quantile_95
      4  5.00  4.70           NA     NA          NA           NA          NA
      11   NA    NA           NA    3.0          NA           NA          NA
      13   NA    NA    0.6172617    4.2    6.170223           NA    9.622302
      15   NA    NA    1.3678290    4.9    6.770349           NA   10.222554
      19   NA    NA           NA    5.0          NA           NA          NA
      29 4.85  3.49           NA     NA          NA           NA          NA
      32 9.70 35.20           NA    2.6          NA           NA   35.100000
         quantile_975 lower_range upper_range    shape    scale   meanlog     sdlog
      4            NA          NA          NA 1.131734 4.418000        NA        NA
      11           NA          NA          NA       NA       NA 1.0986120 2.9115800
      13     10.82306          NA          NA 2.138094 2.153314        NA        NA
      15     11.42344          NA          NA 2.373396 6.438843        NA        NA
      19           NA           1          10       NA       NA 1.6089493 0.6103889
      29           NA          NA          NA 1.929655 2.513402        NA        NA
      32           NA          NA          NA       NA       NA 0.9466094 1.6281993
         extracted discretised phase_bias_adjusted
      4        yes        <NA>                <NA>
      11       yes        <NA>                <NA>
      13       yes          no                  no
      15       yes          no                  no
      19       yes        <NA>                <NA>
      29       yes        <NA>                <NA>
      32       yes          no                 yes
                                                    notes     PMID
      4                                              <NA> 25564903
      11 Extracted using range 0 to 18, lognormal assumed 19815859
      13     extraction used quantile_025 and quantile_75 23803488
      15     extraction used quantile_025 and quantile_95 23803488
      19                                             <NA> 23782161
      29                                 Feb-26 to Mar-25 12781533
      32                              For living patients 32079150
                                   DOI       added_by
      4          10.1056/nejmoa1411100 Adam Kucharski
      11         10.1056/NEJMoa0906695 Adam Kucharski
      13 10.1016/S0140-6736(13)61171-X Adam Kucharski
      15 10.1016/S0140-6736(13)61171-X Adam Kucharski
      19         10.1056/NEJMoa1306742 Adam Kucharski
      29 10.1016/S0140-6736(03)13410-1 Adam Kucharski
      32            10.3390/jcm9020538 Adam Kucharski

# list_distributions works for onset_to_death, params = FALSE

    Code
      list_distributions(delay_dist = "onset_to_death", parameters = FALSE)
    Output
                 pathogen_id    study_id year size distribution
      5                ebola    WHO_team 2014  500        gamma
      33 SARS_CoV_2_wildtype Linton_etal 2020   39        lnorm

# list_distributions works for onset_to_death, params = TRUE

    Code
      list_distributions(delay_dist = "onset_to_death", parameters = TRUE)
    Output
                 pathogen_id        type_id    study_id year size distribution mean
      5                ebola onset_to_death    WHO_team 2014  500        gamma  7.5
      33 SARS_CoV_2_wildtype onset_to_death Linton_etal 2020   39        lnorm 20.2
           sd quantile_025 median quantile_75 quantile_875 quantile_95 quantile_975
      5   6.8           NA     NA          NA           NA          NA           NA
      33 11.6           NA   17.1          NA           NA        39.9           NA
         lower_range upper_range    shape    scale  meanlog     sdlog extracted
      5           NA          NA 1.216479 6.165333       NA        NA       yes
      33          NA          NA       NA       NA 2.863179 0.5338606       yes
         discretised phase_bias_adjusted notes     PMID                   DOI
      5         <NA>                <NA>  <NA> 25564903 10.1056/nejmoa1411100
      33          no                 yes  <NA>       NA                      
               added_by
      5  Adam Kucharski
      33               

# list_distributions works for serial_interval, params = FALSE

    Code
      list_distributions(delay_dist = "serial_interval", parameters = FALSE)
    Output
         pathogen_id          study_id year size distribution
      2        ebola WHO_response_team 2014   92        gamma
      20    MERS_CoV       Assiri_etal 2013   23        lnorm
      24   monkeypox             UKHSA 2022   17        gamma

# list_distributions works for serial_interval, params = TRUE

    Code
      list_distributions(delay_dist = "serial_interval", parameters = TRUE)
    Output
         pathogen_id         type_id          study_id year size distribution mean
      2        ebola serial_interval WHO_response_team 2014   92        gamma 15.3
      20    MERS_CoV serial_interval       Assiri_etal 2013   23        lnorm   NA
      24   monkeypox serial_interval             UKHSA 2022   17        gamma  9.8
          sd quantile_025 median quantile_75 quantile_875 quantile_95 quantile_975
      2  9.3           NA     NA          NA           NA          NA           NA
      20  NA           NA    7.6          NA           NA        19.4         23.1
      24 8.3           NA     NA          NA           NA          NA           NA
         lower_range upper_range    shape    scale meanlog sdlog extracted
      2           NA          NA 2.706556 5.652941      NA    NA       yes
      20          NA          NA       NA       NA    2.02  0.56       yes
      24          NA          NA 1.394107 7.029592      NA    NA       yes
         discretised phase_bias_adjusted                                      notes
      2         <NA>                <NA>                                       <NA>
      20        <NA>                <NA>                                       <NA>
      24          no                 yes Extracted from mean and SD, assuming gamma
             PMID
      2  25564903
      20 23782161
      24       NA
                                                                                                                                                             DOI
      2                                                                                                                                    10.1056/nejmoa1411100
      20                                                                                                                                   10.1056/NEJMoa1306742
      24 https://www.gov.uk/government/publications/monkeypox-outbreak-technical-briefings/investigation-into-monkeypox-outbreak-in-england-technical-briefing-1
               added_by
      2  Adam Kucharski
      20 Adam Kucharski
      24       Seb Funk

