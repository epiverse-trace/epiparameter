# list_distributions works for incubation, params = FALSE

    Code
      list_distributions(delay_dist = "incubation", parameters = FALSE)
    Output
                  pathogen_id        study_id year size distribution
      1            adenovirus    Lessler_etal 2009   14        lnorm
      2                 ebola        WHO_team 2014  500        gamma
      3             human_CoV    Lessler_etal 2009   13        lnorm
      4  influenza_A_seasonal    Lessler_etal 2009  122        lnorm
      5  influenza_B_seasonal    Lessler_etal 2009   76        lnorm
      6       influenza_H1N1p      Ghani_etal 2009   16        gamma
      7       influenza_H1N1p      Tuite_etal 2010  316        lnorm
      8        influenza_H7N9    Cowling_etal 2013   32        gamma
      9               marburg    Martini_etal 1973    5        gamma
      10              measles    Lessler_etal 2009   56        lnorm
      11             MERS_CoV Cauchemez_et_al 2014    7        lnorm
      12             MERS_CoV     Assiri_etal 2013   23        lnorm
      13        parainfluenza    Lessler_etal 2009   11        lnorm
      14           rhinovirus    Lessler_etal 2009   28        lnorm
      15                  RSV    Lessler_etal 2009   24        lnorm
      16             SARS_CoV   Donnelly_etal 2003   57        gamma
      17             SARS_CoV    Lessler_etal 2009  157        lnorm
      18  SARS_CoV_2_wildtype    McAloon_etal 2020 1269        lnorm
      19            monkeypox           Nolen 2016   16        lnorm

# list_distributions works for incubation, params = TRUE

    Code
      list_distributions(delay_dist = "incubation", parameters = TRUE)
    Output
                  pathogen_id    type_id        study_id year size distribution mean
      1            adenovirus incubation    Lessler_etal 2009   14        lnorm   NA
      2                 ebola incubation        WHO_team 2014  500        gamma   NA
      3             human_CoV incubation    Lessler_etal 2009   13        lnorm   NA
      4  influenza_A_seasonal incubation    Lessler_etal 2009  122        lnorm   NA
      5  influenza_B_seasonal incubation    Lessler_etal 2009   76        lnorm   NA
      6       influenza_H1N1p incubation      Ghani_etal 2009   16        gamma   NA
      7       influenza_H1N1p incubation      Tuite_etal 2010  316        lnorm   NA
      8        influenza_H7N9 incubation    Cowling_etal 2013   32        gamma   NA
      9               marburg incubation    Martini_etal 1973    5        gamma   NA
      10              measles incubation    Lessler_etal 2009   56        lnorm   NA
      11             MERS_CoV incubation Cauchemez_et_al 2014    7        lnorm   NA
      12             MERS_CoV incubation     Assiri_etal 2013   23        lnorm   NA
      13        parainfluenza incubation    Lessler_etal 2009   11        lnorm   NA
      14           rhinovirus incubation    Lessler_etal 2009   28        lnorm   NA
      15                  RSV incubation    Lessler_etal 2009   24        lnorm   NA
      16             SARS_CoV incubation   Donnelly_etal 2003   57        gamma 4.85
      17             SARS_CoV incubation    Lessler_etal 2009  157        lnorm   NA
      18  SARS_CoV_2_wildtype incubation    McAloon_etal 2020 1269        lnorm   NA
      19            monkeypox incubation           Nolen 2016   16        lnorm 9.60
           sd median quantile_75 quantile_95    shape    scale    meanlog     sdlog
      1    NA    5.6         6.5          NA       NA       NA  1.7227644 0.2209673
      2    NA     NA          NA          NA  5.53404 0.921569         NA        NA
      3    NA    3.2         3.5          NA       NA       NA  1.1631462 0.1328705
      4    NA    1.4         1.9          NA       NA       NA  0.3364708 0.4527634
      5    NA    0.6         0.7          NA       NA       NA -0.5108280 0.2285515
      6    NA     NA          NA          NA  8.40278 0.654545         NA        NA
      7    NA     NA          NA          NA       NA       NA  1.4294700 0.2414530
      8    NA     NA          NA          NA  4.93000 0.630000         NA        NA
      9    NA     NA          NA          NA 43.26710 0.157163         NA        NA
      10   NA   12.5        14.4          NA       NA       NA  2.5257260 0.2097952
      11   NA     NA          NA          NA       NA       NA  1.7047500 1.7047500
      12   NA     NA          NA          NA       NA       NA  1.5430400 0.4596070
      13   NA    2.6         3.2          NA       NA       NA  0.9555123 0.3078528
      14   NA    1.9         2.7          NA       NA       NA  0.6418529 0.5209872
      15   NA    4.4         5.1          NA       NA       NA  1.4816021 0.2188927
      16 3.49     NA          NA          NA  2.43121 2.620090         NA        NA
      17   NA    4.0         5.9          NA       NA       NA  1.3862935 0.5762278
      18   NA     NA          NA          NA       NA       NA  1.6300000 0.5000000
      19   NA    9.0          NA          NA       NA       NA  2.1783545 0.3360684
         extracted discretised phase_bias_adjusted
      1        yes          no                  no
      2       <NA>        <NA>                <NA>
      3        yes          no                  no
      4        yes          no                  no
      5        yes          no                  no
      6       <NA>        <NA>                <NA>
      7       <NA>        <NA>                <NA>
      8       <NA>        <NA>                <NA>
      9       <NA>        <NA>                <NA>
      10       yes          no                  no
      11      <NA>        <NA>                <NA>
      12      <NA>        <NA>                <NA>
      13       yes          no                  no
      14       yes          no                  no
      15       yes          no                  no
      16       yes          no                  no
      17       yes          no                  no
      18        no          no                  no
      19       yes          no                <NA>
                                                 notes     PMID
      1                                           <NA> 19393959
      2                                           <NA> 25564903
      3                                           <NA> 19393959
      4                                           <NA> 19393959
      5                                           <NA> 19393959
      6                                           <NA> 20029668
      7                                           <NA> 19959592
      8                                           <NA> 23803488
      9                                           <NA>  4207635
      10                                          <NA> 19393959
      11                                          <NA> 24239323
      12                                          <NA> 23782161
      13                                          <NA> 19393959
      14                                          <NA> 19393959
      15                                          <NA> 19393959
      16                                          <NA> 12781533
      17                                          <NA> 19393959
      18                                          <NA> 32801208
      19 Extracted taking c(6,13) as central 75% range 27191380
                                   DOI       added_by
      1  10.1016/S1473-3099(09)70069-6 Adam Kucharski
      2           10.1056/NEJMc1413884 Adam Kucharski
      3  10.1016/S1473-3099(09)70069-6 Adam Kucharski
      4  10.1016/S1473-3099(09)70069-6 Adam Kucharski
      5  10.1016/S1473-3099(09)70069-6 Adam Kucharski
      6       10.1371/currents.RRN1130 Adam Kucharski
      7            10.1503/cmaj.091807 Adam Kucharski
      8  10.1016/S0140-6736(13)61171-X Adam Kucharski
      9        10.1136/pgmj.49.574.542 Adam Kucharski
      10 10.1016/S1473-3099(09)70069-6 Adam Kucharski
      11 10.1016/S1473-3099(13)70304-9 Adam Kucharski
      12         10.1056/NEJMoa1306742 Adam Kucharski
      13 10.1016/S1473-3099(09)70069-6 Adam Kucharski
      14 10.1016/S1473-3099(09)70069-6 Adam Kucharski
      15 10.1016/S1473-3099(09)70069-6 Adam Kucharski
      16 10.1016/S0140-6736(03)13410-1 Adam Kucharski
      17 10.1016/S1473-3099(09)70069-6 Adam Kucharski
      18   10.1136/bmjopen-2020-039652 Adam Kucharski
      19        10.3201/eid2206.150579       Seb Funk

# list_distributions works for onset_to_admission, params = FALSE

    Code
      list_distributions(delay_dist = "onset_to_admission", parameters = FALSE)
    Output
            pathogen_id      study_id year size distribution
      1           ebola      WHO_team 2014  500        gamma
      2 influenza_H1N1p    Tuite_etal 2010  316        lnorm
      3  influenza_H7N9  Cowling_etal 2013   32        gamma
      4        MERS_CoV   Assiri_etal 2013   23        lnorm
      5        SARS_CoV Donnelly_etal 2003   57        gamma

# list_distributions works for onset_to_admission, params = TRUE

    Code
      list_distributions(delay_dist = "onset_to_admission", parameters = TRUE)
    Output
            pathogen_id            type_id      study_id year size distribution mean
      1           ebola onset_to_admission      WHO_team 2014  500        gamma   NA
      2 influenza_H1N1p onset_to_admission    Tuite_etal 2010  316        lnorm   NA
      3  influenza_H7N9 onset_to_admission  Cowling_etal 2013   32        gamma   NA
      4        MERS_CoV onset_to_admission   Assiri_etal 2013   23        lnorm   NA
      5        SARS_CoV onset_to_admission Donnelly_etal 2003   57        gamma   NA
        sd median quantile_75 quantile_95    shape    scale meanlog    sdlog
      1 NA     NA          NA          NA 5.534040 0.921569      NA       NA
      2 NA     NA          NA          NA       NA       NA 2.17531 0.330773
      3 NA     NA          NA          NA 9.650000 0.450000      NA       NA
      4 NA     NA          NA          NA 7.000000 0.750000      NA       NA
      5 NA     NA          NA          NA 1.929655 2.513402      NA       NA
        extracted discretised phase_bias_adjusted            notes     PMID
      1       yes        <NA>                <NA>             <NA> 25564903
      2      <NA>        <NA>                <NA>             <NA> 19959592
      3      <NA>        <NA>                <NA>             <NA> 23803488
      4      <NA>        <NA>                <NA>             <NA> 23782161
      5      <NA>        <NA>                <NA> Feb-26 to Mar-25 12781533
                                  DOI       added_by
      1          10.1056/NEJMc1413884 Adam Kucharski
      2           10.1503/cmaj.091807 Adam Kucharski
      3 10.1016/S0140-6736(13)61171-X Adam Kucharski
      4         10.1056/NEJMoa1306742 Adam Kucharski
      5 10.1016/S0140-6736(03)13410-1 Adam Kucharski

# list_distributions works for onset_to_death, params = FALSE

    Code
      list_distributions(delay_dist = "onset_to_death", parameters = FALSE)
    Output
                pathogen_id    study_id year size distribution
      1 SARS_CoV_2_wildtype Linton_etal 2020   23        lnorm

# list_distributions works for onset_to_death, params = TRUE

    Code
      list_distributions(delay_dist = "onset_to_death", parameters = TRUE)
    Output
                pathogen_id        type_id    study_id year size distribution mean sd
      1 SARS_CoV_2_wildtype onset_to_death Linton_etal 2020   23        lnorm   NA NA
        median quantile_75 quantile_95 shape scale  meanlog     sdlog extracted
      1     NA          NA          NA    NA    NA 2.863179 0.5338606        no
        discretised phase_bias_adjusted notes     PMID                DOI
      1        <NA>                <NA>  <NA> 32079150 10.3390/jcm9020538
              added_by
      1 Adam Kucharski

# list_distributions works for serial_interval, params = FALSE

    Code
      list_distributions(delay_dist = "serial_interval", parameters = FALSE)
    Output
                pathogen_id          study_id year size distribution
      1               ebola WHO_response_team 2014   92        gamma
      2 SARS_CoV_2_wildtype     Ferretti_etal 2020  191        lnorm
      3           monkeypox             UKHSA 2022  336        lnorm

# list_distributions works for serial_interval, params = TRUE

    Code
      list_distributions(delay_dist = "serial_interval", parameters = TRUE)
    Output
                pathogen_id         type_id          study_id year size distribution
      1               ebola serial_interval WHO_response_team 2014   92        gamma
      2 SARS_CoV_2_wildtype serial_interval     Ferretti_etal 2020  191        lnorm
      3           monkeypox serial_interval             UKHSA 2022  336        lnorm
        mean sd median quantile_75 quantile_95    shape    scale  meanlog     sdlog
      1   NA NA     NA          NA          NA 2.706556 5.652941       NA        NA
      2   NA NA     NA          NA          NA       NA       NA 1.386294 0.6970598
      3   NA NA     NA          NA          NA       NA       NA 2.419172 0.3286863
        extracted discretised phase_bias_adjusted
      1       yes        <NA>                <NA>
      2        no        <NA>                <NA>
      3       yes          no                <NA>
                                         notes     PMID
      1                                   <NA> 25564903
      2                    20/1/2020-21/3/2020 32234805
      3 Extracted taking c(5.9,21.4) as 95% CI       NA
                                                                                                                                                            DOI
      1                                                                                                                                    10.1056/NEJMc1413884
      2                                                                                                                                 10.1126/science.abb6936
      3 https://www.gov.uk/government/publications/monkeypox-outbreak-technical-briefings/investigation-into-monkeypox-outbreak-in-england-technical-briefing-1
              added_by
      1 Adam Kucharski
      2   Rachael Pung
      3       Seb Funk

