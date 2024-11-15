#' Upload a file to SAS
#' 
#' Uploads a file to the remote SAS server.
#' 
#' @param local_path Path of file on local machine to be uploaded.
#' @param sas_path Path to upload local file to on the remote SAS server.
#' 
#' @return No return value.
#' 
#' @export
sas_upload <- function(local_path, sas_path) {
  result <- .pkgenv$session$upload(local_path, sas_path)

  if (!result$Success) {
    warning(result$LOG)
  }

  invisible()
}

#' Download a file from SAS
#' 
#' Downloads a file to the remote SAS server.
#' 
#' @param sas_path Path of file on remote SAS server to be download
#' @param local_path Path to upload SAS file to on local machine.
#' 
#' @return No return value.
#' 
#' @export
sas_download <- function(sas_path, local_path) {
  result <- .pkgenv$session$download(local_path, sas_path)

  if (!result$Success) {
    warning(result$LOG)
  }

  invisible()
}

#' Delete a file or directory from SAS
#' 
#' Deletes a file or directory from the remote SAS server.
#' 
#' @param path Path of file on remote SAS server to be deleted.
#' 
#' @return No return value.
#' 
#' @export
sas_remove <- function(path) {
  .pkgenv$session$file_delete(path, sas_path)

  invisible()
}

#' List contents of a SAS directory
#' 
#' Lists the files or directories of a directory within the remote SAS server.
#' 
#' @param path Path of directory on remote SAS server to list the contents of.
#' 
#' @return No return value.
#' 
#' @export
sas_list <- function(path) {
  .pkgenv$session$dirlist(path)
}

#' @export
sas_read_csv <- function(file, table_name, libref = "WORK") {
  .pkgenv[["session"]]$read_csv(file, table_name, libref)
}

#' @export
sas_write_csv <- function(table_name, path, libref = "WORK") {
  .pkgenv[["session"]]$write_csv(path, table_name, libref)
}

#' @export
sas_write_parquet <- function(table_name, path, libref = "WORK") {
  .pkgenv[["session"]]$sasdata2parquet(path, table_name, libref)
}
