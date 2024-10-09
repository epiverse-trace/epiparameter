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
      Distribution: gamma
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
      Distribution: discrete gamma
      Parameters:
        shape: 1.000
        scale: 1.000

