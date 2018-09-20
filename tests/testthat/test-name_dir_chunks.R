context("test-name_dir_chunks")

test_that("renaming works for a dir", {
  if(fs::dir_exists("test")){
    fs::dir_delete("test")
  }

  fs::dir_create("test")
  fs::dir_copy(system.file("examples", package = "namer"),
            "test")
  fs::file_delete(file.path("test", "examples", "example4.Rmd"))
  name_dir_chunks(file.path("test", "examples"))

  lines <- readLines(file.path("test", "examples", "example1.Rmd"))
  chunk_info <- get_chunk_info(lines)
  expect_true(all(chunk_info$name != ""))


  lines <- readLines(file.path("test", "examples", "example2.Rmd"))
  chunk_info <- get_chunk_info(lines)
  expect_true(all(chunk_info$name != ""))

  fs::dir_delete("test")
})
