# epiparameter
`R` package with epidemiological parameter distributions for infectious diseases. Eventually it will include a range of pathogens and natural history processes, as well as functions to extract parameters from reported statistics.

## Installation

The easiest way to install the development version of `epiparameter` is to use the `devtools` package:

```
# install.packages("devtools")
library(devtools)
install_github("epiverse-trace/epiparameter")
library(epiparameter)
```

## Quick start

To view the available distributions, then define the desired function, e.g. to extract and plot the daily probability mass function for the incubation period of influenza H7N9:

```r
# View available distributions
list_distributions(type="incubation")

# Extract probability mass function for incubation period
incubation_H7N9 <- prob_f_(pathogen="influenza_H7N9",type="incubation")

# Plot probability mass function
plot(0:10,incubation_H7N9(0:10),xlab="time since infection")
```
