

#' Aggregation of data for nowcasting
#'
#' Aggregates mortality data to a weekly basis.
#' Where the percentiles and number of mortalities obtained after every week up to n_week is also given.
#' For more details see the help vignette:
#'
#' \code{vignette("intro", package="attrib")}
#'
#' @param data Dataset containing doe (Date of event), dor (Date of registation) and location_code. The columns must have these exact names.
#' @param aggregation_date Date of aggregation
#' @param n_week Number of weeks to calculate the percentage of the total registraations. Must be larger og equal to 2 amd smaller than the total number of weeks in the dataset.
#' @param pop_data Population data, must contain a column called pop with the population data and a column with year and possibly week.
#' @examples
#'
#' data <- attrib::data_fake_nowcasting_nation_raw
#' data[doe < as.Date("2019-01-01")]
#' aggregation_date <- as.Date("2020-01-01")
#' n_week <- 3
#'
#' data_aggregated <- nowcast_aggregate(data, aggregation_date, n_week)
#'
#' @return Aggregated dataset with the percentiles of registered events within the last 52 weeks
#'
#' @export
nowcast_aggregate <- function(
  data,
  aggregation_date,
  n_week,
  pop_data = NULL) {

  doe <- NULL
  dor <- NULL
  cut_doe <- NULL
  n_death <- NULL
  temp_outcome <- NULL
  n0_0 <- NULL
  p0_0 <- NULL
  temp_variable_n <- NULL
  temp_variable_p <- NULL
  . <- NULL
  new_value <- NULL
  temp_outcome_n <- NULL
  temp_outcome_p<- NULL
  pop <- NULL
  location_code<- NULL
  unique_id <- NULL


  ##### for developing
#
# data <- gen_fake_death_data_county()
# #data <- attrib::data_fake_nowcasting_nation_raw
# aggregation_date <- as.Date("2019-12-31")
# n_week <- 6
# pop_data <- fhidata::norway_population_by_age_cats(cats = list(c(1:120)))[location_code %in% unique(fhidata::norway_locations_b2020$county_code)]
# #pop_data <- NULL
  ### check of parameters ----

  if (! "doe" %in% colnames(data)){
    stop("The dataset does not have the correct column names, doe is missing")
  }

  if (! "dor" %in% colnames(data)){
    stop("The dataset does not have the correct column names, dor is missing")
  }
  if (! "location_code" %in% colnames(data)){
    stop("The dataset does not have the correct column names, location_Code is missing")
  }

  if (! "n_week" > 1){
    stop("n_week is to small" )
  }

  #should perhaps have a check for max length as well.

  ### cleaning ----
  d <- data.table::as.data.table(data)
  d <- d[, .(doe, dor, location_code)]
  d <- d[dor < as.Date(cut(aggregation_date, "week"))] # we erase all date for incompleate weeks.
  d <- d[doe < as.Date(cut(aggregation_date, "week"))]
  d[, cut_doe := as.Date(cut(doe, "week"))]
  d <- d[order(doe, dor)]

  first_date <- as.Date(cut(d[1,]$doe, "week"))
  last_date <- as.Date(cut(aggregation_date -7, "week"))

  # count deaths
  d_death <- d[ , .(
    "n_death" = .N
  ), keyby = .(
    cut_doe,
    location_code
  )]

  d[ d_death,
     on = c("cut_doe","location_code"),
     n_death := n_death]

  retval <- vector("list", length = n_week)
  d_within_week <- d[, .(cut_doe, location_code)]

  # Count deaths within week
  for ( i in 1:n_week){
    temp_d <- d[, .(cut_doe, n_death, location_code)]
    temp <- d[dor < (as.Date(cut_doe) + i*7), .(
      temp_outcome_n = .N,
      temp_outcome_p = sum(dor < (as.Date(cut_doe) + i*7))/n_death,
      n_death = n_death),
      keyby = .(cut_doe, location_code)]

    temp_d[,paste0("n0_", (i-1)) := 0]
    temp_d[,paste0("p0_", (i-1)) := 0]
    temp_d[temp, on= .(cut_doe, location_code),  paste0("n0_", (i-1)) := temp_outcome_n]
    temp_d[temp, on= .(cut_doe, location_code),  paste0("p0_", (i-1)) := temp_outcome_p]


    retval[[i ]] <- as.data.frame(temp_d)

  }

  d_within_week <- cbind.data.frame(retval)
  setDT(d_within_week)
  d_within_week[, unique_id := 1:.N, by=.(cut_doe, location_code)]
  d_within_week <- d_within_week[ unique_id == 1]
  # d_within_week <- unique(as.data.table(d_within_week))
  d_within_week <- as.data.table(subset(d_within_week, select = unique(colnames(d_within_week))))


  date_0 <- as.Date(cut(aggregation_date, "week"))
  d_corrected <- d_within_week[, .(cut_doe,location_code, n_death, n0_0, p0_0)]


  # expand so all dates are present

  dates <- seq.Date(
    from = first_date,
    to = last_date,
    by = 7
  )
  # THIS COULD CAUSE SOME TROUBLE IF THE TIME PERIOD IS VERY LONG.

  dates <- as.Date(cut(dates, "week"))
  all_dates_locations <- expand.grid(
    cut_doe = dates,
    location_code = unique(d_within_week$location_code)
  )

  test <- merge(d_within_week, all_dates_locations, on = c("cut_doe, location_code"), all = TRUE)
  for(i in 0:n_week){
    test[is.na(n_death), paste0("n0_",(i)) := 0]
  }

  test[is.na(n_death), n_death := 0]
  d_within_week <- test
  d_corrected <- d_within_week[, .(cut_doe,location_code, n_death, n0_0, p0_0)]
  # Merge together so all dates are present

  # d_corrected <- merge(d_corrected, all_dates_locations, on = c("cut_doe, location_code"), all = TRUE)
  # d_corrected[is.na(n_death), n0_0 := 0]
  # d_corrected[is.na(n_death), p0_0 := 0]
  # d_corrected[is.na(n_death), n_death := 0]


  # insert NA where we do not have data
  for ( i in 2:n_week){

    week_n <- paste0("n0_",(i-1))
    week_p <- paste0("p0_",(i-1))
    d_within_week[, new_value := NA]
    d_within_week[, temp_variable_n := get(week_n)]
    d_within_week[, temp_variable_p := get(week_p)]


    d_within_week[cut_doe >= (last_date- (i-2)*7)]#, temp_variable_n := new_value]


    d_within_week[cut_doe >= (last_date- (i-2)*7), temp_variable_n := new_value]
    d_within_week[cut_doe >= (last_date- (i-2)*7), temp_variable_p := new_value]


    d_corrected[ d_within_week,
                 on = c("cut_doe", "location_code"),
                 paste0("n0_",(i-1)) := temp_variable_n]
    d_corrected[ d_within_week,
                 on = c("cut_doe", "location_code"),
                 paste0("p0_",(i-1)) := temp_variable_p]
  }

  d_corrected[, week := isoweek(cut_doe)]
  d_corrected[, year := isoyear_n(cut_doe)]
  if(!is.null(pop_data)){
    if ("week" %in% colnames(pop_data)){
    d_corrected[pop_data, pop := pop, on = c("year", "week", "location_code")]
    }else{
    d_corrected[pop_data,
                on = c("year", "location_code"),
                pop := pop]
    }
  }

  ## Save rds
    # data_fake_nowcasting_county_aggregated <- d_corrected
    # save(data_fake_nowcasting_county_aggregated, file = "data/data_fake_nowcasting_county_aggregated.rda", compress = "bzip2")


  retval <- d_corrected

  return (retval)
}
