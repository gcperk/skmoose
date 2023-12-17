# one off to extract the 2014 fire intensity data


# for each block

fi_2014 <- read_sf(file.path("/home//user/Documents/r_repo/2023_moose_block_surveyR/02.Data/data/fire_intensity_2014.gpkg"))


get_fire_intensity <- foreach(x = blockno) %dopar% {

  print(x)

  tmp_aoi <- aoi %>% dplyr::filter(bkname == x)
  #st_bbox(tmp_aoi)
  temp_out_dir <- file.path(out_dir, x)

  get_fire_2014(in_aoi = tmp_aoi, out_path = temp_out_dir)

  in_aoi = tmp_aoi
  out_path = temp_out_dir
  #print(x)




}




get_fire_2014 <- function(in_aoi, out_path) {

  in_aoi = tmp_aoi
  out_path = temp_out_dir
  fire2014 = fi_2014

  fire_outline <- st_union(fire2014)

  #print(x)

  # if fire intensity already exists then add to it if needed



  fire_int_exists <- file.exists(file.path(out_path, "fire_int.gpkg"))

  if(overwrite == FALSE & fire_int_exists == TRUE) {

    message("\r fire intensity already exists, skipping download, select overwrite = TRUE to force download of water layers")

  } else {




    # if the aoi is within the 2014 burn intentity

    if(st_intersects(in_aoi, fire_outline , sparse = FALSE)){

      # aoi within 2014 fire extract data

      aoi_fire <- st_intersection(in_aoi, fire2014) %>%
        dplyr::select(bkname, FIRE_YEAR, BURN_SEVERITY_RATING) %>%
        dplyr::filter(BURN_SEVERITY_RATING %in% c("High", "Medium"))

    }



   for (i in 1:length(fire_int_records)) {
      #i = 1
      fires_int <- bcdata::bcdc_query_geodata(fire_int_records[i]) %>%
        bcdata::filter(bcdata::INTERSECTS(in_aoi)) %>%
        bcdata::select(id, FIRE_YEAR, BURN_SEVERITY_RATING)%>%
        bcdata::filter(BURN_SEVERITY_RATING %in% c("High", "Medium")) %>%
        collect() %>%
        {if(nrow(.) > 0) sf::st_intersection(., in_aoi) else .}

      if(nrow(fires_int) > 0) {
        ## bind results of loops
        if (i == 1) {
          fires_int_all <- fires_int } else { ## i > 1
            if(all(is.na(fires_int_all))) {fires_int_all <- fires_int } else {fires_int_all <- rbind(fires_int_all, fires_int)}
          }
      }

    } ## end loop


    if (all(is.na(fires_int_all)) || nrow(fires_int_all) == 0) {
      print("No recent fire intensity in area of interest") } else {
        sf::st_write(fires_int_all, file.path(out_path, "fire_int.gpkg"), append = FALSE)
      }

  }
  return(TRUE)
}

