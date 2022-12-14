#' Data fit
#'
#' Data fit using glmer from lme4 with family poisson to fit the dataset with the given formula.
#'
#'
#' @param data The observed data to be fitted.
#' @param response The response
#' @param fixef The fixed effects
#' @param ranef The random effects
#' @param offset The offsets.
#' @param dist_family Family
#'
#' @return The model fit of the data with additional attributes offset, response and fit_fix.
#' Offset and response are the same as in the input and fit_fix is the linear model of the fix effects.
#'
#' For more details see the help vignette:
#' \code{vignette("intro", package="attrib")}
#'
#' @examples
#'
#' response <- "deaths_n"
#'
#' fixef <- "ili_isoweekmean7_13_pr100 +
#'   sin(2 * pi * (isoweek - 1) / 52) +
#'   cos(2 * pi * (isoweek - 1) / 52)"
#' ranef <- " (ili_isoweekmean7_13_pr100| season)"
#' offset <- "log(pop_jan1_n)"
#'
#' data <- attrib::data_fake_attrib_nation
#'
#' fit_attrib(data = data, response = response, fixef = fixef, ranef = ranef, offset = offset)
#' @export
fit_attrib <- function(
                       data,
                       response,
                       fixef,
                       ranef,
                       dist_family = "poisson",
                       offset = NULL) {
  is_data_table(data)

  # fix this with offset
  if (is.null(offset)) {
    if (tryCatch(
      {
        stats::as.formula(paste0(response, "~", fixef))
      },
      error = function(e) {
        "error"
      }
    ) == "error") {
      stop("response, fixef or ranef is not in the correct form")
    }

    formula <- paste0(response, "~", fixef, "+", ranef)
    fit_fix <- stats::lm(stats::as.formula(paste0(response, "~", fixef)), data = data)
  } else {
    formula <- paste0(response, "~", fixef, "+ offset(", offset, ")+", ranef)

    if (tryCatch(
      {
        stats::as.formula(formula)
      },
      error = function(e) {
        "error"
      }
    ) == "error") {
      stop("response, offset, fixef or ranef is not in the correct form")
    }

    fit_fix <- stats::lm(stats::as.formula(paste0(response, "~", fixef, "+ offset(", offset, ")")), data = data)
  }

  if(dist_family == "negbin"){
    fit <- lme4::glmer.nb(stats::as.formula(formula), data = data)
  }else{
    fit <- lme4::glmer(stats::as.formula(formula), family = dist_family, data = data)
  }


  attr(fit, "fit_fix") <- fit_fix
  attr(fit, "offset") <- offset
  attr(fit, "response") <- response

  return(fit)
}
