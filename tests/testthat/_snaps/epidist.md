# epidist.print works as expected

    Code
      epidist(disease = "ebola", epi_dist = "incubation", prob_distribution = "gamma",
        prob_distribution_params = c(shape = 1, scale = 1))
    Message <simpleMessage>
      Citation cannot be created as either author, year or DOI is missing
    Output
      Disease: ebola
      Pathogen: NA
      Epi Distribution: incubation
      Study: No citation available
      Distribution: gamma
      Parameters:
        shape: 1.000
        rate: 1.000

---

    Code
      epidist(disease = "ebola", epi_dist = "incubation", prob_distribution = "gamma",
        prob_distribution_params = c(shape = 1, scale = 1), discretise = TRUE)
    Message <simpleMessage>
      Citation cannot be created as either author, year or DOI is missing
    Output
      Disease: ebola
      Pathogen: NA
      Epi Distribution: incubation
      Study: No citation available
      Distribution: discrete gamma
      Parameters:
        shape: 1.000
        scale: 1.000

