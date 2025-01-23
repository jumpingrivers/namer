context("test-unname_dir_chunks")

tmp = tempdir()

test_that("renaming works for a dir", {
  temp_dir = tmp
  fs::dir_copy(system.file("examples", package = "namer"), temp_dir)
  fs::file_delete(file.path(temp_dir, "examples", "example4.Rmd"))
  unname_dir_chunks(file.path(temp_dir, "examples"))
  lines = readLines(file.path(temp_dir, "examples", "example1.Rmd"))
  chunk_info = get_chunk_info(lines)
  expect_true(all(is.na(chunk_info$name[2:nrow(chunk_info)])))


  lines = readLines(file.path(temp_dir, "examples", "example2.Rmd"))
  chunk_info = get_chunk_info(lines)
  expect_true(all(is.na(chunk_info$name[2:nrow(chunk_info)])))

  fs::dir_delete(temp_dir)
})

unlink(tmp)
