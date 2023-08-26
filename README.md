
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Skeena Moose Survey Stratification

<!-- badges: start -->

[![Lifecycle:Experimental](https://img.shields.io/badge/Lifecycle-Experimental-339999)](Redirect-URL)
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

# Estimate Uninhabitable areas

Uninhabitable areas within the landscape are defined under the following
criteria

- Rock and Ice

- Large waterbodies greater than 1km2

- High elevation areas. The default cutoff is currently set to areas
  above **1500 m**

- Steep slopes. The default is currently set to greater than **55
  degrees**.

# Calculate proportion of Moose habitat

Once the area of moose habitat and uninhabitable areas has been
calculated, we then estimate the area and combine these into a single
table.

The table contains the following fields: - bk = block id number -
total_area_m2 = total area of block in m2 - uninh_area_m2 = total
uninhabitable area of the block (m2) - hab_area_m2 = total habitable
area within each block (m2) - prop_uninh_block = proportion of
uninhabitable area of each block. (uninh_area_m2/total_area_m2) -
net_habitat_area_m2 = Net area of habitat available within each block
(m2) (total_area_m2 - uninh_area_m2) - prop_habit_block_m2 = Proportion
of habitat within the total area of the block (m2)
(hab_area_m2/total_area_m2) - prop_habit_net_habit_m2 = proportion of
habitat within the net area of the block
(hab_area_m2/net_habitat_area_m2)

## Appendix A

The following datasets are used to estimate habitat and inhabitable
areas. These include:

- [VRI](https://catalogue.data.gov.bc.ca/dataset/vri-2022-forest-vegetation-composite-polygon).

Rock and Ice (uninhabitable) is filtered using the British Columbia Land
Cover Classification Scheme Level 3 where values are classed as alpine.
(BCLCS_LEVEL_3 = “A”)

Deciduous tree species (habitat) are filtered using the following
fields: “SPECIES_CD_1”,
“SPECIES_CD_2”,“SPECIES_CD_3”,“SPECIES_CD_4”,“SPECIES_CD_5”,“SPECIES_CD_6”.
The default species of interest include (**c(“AT”, “AC”,“EP”,“SB”)**).

- [Lakes](https://catalogue.data.gov.bc.ca/dataset/freshwater-atlas-lakes)
  are filtered by area (AREA_HA) is greater than 1km2 (uninhabitable
  areas) and also \< 1km2 for habitable area.

- [wetlands](https://catalogue.data.gov.bc.ca/dataset/freshwater-atlas-wetlands)
  or \< 1kms are used in habitat.

- [stream
  network](https://catalogue.data.gov.bc.ca/dataset/92344413-8035-4c08-b996-65a9b3f62fca)
  is used to determine and buffer based on stream order.

- [fires
  historic](https://catalogue.data.gov.bc.ca/dataset/22c7cb44-1463-48f7-8e47-88857f207702)
  and \[fires current\]
  (<https://catalogue.data.gov.bc.ca/dataset/cdfc2d7b-c046-4bf0-90ac-4897232619e1>)
  are used to estimate fires. Time since burn is used to filter the
  miniumum and maximum range to include for moose habitat.

- [cutblocks](https://catalogue.data.gov.bc.ca/dataset/b1b647a6-f271-42e0-9cd0-89ec24bce9f7)
  are filterd usein minimum and maximum time since harvest.

- [digital elevation model
  (dem)](https://rdrr.io/github/bcgov/bcmaps/man/cded.html) is used to
  estimate elevation and slope. This is extracted from the bcmaps
  packages and uses TRIM DEM.

``` r
library(skmoose)
## basic example code
```

You’ll still need to render `README.Rmd` regularly, to keep `README.md`
up-to-date. `devtools::build_readme()` is handy for this. You could also
use GitHub Actions to re-render `README.Rmd` every time you push. An
example workflow can be found here:
<https://github.com/r-lib/actions/tree/v1/examples>.
