context("test-name_chunks")

test_that("renaming works", {
  temp_file_path <- file.path(tempdir(), "test.Rmd")

  file.copy(system.file("examples", "example1.Rmd", package = "namer"),
            temp_file_path)
  name_chunks(temp_file_path)
  lines <- readLines(temp_file_path)
  chunk_info <- get_chunk_info(lines)
  expect_true(all(
    chunk_info$name != ""))
  file.remove(temp_file_path)
})

test_that("unnaming is advised when needed", {
  file.copy(system.file("examples", "example4.Rmd", package = "namer"),
            "example4.Rmd")

  expect_error(name_chunks("example4.Rmd"))
  file.remove("example4.Rmd")
})
