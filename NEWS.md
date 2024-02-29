# namer 0.1.8

* Update maintainer

# namer 0.1.7

* `name_dir_chunks()` now also names chunks in Quarto-Files. Note that Quarto chunks are labelled in the RMarkdown style (` ```{r mylabel} `), *not* in the Quarto style (see below):

````
```{r}
#| label: mylabel
````

# namer 0.1.6

* Update maintainer

# namer 0.1.5

* `name_chunks()` and `name_dir_chunks()` are now able to unname all chunks before naming them. This ensures a consistent naming for all chunks instead of just labelling unnamed chunks (@pat-s, #23).

* new function `unname_dir_chunks()` that works in the same way as `name_dir_chunks()` (@pat-s, #23)

* rename `unname_all_chunks()` to `unname_chunks()` to be consistent with `name_chunks()` (@pat-s, #23). `unname_all_chunks()` will be deprecated in a future version and currently gives a warning.

* added some `cli` verbosity (@pat-s, #23)

* The tests using rmarkdown are now skipped if Pandoc 1.12.3 (minimal version for rmarkdown) is not available.

* unname_all_chunks now accepts argument `chunk_name_prefix` with the prefix of the chunknames to be unnamed (@HanOostdijk, #22)

# namer 0.1.4

* The regex recognizing the beginning of a chunk now demands ``` are at the beginning of a line (@gorkang, #17).
* Replace LaTeX special characters with `-` to better support text references in bookdown @martinjhnhadley

# namer 0.1.3

* In examples file.edit only happens if interactive().

# namer 0.1.2

* Testable examples were unwrapped.

* Fixed the test where the temporary directory would have been deleted.

# namer 0.1.1

* No longer depends on stringr.

* Uses a temporary directory in examples, tests, vignette.

* The RStudio add-in allows selecting an R Markdown file, it no longer modifies the current active document (@ellisvalentiner, #14).

# namer 0.1.0

* First release.

* Added a `NEWS.md` file to track changes to the package.
