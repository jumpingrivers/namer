# Unname chunks in a single file

Unname in a single file all chunks, or alternatively only unname the
chunknames with a given prefix. In both cases, the chunk name "setup" is
preserved, that chunk is never unnamed.

## Usage

``` r
unname_chunks(path, chunk_name_prefix = NULL)

unname_all_chunks(path, chunk_name_prefix = NULL)
```

## Arguments

- path:

  Path to file

- chunk_name_prefix:

  Character string with prefix of chunknames that will be removed.
  Default: NULL (indicating all chunknames will be removed except the
  one named \`setup\`)

## Value

Always returns TRUE invisibly. Called for side effects.

## Details

When using namer, please check the edits before pushing them to your
code base. Such automatic chunk labelling is best paired with version
control.

## Examples

``` r
# remove all chunklabels except the one named 'setup'
temp_file_path <- file.path(tempdir(), "test1.Rmd")
file.copy(system.file("examples", "example4.Rmd", package = "namer"),
          temp_file_path,
          overwrite = TRUE)
#> [1] TRUE
unname_chunks(temp_file_path)
if(interactive()){
file.edit(temp_file_path)
}
# remove all chunk labels starting with 'example4'
temp_file_path <- file.path(tempdir(), "test2.Rmd")
file.copy(system.file("examples", "example4.Rmd", package = "namer"),
          temp_file_path,
          overwrite = TRUE)
#> [1] TRUE
unname_chunks(temp_file_path,chunk_name_prefix='example4')
if(interactive()){
file.edit(temp_file_path)
}
```
