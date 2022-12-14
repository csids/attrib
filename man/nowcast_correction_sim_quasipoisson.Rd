% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/nowcast_expand.R
\name{nowcast_correction_sim_quasipoisson}
\alias{nowcast_correction_sim_quasipoisson}
\title{Nowcast simmulation function when nowcast_correction_fn_quasipoisson is used for correction.}
\usage{
nowcast_correction_sim_quasipoisson(
  nowcast_correction_object,
  offset,
  n_sim = 500,
  date_0
)
}
\arguments{
\item{nowcast_correction_object}{object returned from function nowcast_correction_fn_expanded}

\item{offset}{Boolian value which is set to true if offset(log(pop)) is a part of the formula}

\item{n_sim}{Number of simulations}

\item{date_0}{Date of aggregation.}
}
\value{
simulations of the estimate made by the fitted models in nowcast_correction_fn
}
\description{
For more details see the help vignette:
\code{vignette("nowcast", package="attrib")}
}
\examples{
data <- data.table::as.data.table(data_fake_nowcasting_county_aggregated)
data <- data[location_code == "county_nor03"]
n_week_adjusting <- 5
n_week_train <- 52
n_week_start <- n_week_adjusting + n_week_train
date_0 <- data[nrow(data),]$cut_doe #last date in the dataset, assume the dataset is ordered.
data <- data[cut_doe >= (date_0 - n_week_start*7 + 1), ]
nowcast_correction_object <- nowcast_correction_fn_quasipoisson(data,
   n_week_adjusting, offset = TRUE, date_0 )
nowcast_sim <- nowcast_correction_sim_quasipoisson(nowcast_correction_object,
     offset = "log(pop)", date_0= date_0)
}
