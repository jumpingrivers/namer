#' @title Unname chunks in a single file
#'
#' @description Unname all chunks except the setup chunk, in a single file
#'
#' @inherit name_chunks details
#'
#' @param path Path to file
#'
#' @export
#'
#' @examples
#' temp_file_path <- file.path(tempdir(), "test.Rmd")
#' file.copy(system.file("examples", "example4.Rmd", package = "namer"),
#'           temp_file_path,
#'           overwrite = TRUE)
#' unname_all_chunks(temp_file_path)
#' file.edit(temp_file_path)
#' }
unname_all_chunks <- function(path){
  # read the whole file
  lines <- readLines(path)

  # get chunk info
  chunk_headers_info <- get_chunk_info(lines)

  # early exit if no chunk
  if(is.null(chunk_headers_info)){
    return(invisible("TRUE"))
  }

  # preserve the setup label, delete the others
  chunk_headers_info$name[chunk_headers_info$name != "setup"] <- ""

  newlines <- re_write_headers(chunk_headers_info)

  lines[newlines$index] <- newlines$line

  # save file
  writeLines(lines, path)
}
