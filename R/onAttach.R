.onAttach <- function(libname, pkgname) {
  version <- tryCatch(
    utils::packageDescription("attrib", fields = "Version"),
    warning = function(w){
      1
    }
  )

  packageStartupMessage(paste0(
    "attrib ",
    version,
    "\n",
    "https://docs.sykdomspulsen.no/attrib"
  ))
}
