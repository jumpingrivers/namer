#' Name chunks in a single file
#'
#' Name unnamed chunks in a single file using the filename with extension stripped as basis.
#'
#' @param path
#'
#' @export
#'
#' @examples
#' \dontrun{
#' file.copy(system.file("examples", "example1.Rmd", package = "namer"),
#'           "test.Rmd")
#' name_chunks("test.Rmd")
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

