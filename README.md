# attrib <a href="https://www.csids.no/attrib/"><img src="man/figures/logo.png" align="right" width="120" /></a>

## Overview 

[attrib](https://www.csids.no/attrib/) is designed to make the process of calculating attributable mortalities and incident risk ratios efficient and easy.

The package is based on generating simulations making it easy to aggregate all data from for example county to national levels or weekly to seasonal levels without losing information about credible intervals on the way. 

Read the introduction vignette [here](https://www.csids.no/attrib/articles/attrib.html) or run `help(package="attrib")`.

## csverse

<a href="https://www.csids.no/packages.html"><img src="https://www.csids.no/packages/csverse.png" align="right" width="120" /></a>

The [csverse](https://www.csids.no/packages.html) is a set of R packages developed to help solve problems that frequently occur when performing disease surveillance.

If you want to install the dev versions (or access packages that haven't been released on CRAN), run `usethis::edit_r_profile()` to edit your `.Rprofile`. 

Then write in:

```
options(
  repos = structure(c(
    CSVERSE = "https://www.csids.no/drat/",
    CRAN    = "https://cran.rstudio.com"
  ))
)
```

Save the file and restart R.

You can now install [csverse](https://www.csids.no/packages.html) packages from our [drat repository](https://www.csids.no/drat/).

```
install.packages("attrib")
```

