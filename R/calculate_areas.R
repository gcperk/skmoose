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

        #x = blockno[1]
        tmp_aoi <- aoi %>% dplyr::filter(bkname == x)
        temp_out_dir <- file.path(out_dir, x)



      block_area <- sf::st_area(tmp_aoi)

      if(file.exists(file.path(temp_out_dir,"uninhabitable.gpkg"))){

        uninh <- sf::st_read(file.path(temp_out_dir, "uninhabitable.gpkg"), quiet = TRUE)

        uninh_area <- sf::st_area(uninh)[1]

      } else {

        uninh_area <- 0

      }


      if(file.exists(file.path(temp_out_dir,"habitable.gpkg"))){

        hab <- sf::st_read(file.path(temp_out_dir, "habitable.gpkg"),quiet = TRUE)

        hab_area <- sf::st_area(hab)[1]

      } else {

        hab_area <- 0

      }

      tline <- c(x, block_area, uninh_area, hab_area)
      tline


    }

area_tab <- as.data.frame(area_tab, row.names = FALSE)
names(area_tab) <- c("bk", "total_area_m2", "uninh_area_m2", "hab_area_m2")

# calculations

area_final <- area_tab %>%
  rowwise() %>%
  mutate(prop_uninh_block = uninh_area_m2/total_area_m2) %>%
  mutate(net_habitat_area_m2 = total_area_m2 - uninh_area_m2)%>%
  mutate(prop_habit_block_m2 = hab_area_m2/total_area_m2) %>%
  mutate(prop_habit_net_habit_m2 = hab_area_m2/net_habitat_area_m2 )


return(area_final)

}
