# ============================================================
# Fullerton College (FC) Brand Colors
# Package: fctools
# ============================================================

#' Fullerton College brand color palette
#'
#' A named character vector of Fullerton College's official brand
#' colors, keyed by name for easy reference (e.g. `fc_colors["Blue"]`).
#'
#' @format A named character vector of length 8, with hex color codes.
#' @examples
#' fc_colors["Blue"]
#' unname(fc_colors)
#' @export
fc_colors <- c(
  "Blue" = "#0F406B",
  "Yellow" = "#FFD600",
  "Sky" = "#375E9E",
  "Creek" = "#5DCCD4",
  "Breeze" = "#BAEEED",
  "LemonZest" = "#F5F3BF",
  "Rustic" = "#E6605B",
  "Elderberry" = "#1B0D42"
)

#' Fullerton College primary blue
#'
#' Shorthand for `fc_colors["Blue"]`, unnamed, for use in contexts
#' (e.g. base plotting, HTML/CSS generation) that expect a bare
#' hex string rather than a named vector element.
#'
#' @format A single hex color string.
#' @export
fc_blue <- unname(fc_colors["Blue"])

#' Fullerton College neutral text gray
#'
#' Used for body text, axis labels, and captions across FC report
#' templates.
#'
#' @format A single hex color string.
#' @export
fc_gray <- "#333333"
