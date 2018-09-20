context("test-name_chunks")

test_that("renaming works", {
  file.copy(system.file("examples", "example1.Rmd", package = "namer"),
            "test.Rmd")
  name_chunks("test.Rmd")
  lines <- readLines("test.Rmd")
  chunk_info <- get_chunk_info(lines)
  expect_true(all(
    chunk_info$name != ""))
  file.remove("test.Rmd")
})

test_that("unnaming is advised when needed", {
  file.copy(system.file("examples", "example4.Rmd", package = "namer"),
            "example4.Rmd")

  expect_error(name_chunks("example4.Rmd"))
  file.remove("example4.Rmd")
})
