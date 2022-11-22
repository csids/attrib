
# Generates fake data
#
# This function generates a fake dataset with parameters
# @param n_locations Telling how many locations one wants in the output data, default = 11 the number of municipalities in Norway.

start_date <- as.Date("2009-07-20")
end_date <- as.Date("2020-07-19")

location_code <- c("county_nor03", "county_nor11", "county_nor15", "county_nor18", "county_nor30", "county_nor34", "county_nor38", "county_nor42", "county_nor46", "county_nor50", "county_nor54")
# unique(fhidata::norway_locations_b2020$county_code)
# location_code <- "norway"
skeleton <- expand.grid(
  location_code = location_code,
  date = seq.Date(
    from = start_date,
    to = end_date,
    by = 7 # to get a weakly base.
  ),
  stringsAsFactors = FALSE
)
setDT(skeleton)

skeleton[, isoyear := cstime::date_to_isoyear_n(date)]
skeleton[, isoweek := cstime::date_to_isoweek_n(date)]
skeleton[, isoyearweek := cstime::date_to_isoyearweek_c(date)]
skeleton[, seasonweek := cstime::date_to_seasonweek_n(date)]
skeleton[, season := cstime::date_to_season_c(date)]


x_pop <- data.table(
  location_code = c("county_nor03", "county_nor11", "county_nor15", "county_nor18", "county_nor30", "county_nor34", "county_nor38", "county_nor42", "county_nor46", "county_nor50", "county_nor54"),
  pop = c(693494, 479892, 265238, 241235, 1241165, 371385, 419396, 307231, 636531, 468702, 243311)
)

skeleton[
  x_pop,
  on = c("location_code"),
  pop := pop
]

# skeleton[, pop := 5367580]
######## seasonbased influenza
#### still without any lag.
skeleton_season <- unique(skeleton[, c("location_code", "season")])
skeleton_season[, peak_center_influenza := round(stats::rnorm(.N, mean = 28, sd = 3))]
skeleton_season[, hight_peak := stats::rnorm(.N, mean = 2, sd = 0.02)]
skeleton_season[, influenza_coef := stats::rnorm(.N, mean = 0.03, sd = 0.02)]

skeleton <- merge(
  skeleton,
  skeleton_season,
  by = c("location_code", "season")
)

skeleton[, normal_base := stats::dnorm(seasonweek, peak_center_influenza, 5)]
skeleton[, pr100_ili := 10 * 1.2 * hight_peak * normal_base] # something strange doing on her but this gives pr100ili around 2
skeleton[pr100_ili < 0, pr100_ili := 0] # should there be some more randomness here??

skeleton[, pr100_ili_lag_1 := shift(pr100_ili, fill = 0), by = c("location_code")]
skeleton[, pr100_ili_lag_2 := shift(pr100_ili, n = 2L, fill = 0), by = c("location_code")]

# temperature

skeleton_weeks_temp <- unique(skeleton[, c("location_code", "isoweek")])
skeleton_weeks_temp[, mean_temperature := (26 - abs((isoweek - 26)))]
skeleton_weeks_temp[, mean_temperature := c(skeleton_weeks_temp[(.N - 4):.N]$mean_temperature, skeleton_weeks_temp[1:(.N - 5)]$mean_temperature) - 5]

skeleton <- merge(
  skeleton,
  skeleton_weeks_temp,
  by = c("location_code", "isoweek")
)
skeleton[, temperature := stats::rnorm(
  n = .N,
  mean = mean_temperature, # temperature span between -5,20 on average
  sd = 5
)]

skeleton[, temperature_high := 0]
skeleton[temperature > 20, temperature_high := stats::rbinom(.N, 7, 0.2)]

# generate deaths

skeleton[, mu := exp(-8.8 +
  0.08 * temperature_high +
  # 0.25*influenza_coef * pr100_ili +
  influenza_coef * pr100_ili_lag_1 +
  # 10*pr100_covid19_lag_1 +
  0.02 * sin(2 * pi * (isoweek - 1) / 52) + 0.07 * cos(2 * pi * (isoweek - 1) / 52) + # finn a og b
  # 1*pr100_ili_lag_2 +
  log(pop))]


skeleton[, deaths := stats::rpois(n = .N, lambda = mu)]


  # fit <- lme4::glmer(deaths ~ (1|location_code) +
  #                      #splines::ns(skeleton$temperature, df=3) +
  #                      temperature_high +
  #                      pr100_ili_lag_1 +
  #                      (pr100_ili_lag_1|season) +
  #                      sin(2 * pi * (isoweek - 1) / 52) + cos(2 * pi * (isoweek - 1) / 52)+
  #                      offset(log(pop)),
  #                    data = skeleton,
  #                    family = "poisson")
  # summary(fit)
  #
  #
  # death_tot <- skeleton[, .(
  #   death = sum(deaths),
  #   year
  # ), keyby = .(
  #   date
  # )]
  # min(death_tot$death)
  # max(death_tot$death)
  # get unique loctation codes, return n first.

  # fake_data_colums <- c("location_code", "isoweek", "season", "year", "isoyearweek", "x", "pop", "pr100_ili", "pr100_ili_lag_1", "temperature", "temperature_high", "deaths")
  # data_fake_county <- skeleton[, ..fake_data_colums]
  # save(data_fake_county, file = "data/data_fake_county.rda", compress = "bzip2")
  #
  # data_fake_nation <- data_fake_county[, .(
  #   location_code = "norge",
  #   pop = sum(pop),
  #   pr100_ili = mean(pr100_ili),
  #   pr100_ili_lag_1 = mean(pr100_ili_lag_1),
  #   temperature_high = min(temperature_high),
  #   deaths = sum(deaths)
  # ), keyby = .(
  #     isoweek,
  #     season,
  #     isoyear,
  #     isoyearweek,
  #     x
  # )]
  #
  # save(data_fake_nation, file = "data/data_fake_nation.rda", compress = "bzip2")
  #
  #

data_fake_attrib_county <- skeleton[,.(
  location_code,
  isoyear,
  isoweek,
  isoyearweek,
  season,
  seasonweek,
  pop_jan1_n = pop,
  ili_isoweekmean0_6_pr100 = pr100_ili,
  ili_isoweekmean7_13_pr100 = pr100_ili_lag_1,
  heatwavedays_n = temperature_high,
  deaths_n = deaths
)]

data_fake_attrib_nation <- skeleton[,.(
  location_code = "nation_nor",
  pop_jan1_n = sum(pop),
  ili_isoweekmean0_6_pr100 = mean(pr100_ili),
  ili_isoweekmean7_13_pr100 = mean(pr100_ili_lag_1),
  heatwavedays_n = mean(temperature_high),
  deaths_n = sum(deaths)
), keyby=.(
  isoyear,
  isoweek,
  isoyearweek,
  season,
  seasonweek
)]
setcolorder(data_fake_attrib_nation, names(data_fake_attrib_county))

save(data_fake_attrib_county, file = "data/data_fake_attrib_county.rda", compress = "bzip2")
save(data_fake_attrib_nation, file = "data/data_fake_attrib_nation.rda", compress = "bzip2")


