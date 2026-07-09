# ============================================================
# Fullerton College (FC) ggplot2 Theme + Scales
# Package: fctools
# ============================================================

#' Fullerton College ggplot2 theme
#'
#' A `theme_minimal()`-based ggplot2 theme using FC brand colors
#' and typography. Does not set itself as the active theme — call
#' [use_fc_theme()] or `ggplot2::theme_set(theme_fc())` explicitly
#' if you want it applied to every plot in a session.
#'
#' @param base_size Base font size, in points. Default `12`.
#' @param base_family Base font family. Default `"Century Gothic"`.
#'   Requires the font to be registered on the system; see
#'   [use_fc_fonts()].
#'
#' @return A ggplot2 theme object, addable to a ggplot with `+`.
#'
#' @examples
#' \dontrun{
#' library(ggplot2)
#' ggplot(mpg, aes(displ, hwy)) +
#'   geom_point() +
#'   theme_fc()
#' }
#'
#' @export
theme_fc <- function(base_size = 12, base_family = "Century Gothic") {
  ggplot2::theme_minimal(base_size = base_size, base_family = base_family) +
    ggplot2::theme(
      text = ggplot2::element_text(family = base_family, color = fc_gray),
      plot.title = ggplot2::element_text(
        face = "bold",
        color = fc_colors["Blue"],
        size = ggplot2::rel(1.2),
        hjust = 0.5
      ),
      plot.subtitle = ggplot2::element_text(color = fc_gray, hjust = 0.5),
      axis.title = ggplot2::element_text(color = fc_gray, face = "bold"),
      axis.text = ggplot2::element_text(color = fc_gray),
      panel.grid.major = ggplot2::element_line(color = "#DDDDDD"),
      panel.grid.minor = ggplot2::element_blank(),
      plot.caption = ggplot2::element_text(
        color = fc_gray,
        size = ggplot2::rel(0.9),
        hjust = 1
      ),
      legend.title = ggplot2::element_text(color = fc_gray, face = "bold"),
      legend.text = ggplot2::element_text(color = fc_gray),
      plot.margin = ggplot2::margin(10, 10, 10, 10)
    )
}

#' Set theme_fc() as the active ggplot2 theme
#'
#' Convenience wrapper around `ggplot2::theme_set(theme_fc())`. Call
#' this explicitly at the top of a script or report if you want every
#' subsequent ggplot to use FC branding by default. Not run
#' automatically on package load.
#'
#' @param ... Arguments passed to [theme_fc()].
#'
#' @return Invisibly, the previous theme (per `ggplot2::theme_set()`),
#'   called for its side effect.
#'
#' @export
use_fc_theme <- function(...) {
  invisible(ggplot2::theme_set(theme_fc(...)))
}

#' Fullerton College fill scale
#'
#' Applies the FC brand palette to a ggplot's `fill` aesthetic.
#' Colors are recycled if there are more groups than palette colors.
#'
#' @param ... Additional arguments passed to
#'   `ggplot2::scale_fill_manual()` or `ggplot2::scale_fill_gradientn()`.
#' @param discrete Logical. `TRUE` (default) for discrete fill scales;
#'   `FALSE` for continuous scales using the palette as a gradient.
#'
#' @return A ggplot2 scale object, addable to a ggplot with `+`.
#' @export
scale_fill_fc <- function(..., discrete = TRUE) {
  if (discrete) {
    ggplot2::scale_fill_manual(
      values = rep(unname(fc_colors), length.out = 20),
      ...
    )
  } else {
    ggplot2::scale_fill_gradientn(colours = unname(fc_colors), ...)
  }
}

#' Fullerton College color scale
#'
#' Applies the FC brand palette to a ggplot's `color`/`colour`
#' aesthetic. Colors are recycled if there are more groups than
#' palette colors.
#'
#' @param ... Additional arguments passed to
#'   `ggplot2::scale_color_manual()` or `ggplot2::scale_color_gradientn()`.
#' @param discrete Logical. `TRUE` (default) for discrete color scales;
#'   `FALSE` for continuous scales using the palette as a gradient.
#'
#' @return A ggplot2 scale object, addable to a ggplot with `+`.
#' @export
scale_color_fc <- function(..., discrete = TRUE) {
  if (discrete) {
    ggplot2::scale_color_manual(
      values = rep(unname(fc_colors), length.out = 20),
      ...
    )
  } else {
    ggplot2::scale_color_gradientn(colours = unname(fc_colors), ...)
  }
}
