# Name chunks of all Rmds in a dir

Name unnamed chunks in a dir using the filenames with extension stripped
as basis.

## Usage

``` r
name_dir_chunks(dir, unname = FALSE)
```

## Arguments

- dir:

  Path to folder

- unname:

  Should all chunks be unnamed before naming? Default is \`FALSE\`.
  Turning this option on will cause all existing labels to be
  overwritten. In contrast, with its default \`unname = FALSE\` only
  unlabelled chunks will be named.

## Value

Always returns TRUE invisibly. Called for side effects.

## Details

When using namer, please check the edits before pushing them to your
code base. Such automatic chunk labelling is best paired with version
control.

## Examples

``` r
temp_dir <- tempdir()
# just to make sure we're not overwriting
if(fs::dir_exists(file.path(temp_dir, "examples"))){
fs::dir_delete(file.path(temp_dir, "examples"))
}
fs::dir_copy(system.file("examples", package = "namer"),
            temp_dir)
 # this is an example file that'd fail
fs::file_delete(file.path(temp_dir,
                         "examples", "example4.Rmd"))
name_dir_chunks(temp_dir)
#> ── Naming all chunks ───────────────────────────────────────────────────────────
if(interactive()){
file.edit(file.path(temp_dir,
                   "examples", "example1.Rmd"))
}
```
