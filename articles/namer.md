# Intro to the namer package

The goal of {namer} is to name the chunks of R Markdown files. It’s your
safety net when you’ve (willingly) forgotten to name most chunks of all
R Markdown files in a folder. {namer} does *not* give meaningful labels
to your chunks, but it gives them labels that won’t change depending on
their position like the automatic `knitr:::unnamed_chunk` function does
when knitting. So you can e.g. shuffle your chunks and not loose their
cache, or more easily debug over a whole folder!

For context about *why* you should name your R Markdown chunks, read
[this blog post](https://masalmon.eu/2017/08/08/chunkpets/).

The screenshot below is [a real life
example](https://github.com/lockedata/pres-datascience/pull/1/), result
of running `namer::name_dir_chunks("pres")`. In each of the files in the
dir “pres”, it labelled chunks using the filename and numbers.

[![Example of
use](../reference/figures/screenshot.png)](https://github.com/lockedata/pres-datascience/pull/1/files)

## Use

This is a basic example which shows you how to solve a common problem.
The “test” folder first contains R Markdown files with unnamed chunks.
After running `name_dir_chunks`, they’re all named, with names using the
filenames as basis.

``` r

fs::dir_copy(system.file("examples", package = "namer"),
            "test")
name_dir_chunks("test")
file.edit("test/example1.Rmd")
```

There’s also
[`name_chunks()`](https://jumpingrivers.github.io/namer/reference/name_chunks.md)
for use on a single R Markdown file; and
[`unname_chunks()`](https://jumpingrivers.github.io/namer/reference/unname_chunks.md)
to unname all chunks of a single R Markdown file as well as
[`unname_dir_chunks()`](https://jumpingrivers.github.io/namer/reference/unname_dir_chunks.md)
to unname all chunks of all R Markdown files in a directory, which can
be useful when cleaning your chunk labels.

By default
[`unname_chunks()`](https://jumpingrivers.github.io/namer/reference/unname_chunks.md)
unnames all chunks with exception of the ‘setup’ chunk. By using the
argument `chunk_name_prefix` one can indicate the prefix of the labels
that will be unnamed. Useful when one refers to a label by using chunk
option `ref.label` so that it is inconvenient when that label is
unnamed. By setting `chunk_name_prefix` equal to ‘the filename with
extension stripped’ followed with a ‘-’ (dash) only the labels generated
by
[`name_chunks()`](https://jumpingrivers.github.io/namer/reference/name_chunks.md)
will be unnamed.

If you’re working with RStudio, installing the package will have
installed an addin for labelling chunks of *any R Markdown document you
select*.

**When using {namer}, please check the edits before pushing them to your
code base. Such automatic chunk labelling is best paired with [version
control](https://happygitwithr.com/).**
