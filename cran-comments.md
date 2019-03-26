## Test environments
- local x86_64-pc-linux-gnu install, R 3.4.4
- R-hub ubuntu-gcc-release (r-release)
- R-hub windows-x86_64-devel (r-devel)
- R-hub fedora-clang-devel (r-devel)


## R CMD check results

0 errors | 0 warnings | 0 note

## Release summary

Bug fixes

* The regex recognizing the beginning of a chunk now demands ``` are at the beginning of a line.
* Replace LaTeX special characters with `-` to better support text references in bookdown.
