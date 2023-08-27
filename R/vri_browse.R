
#' Filter Moose Browse Species
#'
#' @param vri vri file as gpkg containing the fields SPECIES_CD_1
#' @param species_codes species codes to include. Default is c("AT", "AC","EP","SB")
#'
#' @return sf object with single polygon with deciduous browse
#' @export
#'
#' @examples
#' \dontrun{
#' vri_browse(vri, species_codes = c("AT", "AC","EP","SB"))
#' }

vri_browse <-function(vri, species_codes = c("AT", "AC", "EP", "SB")) {
    #vri <- st_read(file.path(out_dir, "vri.gpkg"))
    #species_codes = c("AT", "AC","EP","SB")


    vri1 <- vri %>% dplyr::filter(SPECIES_CD_1 %in% species_codes) %>%
      dplyr::select(SPECIES_CD_1)

    vri2 <- vri %>% dplyr::filter(SPECIES_CD_2 %in% species_codes) %>%
      dplyr::select(SPECIES_CD_2)

    vri3 <- vri %>% dplyr::filter(SPECIES_CD_3 %in% species_codes) %>%
      dplyr::select(SPECIES_CD_3)

    vri4 <- vri %>% dplyr::filter(SPECIES_CD_4 %in% species_codes) %>%
      dplyr::select(SPECIES_CD_4)

    vri5 <- vri %>% dplyr::filter(SPECIES_CD_5 %in% species_codes) %>%
      dplyr::select(SPECIES_CD_5)

    vri6 <- vri %>% dplyr::filter(SPECIES_CD_6 %in% species_codes) %>%
      dplyr::select(SPECIES_CD_6)


    vri_moose <- bind_rows(vri1, vri2, vri3, vri4, vri5, vri6)

    vri_moose <- sf::st_union(vri_moose)

    return(vri_moose)

  }

