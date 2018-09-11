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
  # read the whole file
  lines <- readLines(path)

  # find which lines are chunk starts
  chunk_header_indices <- which(stringr::str_detect(lines,
                                       "```\\{[a-zA-Z0-9]"))

  # parse these chunk headers
  chunk_headers_info <- purrr::map_df(chunk_header_indices,
                                      digest_chunk_header,
                                      lines)

  # filter the one corresponding to unnamed chunks
  chunk_headers_info %>%
    dplyr::filter(is.na(name)) -> unnamed

  # count unnamed chunks
  no_unnamed <- length(unique(unnamed$index))

  # act only if needed!
  if(no_unnamed > 0){
    # create new chunk names
    filename <- fs::path_ext_remove(path)
    filename <- fs::path_file(filename)
    new_chunk_names <-  glue::glue("{filename}-{1:no_unnamed}")
    new_chunk_names <- as.character(new_chunk_names)
    # and write to which line they correspond
    names(new_chunk_names) <- unique(unnamed$index)

    # add name to original information
    # about unnamed chunk
    nownamed <- unnamed %>%
      dplyr::group_by(index) %>%
      dplyr::mutate(name = new_chunk_names[as.character(index)])

    # re-write the header of these chunks
    newlines <- re_write_headers(nownamed)
    # replace original lines
    lines[newlines$index] <- newlines$line

    # save file
    writeLines(lines, path)
}

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
