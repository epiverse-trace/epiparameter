# epidist.print works as expected

    Code
      epidist(disease = "ebola", epi_dist = "incubation", prob_distribution = "gamma",
        prob_distribution_params = c(shape = 1, scale = 1))
    Message <simpleMessage>
      Citation cannot be created as either author, year or DOI is missing
    Output
      Disease: ebola
      Epi Distribution: incubation
      Distribution: Gamma(1, 1)
      Parameters:
        shape: 1
        rate: 1

