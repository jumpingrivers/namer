context("test-get_chunk_info")

test_that("get_chunk_info works", {
  file <- system.file("examples", "example1.Rmd", package = "namer")
  lines <- readLines(file)
  output <- get_chunk_info(lines)
  testthat::expect_is(output, "data.frame")

  expected <- structure(list(language = c("r", "r", "python"), name = c("setup",
                                                                        NA, NA), options = c(", include=FALSE", "", ", echo=FALSE"),
                             index = c(8L, 18L, 26L)), row.names = c(NA, -3L), class = c("tbl_df",
                                                                                         "tbl", "data.frame"))

  testthat::expect_equal(output,expected)

  testthat::expect_null(get_chunk_info(""))
})
