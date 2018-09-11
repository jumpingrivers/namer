context("test-parse_chunk_header")

test_that("parse_chunk_header works", {
  df <- purrr::map_df(chunk_headers <- c("```{python, echo=FALSE}",
                                         "```{r lala, echo=FALSE}",
                                         "```{java}"),
                      parse_chunk_header)
  df2 <- structure(list(language = c("python", NA, "r", NA, "java"), name = c(NA,
                                                                              NA, "lala", NA, NA), option = c(NA, "echo", NA, "echo", NA),
                        option_value = c(NA, "FALSE", NA, "FALSE", NA)), row.names = c(NA,
                                                                                       -5L), class = c("tbl_df", "tbl", "data.frame"))
  testthat::expect_identical(df,
                             df2)
})
