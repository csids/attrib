.onAttach <- function(libname, pkgname) {
  packageStartupMessage(paste0(
    "attrib ",
    utils::packageDescription("attrib")$Version,
    "\n",
    "https://docs.sykdomspulsen.no/attrib"
  ))
}
