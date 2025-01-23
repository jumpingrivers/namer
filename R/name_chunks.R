#' @title Name chunks in a single file
#'
#' @description Name unnamed chunks in a single file using the
#' filename with extension stripped as basis.
#'
#' @details When using namer, please check the edits
#'  before pushing them to your code base. Such automatic
#'  chunk labelling is best paired with version control.
#'
#' @returns Always returns TRUE invisibly. Called for side effects.
#'
#' @template path
#' @template unname
#' @template prefix
#'
#' @export
#'
#' @examples
#' temp_file_path <- file.path(tempdir(), "test.Rmd")
#' file.copy(system.file("examples", "example1.Rmd", package = "namer"),
#'           temp_file_path,
#'           overwrite = TRUE)
#' name_chunks(temp_file_path)
#' if(interactive()){
#' file.edit(temp_file_path)
#' }
#' file.remove(temp_file_path)
name_chunks <- function(path, unname = FALSE, prefix) {
  # read the whole file
  lines <- readLines(path)

  # get chunk info
  chunk_headers_info <- get_chunk_info(lines)

  # early exit if no chunk
  if (is.null(chunk_headers_info)) {
    return(invisible(TRUE))
  }

  # check if a force-unname should be done
  if (isTRUE(unname)) {
    unname_chunks(path)
  }

  # filter the one corresponding to unnamed chunks
  chunk_headers_info %>%
    dplyr::filter(is.na(.data$name)) -> unnamed

  # count unnamed chunks
  no_unnamed <- length(unique(unnamed$index))

  # act only if needed!
  if (no_unnamed > 0) {
    if (missing(prefix)) {
      # create new chunk names
      filename <- fs::path_ext_remove(path)
      prefix <- fs::path_file(filename)
    }
    # support for bookdown text references by removing underscores
    # https://bookdown.org/yihui/bookdown/markdown-extensions-by-bookdown.html#fnref5
    prefix <- clean_latex_special_characters(prefix)
    new_chunk_names <-  glue::glue("{prefix}-{1:no_unnamed}")
    new_chunk_names <- as.character(new_chunk_names)
    # and write to which line they correspond
    names(new_chunk_names) <- unique(unnamed$index)

    # unique names?
    existing_names <- unique(chunk_headers_info$name)
    existing_names <- existing_names[!is.na(existing_names)]

    if (any(new_chunk_names %in% existing_names)) {
      new_chunk_names[new_chunk_names %in% existing_names] <-
        glue::glue("{new_chunk_names[new_chunk_names %in% existing_names]}-bis")
    }

    # add name to original information
    # about unnamed chunk
    nownamed <- unnamed %>%
      dplyr::group_by(.data$index) %>%
      dplyr::mutate(name = new_chunk_names[as.character(.data$index)]) %>%
      dplyr::ungroup()

    # re-write the header of these chunks
    newlines <- re_write_headers(nownamed)
    # replace original lines
    lines[newlines$index] <- newlines$line

    # re-get chunk names
    new_chunk_headers_info <- get_chunk_info(lines)
    if (length(unique(new_chunk_headers_info$name)) != nrow(new_chunk_headers_info)) {
      stop("Despite our efforts we'd be creating duplicate names.
Had you run our script on your R Markdown before?
Maybe namer::unname_chunks before running name_chunks.")
    }

    # save file
    writeLines(lines, path)
  }
  return(invisible(TRUE))
}

#' @title  Name chunks of all Rmds in a dir
#'
#' @description  Name unnamed chunks in a dir using the filenames with extension stripped as basis.
#'
#' @returns Always returns TRUE invisibly. Called for side effects.
#'
#' @inherit name_chunks details
#'
#' @template dir
#' @template unname
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
name_dir_chunks = function(dir, unname = FALSE) {

  if (isTRUE(unname)) {
    cli::cat_rule("Unnaming all chunks")
    unname_dir_chunks(dir)
  }

  cli::cat_rule("Naming all chunks")

  rmds = fs::dir_ls(dir, regexp = "*.[RrQq]md")
  purrr::walk(rmds, chatty_name_chunks)

  return(invisible(TRUE))
}

chatty_name_chunks = function(path) {
  message(glue::glue("Scanning {path}..."))
  name_chunks(path)
}
