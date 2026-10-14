# Changelog

## namer 0.1.10

### Bug fixes and minor improvements

- Issues now use the Jumping Rivers organisation templates.

## namer 0.1.9 *2025-01-23*

CRAN release: 2025-01-23

- Allow to choose prefix for chunk names
  [\#2](https://github.com/jumpingrivers/namer/issues/2)
  ([@statnmap](https://github.com/statnmap),
  [\#30](https://github.com/jumpingrivers/namer/issues/30))
- New addins: ([@statnmap](https://github.com/statnmap),
  [\#30](https://github.com/jumpingrivers/namer/issues/30))
  - Name current Rmd file
  - Name file chosen in a directory
  - Name chunks from a folder

## namer 0.1.8

CRAN release: 2024-02-29

- Update maintainer

## namer 0.1.7

- [`name_dir_chunks()`](https://jumpingrivers.github.io/namer/reference/name_dir_chunks.md)
  now also names chunks in Quarto-Files. Note that Quarto chunks are
  labelled in the RMarkdown style (```` ```{r mylabel} ````), *not* in
  the Quarto style (see below):

&nbsp;

    ```{r}
    #| label: mylabel

## namer 0.1.6

CRAN release: 2022-10-06

- Update maintainer

## namer 0.1.5

CRAN release: 2019-12-16

- [`name_chunks()`](https://jumpingrivers.github.io/namer/reference/name_chunks.md)
  and
  [`name_dir_chunks()`](https://jumpingrivers.github.io/namer/reference/name_dir_chunks.md)
  are now able to unname all chunks before naming them. This ensures a
  consistent naming for all chunks instead of just labelling unnamed
  chunks ([@pat-s](https://github.com/pat-s),
  [\#23](https://github.com/jumpingrivers/namer/issues/23)).

- new function
  [`unname_dir_chunks()`](https://jumpingrivers.github.io/namer/reference/unname_dir_chunks.md)
  that works in the same way as
  [`name_dir_chunks()`](https://jumpingrivers.github.io/namer/reference/name_dir_chunks.md)
  ([@pat-s](https://github.com/pat-s),
  [\#23](https://github.com/jumpingrivers/namer/issues/23))

- rename
  [`unname_all_chunks()`](https://jumpingrivers.github.io/namer/reference/unname_chunks.md)
  to
  [`unname_chunks()`](https://jumpingrivers.github.io/namer/reference/unname_chunks.md)
  to be consistent with
  [`name_chunks()`](https://jumpingrivers.github.io/namer/reference/name_chunks.md)
  ([@pat-s](https://github.com/pat-s),
  [\#23](https://github.com/jumpingrivers/namer/issues/23)).
  [`unname_all_chunks()`](https://jumpingrivers.github.io/namer/reference/unname_chunks.md)
  will be deprecated in a future version and currently gives a warning.

- added some `cli` verbosity ([@pat-s](https://github.com/pat-s),
  [\#23](https://github.com/jumpingrivers/namer/issues/23))

- The tests using rmarkdown are now skipped if Pandoc 1.12.3 (minimal
  version for rmarkdown) is not available.

- unname_all_chunks now accepts argument `chunk_name_prefix` with the
  prefix of the chunknames to be unnamed
  ([@HanOostdijk](https://github.com/HanOostdijk),
  [\#22](https://github.com/jumpingrivers/namer/issues/22))

## namer 0.1.4

CRAN release: 2019-03-26

- The regex recognizing the beginning of a chunk now demands \`\`\` are
  at the beginning of a line ([@gorkang](https://github.com/gorkang),
  [\#17](https://github.com/jumpingrivers/namer/issues/17)).
- Replace LaTeX special characters with `-` to better support text
  references in bookdown
  [@martinjhnhadley](https://github.com/martinjhnhadley)

## namer 0.1.3

CRAN release: 2018-10-30

- In examples file.edit only happens if interactive().

## namer 0.1.2

- Testable examples were unwrapped.

- Fixed the test where the temporary directory would have been deleted.

## namer 0.1.1

- No longer depends on stringr.

- Uses a temporary directory in examples, tests, vignette.

- The RStudio add-in allows selecting an R Markdown file, it no longer
  modifies the current active document
  ([@ellisvalentiner](https://github.com/ellisvalentiner),
  [\#14](https://github.com/jumpingrivers/namer/issues/14)).

## namer 0.1.0

- First release.

- Added a `NEWS.md` file to track changes to the package.
