sashtml_engine <- function (options) {
  code <- paste(options$code, collapse = "\n")

  if (identical(options$include, FALSE)) {
    options$echo <- FALSE
    options$outputv <- FALSE
  }

  if (identical(options$eval, FALSE)) {
    out <- list()
  } else {
    results <- .pkgenv$session$submit(code)

    if (identical(options$output, FALSE)) {
      out <- list()
    } else {
      if (identical(options$capture, "lst")) {
        out <- wrap_in_iframe(results$LST)
      } else if (identical(options$capture, "log")) {
        out <- wrap_in_pre(results$LOG)
      } else {
        lst <- wrap_in_iframe(results$LST)
        log <- wrap_in_pre(results$LOG)
        out <- wrap_in_panel_tabset(lst, log)
      }
      options$results <- "asis"
    }
  }

  if (identical(options$echo, FALSE)) {
    code <- list()
  }
  
  knitr::engine_output(options, code, out)
}
