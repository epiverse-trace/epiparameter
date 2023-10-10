# epidist_db print method works as expected for > 5 <epidist>

    Code
      epidist_db()
    Message <simpleMessage>
      Returning 118 results that match the criteria (95 are parameterised). 
      Use subset to filter by entry variables or single_epidist to return a single entry. 
      To retrieve the short citation for each use the 'get_citation' function
    Output
      List of <epidist> objects
        Number of entries in library: 118
        Number of studies in library: 45
        Number of diseases: 23
        Number of delay distributions: 108
        Number of offspring distributions: 10

# epidist_db print method works as expected for <= 5 <epidist>

    Code
      epidist_db(disease = "SARS", epi_dist = "offspring distribution")
    Message <simpleMessage>
      Returning 2 results that match the criteria (2 are parameterised). 
      Use subset to filter by entry variables or single_epidist to return a single entry. 
      To retrieve the short citation for each use the 'get_citation' function
    Output
      [[1]]
      Disease: SARS
      Pathogen: SARS-Cov-1
      Epi Distribution: offspring distribution
      Study: Lloyd-Smith JO, Schreiber SJ, Kopp PE, Getz WM (2005). "Superspreading
      and the effect of individual variation on disease emergence." _Nature_.
      doi:10.1038/nature04153 <https://doi.org/10.1038/nature04153>.
      Distribution: nbinom
      Parameters:
        mean: 1.630
        dispersion: 0.160
      
      [[2]]
      Disease: SARS
      Pathogen: SARS-Cov-1
      Epi Distribution: offspring distribution
      Study: Lloyd-Smith JO, Schreiber SJ, Kopp PE, Getz WM (2005). "Superspreading
      and the effect of individual variation on disease emergence." _Nature_.
      doi:10.1038/nature04153 <https://doi.org/10.1038/nature04153>.
      Distribution: nbinom
      Parameters:
        mean: 0.940
        dispersion: 0.170
      
      attr(,"class")
      [1] "multi_epidist"

