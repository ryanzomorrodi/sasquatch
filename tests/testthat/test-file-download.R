test_that("downloading from SAS", {
  skip_on_cran()
  skip_if_offline()
  withr::defer(file.remove(local_path))
  withr::defer(file.remove(local_path_download))
  withr::defer(sas_file_remove(sas_path))
  
  local_path <- tempfile(pattern="temp", fileext=".sas")
  local_path_download <- tempfile(pattern="temp", fileext=".sas")
  local_name <- basename(local_path)
  sas_path <- paste0("~/", local_name)

  "no file exists download"
  expect_warning(sas_file_download(sas_path, local_path))

  "file exists download"
  cat("PROC MEANS DATA = sashelp.cars; RUN;", file = local_path)
  sas_file_upload(local_path, sas_path)
  expect_true(sas_file_download(sas_path, local_path_download))
  expect_true(file.exists(local_path_download))
  expect_equal(readLines(local_path, warn = FALSE), readLines(local_path_download, warn = FALSE))
})
