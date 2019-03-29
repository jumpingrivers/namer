# namer (development version)
* unname_all_chunks now accepts argument `ch_n_p` with the prefix of the chunknames to be unnamed

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
