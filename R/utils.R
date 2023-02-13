#' Calculate the quantiles of a probability distribution based on the vector
#' of probabilities and time data (e.g. time since infection)
#'
#' @description This function can be used in cases where the data on a fitted
#' distribution is not openly available and the summary statistics of the
#' distribution are not reported so the data are scraped from the plot and
#' the quantiles are needed in order use the `extract_param()` function
#'
#' @param prob A numeric vector of probabilities
#' @param days A numeric vector of days
#' @param quantile A single numeric or vector of numerics specifying which
#' quantiles to extract from the distribution
#'
#' @return A named vector of quantiles
#' @export
#'
#' @examples
#' prob <- dgamma(seq(0, 10, length.out = 21), shape = 2, scale = 2)
#' days <- seq(0, 10, 0.5)
#' quantiles <- c(0.025, 0.975)
#' calc_disc_dist_quantile(prob = prob, days = days, quantile = quantiles)
calc_disc_dist_quantile <- function(prob, days, quantile) {
  # check inputs
  checkmate::assert_numeric(prob)
  checkmate::assert_numeric(days)
  checkmate::assert_numeric(quantile, lower = 0, upper = 1)

  csum_prob <- cumsum(prob)
  sum_prob <- sum(prob)
  q_value <- quantile * sum_prob
  q_index <- vector(mode = "numeric", length = length(quantile))
  for (i in seq_along(quantile)) {
    q_index[i] <- which.min(abs(q_value[i] - csum_prob))
  }
  quantiles <- days[q_index]
  names(quantiles) <- as.character(quantile)
  quantiles
}
#' Creates a JSON version of the epiparameter database
#'
#' @description This converts the database from a data frame (read from the csv
#' stored in the package) into a JSON data file and saves it. This functions
#' allows the database to be edited and then the JSON file can be updated but
#' calling this function.
#'
#' @param read_path A relative file path from the package root directory to read
#' the parameters database from
#' @param write_path A relative file path from the package root directory to
#' write the JSON data file to
#'
#' @return Invisibly returns the JSON data.
#' @keywords internal
make_json_data <- function(read_path = file.path("extdata",
                                                 "parameters.csv"),
                           write_path = file.path("inst",
                                                  "extdata",
                                                  "data.json")) {
  # read in epiparameter database
  data <- utils::read.csv(
    file = system.file(
      read_path,
      package = "epiparameter",
      mustWork = TRUE
    ), header = TRUE
  )

  # convert cells with arrays to numeric
  for (i in grep(pattern = "_ci_limits$", x = colnames(data))) {
    if (!all(is.na(data[[i]]))) {
      data[[i]] <- lapply(
        strsplit(x = data[[i]], split = ",", fixed = TRUE),
        as.numeric
      )
    }

  }

  # save json data
  jsonlite::write_json(
    data,
    path = write_path,
    dataframe = "columns",
    na = "null",
    pretty = TRUE
  )

  # invisibly return json data
  invisible(data)
}

#' Creates a data schema in JSON format from a yaml file
#'
#' @description This converts the yaml data schema (data dictionary) stored in
#' the package into a JSON schema and saves it. This functions allows the yaml
#' to be the file which can be read and edited and then this file updates to
#' the JSON schema to match the yaml schema.
#'
#' @param read_path A relative file path from the package root directory to read
#' the yaml schema from
#' @param write_path A relative file path from the package root directory to
#' write the JSON schema to
#'
#' @return Invisibly returns the JSON schema.
#' @keywords internal
make_json_schema <- function(read_path = file.path("extdata",
                                                   "data_dictionary.yaml"),
                             write_path = file.path("inst",
                                                    "extdata",
                                                    "schema.json")) {
  # read schema
  schema <- yaml::read_yaml(
    system.file(
      read_path,
      package = "epiparameter",
      mustWork = TRUE
    )
  )

  # save json schema
  jsonlite::write_json(
    schema,
    path = write_path,
    auto_unbox = TRUE,
    pretty = TRUE
  )

  # invisibly return json schema
  invisible(schema)
}
