## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----echo=FALSE, fig.width=8, fig.height=5------------------------------------
# read NAMESPACE
namespace <- base::parseNamespaceFile("epiparameter", .libPaths()[1L]) # nolint: undesirable_function_linter
s3methods <- namespace$S3methods
epiparameter_class_methods <-
  s3methods[which(s3methods[, 2] == "epiparameter"), 1]

# create network with all methods around the central node
getters <- c("family()", "get_citation()", "get_parameters()")
modifiers <- c("discretise()", "as.function()")
distribution_functions <- c("cdf()", "density()", "generate()", "quantile()")
utilities <- c("print()", "plot()", "mean()", "c()", "format()")
checkers <- c("is_epiparameter()", "is_parameterised()", "is_truncated()")
conversions <- c(
  "convert_params_to_summary_stats()", "convert_summary_stats_to_params()"
)
coercion <- "as.data.frame()"

# add one to each for the intermediate group nodes
groups <- data.frame(
  group = c(
    rep("Getters", length(getters) + 1),
    rep("Modifiers", length(modifiers) + 1),
    rep("Distribution functions", length(distribution_functions) + 1),
    rep("Utilities", length(utilities) + 1),
    rep("Checkers", length(checkers) + 1),
    rep("Conversions", length(conversions) + 1),
    rep("Coercion", length(coercion) + 1)
  ),
  functions = c(
    c("Getters", getters),
    c("Modifiers", modifiers),
    c("Distribution functions", distribution_functions),
    c("Utilities", utilities),
    c("Checkers", checkers),
    c("Conversions", conversions),
    c("Coercion", coercion)
  )
)

nodes <- data.frame(
  id = seq_len(nrow(groups) + 1),
  group = c("<epiparameter>", groups$group),
  label = c("<epiparameter>", groups$functions),
  shape = "box",
  stringsAsFactors = FALSE
)

from <- seq_len(nrow(groups))

# plus one for the central node
to <- 2:(nrow(groups) + 2)

for (grp in unique(groups$group)) {
  # plus one for central node
  from[which(groups$group == grp) + 1] <- min(which(groups$group == grp)) + 1
}

# set intermediate nodes to connect to central node
from[groups$group == groups$functions] <- 1

edges <- data.frame(
  from = from,
  to = to,
  color = "black",
  stringsAsFactors = FALSE
)

colours <- RColorBrewer::brewer.pal(
  n = length(unique(nodes$group)),
  name = "Set3"
)

# functions from parseNamespaceFile() need parentheses to match formatting
epiparameter_class_methods <- paste0(epiparameter_class_methods, "()")
if (!all(epiparameter_class_methods %in% groups$functions)) {
  message(
    "This diagram is out of date, as new methods have been added to the ",
    "package which are not included."
  )
}

library(visNetwork)
visNetwork(nodes, edges) |>
  visNodes(font = list(size = 18)) |>
  visGroups(groupname = "<epiparameter>", color = colours[1]) |>
  visGroups(groupname = "Getters", color = colours[2]) |>
  visGroups(groupname = "Modifiers", color = colours[3]) |>
  visGroups(
    groupname = "Distribution functions",
    color = colours[4]
  ) |>
  visGroups(groupname = "Utilities", color = colours[5]) |>
  visGroups(groupname = "Checkers", color = colours[6]) |>
  visGroups(groupname = "Conversions", color = colours[7]) |>
  visGroups(groupname = "Coercion", color = colours[8])

