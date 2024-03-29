% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/unname_chunks.R
\name{unname_dir_chunks}
\alias{unname_dir_chunks}
\title{Unname chunks of all Rmds in a dir}
\usage{
unname_dir_chunks(dir)
}
\arguments{
\item{dir}{Path to folder}
}
\value{
Always returns TRUE invisibly. Called for side effects.
}
\description{
Name unnamed chunks in a dir using the filenames with extension stripped as basis.
}
\details{
When using namer, please check the edits
 before pushing them to your code base. Such automatic
 chunk labelling is best paired with version control.
}
\examples{
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
if(interactive()){
file.edit(file.path(temp_dir,
                   "examples", "example1.Rmd"))
}
}
