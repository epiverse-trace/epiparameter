# nocov start
.onLoad <- function(libname, pkgname) {
  s3_register("dplyr::dplyr_reconstruct", "epiparam")
  invisible()
}
# nocov end
