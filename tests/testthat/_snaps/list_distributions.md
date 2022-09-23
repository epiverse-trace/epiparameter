# list_distributions works for incubation, params = FALSE

    Code
      list_distributions(type = "incubation", parameters = FALSE)
    Output
      # A tibble: 19 x 5
         pathogen_ID          study_ID         year  size distribution
         <chr>                <chr>           <dbl> <dbl> <chr>       
       1 adenovirus           Lessler_etal     2009    14 lnorm       
       2 ebola                WHO_team         2014   500 gamma       
       3 human_CoV            Lessler_etal     2009    13 lnorm       
       4 influenza_A_seasonal Lessler_etal     2009   122 lnorm       
       5 influenza_B_seasonal Lessler_etal     2009    76 lnorm       
       6 influenza_H1N1p      Ghani_etal       2009    16 gamma       
       7 influenza_H1N1p      Tuite_etal       2010   316 lnorm       
       8 influenza_H7N9       Cowling_etal     2013    32 gamma       
       9 marburg              Martini_etal     1973     5 gamma       
      10 measles              Lessler_etal     2009    56 lnorm       
      11 MERS_CoV             Cauchemez_et_al  2014     7 lnorm       
      12 MERS_CoV             Assiri_etal      2013    23 lnorm       
      13 parainfluenza        Lessler_etal     2009    11 lnorm       
      14 rhinovirus           Lessler_etal     2009    28 lnorm       
      15 RSV                  Lessler_etal     2009    24 lnorm       
      16 SARS_CoV             Donnelly_etal    2003    57 gamma       
      17 SARS_CoV             Lessler_etal     2009   157 lnorm       
      18 SARS_CoV_2_wildtype  McAloon_etal     2020  1269 lnorm       
      19 monkeypox            Nolen            2016    16 lnorm       

# list_distributions works for incubation, params = TRUE

    Code
      list_distributions(type = "incubation", parameters = TRUE)
    Output
      # A tibble: 19 x 22
         pathogen_ID    type_ID study~1  year  size distr~2  mean    sd median 75_qu~3
         <chr>          <chr>   <chr>   <dbl> <dbl> <chr>   <dbl> <dbl>  <dbl>   <dbl>
       1 adenovirus     incuba~ Lessle~  2009    14 lnorm   NA    NA       5.6     6.5
       2 ebola          incuba~ WHO_te~  2014   500 gamma   NA    NA      NA      NA  
       3 human_CoV      incuba~ Lessle~  2009    13 lnorm   NA    NA       3.2     3.5
       4 influenza_A_s~ incuba~ Lessle~  2009   122 lnorm   NA    NA       1.4     1.9
       5 influenza_B_s~ incuba~ Lessle~  2009    76 lnorm   NA    NA       0.6     0.7
       6 influenza_H1N~ incuba~ Ghani_~  2009    16 gamma   NA    NA      NA      NA  
       7 influenza_H1N~ incuba~ Tuite_~  2010   316 lnorm   NA    NA      NA      NA  
       8 influenza_H7N9 incuba~ Cowlin~  2013    32 gamma   NA    NA      NA      NA  
       9 marburg        incuba~ Martin~  1973     5 gamma   NA    NA      NA      NA  
      10 measles        incuba~ Lessle~  2009    56 lnorm   NA    NA      12.5    14.4
      11 MERS_CoV       incuba~ Cauche~  2014     7 lnorm   NA    NA      NA      NA  
      12 MERS_CoV       incuba~ Assiri~  2013    23 lnorm   NA    NA      NA      NA  
      13 parainfluenza  incuba~ Lessle~  2009    11 lnorm   NA    NA       2.6     3.2
      14 rhinovirus     incuba~ Lessle~  2009    28 lnorm   NA    NA       1.9     2.7
      15 RSV            incuba~ Lessle~  2009    24 lnorm   NA    NA       4.4     5.1
      16 SARS_CoV       incuba~ Donnel~  2003    57 gamma    4.85  3.49   NA      NA  
      17 SARS_CoV       incuba~ Lessle~  2009   157 lnorm   NA    NA       4       5.9
      18 SARS_CoV_2_wi~ incuba~ McAloo~  2020  1269 lnorm   NA    NA      NA      NA  
      19 monkeypox      incuba~ Nolen    2016    16 lnorm    9.6  NA       9      NA  
      # ... with 12 more variables: `95_quantile` <lgl>, shape <dbl>, scale <dbl>,
      #   meanlog <dbl>, sdlog <dbl>, extracted <chr>, discretised <chr>,
      #   phase_bias_adjusted <chr>, notes <chr>, PMID <dbl>, DOI <chr>,
      #   added_by <chr>, and abbreviated variable names 1: study_ID,
      #   2: distribution, 3: `75_quantile`

# list_distributions works for onset_to_admission, params = FALSE

    Code
      list_distributions(type = "onset_to_admission", parameters = FALSE)
    Output
      # A tibble: 5 x 5
        pathogen_ID     study_ID       year  size distribution
        <chr>           <chr>         <dbl> <dbl> <chr>       
      1 ebola           WHO_team       2014   500 gamma       
      2 influenza_H1N1p Tuite_etal     2010   316 lnorm       
      3 influenza_H7N9  Cowling_etal   2013    32 gamma       
      4 MERS_CoV        Assiri_etal    2013    23 lnorm       
      5 SARS_CoV        Donnelly_etal  2003    57 gamma       

# list_distributions works for onset_to_admission, params = TRUE

    Code
      list_distributions(type = "onset_to_admission", parameters = TRUE)
    Output
      # A tibble: 5 x 22
        patho~1 type_ID study~2  year  size distr~3  mean    sd median 75_qu~4 95_qu~5
        <chr>   <chr>   <chr>   <dbl> <dbl> <chr>   <dbl> <dbl>  <dbl>   <dbl> <lgl>  
      1 ebola   onset_~ WHO_te~  2014   500 gamma      NA    NA     NA      NA NA     
      2 influe~ onset_~ Tuite_~  2010   316 lnorm      NA    NA     NA      NA NA     
      3 influe~ onset_~ Cowlin~  2013    32 gamma      NA    NA     NA      NA NA     
      4 MERS_C~ onset_~ Assiri~  2013    23 lnorm      NA    NA     NA      NA NA     
      5 SARS_C~ onset_~ Donnel~  2003    57 gamma      NA    NA     NA      NA NA     
      # ... with 11 more variables: shape <dbl>, scale <dbl>, meanlog <dbl>,
      #   sdlog <dbl>, extracted <chr>, discretised <chr>, phase_bias_adjusted <chr>,
      #   notes <chr>, PMID <dbl>, DOI <chr>, added_by <chr>, and abbreviated
      #   variable names 1: pathogen_ID, 2: study_ID, 3: distribution,
      #   4: `75_quantile`, 5: `95_quantile`

# list_distributions works for onset_to_death, params = FALSE

    Code
      list_distributions(type = "onset_to_death", parameters = FALSE)
    Output
      # A tibble: 1 x 5
        pathogen_ID         study_ID     year  size distribution
        <chr>               <chr>       <dbl> <dbl> <chr>       
      1 SARS_CoV_2_wildtype Linton_etal  2020    23 lnorm       

# list_distributions works for onset_to_death, params = TRUE

    Code
      list_distributions(type = "onset_to_death", parameters = TRUE)
    Output
      # A tibble: 1 x 22
        patho~1 type_ID study~2  year  size distr~3  mean    sd median 75_qu~4 95_qu~5
        <chr>   <chr>   <chr>   <dbl> <dbl> <chr>   <dbl> <dbl>  <dbl>   <dbl> <lgl>  
      1 SARS_C~ onset_~ Linton~  2020    23 lnorm      NA    NA     NA      NA NA     
      # ... with 11 more variables: shape <dbl>, scale <dbl>, meanlog <dbl>,
      #   sdlog <dbl>, extracted <chr>, discretised <chr>, phase_bias_adjusted <chr>,
      #   notes <chr>, PMID <dbl>, DOI <chr>, added_by <chr>, and abbreviated
      #   variable names 1: pathogen_ID, 2: study_ID, 3: distribution,
      #   4: `75_quantile`, 5: `95_quantile`

# list_distributions works for serial_interval, params = FALSE

    Code
      list_distributions(type = "serial_interval", parameters = FALSE)
    Output
      # A tibble: 3 x 5
        pathogen_ID         study_ID           year  size distribution
        <chr>               <chr>             <dbl> <dbl> <chr>       
      1 ebola               WHO_response_team  2014    92 gamma       
      2 SARS_CoV_2_wildtype Ferretti_etal      2020   191 lnorm       
      3 monkeypox           UKHSA              2022   336 lnorm       

# list_distributions works for serial_interval, params = TRUE

    Code
      list_distributions(type = "serial_interval", parameters = TRUE)
    Output
      # A tibble: 3 x 22
        patho~1 type_ID study~2  year  size distr~3  mean    sd median 75_qu~4 95_qu~5
        <chr>   <chr>   <chr>   <dbl> <dbl> <chr>   <dbl> <dbl>  <dbl>   <dbl> <lgl>  
      1 ebola   serial~ WHO_re~  2014    92 gamma      NA    NA     NA      NA NA     
      2 SARS_C~ serial~ Ferret~  2020   191 lnorm      NA    NA     NA      NA NA     
      3 monkey~ serial~ UKHSA    2022   336 lnorm      NA    NA     NA      NA NA     
      # ... with 11 more variables: shape <dbl>, scale <dbl>, meanlog <dbl>,
      #   sdlog <dbl>, extracted <chr>, discretised <chr>, phase_bias_adjusted <chr>,
      #   notes <chr>, PMID <dbl>, DOI <chr>, added_by <chr>, and abbreviated
      #   variable names 1: pathogen_ID, 2: study_ID, 3: distribution,
      #   4: `75_quantile`, 5: `95_quantile`

