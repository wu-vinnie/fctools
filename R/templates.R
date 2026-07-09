# ==============================================================================
# Project templates
# ==============================================================================

#' Create a new report project
#'
#' Creates a new Quarto report project using one of the bundled report
#' templates.
#'
#' @param format Report format. One of `"html"` or `"pdf"`.
#'   Defaults to `"html"`.
#'
#' @param path Destination directory.
#'
#' * `NULL` (default): use the current working directory.
#' * Relative path: create a new folder inside the current working directory.
#' * Absolute path: create the project there.
#'
#' @return Invisibly returns the project path.
#'
#' @export
use_report <- function(format = NULL, path = NULL) {
  use_template(
    type = "report",
    format = format,
    path = path
  )
}


#' Create a new presentation project
#'
#' Creates a new Quarto presentation project.
#'
#' @param format Presentation format.
#' Currently only `"revealjs"` is available.
#'
#' @inheritParams use_report
#'
#' @return Invisibly returns the project path.
#'
#' @export
use_presentation <- function(format = NULL, path = NULL) {
  use_template(
    type = "presentation",
    format = format,
    path = path
  )
}
