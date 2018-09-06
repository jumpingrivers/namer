#' Name chunks in a single file
#'
#' Name unnamed chunks in a single file using the filename with extension stripped as basis.
#'
#' @param path Path to file
#'
#' @export
#'
#' @examples
#' \dontrun{
#' file.copy(system.file("examples", "example1.Rmd", package = "namer"),
#'           "test.Rmd")
#' name_chunks("test.Rmd")
#' file.edit("test.Rmd")
#' }
name_chunks <- function(path){
  lines <- readLines(path)

  unnamed <- which(stringr::str_detect(lines,
                                       "```\\{r[,\\}]"))

  no_unnamed <- length(unnamed)

  if(no_unnamed > 0){
    filename <- fs::path_ext_remove(path)
    filename <- fs::path_file(filename)

    lines[unnamed] <- stringr::str_replace(lines[unnamed],
                                           "```\\{r",
                                           glue::glue("```\\{r [filename]-[1:no_unnamed]",
                                                      .open = "[", .close = "]"))
  }

  writeLines(lines, path)
}

#' Name chunks of all Rmds in a dir
#'
#' Name unnamed chunks in a dir using the filenames with extension stripped as basis.
#'
#' @param dir Path to folder
#'
#' @export
#'
#' @examples
#' \dontrun{
#' fs::dir_copy(system.file("examples", package = "namer"),
#'             "test")
#' name_dir_chunks("test")
#' file.edit("test/example1.Rmd")
#' }
name_dir_chunks <- function(dir){
  rmds <- fs::dir_ls(dir, regexp = "*.[Rr]md")
  purrr::walk(rmds, name_chunks)
}
