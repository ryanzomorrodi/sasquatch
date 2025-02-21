#' Convert R table to SAS
#' 
#' @description
#' Converts R table into a table in the current SAS session. R tables must only
#' have logical, integer, double, factor, character, POSIXct, or Date class 
#' columns.
#' 
#' @param x `data.frame`; R table.
#' @param table_name string; Name of table to be created in SAS.
#' @param libref string; Name of libref to store SAS table within.
#' 
#' @details
#' SAS only has two data types (numeric and character). Data types are converted
#' as follows:
#' 
#' * logical -> numeric
#' * integer -> numeric
#' * double -> numeric
#' * factor -> character
#' * character -> character
#' * POSIXct -> numeric (datetime)
#' * Date -> numeric (date)
#' 
#' @return `data.frame`; `x`.
#' 
#' @export
#' 
#' @seealso [sas_to_r()]
#' @examples
#' \dontrun{
#' sas_connect()
#' sas_from_r(mtcars, "mtcars")
#' }
sas_from_r <- function(x, table_name, libref = "WORK") {
  chk::chk_not_missing(x)
  chk::chk_data(x)
  chk_has_sas_vld_datatypes(x)
  chk_has_rownames(x)
  chk::chk_not_missing(table_name, "`table_name`")
  chk::chk_string(table_name)
  chk::chk_string(libref)
  
  x_copy <- x

  numeric_cols <- sapply(x, is.integer) | sapply(x, is.logical)
  x[numeric_cols] <- lapply(x[numeric_cols], as.double) 
  factor_cols <- sapply(x, is.factor)
  x[factor_cols] <- lapply(x[factor_cols], as.character)
  date_cols <- sapply(x, \(col) identical(class(col), "Date"))
  x[date_cols] <- lapply(x[date_cols], \(col) as.POSIXct(col))

  # Specify Date columns as date
  date_colnames <- colnames(x)[date_cols]
  date_list <- as.list(rep("date", length(date_colnames)))
  names(date_list) <- date_colnames
  date_dict <- do.call(what = reticulate::dict, date_list)

  x <- reticulate::r_to_py(x)
  execute_if_connection_active(
    reticulate::py_capture_output(
      .pkgenv$session$dataframe2sasdata(x, table_name, libref, datetimes = date_dict)
    )
  )

  invisible(x_copy)
}

chk_has_sas_vld_datatypes <- function(x, x_name = NULL) {
  if (vld_has_sas_vld_datatypes(x)) {
    return(invisible(x))
  }
  if (is.null(x_name)) x_name <- chk::deparse_backtick_chk(substitute(x))
  chk::abort_chk(x_name, " must only have logical, integer, double, factor, character, POSIXct, or Date class columns")
}
vld_has_sas_vld_datatypes <- function(x) {
  all(sapply(x, \(col) inherits(col, c("logical", "integer", "numeric", "factor", "character", "POSIXct", "Date"))))
}

chk_has_rownames <- function(x, x_name = NULL) {
  if (vld_has_rownames(x)) {
    return(invisible(x))
  }
  if (is.null(x_name)) x_name <- chk::deparse_backtick_chk(substitute(x))
  chk::wrn(x_name, " rownames will not be transferred as a column")
}
vld_has_rownames <- function(x) is.na(.row_names_info(x, type = 0)[1])
