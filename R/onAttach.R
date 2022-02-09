.onAttach <- function(libname, pkgname) {
  version <- tryCatch(
    utils::attribDescription("attrib", fields = "Version"),
    warning = function(w){
      1
    }
  )

  attribStartupMessage(paste0(
    "attrib ",
    version,
    "\n",
    "https://docs.sykdomspulsen.no/attrib"
  ))
}
