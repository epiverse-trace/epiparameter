# epiparameter_db print method works as expected for > 5 <epiparameter>

    Code
      epiparameter_db()
    Message
      Returning 125 results that match the criteria (100 are parameterised). 
      Use subset to filter by entry variables or single_epiparameter to return a single entry. 
      To retrieve the citation for each use the 'get_citation' function
    Output
      # List of 125 <epiparameter> objects
      Number of diseases: 23
      > Adenovirus > COVID-19 > Chikungunya > Dengue > Ebola Virus Disease > Hantavirus Pulmonary Syndrome > Human Coronavirus > Influenza > Japanese Encephalitis > MERS > Marburg Virus Disease > Measles > Mpox > Parainfluenza > Pneumonic Plague > RSV > Rhinovirus > Rift Valley Fever > SARS > Smallpox > West Nile Fever > Yellow Fever > Zika Virus Disease
      Number of epi parameters: 13
      > case fatality risk > generation time > hospitalisation to death > hospitalisation to discharge > incubation period > notification to death > notification to discharge > offspring distribution > onset to death > onset to discharge > onset to hospitalisation > onset to ventilation > serial interval
      [[1]]
      Disease: Adenovirus
      Pathogen: Adenovirus
      Epi Parameter: incubation period
      Study: Lessler J, Reich N, Brookmeyer R, Perl T, Nelson K, Cummings D (2009).
      "Incubation periods of acute respiratory viral infections: a systematic
      review." _The Lancet Infectious Diseases_.
      doi:10.1016/S1473-3099(09)70069-6
      <https://doi.org/10.1016/S1473-3099%2809%2970069-6>.
      Distribution: lnorm (days)
      Parameters:
        meanlog: 1.723
        sdlog: 0.231
      
      [[2]]
      Disease: Human Coronavirus
      Pathogen: Human_Cov
      Epi Parameter: incubation period
      Study: Lessler J, Reich N, Brookmeyer R, Perl T, Nelson K, Cummings D (2009).
      "Incubation periods of acute respiratory viral infections: a systematic
      review." _The Lancet Infectious Diseases_.
      doi:10.1016/S1473-3099(09)70069-7
      <https://doi.org/10.1016/S1473-3099%2809%2970069-7>.
      Distribution: lnorm (days)
      Parameters:
        meanlog: 1.163
        sdlog: 0.140
      
      [[3]]
      Disease: SARS
      Pathogen: SARS-Cov-1
      Epi Parameter: incubation period
      Study: Lessler J, Reich N, Brookmeyer R, Perl T, Nelson K, Cummings D (2009).
      "Incubation periods of acute respiratory viral infections: a systematic
      review." _The Lancet Infectious Diseases_.
      doi:10.1016/S1473-3099(09)70069-8
      <https://doi.org/10.1016/S1473-3099%2809%2970069-8>.
      Distribution: lnorm (days)
      Parameters:
        meanlog: 1.386
        sdlog: 0.593
      
      # i 122 more elements
      # i Use `print(n = ...)` to see more elements.
      # i Use `parameter_tbl()` to see a summary table of the parameters.
      # i Explore database online at: https://epiverse-trace.github.io/epiparameter/articles/database.html

# epiparameter_db print method works as expected for <= 5 <epiparameter>

    Code
      epiparameter_db(disease = "SARS", epi_name = "offspring distribution")
    Message
      Returning 2 results that match the criteria (2 are parameterised). 
      Use subset to filter by entry variables or single_epiparameter to return a single entry. 
      To retrieve the citation for each use the 'get_citation' function
    Output
      # List of 2 <epiparameter> objects
      Number of diseases: 1
      > SARS
      Number of epi parameters: 1
      > offspring distribution
      [[1]]
      Disease: SARS
      Pathogen: SARS-Cov-1
      Epi Parameter: offspring distribution
      Study: Lloyd-Smith J, Schreiber S, Kopp P, Getz W (2005). "Superspreading and
      the effect of individual variation on disease emergence." _Nature_.
      doi:10.1038/nature04153 <https://doi.org/10.1038/nature04153>.
      Distribution: nbinom (No units)
      Parameters:
        mean: 1.630
        dispersion: 0.160
      
      [[2]]
      Disease: SARS
      Pathogen: SARS-Cov-1
      Epi Parameter: offspring distribution
      Study: Lloyd-Smith J, Schreiber S, Kopp P, Getz W (2005). "Superspreading and
      the effect of individual variation on disease emergence." _Nature_.
      doi:10.1038/nature04153 <https://doi.org/10.1038/nature04153>.
      Distribution: nbinom (No units)
      Parameters:
        mean: 0.940
        dispersion: 0.170
      
      # i Use `parameter_tbl()` to see a summary table of the parameters.
      # i Explore database online at: https://epiverse-trace.github.io/epiparameter/articles/database.html

# epiparameter.print works as expected

    Code
      epiparameter(disease = "ebola", epi_name = "incubation", prob_distribution = create_prob_distribution(
        prob_distribution = "gamma", prob_distribution_params = c(shape = 1, scale = 1)))
    Message
      Citation cannot be created as author, year, journal or title is missing
    Output
      Disease: ebola
      Pathogen: NA
      Epi Parameter: incubation
      Study: (????). "No citation."
      Distribution: gamma (NA)
      Parameters:
        shape: 1.000
        scale: 1.000

---

    Code
      epiparameter(disease = "ebola", epi_name = "incubation", prob_distribution = create_prob_distribution(
        prob_distribution = "gamma", prob_distribution_params = c(shape = 1, scale = 1),
        discretise = TRUE))
    Message
      Citation cannot be created as author, year, journal or title is missing
    Output
      Disease: ebola
      Pathogen: NA
      Epi Parameter: incubation
      Study: (????). "No citation."
      Distribution: discrete gamma (NA)
      Parameters:
        shape: 1.000
        scale: 1.000

