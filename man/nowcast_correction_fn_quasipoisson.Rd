% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/nowcast_expand.R
\name{nowcast_correction_fn_quasipoisson}
\alias{nowcast_correction_fn_quasipoisson}
\title{Nowcast correction function using the quasipoisson distribution.}
\usage{
nowcast_correction_fn_quasipoisson(data, n_week_adjusting, offset, date_0)
}
\arguments{
\item{data}{Data generated with nowcast_aggregate containing the part of the dataset that the model should train on.}

\item{n_week_adjusting}{Number of weeks to correct}

\item{offset}{Boolian value which is set to true if offset(log(pop)) is a part of the formula}

\item{date_0}{Date of aggregation.}
}
\value{
nowcast_correction_object including corrected data for all weeks in n_wwk_adjust and the model fits for all weeks
}
\description{
For more details see the help vignette:
\code{vignette("nowcast", package="attrib")}
}
\examples{
data<- data.table::as.data.table(data_fake_nowcasting_county_aggregated)
data <- data[location_code == "county_nor03"]
n_week_adjusting <- 5
n_week_train <- 52
n_week_start <- n_week_adjusting + n_week_train
date_0 <- data[nrow(data),]$cut_doe #last date in the dataset, assume the dataset is ordered.
data <- data[cut_doe >= (date_0 - n_week_start*7 + 1), ]
nowcast_correction_object <- nowcast_correction_fn_quasipoisson(data,
     n_week_adjusting, offset = "log(pop)", date_0 )
}
