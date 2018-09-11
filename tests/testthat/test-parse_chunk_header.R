context("test-parse_chunk_header")

test_that("parse_chunk_header works", {
  df <- purrr::map_df(chunk_headers <- c("```{python, echo=FALSE}",
                                         "```{r lala, echo=FALSE}",
                                         "```{java}"),
                      parse_chunk_header)
  df2 <- structure(list(language = c("python", "r", "java"), name = c(NA,
                                                                      "lala", NA), options = c(", echo=FALSE", ", echo=FALSE", "")), row.names = c(NA,
                                                                                                                                                   -3L), class = c("tbl_df", "tbl", "data.frame"))
  testthat::expect_identical(df,
                             df2)
})
