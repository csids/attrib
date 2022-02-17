# attrib <a href="https://docs.sykdomspulsen.no/attrib"><img src="man/figures/logo.png" align="right" width="120" /></a>

## Overview 

[attrib](https://docs.sykdomspulsen.no/attrib) is designed to make the process of calculating attributable mortalities and incident risk ratios efficient and easy.

The package is based on generating simulations making it easy to aggregate all data from for example county to national levels or weekly to seasonal levels without losing information about credible intervals on the way. 

Read the introduction vignette [here](https://docs.sykdomspulsen.no/attrib/articles/attrib.html) or run `help(package="attrib")`.

## splverse

<a href="https://docs.sykdomspulsen.no/packages"><img src="https://docs.sykdomspulsen.no/packages/splverse.png" align="right" width="120" /></a>

The [splverse](https://docs.sykdomspulsen.no/packages) is a set of R packages developed to help solve problems that frequently occur when performing infectious disease surveillance.

If you want to install the dev versions (or access packages that haven't been released on CRAN), run `usethis::edit_r_profile()` to edit your `.Rprofile`. 

Then write in:

```
options(
  repos = structure(c(
    SPLVERSE  = "https://docs.sykdomspulsen.no/drat/",
    CRAN      = "https://cran.rstudio.com"
  ))
)
```

Save the file and restart R.

You can now install [splverse](https://docs.sykdomspulsen.no/packages) packages from our [drat registry](https://docs.sykdomspulsen.no/drat).

```
install.packages("attrib")
```

