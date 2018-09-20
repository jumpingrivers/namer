context("test-unname_all_chunks")

test_that("unname_all_chunks works", {
  file.copy(system.file("examples", "example4.Rmd", package = "namer"),
            "test.Rmd")
  unname_all_chunks("test.Rmd")

  lines <- readLines("test.Rmd")
  chunk_info <- get_chunk_info(lines)

  testthat::expect_true(all(is.na(chunk_info$name[2:5])))

  rendering <- rmarkdown::render("test.Rmd")
  testthat::expect_is(rendering, "character")

  file.remove("test.Rmd")
  file.remove("test.html")
})
