#' Merge uninhabitable areas
#'
#' @param tmp_aoi sf object with aoi of interest
#' @param temp_out_dir file path where all prepared spatial files
#'
#' @return TRUE
#' @export
#'
#' @examples
#' \dontrun{
#' merge_nonhabitat(tmp_aoi, temp_out_dir)
#' }

merge_nonhabit <- function(tmp_aoi, temp_out_dir) {


  uninhab_sf <- c("high_elevation.gpkg","rockice.gpkg",
                  "steep.gpkg","largelakes.gpkg")


  if(any(uninhab_sf %in% list.files(temp_out_dir))){
    print("contains uninhabitable areas")

    unh <-  sf::st_sf(st_sfc(), crs = 3005)


    if(file.exists(file.path(temp_out_dir,"high_elevation.gpkg"))){
      high_elev <- sf::st_read(file.path(temp_out_dir,"high_elevation.gpkg"))
      unh <- rbind(high_elev, unh)
      unh <- sf::st_union(unh)

    }

    if(file.exists(file.path(temp_out_dir,"rockice.gpkg"))){
      rockice<- sf::st_read(file.path(temp_out_dir,"rockice.gpkg"))
      unh <- rbind(rockice, unh)
      unh <- sf::st_union(unh)
    }


    if(file.exists(file.path(temp_out_dir,"steep.gpkg"))){
      steep<- sf::st_read(file.path(temp_out_dir,"steep.gpkg"))
      unh <- rbind(steep, unh)
      unh <- sf::st_union(steep, unh)
    }


    if(file.exists(file.path(temp_out_dir,"largelakes.gpkg"))){
      largelakes<- sf::st_read(file.path(temp_out_dir,"largelakes.gpkg"))
      unh <- rbind(largelakes, unh)
      unh <- sf::st_union(largelakes, unh)
    }

    # crop to the study area
    unhab_all = sf::st_intersection(unh, tmp_aoi)
    st_write(unhab_all, file.path(temp_out_dir, "uninhabitable.gpkg"),          append = FALSE)

    #return(unhab_all)

  } else {

    print("no uninhabitable area found")

  }
  return(TRUE)
}





