# nocov start
.onLoad <- function(...) {
  s3_register("dplyr::dplyr_reconstruct", "epiparam")
  invisible()
}
# nocov end
