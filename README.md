
<!-- README.md is generated from README.Rmd. Please edit that file -->

# skmoose

<!-- badges: start -->
<!-- badges: end -->

SKmoose is used to assess moose habitat quality within given survey
blocks under aseries of criteria. This package provides a number of
functions to extract data, estimate habitat and inhabitable areas within
each block and report the values in a table.

Where possible, data used in the process is extracted directly from the
BC data catalogue, using [bcdata](https://github.com/bcgov/bcdata) and
[bcmaps](https://github.com/bcgov/bcmaps) R packages to ensure up to
date information is used.

This package was written for Skeena Region under the Ministry of Water,
Lands & Resources Stewardship.

Optional additional data can be extracted including confidential survey
telemetry data, however this is dependant on outside sources.

Two vignettes are provided as a guide for users. These include a
detailed version which steps through each part of the process and an
abreviated version. A test dataset is provided within the package to
assist with understanding the process.

## Installation

You can install the development version of skmoose from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("gcperk/skmoose")
```

## Overview

Potential Moose habitat is estimated for each survey block based on a
series of criteria with spatial data extracted from the bcdata
catalogue. Uninhabitable areas are also estimated using a set of
criteria. All spatial data is extracted on a per block area rather than
an entire study area to improve efficiency of processing. Appendix A
provides a full list of references and spatial queries. Once potenital
habitat and inhabitable areas are compiled, total area of each are
calculated to provide a means of stratifying moose survey blocks into
catergories of Low, Medium and High. A table of all calculations is
output for the user to review.

# Estimate Moose habiat

The following criteria are used to estimate area of moose habitat. Once
compiled these areas are dissolved into a single polygon. Uninhabitable
areas, as calculated below are then removed before final area
calculations are completed. Values shown below in **bold** are the
default values, which can be adjusted using parameters within the
functions.

- Deciduous tree species within the VRI (vegetation resource inventory).
  The default species include AC (Poplar), AT (Trembling Aspen), EP
  (Paper Birch), SB (Black Spruce), ie (**c(“AT”, “AC”,“EP”,“SB”)**).

- Early seral/shrub dynamic habitats. This includes: 1) fires and 2)
  cutblocks with a minimum time of **5 yrs** since disturbance and
  maximum time of **40 yrs** since disturbance. These ages can be
  adjusted seperately for each disturbance type.

- Proximity to streams, streams with orders of 3 to 8 are buffered by
  150m, and streams with order of 9 are buffered to 500m

- Small lakes and wetlands which are less than 1 km2.

- Skeena Wildlife Ecological Resource Model- Winter forage output -
  still to be added.

# Estimate Uninhabitable areas for moose

Uninhabitable areas within the landscape are defined under the following
criteria

- Large waterbodies greater than 1km2

- High elevation areas. The default cutoff is currently set to areas
  above **1500 m**

- Steep slopes. The default is currently set to greater than **55
  degrees**.

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
