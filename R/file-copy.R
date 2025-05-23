#' Copy a file on SAS
#'
#' Copies a file on the remote SAS server. Is analogous to
#' `file.copy()`, but for the remote SAS server.
#'
#' @param from_path string; Path of file on remote SAS server to be copied.
#' @param to_path string; Path of file on remote SAS server to copy to.
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
#' # create a file and upload it to SAS
#' cat("PROC MEANS DATA = sashelp.cars;RUN;", file = "script.sas")
#' sas_file_upload(local_path = "script.sas", sas_path = "~/script.sas")
#'
#' # copy file on SAS
#' sas_file_copy("~/script.sas", "~/script_copy.sas")
#' }
sas_file_copy <- function(from_path, to_path) {
  check_session()
  check_string(from_path)
  check_string(to_path)

  execute_if_connection_active(
    result <- .sas_file_copy(from_path, to_path)
  )

  if (!result$Success) {
    cli::cli_warn("{result$LOG}")
  }

  invisible(result$Success)
}

.sas_file_copy <- function(from_path, to_path) {
  .pkgenv$session$file_copy(from_path, to_path)
}
