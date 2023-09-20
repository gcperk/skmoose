
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Skeena Moose Survey Stratification

<!-- badges: start -->

[![Lifecycle:Experimental](https://img.shields.io/badge/Lifecycle-Experimental-339999)](Redirect-URL)
<!-- badges: end -->

[SKmoose](https://gcperk.github.io/skmoose/index.html) is used to assess
moose habitat quality within given survey blocks under aseries of
criteria. This package provides a number of functions to extract data,
estimate habitat and inhabitable areas within each block and report the
values in a table.

Where possible, data used in the process is extracted directly from the
BC data catalogue, using [bcdata](https://github.com/bcgov/bcdata) and
[bcmaps](https://github.com/bcgov/bcmaps) R packages to ensure up to
date information is used.

This package was written for Skeena Region under the Ministry of Water,
Lands & Resources Stewardship.

Optional additional data can be extracted including confidential survey
telemetry data, however this is dependent on outside sources.

A vignette is provided as a guide for users. These include a detailed
step by step of all function in the package resulting in a csv table
with compiled results. A test dataset is provided within the package to
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

## Criteria for potential Moose habiat

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

- Proximity to streams, streams with orders of **3 to 8** are buffered
  by **150m**, and streams with order of **9** are buffered to **500m**.

- Small lakes and wetlands which are less than 1 km2.

## Criteria for uninhabitable areas

Uninhabitable areas within the landscape are defined under the following
criteria

- Rock and Ice

- Large waterbodies greater than 1km2

- High elevation areas. The default cutoff is currently set to areas
  above **1500 m**

- Steep slopes. The default is currently set to greater than **55
  degrees**.

## Calculate proportion of Moose habitat

Once the area of moose habitat and uninhabitable areas has been
calculated, we then estimate the area and combine these into a single
table (csv).

The table contains the following fields:

- bk = block id number

- block_area_km2 = total area of block in m2

- uninh_area_km2 = total uninhabitable area of the block (km2)

- prop_uninh_block = proportion of uninhabitable area of each block
  (0-1). (uninh_area_km2/block_area_km2)

- net_habitat_area_km2 = Net area of habitat available within each block
  (km2) (block_area_km2 - uninh_area_km2)

- hab_area_km2 = total habitable area within each block (km2)

- prop_habit_block_km2 = Proportion of habitat within the total area of
  the block (km2) (hab_area_km2/block_area_km2)

- prop_habit_net_habit_km2 = proportion of habitat within the net area
  of the block (hab_area_km2/net_habitat_area_km2)

## OPTIONAL: Moose Habitat Strata Classification

Two options exist to automate the classify of blocks into
Low/Medium/High categories based on the proportion of Moose
Habitat/Block Area (prop_habit_block_km2).

Values can be based on specific numeric thresholds, with default values
of low (0 - 0.4), medium (0.41 - 0.7) and high (\>0.71). Alternatively
the values can be calculated based on quartiles of the distribution, in
which cutoff values are selected based on the distribution of all values
in the blocks.

These steps also produce a table, and an optional spatial file for
review and adjustment.

### Appendix A

The following datasets are used to estimate habitat and inhabitable
areas. These include:

- [VRI](https://catalogue.data.gov.bc.ca/dataset/vri-2022-forest-vegetation-composite-polygon).
  Vegetation Resource Inventory: Rock and Ice (uninhabitable) is
  filtered using the British Columbia Land Cover Classification Scheme
  Level 3 where values are classed as alpine. (BCLCS_LEVEL_3 = “A”)

- [VRI](https://catalogue.data.gov.bc.ca/dataset/vri-2022-forest-vegetation-composite-polygon).
  Vegetation Resource Inventory: Deciduous tree species (habitat) are
  filtered using the following fields: “SPECIES_CD_1”,
  “SPECIES_CD_2”,“SPECIES_CD_3”,“SPECIES_CD_4”,“SPECIES_CD_5”,“SPECIES_CD_6”.
  The default species of interest include (**c(“AT”, “AC”,“EP”,“SB”)**).

- [Lakes](https://catalogue.data.gov.bc.ca/dataset/freshwater-atlas-lakes)
  are filtered by area (AREA_HA) is greater than 1km2 (uninhabitable
  areas) and also \< 1km2 for habitable area.

- [wetlands](https://catalogue.data.gov.bc.ca/dataset/freshwater-atlas-wetlands)
  of area \< 1kms are combined with small lakes as potential moose
  habitat.

- [stream
  network](https://catalogue.data.gov.bc.ca/dataset/92344413-8035-4c08-b996-65a9b3f62fca)
  is used to determine and buffer based on stream order.

- [fires
  historic](https://catalogue.data.gov.bc.ca/dataset/22c7cb44-1463-48f7-8e47-88857f207702)
  and [fires
  current](https://catalogue.data.gov.bc.ca/dataset/cdfc2d7b-c046-4bf0-90ac-4897232619e1)
  are used to estimate fires. Time since burn is used to filter the
  miniumum and maximum range to include for moose habitat.

- [cutblocks](https://catalogue.data.gov.bc.ca/dataset/b1b647a6-f271-42e0-9cd0-89ec24bce9f7)
  are filterd usein minimum and maximum time since harvest.

- [digital elevation model
  (dem)](https://rdrr.io/github/bcgov/bcmaps/man/cded.html) is used to
  estimate elevation and slope. This is extracted from the bcmaps
  packages and uses TRIM DEM.
