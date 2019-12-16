skip_if_not_r35 <- function() {
  R_version <- paste(R.version$major,
                   R.version$minor,
                   sep = ".")

  skip_if_not(R_version >= "3.5.0")

}
