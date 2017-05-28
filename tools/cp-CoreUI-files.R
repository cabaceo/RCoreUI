#!/usr/bin/env Rscript

## NOT WORKING ##

# This script copies resources from CoreUI to RCoreUI's inst
# directory. The CoreUI/ project directory should be on the same level
# as the RCoreUI/ project directory.


# Returns the file currently being sourced or run with Rscript
thisFile <- function() {
  cmdArgs <- commandArgs(trailingOnly = FALSE)
  needle <- "--file="
  match <- grep(needle, cmdArgs)
  if (length(match) > 0) {
    # Rscript
    return(normalizePath(sub(needle, "", cmdArgs[match])))
  } else {
    # 'source'd via R console
    return(normalizePath(sys.frames()[[1]]$ofile))
  }
}

srcdir <- file.path(dirname(thisFile()), "../../CoreUI")
destdir <- file.path(dirname(thisFile()), "../inst/CoreUI")


file.copy(file.path(srcdir, "/js/app.js"), "../srcjs/CoreUI", overwrite = TRUE)
file.copy(file.path(srcdir, "/css/style.css"), destdir, overwrite = TRUE)
file.copy(file.path(srcdir, "/css/simple-line-icons.css"), destdir, overwrite = TRUE)
file.copy(file.path(srcdir, "/css/font-awesome.css"), destdir, overwrite = TRUE)
file.copy(file.path(srcdir, "/css/font-awesome.css.map"), destdir, overwrite = TRUE)
file.copy(file.path(srcdir, "/css/font-awesome.min.css"), destdir, overwrite = TRUE)
