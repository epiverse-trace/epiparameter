# epidist_db print method works as expected for > 5 <epidist>

    Code
      epidist_db()
    Message
      Returning 122 results that match the criteria (99 are parameterised). 
      Use subset to filter by entry variables or single_epidist to return a single entry. 
      To retrieve the citation for each use the 'get_citation' function
    Output
      # List of 122 <epidist> objects
      Number of diseases: 23
      > Adenovirus > COVID-19 > Chikungunya > Dengue > Ebola Virus Disease > Hantavirus Pulmonary Syndrome > Human Coronavirus > Influenza > Japanese Encephalitis > MERS > Marburg Virus Disease > Measles > Mpox > Parainfluenza > Pneumonic Plague > RSV > Rhinovirus > Rift Valley Fever > SARS > Smallpox > West Nile Fever > Yellow Fever > Zika Virus Disease
      Number of epi distributions: 12
      > generation time > hospitalisation to death > hospitalisation to discharge > incubation period > notification to death > notification to discharge > offspring distribution > onset to death > onset to discharge > onset to hospitalisation > onset to ventilation > serial interval
      [[1]]
      Disease: Adenovirus
      Pathogen: Adenovirus
      Epi Distribution: incubation period
      Study: Lessler J, Reich N, Brookmeyer R, Perl T, Nelson K, Cummings D (2009).
      "Incubation periods of acute respiratory viral infections: a systematic
      review." _The Lancet Infectious Diseases_.
      doi:10.1016/S1473-3099(09)70069-6
      <https://doi.org/10.1016/S1473-3099%2809%2970069-6>.
      Distribution: lnorm
      Parameters:
        meanlog: 1.247
        sdlog: 0.975
      
      [[2]]
      Disease: Human Coronavirus
      Pathogen: Human_Cov
      Epi Distribution: incubation period
      Study: Lessler J, Reich N, Brookmeyer R, Perl T, Nelson K, Cummings D (2009).
      "Incubation periods of acute respiratory viral infections: a systematic
      review." _The Lancet Infectious Diseases_.
      doi:10.1016/S1473-3099(09)70069-7
      <https://doi.org/10.1016/S1473-3099%2809%2970069-7>.
      Distribution: lnorm
      Parameters:
        meanlog: 0.742
        sdlog: 0.918
      
      [[3]]
      Disease: SARS
      Pathogen: SARS-Cov-1
      Epi Distribution: incubation period
      Study: Lessler J, Reich N, Brookmeyer R, Perl T, Nelson K, Cummings D (2009).
      "Incubation periods of acute respiratory viral infections: a systematic
      review." _The Lancet Infectious Diseases_.
      doi:10.1016/S1473-3099(09)70069-8
      <https://doi.org/10.1016/S1473-3099%2809%2970069-8>.
      Distribution: lnorm
      Parameters:
        meanlog: 0.660
        sdlog: 1.205
      
      # i 119 more elements
      # i Use `print(n = ...)` to see more elements.
      # i Use `parameter_tbl()` to see a summary table of the parameters.
      # i Explore database online at: https://epiverse-trace.github.io/epiparameter/articles/database.html

# epidist_db print method works as expected for <= 5 <epidist>

    Code
      epidist_db(disease = "SARS", epi_dist = "offspring distribution")
    Message
      Returning 2 results that match the criteria (2 are parameterised). 
      Use subset to filter by entry variables or single_epidist to return a single entry. 
      To retrieve the citation for each use the 'get_citation' function
    Output
      # List of 2 <epidist> objects
      Number of diseases: 1
      > SARS
      Number of epi distributions: 1
      > offspring distribution
      [[1]]
      Disease: SARS
      Pathogen: SARS-Cov-1
      Epi Distribution: offspring distribution
      Study: Lloyd-Smith J, Schreiber S, Kopp P, Getz W (2005). "Superspreading and
      the effect of individual variation on disease emergence." _Nature_.
      doi:10.1038/nature04153 <https://doi.org/10.1038/nature04153>.
      Distribution: nbinom
      Parameters:
        mean: 1.630
        dispersion: 0.160
      
      [[2]]
      Disease: SARS
      Pathogen: SARS-Cov-1
      Epi Distribution: offspring distribution
      Study: Lloyd-Smith J, Schreiber S, Kopp P, Getz W (2005). "Superspreading and
      the effect of individual variation on disease emergence." _Nature_.
      doi:10.1038/nature04153 <https://doi.org/10.1038/nature04153>.
      Distribution: nbinom
      Parameters:
        mean: 0.940
        dispersion: 0.170
      
      # i Use `parameter_tbl()` to see a summary table of the parameters.
      # i Explore database online at: https://epiverse-trace.github.io/epiparameter/articles/database.html

