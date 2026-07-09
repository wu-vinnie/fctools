# ============================================================
# Fullerton College (FC) Plotly Theme
# Package: fctools

# ============================================================

#' Apply Fullerton College styling to a plotly chart
#'
#' Applies FC brand fonts, colors, and a stripped-down grid/axis
#' style to an existing plotly object via `plotly::layout()`.
#' Intended to be used at the end of a plotly pipe chain.
#'
#' @param p A plotly object (from `plotly::plot_ly()` or
#'   `plotly::ggplotly()`).
#'
#' @return The input plotly object with FC layout styling applied.
#'
#' @examples
#' \dontrun{
#' library(plotly)
#' plot_ly(mpg, x = ~displ, y = ~hwy, type = "scatter", mode = "markers") |>
#'   fc_plotly_theme()
#' }
#'
#' @export
fc_plotly_theme <- function(p) {
  p |>
    plotly::layout(
      margin = list(l = 90, r = 40, t = 60, b = 60),
      font = list(family = "Century Gothic", color = fc_gray),
      xaxis = list(
        titlefont = list(family = "Century Gothic", size = 14, color = fc_blue),
        tickfont = list(family = "Century Gothic", size = 12, color = fc_gray),
        showgrid = FALSE,
        zeroline = FALSE,
        showline = FALSE
      ),
      yaxis = list(
        titlefont = list(family = "Century Gothic", size = 14, color = fc_blue),
        tickfont = list(family = "Century Gothic", size = 12, color = fc_gray),
        showgrid = FALSE,
        zeroline = FALSE,
        showline = FALSE
      ),
      plot_bgcolor = "white",
      paper_bgcolor = "white",
      hoverlabel = list(
        font = list(family = "Century Gothic", size = 12, color = "white"),
        bgcolor = fc_blue,
        bordercolor = fc_gray
      )
    )
}
