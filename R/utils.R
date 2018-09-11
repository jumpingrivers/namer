# not elegant, given a part of a header,
# transform it into the row of a tibble
parse_chunk_part <- function(chunk_header_part){
  # options part
  if(stringr::str_detect(chunk_header_part,
                         "=")){
    chunk_header_part %>%
      stringr::str_split("=",
                         simplify = TRUE) -> options

    tibble::tibble(option = trimws(options[1, 1]),
                   option_value = trimws(options[1, 2]))
  }else{
    # chunk language and name
    chunk_header_part %>%
      stringr::str_split(" ",
                         simplify = TRUE) -> language_name

    if(ncol(language_name) == 1){
      tibble::tibble(language = trimws(language_name[1, 1]),
                     name = NA)
    }else{
      tibble::tibble(language = trimws(language_name[1, 1]),
                     name = trimws(language_name[1, 2]))

    }

  }

}
# from a chunk header
# to a tibble with language, name, option, option values
parse_chunk_header <- function(chunk_header){
  # remove boundaries
  chunk_header %>%
    stringr::str_remove_all("```\\{") %>%
    stringr::str_remove_all("\\}") %>%
    # split by comma
    stringr::str_split("\\,",
                       simplify = TRUE) %>%
    as.character() %>%
    trimws() %>%
    # parse each part
    purrr::map_df(parse_chunk_part)
}

digest_chunk_header <- function(chunk_header_index,
                                lines){
  # parse the chunk header
  lines[chunk_header_index] %>%
    parse_chunk_header -> chunk_info

  # keep index
  chunk_info$index <- chunk_header_index

  # use the language for all row
  chunk_info$language <- chunk_info$language[!is.na(chunk_info$language)]

  # use the name for all rows if any name
  if(any(!is.na(chunk_info$name))){

    chunk_info$name <- chunk_info$name[!is.na(chunk_info$name)]
  }

  chunk_info
}

# helper to go from tibble with chunk info
# to header to write in R Markdown
re_write_headers <- function(info_df){
  info_df %>%
    dplyr::group_by(index) %>%
    dplyr::summarise(options = paste0(", ", glue::glue_collapse(
                                        glue::glue("{option}={option_value}"),
                                                          sep = ", ")),
                     options = stringr::str_remove_all(options, ", NA=NA"),
                     line = glue::glue("```{(language[1]) (name[1])(options)}",
                                       .open = "(",
                                       .close = ")"),
                     # for when no name
                     line = stringr::str_replace_all(line, " \\,", ","),
                     line = stringr::str_remove_all(line, " NA")) %>%
    dplyr::select(- options)
}


extract_r_chunks <- function(path){
  path %>%
    readLines() %>%
    commonmark::markdown_xml() %>%
    xml2::read_xml() %>%
    xml2::xml_find_all("//d1:code_block", xml2::xml_ns(.))  %>%
    # select chunks with language info
    .[xml2::xml_has_attr(., "info")] %>%
    # select R chunks
    .[stringr::str_detect(xml2::xml_attr(., "info"), "\\{r")]
}

extract_label <- function(chunk){
  chunk %>%
    xml2::xml_attr("info") %>%
    stringr::str_remove("\\{[a-zA-Z0-9]*") %>%
    trimws() %>%
    stringr::str_extract("^[a-zA-Z0-9]*(-[0-9]*)?") %>%
    trimws() %>%
    stringr::str_replace_na(replacement = "")
}

extract_chunks_names <- function(path){
  chunks <- extract_r_chunks(path)

  purrr::map_chr(chunks, extract_label)


}
