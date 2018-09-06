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
    stringr::str_remove("\\{r") %>%
    trimws() %>%
    stringr::str_extract("^[a-zA-Z0-9]*(-[0-9]*)?") %>%
    trimws() %>%
    stringr::str_replace_na(replacement = "")
}

extract_chunks_names <- function(path){
  chunks <- extract_r_chunks(path)

  purrr::map_chr(chunks, extract_label)


}
