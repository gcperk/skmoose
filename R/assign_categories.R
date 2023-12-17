#' Assign Moose Stratification categories
#' Assign each block a high, medium or low category based on assigned values or quartile.
#'
#' @param out_table data frame of moose stratification values
#' @param quartile TRUE or FALSE, if FALSE then categories will be based on low, med, high parameters
#' @param low numeric value to assign the highest value of the low category, default is 0.4
#' @param med numeric value to assign the highest value of the medium category, default is 0.7
#' @param high numeric value to assign the highest value of the high category, default is 1
#' @param burn_strat numeric value threshold above which block will be classes as "burn_strat", default is 0.5
#'
#' @return data table
#' @export
#' @examples
#' \dontrun{
#' assign_categories(out_table, quartile = FALSE, low = 40, med = 70, high = 100)
#' }

assign_categories <- function(out_table, quartile = FALSE, low = 0.4, med = 0.7, high = 1, burn_strat = 0.5) {

 #  quartile = FALSE
 # low = 0.4
 # med = 0.7
 # high = 1
 # burn_strat = 0.5

    if (quartile) {
      print("assigning catergories based on quartiles")

      qts <- stats::quantile(out_table$prop_habit_block_km2)

      low <- qts[[2]]
      med <- qts[[3]]
      high <- qts[[4]]


      out <- out_table %>%
        mutate(
          class = case_when(
            prop_habit_block_km2 <= low ~ "low",
            prop_habit_block_km2 >= high ~ "high",
            prop_habit_block_km2 > low &
              prop_habit_block_km2 < high ~ "med"
          )
        )


    } else {
      print("assigning catergories based on selected values for low, med, high")

    out <- out_table %>%
      mutate(
        class = case_when(
          prop_habit_block_km2 < low ~ "low",
          prop_habit_block_km2 > med ~ "high",
          prop_habit_block_km2 >= low & prop_habit_block_km2 <= med ~ "med"
        )
      )
    }

  if(burn_strat)(

    out <-  out %>%
      mutate(
        class = case_when(
          prop_fireint_block_km2  > burn_strat ~ "burnt",
          .default = as.character(class))
        # might need a default value also
      )

    )

    return(out)
  }

