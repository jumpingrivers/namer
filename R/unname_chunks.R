#' @title Unname chunks in a single file
#'
#' @description Unname in a single file all chunks,
#' or alternatively only unname the chunknames with a given prefix.
#' In both cases, the chunk name "setup" is preserved, that chunk is never unnamed.
#'
#' @inherit name_chunks details
#' @inheritParams name_chunks
#'
#' @param path Path to file
#' @param chunk_name_prefix Character string with prefix of chunknames that will be removed. Default: NULL (indicating all chunknames will be removed except the one named `setup`)
#'
#' @export
#'
#' @examples
#' # remove all chunklabels except the one named 'setup'
#' temp_file_path <- file.path(tempdir(), "test1.Rmd")
#' file.copy(system.file("examples", "example4.Rmd", package = "namer"),
#'           temp_file_path,
#'           overwrite = TRUE)
#' unname_chunks(temp_file_path)
#' if(interactive()){
#' file.edit(temp_file_path)
#' }
#' # remove all chunk labels starting with 'example4'
#' temp_file_path <- file.path(tempdir(), "test2.Rmd")
#' file.copy(system.file("examples", "example4.Rmd", package = "namer"),
#'           temp_file_path,
#'           overwrite = TRUE)
#' unname_chunks(temp_file_path,chunk_name_prefix='example4')
#' if(interactive()){
#' file.edit(temp_file_path)
#' }
unname_chunks <- function(path,chunk_name_prefix=NULL){
  # read the whole file
  lines <- readLines(path)

  # get chunk info
  chunk_headers_info <- get_chunk_info(lines)

  # early exit if no chunk
  if(is.null(chunk_headers_info)){
    return(invisible("TRUE"))
  }

  if ( is.null(chunk_name_prefix)){
    # preserve the setup label, delete the others
    chunk_headers_info$name[chunk_headers_info$name != "setup"] <- ""
  } else {
    # preserve labels not starting with chunk_name_prefix
    del_labels <- strtrim(chunk_headers_info$name,nchar(chunk_name_prefix)) %in%
      chunk_name_prefix
    setup_label <- !(chunk_headers_info$name %in% 'setup')
    del_labels <- del_labels & setup_label
    chunk_headers_info$name[del_labels] <- ""
  }

  newlines <- re_write_headers(chunk_headers_info)

  lines[newlines$index] <- newlines$line

  # save file
  writeLines(lines, path)
}

#' @title  Unname chunks of all Rmds in a dir
#'
#' @description  Name unnamed chunks in a dir using the filenames with extension stripped as basis.
#'
#' @inheritParams name_chunks
#' @inherit name_chunks details
#'
#' @param dir Path to folder
#'
#' @export
#'
#' @examples
#' temp_dir <- tempdir()
#' # just to make sure we're not overwriting
#' if(fs::dir_exists(file.path(temp_dir, "examples"))){
#' fs::dir_delete(file.path(temp_dir, "examples"))
#' }
#' fs::dir_copy(system.file("examples", package = "namer"),
#'             temp_dir)
#'  # this is an example file that'd fail
#' fs::file_delete(file.path(temp_dir,
#'                          "examples", "example4.Rmd"))
#' name_dir_chunks(temp_dir)
#' if(interactive()){
#' file.edit(file.path(temp_dir,
#'                    "examples", "example1.Rmd"))
#' }
unname_dir_chunks <- function(dir){
  rmds <- fs::dir_ls(dir, regexp = "*.[Rr]md")
  purrr::walk(rmds, chatty_unname_chunks)
}

chatty_unname_chunks <- function(path){
  message(glue::glue("Scanning {path}..."))
  unname_chunks(path)
}
