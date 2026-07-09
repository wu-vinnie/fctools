# ==============================================================================
# Internal helper
# ==============================================================================

# Extract a single ethnicity indicator from a CCCCO MIS ethnicity code.
.get_ethnicity <- function(
  x,
  ethnicity = c(
    "black",
    "native",
    "asian",
    "filipino",
    "hispanic",
    "pi",
    "white",
    "unknown"
  )
) {
  if (!is.character(x)) {
    stop("`x` must be a character vector.", call. = FALSE)
  }

  ethnicity <- match.arg(ethnicity)

  out <- rep(NA_integer_, length(x))

  not_na <- !is.na(x)

  xs <- x[not_na]

  out[not_na] <- switch(
    ethnicity,

    black = as.integer(
      substr(xs, 15, 15) == "Y"
    ),

    native = as.integer(
      substr(xs, 16, 16) == "Y"
    ),

    asian = as.integer(
      grepl("Y", substr(xs, 6, 12)) |
        substr(xs, 14, 14) == "Y"
    ),

    filipino = as.integer(
      substr(xs, 13, 13) == "Y"
    ),

    hispanic = as.integer(
      substr(xs, 1, 1) == "Y" |
        grepl("Y", substr(xs, 2, 5))
    ),

    pi = as.integer(
      grepl("Y", substr(xs, 17, 20))
    ),

    white = as.integer(
      substr(xs, 21, 21) == "Y"
    ),

    unknown = as.integer(
      xs == strrep("N", 21) |
        xs == paste0("X", strrep("N", 20))
    )
  )

  out
}

# ==============================================================================
# Public functions
# ==============================================================================

#' Derive ethnicity indicators from a CCCCO MIS ethnicity code
#'
#' Adds ethnicity indicator variables to a data frame based on the
#' 21-character California Community Colleges Chancellor's Office (CCCCO)
#' MIS ethnicity code.
#'
#' This is a convenience function that derives all ethnicity indicators
#' at once. If only a single ethnicity indicator is needed, use one of
#' the helper functions such as `get_black()`, `get_asian()`, or
#' `get_hispanic()`.
#'
#' Existing ethnicity indicator columns with the same names are
#' overwritten.
#'
#' @param data A data frame.
#' @param mis_col Name of the column containing the CCCCO MIS ethnicity
#'   code.
#'
#' @return The input data frame with the following variables added:
#' \describe{
#'   \item{ethn_black}{Black/African American}
#'   \item{ethn_native}{American Indian/Alaska Native}
#'   \item{ethn_asian}{Asian}
#'   \item{ethn_filipino}{Filipino}
#'   \item{ethn_hispanic}{Hispanic/Latino}
#'   \item{ethn_pi}{Native Hawaiian or Other Pacific Islander}
#'   \item{ethn_white}{White}
#'   \item{ethn_unknown}{Unknown / not stated}
#' }
#'
#' Each indicator is coded as:
#' \itemize{
#'   \item `1` = belongs to the ethnicity
#'   \item `0` = does not belong to the ethnicity
#'   \item `NA` = missing MIS ethnicity code
#' }
#'
#' @seealso
#' `get_black()`,
#' `get_native()`,
#' `get_asian()`,
#' `get_filipino()`,
#' `get_hispanic()`,
#' `get_pi()`,
#' `get_white()`,
#' `get_unknown()`
#'
#' @examples
#'
#' \dontrun{
#'
#' # Default column name is "MIS_ETHNICITY_CODE"
#' df <- get_ethnicity(df)
#'
#' # Specify a different MIS ethnicity column
#' df <- get_ethnicity(df, "MIS_ETHNICITY_CODE")
#'
#' # Derive a single ethnicity indicator
#' df$ethn_black <- get_black(df$MIS_ETHNICITY_CODE)
#'
#' }
#'
#' @export
get_ethnicity <- function(
  data,
  mis_col = "MIS_ETHNICITY_CODE"
) {
  if (!is.data.frame(data)) {
    stop("`data` must be a data frame.", call. = FALSE)
  }

  if (!mis_col %in% names(data)) {
    stop(
      "`",
      mis_col,
      "` was not found in `data`.",
      call. = FALSE
    )
  }

  x <- data[[mis_col]]

  data$ethn_black <- get_black(x)
  data$ethn_native <- get_native(x)
  data$ethn_asian <- get_asian(x)
  data$ethn_filipino <- get_filipino(x)
  data$ethn_hispanic <- get_hispanic(x)
  data$ethn_pi <- get_pi(x)
  data$ethn_white <- get_white(x)
  data$ethn_unknown <- get_unknown(x)

  data
}

# ==============================================================================
# Individual ethnicity helpers
# ==============================================================================

#' Derive individual ethnicity indicators
#'
#' Helper functions that extract a single ethnicity indicator from a
#' California Community Colleges Chancellor's Office (CCCCO) MIS
#' ethnicity code.
#'
#' @param x A character vector containing CCCCO MIS ethnicity codes.
#'
#' @return An integer vector where:
#' \itemize{
#'   \item `1` = belongs to the requested ethnicity
#'   \item `0` = does not belong to the requested ethnicity
#'   \item `NA` = missing MIS ethnicity code
#' }
#'
#' @seealso
#' `get_ethnicity()`
#'
#' @name ethnicity_helpers
NULL

#' @rdname ethnicity_helpers
#' @export
get_black <- function(x) {
  .get_ethnicity(x, "black")
}

#' @rdname ethnicity_helpers
#' @export
get_native <- function(x) {
  .get_ethnicity(x, "native")
}

#' @rdname ethnicity_helpers
#' @export
get_asian <- function(x) {
  .get_ethnicity(x, "asian")
}

#' @rdname ethnicity_helpers
#' @export
get_filipino <- function(x) {
  .get_ethnicity(x, "filipino")
}

#' @rdname ethnicity_helpers
#' @export
get_hispanic <- function(x) {
  .get_ethnicity(x, "hispanic")
}

#' @rdname ethnicity_helpers
#' @export
get_pi <- function(x) {
  .get_ethnicity(x, "pi")
}

#' @rdname ethnicity_helpers
#' @export
get_white <- function(x) {
  .get_ethnicity(x, "white")
}

#' @rdname ethnicity_helpers
#' @export
get_unknown <- function(x) {
  .get_ethnicity(x, "unknown")
}
