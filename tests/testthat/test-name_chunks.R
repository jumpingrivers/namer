context("test-name_chunks")

test_that("renaming works", {
  file.copy(system.file("examples", "example1.Rmd", package = "namer"),
            "test.Rmd")
  name_chunks("test.Rmd")
  expect_true(all(
    extract_chunks_names("test.Rmd") != ""))
  file.remove("test.Rmd")
})
