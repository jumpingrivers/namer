context("test-name_chunks")

test_that("renaming works", {
  file.copy(system.file("examples", "example1.Rmd", package = "namer"),
            "test.Rmd")
  name_chunks("test.Rmd")
  expect_true(all(
    extract_chunks_names("test.Rmd") != ""))
  file.remove("test.Rmd")
})

test_that("unnaming is advised when needed", {
  file.copy(system.file("examples", "example4.Rmd", package = "namer"),
            "example4.Rmd")

  expect_error(name_chunks("example4.Rmd"))
  file.remove("example4.Rmd")
})
