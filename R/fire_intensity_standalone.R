# one off to extract the 2014 fire intensity data
# for each block
#
# fi_2014 <- sf::read_sf(file.path("/home//user/Documents/r_repo/2023_moose_block_surveyR/02.Data/data/fire_intensity_2014.gpkg"))
#
#
# get_fire_intensity <- foreach(x = blockno) %dopar% {
#
#   print(x)
#
#   tmp_aoi <- aoi %>% dplyr::filter(bkname == x)
#   #st_bbox(tmp_aoi)
#   temp_out_dir <- file.path(out_dir, x)
#
#   get_fire_2014(in_aoi = tmp_aoi, out_path = temp_out_dir, fire2014 = fi_2014)
#
# }
#
#
# get_fire_2014 <- function(in_aoi, out_path, fire2014) {
#
#   #in_aoi = tmp_aoi
#   #out_path = temp_out_dir
#   #
#
#   fire_outline <- st_union(fire2014)
#
#   #print(x)
#
#   # check if 2014 fire intersect with the aoi
#
#   if(st_intersects(in_aoi, fire_outline , sparse = FALSE)){
#
#     print("aoi interects with 2014 fire... extracting data")
#
#     aoi_fire <- st_intersection(in_aoi, fire2014) %>%
#       dplyr::select(bkname, FIRE_YEAR, BURN_SEVERITY_RATING) %>%
#       dplyr::filter(BURN_SEVERITY_RATING %in% c("High", "Medium"))
#
#
#     # check if there is any data and if there is then check if fire intensity already exists
#
#     if(nrow(aoi_fire) > 0) {
#
#       fire_int_exists <- file.exists(file.path(out_path, "fire_int.gpkg"))
#
#       if(fire_int_exists == TRUE) {
#
#         message("\r fire intensity already exists, updating old intensity")
#
#         #old_intensity <- read_sf(file.path(out_path, "fire_int.gpkg"))
#
#         sf::st_write(aoi_fire, file.path(out_path, "fire_int.gpkg"), append = TRUE)
#
#       } else {
#
#         print("no previous intensity exists, creating new fire intensity")
#
#         sf::st_write(aoi_fire, file.path(out_path, "fire_int.gpkg"), append = FALSE)
#
#              }
#       }
#
#   }
#
#   print("aoi does not intersect with 2014 fire intensity")
#
# }
