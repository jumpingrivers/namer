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
  expect_true(all(
    extract_chunks_names(file.path("test", "examples", "example1.Rmd")) != ""))
  expect_true(all(
    extract_chunks_names(file.path("test", "examples", "example2.Rmd")) != ""))
  fs::dir_delete("test")
})
