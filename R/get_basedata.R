#' Get base data required from bc data catalogue
#'
#' @param in_aoi an sf object containing a polygon with the area of interest to extract to
#' @param out_path file folder location where raw data will be saved (as gpkg)
#'
#' @return a series of geopackages with used as base data from moose strtatification
#' @export
#'
#' @examples
#' #get_basedata(aoi, out_path)


get_basedata <- function(in_aoi, out_path){


  skmoose::get_VRI(in_aoi, out_path)
  skmoose::get_water(in_aoi, out_path)
  skmoose::get_harvest(in_aoi, out_path)
  skmoose::get_water(in_aoi, out_path)
  skmoose::get_streams(in_aoi, out_path)
  skmoose::get_fires(in_aoi, out_path)
  skmoose::get_dem(in_aoi, out_path)



  # 1: download vri

  get_VRI <- function(in_aoi, out_path) {
    message("\rDownloading VRI layers")

    vri <- bcdata::bcdc_query_geodata("2ebb35d8-c82f-4a17-9c96-612ac3532d55") %>%
      bcdata::filter(INTERSECTS(in_aoi)) %>%
      bcdata::select(c("SPECIES_CD_1", "SPECIES_CD_2","SPECIES_CD_3","SPECIES_CD_4","SPECIES_CD_5","SPECIES_CD_6",
                       "BCLCS_LEVEL_3")) %>% # Treed sites
      bcdata::collect() %>%
      {if(nrow(.) > 0) sf::st_intersection(., in_aoi) else .}


      sf::st_write(vri, file.path(out_path, "vri.gpkg"), append = FALSE)

    return(TRUE)
    }


  # 2. download water bodies

  get_water <- function(in_aoi, out_path) {

      message("\rDownloading lake, streams and wetland layers")

      ## LAKES ##

      # 1 Square Kilometer = 100.00 Hectare

      # Uses date filter which filters lakes
      lakes <- bcdata::bcdc_query_geodata("cb1e3aba-d3fe-4de1-a2d4-b8b6650fb1f6") %>%
        bcdata::filter(INTERSECTS(in_aoi)) %>%
        bcdata::collect() %>%
        dplyr::select(id, WATERBODY_TYPE, AREA_HA) %>%
        dplyr::filter(AREA_HA > 1000)

      st_write(lakes, file.path(out_path, "lakes.gpkg"), append = FALSE)


  # download wetlands

      wetlands <- bcdata::bcdc_query_geodata("93b413d8-1840-4770-9629-641d74bd1cc6") %>%
        bcdata::filter(INTERSECTS(in_aoi)) %>%
        bcdata::collect() %>%
        dplyr::select(id, WATERBODY_TYPE, AREA_HA)

      wetlands <- wetlands %>% dplyr::filter(AREA_HA <= 1000) %>%
        sf::st_union()

        sf::st_write(wetlands, file.path(out_path, "wetlands.gpkg"), append = FALSE)

      return(TRUE)
    }

  # 3. download stream index

  get_streams <- function(in_aoi, out_path) {

    message("\rDownloading streams")

  streams <- bcdata::bcdc_query_geodata("92344413-8035-4c08-b996-65a9b3f62fca") %>%
    bcdata::filter(INTERSECTS(in_aoi)) %>%
    bcdata::collect() %>%
    dplyr::select(c("id", "STREAM_ORDER"))%>%
    sf::st_zm()


   sf::st_write(streams, file.path(out_path, "streams.gpkg"), append = FALSE)

   return(TRUE)
      }


  # 4. download fire history

  get_fires <- function(in_aoi, out_path) {

      message("\rDownloading fire disturbance")

      fire_records <- c("cdfc2d7b-c046-4bf0-90ac-4897232619e1",
                        "22c7cb44-1463-48f7-8e47-88857f207702")

      fires_all <- NA ## placeholder

      for (i in 1:length(fire_records)) {
        fires <- bcdata::bcdc_query_geodata(fire_records[i]) %>%
          bcdata::filter(INTERSECTS(in_aoi)) %>%
          collect() %>%
          {if(nrow(.) > 0) sf::st_intersection(., in_aoi) else .}

        if(nrow(fires) > 0) {
          ## bind results of loops
          if (i == 1) {
            fires_all <- fires } else { ## i > 1
              if(all(is.na(fires_all))) {fires_all <- fires } else {fires_all <- rbind(fires_all, fires)}
            }
        } #else {print("No fires in layer queried") }

        # rm(fires)
      } ## end loop


      if (all(is.na(fires_all)) || nrow(fires_all) == 0) {
        print("No recent fire disturbance in area of interest") } else {
          sf::st_write(fires_all, file.path(out_path, "fire.gpkg"), append = FALSE)
        }

      return(TRUE)
      }



  # 5. download cutblocks

  get_harvest <- function(in_aoi, out_path) {

      message("\rDownloading cutblock layers")

      cutblocks <- bcdata::bcdc_query_geodata("b1b647a6-f271-42e0-9cd0-89ec24bce9f7") %>%
        bcdata::filter(INTERSECTS(in_aoi)) %>%
        bcdata::select(c("HARVEST_YEAR")) %>%
        bcdata::collect()

    sf::st_write(cutblocks, file.path(out_path, "cutblocks.gpkg"), append = FALSE)

    return(TRUE)
    }


  # download DEM via CDED package

    get_dem <- function(in_aoi, out_path){

      trim_raw <- bcmaps::cded_raster(in_aoi)
      trim <- terra::rast(trim_raw)

      #write out dem # in case
      terra::writeRaster(trim, file.path(out_path, "dem.tif"), overwrite = TRUE)

      # generate slope
      rslope <- terra::terrain(trim, v = "slope", neighbors = 8, unit = "degrees")

      #write out dem # in case
      terra::writeRaster(rslope, file.path(out_path, "slope.tif"), overwrite = TRUE)

      return(TRUE)
    }

    message("\rBasedata downloaded")


}
