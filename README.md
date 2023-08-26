
<!-- README.md is generated from README.Rmd. Please edit that file -->

# skmoose

<!-- badges: start -->
<!-- badges: end -->

SKmoose package which provides a series of steps to estimate moose
habitat quality within given survey blocks. This package was written for
the Skeena Regional Moose survey group under Ministry of Water, Lands &
Resources Stewardship.

Where possible, data used in the process is extracted directly from the
BC data catalogue, using bcdata and bcmaps R packages. These ensure up
to date information.

Optional additional data can be extracted including confidential survey
telemetry data, however this is dependant on outside sources.

Two vignettes are provided as a guide for users. These include a
detailed version which steps through each part of the process and an
abreviated version. A test dataset is provided within the package to
assist with understsnding the process.

## Installation

You can install the development version of skmoose from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("gcperk/skmoose")
```

## Overview

Moose Habitat is estimated for each survey block based on a series of
criteria to identify possible moose habitat and remove uninhabitable
areas. The spatial data is assembled per survey block rather than the
entire extent of the given study area to improve efficient of
processing. Appendinces A provides a full list of references and spatial
querys for each criteria.

# Estimate Uninhabiable Moose areas

Uninhabitable areas within the landscape are defined under the following
criteria

- Waterbodies \> 1km2

- Elevation \> 1500 m

- Slope \> 55 degrees

# Estimate Moose Habitat

# Calculate areas

# output table for analysis

A detailed table of criteria is provided below.

This is a basic example which shows you how to solve a common problem:

``` r
library(skmoose)
## basic example code
```

What is special about using `README.Rmd` instead of just `README.md`?
You can include R chunks like so:

``` r
summary(cars)
#>      speed           dist       
#>  Min.   : 4.0   Min.   :  2.00  
#>  1st Qu.:12.0   1st Qu.: 26.00  
#>  Median :15.0   Median : 36.00  
#>  Mean   :15.4   Mean   : 42.98  
#>  3rd Qu.:19.0   3rd Qu.: 56.00  
#>  Max.   :25.0   Max.   :120.00
```

You’ll still need to render `README.Rmd` regularly, to keep `README.md`
up-to-date. `devtools::build_readme()` is handy for this. You could also
use GitHub Actions to re-render `README.Rmd` every time you push. An
example workflow can be found here:
<https://github.com/r-lib/actions/tree/v1/examples>.
