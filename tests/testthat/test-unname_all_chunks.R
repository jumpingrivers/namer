context("test-unname_all_chunks")

test_that("unname_all_chunks works", {
  file.copy(system.file("examples", "example4.Rmd", package = "namer"),
            "test.Rmd")
  unname_all_chunks("test.Rmd")
  testthat::expect_true(all(
    extract_chunks_names("test.Rmd")[2:5] == ""))

  rendering <- rmarkdown::render("test.Rmd")
  testthat::expect_is(rendering, "character")

  file.remove("test.Rmd")
  file.remove("test.html")
})
