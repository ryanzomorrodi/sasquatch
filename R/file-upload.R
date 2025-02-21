#' Upload a file to SAS
#' 
#' Uploads a file to the remote SAS server.
#' 
#' @param local_path string; Path of file on local machine to be uploaded.
#' @param sas_path string; Path to upload local file to on the remote SAS server.
#' 
#' @return `logical`; value indicating if the operation succeeded.
#' 
#' @export
#' 
#' @family file management functions
#' @examples
#' \dontrun{
#' # connect to SAS
#' sas_connect()
#' 
#' # create a file to upload
#' cat("PROC MEANS DATA = sashelp.cars;RUN;", file = "script.sas")
#' 
#' # upload file
#' sas_file_upload(local_path = "script.sas", sas_path = "~/script.sas")
#' }
sas_file_upload <- function(local_path, sas_path) {
  chk_session()
  chk::chk_not_missing(local_path, "`local_path`")
  chk::chk_string(local_path)
  chk::chk_file(local_path)
  chk::chk_not_missing(sas_path, "`sas_path`")
  chk::chk_string(sas_path)

  execute_if_connection_active(
    result <- .pkgenv$session$upload(local_path, sas_path)
  )

  if (!result$Success) {
    chk::wrn(result$LOG)
  }

  result$Success
}
