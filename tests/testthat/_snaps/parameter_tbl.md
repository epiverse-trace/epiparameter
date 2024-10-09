# parameter_tbl works as expected supplied with db

    Code
      dist_tbl
    Output
      # Parameter table:
      # A data frame:    125 x 7
         disease          pathogen epi_name prob_distribution author  year sample_size
         <chr>            <chr>    <chr>    <chr>             <chr>  <dbl>       <dbl>
       1 Adenovirus       Adenovi~ incubat~ lnorm             Lessl~  2009          14
       2 Human Coronavir~ Human_C~ incubat~ lnorm             Lessl~  2009          13
       3 SARS             SARS-Co~ incubat~ lnorm             Lessl~  2009         157
       4 Influenza        Influen~ incubat~ lnorm             Lessl~  2009         151
       5 Influenza        Influen~ incubat~ lnorm             Lessl~  2009          90
       6 Influenza        Influen~ incubat~ lnorm             Lessl~  2009          78
       7 Measles          Measles~ incubat~ lnorm             Lessl~  2009          55
       8 Parainfluenza    Parainf~ incubat~ lnorm             Lessl~  2009          11
       9 RSV              RSV      incubat~ lnorm             Lessl~  2009          24
      10 Rhinovirus       Rhinovi~ incubat~ lnorm             Lessl~  2009          28
      # i 115 more rows

# parameter_tbl works for incubation period with db

    Code
      incub_tbl
    Output
      # Parameter table:
      # A data frame:    73 x 7
         disease          pathogen epi_name prob_distribution author  year sample_size
         <chr>            <chr>    <chr>    <chr>             <chr>  <dbl>       <dbl>
       1 Adenovirus       Adenovi~ incubat~ lnorm             Lessl~  2009          14
       2 Human Coronavir~ Human_C~ incubat~ lnorm             Lessl~  2009          13
       3 SARS             SARS-Co~ incubat~ lnorm             Lessl~  2009         157
       4 Influenza        Influen~ incubat~ lnorm             Lessl~  2009         151
       5 Influenza        Influen~ incubat~ lnorm             Lessl~  2009          90
       6 Influenza        Influen~ incubat~ lnorm             Lessl~  2009          78
       7 Measles          Measles~ incubat~ lnorm             Lessl~  2009          55
       8 Parainfluenza    Parainf~ incubat~ lnorm             Lessl~  2009          11
       9 RSV              RSV      incubat~ lnorm             Lessl~  2009          24
      10 Rhinovirus       Rhinovi~ incubat~ lnorm             Lessl~  2009          28
      # i 63 more rows

# parameter_tbl works for different distribution with db

    Code
      serial_tbl
    Output
      # Parameter table:
      # A data frame:    18 x 7
         disease          pathogen epi_name prob_distribution author  year sample_size
         <chr>            <chr>    <chr>    <chr>             <chr>  <dbl>       <dbl>
       1 Influenza        Influen~ serial ~ gamma             Ghani~  2009          58
       2 Marburg Virus D~ Marburg~ serial ~ <NA>              Pavlin  2014          38
       3 Marburg Virus D~ Marburg~ serial ~ gamma             Ajell~  2012         374
       4 Mpox             Mpox Vi~ serial ~ gamma             Madew~  2022          57
       5 Mpox             Mpox Vi~ serial ~ gamma             Madew~  2022          40
       6 Ebola Virus Dis~ Ebola V~ serial ~ gamma             WHO E~  2015         305
       7 Ebola Virus Dis~ Ebola V~ serial ~ gamma             WHO E~  2015          37
       8 Ebola Virus Dis~ Ebola V~ serial ~ gamma             WHO E~  2015         147
       9 Ebola Virus Dis~ Ebola V~ serial ~ gamma             WHO E~  2015         112
      10 MERS             MERS-Cov serial ~ lnorm             Assir~  2013          23
      11 MERS             MERS-Cov serial ~ gamma             Cowli~  2015          99
      12 COVID-19         SARS-Co~ serial ~ <NA>              Alene~  2021        3924
      13 COVID-19         SARS-Co~ serial ~ lnorm             Nishi~  2020          28
      14 COVID-19         SARS-Co~ serial ~ weibull           Nishi~  2020          18
      15 COVID-19         SARS-Co~ serial ~ norm              Yang ~  2020         131
      16 Mpox             Mpox Vi~ serial ~ gamma             Guo e~  2022          42
      17 Mpox             Mpox Vi~ serial ~ <NA>              Wang ~  2022          16
      18 Mpox             Mpox Vi~ serial ~ <NA>              Wang ~  2022          34

# parameter_tbl works for COVID-19 db

    Code
      incub_tbl
    Output
      # Parameter table:
      # A data frame:    27 x 7
         disease  pathogen   epi_name       prob_distribution author  year sample_size
         <chr>    <chr>      <chr>          <chr>             <chr>  <dbl>       <dbl>
       1 COVID-19 SARS-CoV-2 incubation pe~ <NA>              Men e~  2020          59
       2 COVID-19 SARS-CoV-2 incubation pe~ <NA>              Rai e~  2022        6241
       3 COVID-19 SARS-CoV-2 incubation pe~ <NA>              Alene~  2021        1453
       4 COVID-19 SARS-CoV-2 serial interv~ <NA>              Alene~  2021        3924
       5 COVID-19 SARS-CoV-2 serial interv~ lnorm             Nishi~  2020          28
       6 COVID-19 SARS-CoV-2 serial interv~ weibull           Nishi~  2020          18
       7 COVID-19 SARS-CoV-2 incubation pe~ weibull           Yang ~  2020         178
       8 COVID-19 SARS-CoV-2 serial interv~ norm              Yang ~  2020         131
       9 COVID-19 SARS-CoV-2 incubation pe~ <NA>              Elias~  2021       28675
      10 COVID-19 SARS-CoV-2 incubation pe~ weibull           Bui e~  2020          19
      # i 17 more rows

# parameter_tbl works for SARS-CoV-2 db

    Code
      incub_tbl
    Output
      # Parameter table:
      # A data frame:    27 x 7
         disease  pathogen   epi_name       prob_distribution author  year sample_size
         <chr>    <chr>      <chr>          <chr>             <chr>  <dbl>       <dbl>
       1 COVID-19 SARS-CoV-2 incubation pe~ <NA>              Men e~  2020          59
       2 COVID-19 SARS-CoV-2 incubation pe~ <NA>              Rai e~  2022        6241
       3 COVID-19 SARS-CoV-2 incubation pe~ <NA>              Alene~  2021        1453
       4 COVID-19 SARS-CoV-2 serial interv~ <NA>              Alene~  2021        3924
       5 COVID-19 SARS-CoV-2 serial interv~ lnorm             Nishi~  2020          28
       6 COVID-19 SARS-CoV-2 serial interv~ weibull           Nishi~  2020          18
       7 COVID-19 SARS-CoV-2 incubation pe~ weibull           Yang ~  2020         178
       8 COVID-19 SARS-CoV-2 serial interv~ norm              Yang ~  2020         131
       9 COVID-19 SARS-CoV-2 incubation pe~ <NA>              Elias~  2021       28675
      10 COVID-19 SARS-CoV-2 incubation pe~ weibull           Bui e~  2020          19
      # i 17 more rows

# parameter_tbl works for disease & epi_name subset with db

    Code
      incub_tbl
    Output
      # Parameter table:
      # A data frame:    15 x 7
         disease  pathogen   epi_name       prob_distribution author  year sample_size
         <chr>    <chr>      <chr>          <chr>             <chr>  <dbl>       <dbl>
       1 COVID-19 SARS-CoV-2 incubation pe~ <NA>              Men e~  2020          59
       2 COVID-19 SARS-CoV-2 incubation pe~ <NA>              Rai e~  2022        6241
       3 COVID-19 SARS-CoV-2 incubation pe~ <NA>              Alene~  2021        1453
       4 COVID-19 SARS-CoV-2 incubation pe~ weibull           Yang ~  2020         178
       5 COVID-19 SARS-CoV-2 incubation pe~ <NA>              Elias~  2021       28675
       6 COVID-19 SARS-CoV-2 incubation pe~ weibull           Bui e~  2020          19
       7 COVID-19 SARS-CoV-2 incubation pe~ lnorm             McAlo~  2020        1357
       8 COVID-19 SARS-CoV-2 incubation pe~ lnorm             McAlo~  2020        1269
       9 COVID-19 SARS-CoV-2 incubation pe~ lnorm             Linto~  2020          52
      10 COVID-19 SARS-CoV-2 incubation pe~ lnorm             Linto~  2020         158
      11 COVID-19 SARS-CoV-2 incubation pe~ lnorm             Linto~  2020          52
      12 COVID-19 SARS-CoV-2 incubation pe~ lnorm             Lauer~  2020         181
      13 COVID-19 SARS-CoV-2 incubation pe~ lnorm             Lauer~  2020          99
      14 COVID-19 SARS-CoV-2 incubation pe~ lnorm             Lauer~  2020         108
      15 COVID-19 SARS-CoV-2 incubation pe~ lnorm             Lauer~  2020          73

# parameter_tbl works when supplied a subset db

    Code
      covid_tbl
    Output
      # Parameter table:
      # A data frame:    27 x 7
         disease  pathogen   epi_name       prob_distribution author  year sample_size
         <chr>    <chr>      <chr>          <chr>             <chr>  <dbl>       <dbl>
       1 COVID-19 SARS-CoV-2 incubation pe~ <NA>              Men e~  2020          59
       2 COVID-19 SARS-CoV-2 incubation pe~ <NA>              Rai e~  2022        6241
       3 COVID-19 SARS-CoV-2 incubation pe~ <NA>              Alene~  2021        1453
       4 COVID-19 SARS-CoV-2 serial interv~ <NA>              Alene~  2021        3924
       5 COVID-19 SARS-CoV-2 serial interv~ lnorm             Nishi~  2020          28
       6 COVID-19 SARS-CoV-2 serial interv~ weibull           Nishi~  2020          18
       7 COVID-19 SARS-CoV-2 incubation pe~ weibull           Yang ~  2020         178
       8 COVID-19 SARS-CoV-2 serial interv~ norm              Yang ~  2020         131
       9 COVID-19 SARS-CoV-2 incubation pe~ <NA>              Elias~  2021       28675
      10 COVID-19 SARS-CoV-2 incubation pe~ weibull           Bui e~  2020          19
      # i 17 more rows

# parameter_tbl works as expected supplied with <epiparameter>

    Code
      dist_tbl
    Output
      # Parameter table:
      # A data frame:    1 x 7
        disease  pathogen   epi_name        prob_distribution author  year sample_size
        <chr>    <chr>      <chr>           <chr>             <chr>  <dbl>       <dbl>
      1 COVID-19 SARS-CoV-2 onset to hospi~ lnorm             Linto~  2020         155

# parameter_tbl works as expected with discretised <epiparameter>

    Code
      dist_tbl
    Output
      # Parameter table:
      # A data frame:    1 x 7
        disease pathogen epi_name        prob_distribution author  year sample_size
        <chr>   <chr>    <chr>           <chr>             <chr>  <dbl>       <dbl>
      1 Ebola   <NA>     serial interval gamma             Smith   2022          NA

