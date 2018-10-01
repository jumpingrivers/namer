context("test-name_dir_chunks")

test_that("renaming works for a dir", {
  temp_dir <- tempdir()
  fs::dir_copy(system.file("examples", package = "namer"),
               temp_dir)
  fs::file_delete(file.path(temp_dir, "example4.Rmd"))
  name_dir_chunks(temp_dir)
  lines <- readLines(file.path("test", "examples", "example1.Rmd"))
  chunk_info <- get_chunk_info(lines)
  expect_true(all(chunk_info$name != ""))


  lines <- readLines(file.path("test", "examples", "example2.Rmd"))
  chunk_info <- get_chunk_info(lines)
  expect_true(all(chunk_info$name != ""))

  fs::dir_delete(temp_dir)
})
