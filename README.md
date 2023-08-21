
<!-- README.md is generated from README.Rmd. Please edit that file -->

# libminer

<!-- badges: start -->

[![R-CMD-check](https://github.com/gcperk/libminer/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/gcperk/libminer/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

The goal of libminer is to provide summary of a users library. It is a
toy package for testing and learning package development.

## Installation

You can install the development version of libminer from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("gcperk/libminer")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(libminer)

lib_summary()
#>                                                                 library
#> 1                                    C:/Program Files/R/R-4.2.3/library
#> 2                        C:/Users/genev/AppData/Local/R/win-library/4.2
#> 3 C:/Users/genev/AppData/Local/Temp/Rtmp8Yj7Lk/temp_libpath57741eae1c13
#>   n_packages
#> 1         30
#> 2        204
#> 3          1
lib_summary(sizes = TRUE)
#>                                                                 library
#> 1                                    C:/Program Files/R/R-4.2.3/library
#> 2                        C:/Users/genev/AppData/Local/R/win-library/4.2
#> 3 C:/Users/genev/AppData/Local/Temp/Rtmp8Yj7Lk/temp_libpath57741eae1c13
#>   n_packages  lib_size
#> 1         30  67242362
#> 2        204 598585079
#> 3          1     16548
```
