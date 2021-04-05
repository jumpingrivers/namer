name_chunks_file_addin <- function(){
  name_chunks(path = rstudioapi::selectFile(filter = "R Markdown Files (*.Rmd)"))
}

name_chunks_addin <- function(){
  prefix <- rstudioapi::showPrompt(title = "Chunk names prefix",
                                   message = "Leave empty to use filename (Default)", default = "")
  if (prefix == "") {
    name_chunks(path = rstudioapi::getActiveDocumentContext()$path)
  } else {
    name_chunks(path = rstudioapi::getActiveDocumentContext()$path, prefix = prefix)
  }
}

name_chunks_directory_addin <- function(){
  namer::name_dir_chunks(rstudioapi::selectDirectory())
}
