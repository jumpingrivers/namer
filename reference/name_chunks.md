# Name chunks in a single file

Name unnamed chunks in a single file using the filename with extension
stripped as basis.

## Usage

``` r
name_chunks(path, unname = FALSE, prefix)
```

## Arguments

- path:

  Path to file

- unname:

  Should all chunks be unnamed before naming? Default is \`FALSE\`.
  Turning this option on will cause all existing labels to be
  overwritten. In contrast, with its default \`unname = FALSE\` only
  unlabelled chunks will be named.

- prefix:

  prefix to use to name chunks. Default to cleaned name of the Rmd.

## Value

Always returns TRUE invisibly. Called for side effects.

## Details

When using namer, please check the edits before pushing them to your
code base. Such automatic chunk labelling is best paired with version
control.

## Examples

``` r
temp_file_path <- file.path(tempdir(), "test.Rmd")
file.copy(system.file("examples", "example1.Rmd", package = "namer"),
          temp_file_path,
          overwrite = TRUE)
#> [1] TRUE
name_chunks(temp_file_path)
if(interactive()){
file.edit(temp_file_path)
}
file.remove(temp_file_path)
#> [1] TRUE
```
