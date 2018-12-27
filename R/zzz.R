.onAttach <- function(libname, pkgname) {
    # packageStartupMessage("Welcome to paristools")
}

.onLoad <- function(libname, pkgname) {
    options(lifecycle_disable_warnings = TRUE) 
}

.onUnload <- function (libpath) {
  library.dynam.unload("paristools", libpath)
}
