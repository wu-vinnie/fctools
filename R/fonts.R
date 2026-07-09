# ============================================================
# Fullerton College (FC) Font & Table Defaults
# Package: fctools
# ============================================================

#' Register Century Gothic (and other system fonts) for plotting
#'
#' Wraps `extrafont::loadfonts()` so FC's brand font renders correctly
#' in ggplot2/base R graphics output. Not run automatically on package
#' load — call this explicitly once per session, before rendering any
#' plots, if you need non-web fonts embedded (e.g. for PDF reports).
#'
#' HTML reports generally don't need this: browsers render
#' `font-family: "Century Gothic"` from `fullerton.css` directly and
#' fall back to Helvetica/sans-serif if the font isn't installed on
#' the reader's machine.
#'
#' @param device Passed to `extrafont::loadfonts()`. One of `"auto"`
#'   (default; picks `"win"` on Windows and `"pdf"` elsewhere),
#'   `"win"`, `"pdf"`, or `"postscript"`.
#' @param quiet Logical. Suppress font-loading messages. Default `TRUE`.
#'
#' @return Invisibly, `NULL`. Called for its side effect of
#'   registering fonts with the graphics device.
#'
#' @export
use_fc_fonts <- function(
  device = c("auto", "win", "pdf", "postscript"),
  quiet = TRUE
) {
  device <- match.arg(device)

  if (device == "auto") {
    device <- if (.Platform$OS.type == "windows") "win" else "pdf"
  }

  extrafont::loadfonts(device = device, quiet = quiet)

  invisible(NULL)
}

#' Apply Fullerton College defaults to flextable
#'
#' Sets `flextable`'s global font-family default to FC's brand font.
#' Not run automatically on package load — call this explicitly at
#' the top of a script or report if you're using `flextable` for
#' publication-quality tables and want them to match FC branding by
#' default.
#'
#' @return Invisibly, `NULL`. Called for its side effect of setting
#'   `flextable` package-level defaults.
#'
#' @export
use_fc_flextable <- function() {
  flextable::set_flextable_defaults(font.family = "Century Gothic")
  invisible(NULL)
}
