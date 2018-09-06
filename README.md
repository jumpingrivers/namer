# namer

[![Project Status: WIP – Initial development is in progress, but there has not yet been a stable, usable release suitable for the public.](http://www.repostatus.org/badges/latest/wip.svg)](http://www.repostatus.org/#wip)

The goal of namer is to name the chunks of R Markdown files. It's your safety net when you've (willingly) forgotten to name most chunks of all R Markdown files in a folder.

For context about _why_ you should name your R Markdown chunks, read [this blog post](https://masalmon.eu/2017/08/08/chunkpets/).

## Installation

Available at your own risk from this repo using:

``` r
remotes::install_github("lockedata/namer")
```

## Example

This is a basic example which shows you how to solve a common problem. The "test" folder first contains R Markdown files with unnamed chunks. After running `name_dir_chunks`, they're all named, with names using the filenames as basis.

``` r
fs::dir_copy(system.file("examples", package = "namer"),
            "test")
name_dir_chunks("test")
file.edit("test/example1.Rmd")
```

There's also `name_chunks` for use on a single R Markdown file.

## Contributing

Wanna report a bug or suggest a feature? Great stuff! For more information on how to contribute check out [our contributing guide](.github/CONTRIBUTING.md). 

 Please note that this R package is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md). By participating in this package project you agree to abide by its terms.
