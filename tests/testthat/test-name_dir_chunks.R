context("test-name_dir_chunks")

test_that("renaming works for a dir", {
  fs::dir_delete("test")
  fs::dir_copy(system.file("examples", package = "namer"),
            "test")
  fs::file_delete(file.path("test", "example4.Rmd"))
  name_dir_chunks("test")
  expect_true(all(
    extract_chunks_names(file.path("test", "example1.Rmd")) != ""))
  expect_true(all(
    extract_chunks_names(file.path("test", "example2.Rmd")) != ""))
  fs::dir_delete("test")
})
