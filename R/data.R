#' A vector of `character` strings with the core column names of the
#' epidemiological parameter data exported by the \pkg{epireview} R package.
#'
#' @format ## `epireview_core_cols`
#' A `character` vector with `r length(epiparameter::epireview_core_cols)`
#' elements.
#'
#' These are the columns of the \pkg{epireview} epidemiological parameter table
#' (`load_epidata(<pathogen>)$params`) that are required to convert an
#' \pkg{epireview} entry into an `<epiparameter>` object with
#' [as_epiparameter()]. They are used to identify an \pkg{epireview} parameter
#' table and to check that the columns needed for conversion are present.
#'
#' @source <https://github.com/mrc-ide/epireview>
"epireview_core_cols"
