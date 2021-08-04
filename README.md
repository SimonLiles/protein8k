# protein8k
V0.0.1

Author: Simon Liles

Maintainer: Simon Liles, simon@quantknot.com

This is a package that can be used for the visual analysis of proteins. 

This package is still in early Alpha. Expect significant and continuous changes for a while.

This README will also be updated with more information as the package evolves. 

# Download and Installation
The easiest way to download and install this package is through CRAN. Simply run the following command in your R Console. 

```{r}
install.packages("protein8k")
```

To download and install the development version into your R session is to use the devtool function `install_github()`. The development version is not recommended for most users because it may contain bugs. 

You can copy and paste this code into your console and it should work. If there are any issues, please contact the package maintainer. 

```{r}
devtools::install_github("SimonLiles/protein8k")
```

If you want vignettes included from the GitHub install, use this code. 

```{r}
devtools::install_github("SimonLiles/protein8k", build_vignettes = TRUE)
```

# Bugs
If you encounter any issues, please contact the package maintainer. 
