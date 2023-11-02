#' Calculate area of block
#'
#' @param blockno list of block id numbers
#' @param aoi sf of aoi entire area with block ids
#' @param out_dir location of output folder
#'
#' @return table
#' @export
#'
#' @examples
#' \dontrun{
#' calculate_area(blockno, in_aoi, out_path)
#' }
calculate_areas <- function(blockno, aoi, out_dir){


  area_tab <- foreach::foreach(x = blockno, .combine=rbind) %dopar% {

       # x = blockno[42]

        tmp_aoi <- aoi %>% dplyr::filter(bkname == x)
        temp_out_dir <- file.path(out_dir, x)



      block_area <- sf::st_area(tmp_aoi)
      block_area <- block_area/1000000

      if(file.exists(file.path(temp_out_dir,"uninhabitable.gpkg"))){

        uninh <- sf::st_read(file.path(temp_out_dir, "uninhabitable.gpkg"), quiet = TRUE)

        uninh_area <- sf::st_area(uninh)[1]
        uninh_area <- uninh_area/1000000

      } else {

        uninh_area <- 0

      }


      if(file.exists(file.path(temp_out_dir,"habitable.gpkg"))){

        hab <- sf::st_read(file.path(temp_out_dir, "habitable.gpkg"),quiet = TRUE)

        hab_area <- sf::st_area(hab)[1]
        hab_area <- hab_area/1000000

      } else {

        hab_area <- 0

      }

      if(file.exists(file.path(temp_out_dir,"non_wet_fire.gpkg"))){

        nwfire <- sf::st_read(file.path(temp_out_dir, "non_wet_fire.gpkg"),quiet = TRUE)

        fire_int_area <- sf::st_area(nwfire)[1]
        fire_int_area <- fire_int_area/1000000

      } else {

        fire_int_area <- 0

      }



      tline <- c(x, block_area, uninh_area, hab_area, fire_int_area)
      tline


    }

area_tab <- as.data.frame(area_tab, row.names = FALSE)
names(area_tab) <- c("bkname", "block_area_km2", "uninhab_area_km2", "habitat_area_km2","fire_int_area_km2")

# calculations

area_final <- area_tab %>%
  rowwise() %>%
  mutate(prop_uninhab_block = uninhab_area_km2/block_area_km2) %>%
  mutate(net_habitat_area_km2 = block_area_km2 - uninhab_area_km2)%>%
  mutate(prop_habit_block_km2 = habitat_area_km2/block_area_km2) %>%
  mutate(prop_habit_net_habit_km2 = habitat_area_km2/net_habitat_area_km2 ) %>%
  mutate(prop_fireint_block_km2 = fire_int_area_km2/block_area_km2)

area_final  <- area_final%>%
  dplyr::select(bkname, "block_area_km2" , "uninhab_area_km2", "prop_uninhab_block", "net_habitat_area_km2",
                "habitat_area_km2", "prop_habit_block_km2", "prop_habit_net_habit_km2","fire_int_area_km2", "prop_fireint_block_km2") %>%
  mutate_if(is.numeric, round, 2)


return(area_final)

}
