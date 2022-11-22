#' Fake data for attributable mortality in Norway (counties)
#'
#' @format
#' \describe{
#' \item{location_code}{Location code of the Norwegian counties.}
#' \item{isoyear}{Isoyear.}
#' \item{isoweek}{Isoweek.}
#' \item{isoyearweek}{Isoyear and isoweek.}
#' \item{season}{Season used for influenza like illnesses.}
#' \item{seasonweek}{Number of weeks from the start of the season.}
#' \item{pop_jan1_n}{Population size.}
#' \item{ili_isoweekmean0_6_pr100}{Per hundred ILI, percentage of consultations diagnosed as influenza like illnesses.}
#' \item{ili_isoweekmean7_13_pr100}{ili_isoweekmean0_6_pr100 lagged by one week.}
#' \item{heatwavedays_n}{Number of days of the week that were considered a heatwave}
#' \item{deaths_n}{Number of deaths}
#' }
"data_fake_attrib_county"

#' Fake data for attributable mortality in Norway (nation)
#'
#' @format
#' \describe{
#' \item{location_code}{Location code of the Norwegian nation (nation_nor)}
#' \item{isoyear}{Isoyear.}
#' \item{isoweek}{Isoweek.}
#' \item{isoyearweek}{Isoyear and isoweek.}
#' \item{season}{Season used for influenza like illnesses.}
#' \item{seasonweek}{Number of weeks from the start of the season.}
#' \item{pop_jan1_n}{Population size.}
#' \item{ili_isoweekmean0_6_pr100}{Per hundred ILI, percentage of consultations diagnosed as influenza like illnesses.}
#' \item{ili_isoweekmean7_13_pr100}{ili_isoweekmean0_6_pr100 lagged by one week.}
#' \item{heatwavedays_n}{Number of days of the week that were considered a heatwave}
#' \item{deaths_n}{Number of deaths}
#' }
"data_fake_attrib_nation"


#' Fake data for mortality registration
#'
#' @format
#' \describe{
#' \item{doe}{Date of event}
#' \item{dor}{Date of registration}
#' \item{location_code}{Location code}
#' }
"data_fake_nowcasting_county_raw"

#' Fake data for mortality registration
#'
#' @format
#' \describe{
#' \item{doe}{Date of event}
#' \item{dor}{Date of registration}
#' }
"data_fake_nowcasting_nation_raw"

#' Cleaned fake data for mortalityregistration
#'
#' @format
#' \describe{
#' \item{cut_doe}{First date of every week}
#' \item{n_death}{Number of true deaths this week}
#' \item{n0_0}{Number of registrations within the current week}
#' \item{n0_1}{Number of registrations within the current and previous week}
#' \item{p0_1}{Percentile of registrations within the current and previous week}
#' \item{n0_2}{Number of registrations within the 2 last weeks and the current week}
#' \item{p0_2}{Percentile of registrations within the current and prvious 2 weeks}
#' \item{n0_3}{Number of registrations within the 3 last weeks and the current week}
#' \item{p0_3}{Percentile of registrations within the current and prvious 3 weeks}
#' \item{n0_4}{Number of registrations within the 4 weeks and the current week}
#' \item{p0_4}{Percentile of registrations within the current and prvious 4 weeks}
#' \item{n0_5}{Number of registrations within the 5 weeks and the current week}
#' \item{p0_5}{Percentile of registrations within the current and prvious 5 weeks}
#' \item{n0_6}{Number of registrations within the 6 weeks and the current week}
#' \item{p0_6}{Percentile of registrations within the current and prvious 6 weeks}
#' \item{n0_7}{Number of registrations within the 7 weeks and the current week}
#' \item{p0_7}{Percentile of registrations within the current and prvious 7 weeks}
#' \item{n0_8}{Number of registrations within the 8 weeks and the current week}
#' \item{p0_8}{Percentile of registrations within the current and prvious 8 weeks}
#' \item{n0_9}{Number of registrations within the 9 weeks and the current week}
#' \item{p0_9}{Percentile of registrations within the current and prvious 9 weeks}
#' \item{n0_10}{Number of registrations within the 10 weeks and the current week}
#' \item{p0_10}{Percentile of registrations within the current and prvious 10 weeks}
#' \item{n0_11}{Number of registrations within the 11 weeks and the current week}
#' \item{p0_11}{Percentile of registrations within the current and prvious 11 weeks}
#' \item{n0_12}{Number of registrations within the 12 weeks and the current week}
#' \item{p0_12}{Percentile of registrations within the current and prvious 12 weeks}
#' \item{n0_13}{Number of registrations within the 13 weeks and the current week}
#' \item{p0_13}{Percentile of registrations within the current and prvious 13 weeks}
#' \item{n0_14}{Number of registrations within the 14 weeks and the current week}
#' \item{p0_14}{Percentile of registrations within the current and prvious 14 weeks}
#' \item{n0_15}{Number of registrations within the 15 weeks and the current week}
#' \item{p0_15}{Percentile of registrations within the current and prvious 15 weeks}
#' }
"data_fake_nowcasting_nation_aggregated"

#' Cleaned fake data for mortality registration on a county basis
#'
#' @format
#' \describe{
#' \item{cut_doe}{First date of every week}
#' \item{location_code}{Location code}
#' \item{n_death}{Number of true deaths this week}
#' \item{n0_0}{Number of registrations within the current week}
#' \item{n0_1}{Number of registrations within the current and previous week}
#' \item{p0_1}{Percentile of registrations within the current and previous week}
#' \item{n0_2}{Number of registrations within the 2 last weeks and the current week}
#' \item{p0_2}{Percentile of registrations within the current and prvious 2 weeks}
#' \item{n0_3}{Number of registrations within the 3 last weeks and the current week}
#' \item{p0_3}{Percentile of registrations within the current and prvious 3 weeks}
#' \item{n0_4}{Number of registrations within the 4 weeks and the current week}
#' \item{p0_4}{Percentile of registrations within the current and prvious 4 weeks}
#' \item{n0_5}{Number of registrations within the 5 weeks and the current week}
#' \item{p0_5}{Percentile of registrations within the current and prvious 5 weeks}
#' \item{n0_6}{Number of registrations within the 6 weeks and the current week}
#' \item{p0_6}{Percentile of registrations within the current and prvious 6 weeks}
#' \item{n0_7}{Number of registrations within the 7 weeks and the current week}
#' \item{p0_7}{Percentile of registrations within the current and prvious 7 weeks}
#' \item{n0_8}{Number of registrations within the 8 weeks and the current week}
#' \item{p0_8}{Percentile of registrations within the current and prvious 8 weeks}
#' \item{n0_9}{Number of registrations within the 9 weeks and the current week}
#' \item{p0_9}{Percentile of registrations within the current and prvious 9 weeks}
#' \item{n0_10}{Number of registrations within the 10 weeks and the current week}
#' \item{p0_10}{Percentile of registrations within the current and prvious 10 weeks}
#' \item{n0_11}{Number of registrations within the 11 weeks and the current week}
#' \item{p0_11}{Percentile of registrations within the current and prvious 11 weeks}
#' \item{n0_12}{Number of registrations within the 12 weeks and the current week}
#' \item{p0_12}{Percentile of registrations within the current and prvious 12 weeks}
#' \item{n0_13}{Number of registrations within the 13 weeks and the current week}
#' \item{p0_13}{Percentile of registrations within the current and prvious 13 weeks}
#' \item{n0_14}{Number of registrations within the 14 weeks and the current week}
#' \item{p0_14}{Percentile of registrations within the current and prvious 14 weeks}
#' \item{n0_15}{Number of registrations within the 15 weeks and the current week}
#' \item{p0_15}{Percentile of registrations within the current and prvious 15 weeks}
#' }
"data_fake_nowcasting_county_aggregated"
