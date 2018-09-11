

parse_chunk_part <- function(chunk_header_part){
  if(stringr::str_detect(chunk_header_part,
                         "=")){
    chunk_header_part %>%
      stringr::str_split("=",
                         simplify = TRUE) -> options

    tibble::tibble(option = trimws(options[1, 1]),
                   option_value = trimws(options[1, 2]))
  }else{
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

parse_chunk_header <- function(chunk_header){
  # remove the boundaries
  chunk_header %>%
    stringr::str_remove_all("```\\{") %>%
    stringr::str_remove_all("\\}") %>%
    stringr::str_split("\\,",
                       simplify = TRUE) %>%
    as.character() %>%
    trimws() %>%
    purrr::map_df(parse_chunk_part)
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
