#' @title Unname chunks in a single file
#'
#' @description Unname in a single file all chunks except the setup chunk, or alternatively unname the chunknames with a given prefix
#'
#' @inherit name_chunks details
#'
#' @param path Path to file
#' @param ch_n_p Character string with prefix of chunknames that will be removed. Default: NULL (indicating all chunknames will be removed except the one named `setup`)
#'
#' @export
#'
#' @examples
#' # remove all chunklabels except the one named 'setup'
#' temp_file_path <- file.path(tempdir(), "test1.Rmd")
#' file.copy(system.file("examples", "example4.Rmd", package = "namer"),
#'           temp_file_path,
#'           overwrite = TRUE)
#' unname_all_chunks(temp_file_path)
#' if(interactive()){
#' file.edit(temp_file_path)
#' }
#' # remove all chunk labels starting with 'example4'
#' temp_file_path <- file.path(tempdir(), "test2.Rmd")
#' file.copy(system.file("examples", "example4.Rmd", package = "namer"),
#'           temp_file_path,
#'           overwrite = TRUE)
#' unname_all_chunks(temp_file_path,ch_n_p='example4')
#' if(interactive()){
#' file.edit(temp_file_path)
#' }
unname_all_chunks <- function(path,ch_n_p=NULL){
  # read the whole file
  lines <- readLines(path)

  # get chunk info
  chunk_headers_info <- get_chunk_info(lines)

  # early exit if no chunk
  if(is.null(chunk_headers_info)){
    return(invisible("TRUE"))
  }

  if ( is.null(ch_n_p)){
    # preserve the setup label, delete the others
    chunk_headers_info$name[chunk_headers_info$name != "setup"] <- ""
  } else {
    # preserve labels not starting with ch_n_p
    del_labels = stringr::str_detect(
      stringr::str_replace_na(chunk_headers_info$name, replacement = ""),
      glue::glue('^{ch_n_p}'))
    chunk_headers_info$name[del_labels] <- ""
  }

  newlines <- re_write_headers(chunk_headers_info)

  lines[newlines$index] <- newlines$line

  # save file
  writeLines(lines, path)
}
