#' Unname chunks in a single file
#'
#' Unname all chunks in a single file
#'
#' @param path Path to file
#'
#' @export
#'
#' @examples
#' \dontrun{
#' file.copy(system.file("examples", "example4.Rmd", package = "namer"),
#'           "test.Rmd")
#' unname_all_chunks("test.Rmd")
#' file.edit("test.Rmd")
#' }
unname_all_chunks <- function(path){
  # read the whole file
  lines <- readLines(path)

  # find which lines are chunk starts
  chunk_header_indices <- which(stringr::str_detect(lines,
                                                    "```\\{[a-zA-Z0-9]"))

  # parse these chunk headers
  chunk_headers_info <- purrr::map_df(chunk_header_indices,
                                      digest_chunk_header,
                                      lines)
  chunk_headers_info$name[chunk_headers_info$name != "setup"] <- ""

  newlines <- re_write_headers(chunk_headers_info)

  lines[newlines$index] <- newlines$line

  # save file
  writeLines(lines, path)
}
