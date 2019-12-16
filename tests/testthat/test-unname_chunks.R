context("test-unname_chunks")

test_that("unname_chunks works in case is.null(chunk_name_prefix) == TRUE", {
  # check arg of tempdir
  skip_if_not_r35()
  skip_if_not(rmarkdown::pandoc_available("1.12.3"))

  temp_file_path <- file.path(tempdir(check = TRUE), "example4.Rmd")

  file.copy(system.file("examples", "example4.Rmd", package = "namer"),
            temp_file_path)
  unname_chunks(temp_file_path)

  lines <- readLines(temp_file_path)
  chunk_info <- get_chunk_info(lines)

  testthat::expect_identical(chunk_info$name[1],'setup')
  testthat::expect_true(all(is.na(chunk_info$name[-1])))

  rendering <- rmarkdown::render(temp_file_path)
  testthat::expect_is(rendering, "character")

  file.remove(temp_file_path)

  basename <- fs::path_ext_remove(temp_file_path)

  file.remove(paste0(basename, ".html"))
})

test_that("unname_chunks works in case is.null(chunk_name_prefix) == FALSE", {
  # check arg of tempdir
  skip_if_not_r35()
  skip_if_not(rmarkdown::pandoc_available("1.12.3"))

  temp_file_path <- file.path(tempdir(check = TRUE), "example4.Rmd")

  file.copy(system.file("examples", "example4.Rmd", package = "namer"),
            temp_file_path)
  unname_chunks(temp_file_path,chunk_name_prefix='example4')

  lines <- readLines(temp_file_path)
  chunk_info <- get_chunk_info(lines)

  testthat::expect_identical(chunk_info$name[1],'setup')
  testthat::expect_identical(chunk_info$name[6],'sessioninfo')
  testthat::expect_true(all(is.na(chunk_info$name[2:5])))

  rendering <- rmarkdown::render(temp_file_path)
  testthat::expect_is(rendering, "character")

  file.remove(temp_file_path)

  basename <- fs::path_ext_remove(temp_file_path)

  file.remove(paste0(basename, ".html"))
})

test_that("unname_chunks works in case chunk_name_prefix == 'setup' ", {
  # check arg of tempdir
  skip_if_not_r35()
  skip_if_not(rmarkdown::pandoc_available("1.12.3"))

  temp_file_path <- file.path(tempdir(check = TRUE), "example4.Rmd")

  file.copy(system.file("examples", "example4.Rmd", package = "namer"),
            temp_file_path)
  unname_chunks(temp_file_path,chunk_name_prefix='setup')

  lines <- readLines(temp_file_path)
  chunk_info <- get_chunk_info(lines)

  testthat::expect_identical(chunk_info$name[1],'setup')
  testthat::expect_identical(chunk_info$name[3],'example4-1')
  testthat::expect_identical(chunk_info$name[4],'example4-1-bis')
  testthat::expect_identical(chunk_info$name[6],'sessioninfo')
  testthat::expect_true(all(is.na(chunk_info$name[c(2,5)])))

  rendering <- rmarkdown::render(temp_file_path)
  testthat::expect_is(rendering, "character")

  file.remove(temp_file_path)

  basename <- fs::path_ext_remove(temp_file_path)

  file.remove(paste0(basename, ".html"))
})

test_that("unname_all_chunks works but gives a warning",{
  # check arg of tempdir
  skip_if_not_r35()

  temp_file_path <- file.path(tempdir(check = TRUE), "example4.Rmd")

  file.copy(system.file("examples", "example4.Rmd", package = "namer"),
            temp_file_path)
  expect_warning(unname_all_chunks(temp_file_path),
                 "please use")

  lines <- readLines(temp_file_path)
  chunk_info <- get_chunk_info(lines)

  testthat::expect_identical(chunk_info$name[1],'setup')
  testthat::expect_true(all(is.na(chunk_info$name[-1])))

}
)
