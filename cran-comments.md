## Test environments
- local x86_64-pc-linux-gnu install, R 3.6.1
- R-hub windows-x86_64-devel (r-devel)
- R-hub ubuntu-gcc-release (r-release)
- R-hub fedora-clang-devel (r-devel)


## R CMD check results

0 errors | 0 warnings | 0 note

## Release summary

* The tests using rmarkdown are now skipped if Pandoc 1.12.3 (minimal version for rmarkdown) is not available.

* unname_all_chunks now accepts argument `chunk_name_prefix` with the prefix of the chunknames to be unnamed
