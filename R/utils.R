# ==============================================================================
# Internal template utilities
# ==============================================================================

# Copy the contents of a template directory into a destination directory.
copy_template <- function(template, destination) {
  if (template == "") {
    stop("Template not found.", call. = FALSE)
  }

  # Create destination if needed
  if (!fs::dir_exists(destination)) {
    fs::dir_create(destination, recurse = TRUE)
  }

  # Don't overwrite an existing project
  if (length(list.files(destination, all.files = TRUE, no.. = TRUE)) > 0) {
    stop(
      "Destination directory is not empty:\n",
      normalizePath(destination),
      call. = FALSE
    )
  }

  files <- fs::dir_ls(
    template,
    all = TRUE,
    recurse = FALSE
  )

  for (file in files) {
    target <- file.path(
      destination,
      basename(file)
    )

    if (fs::is_dir(file)) {
      fs::dir_copy(
        path = file,
        new_path = target
      )
    } else {
      fs::file_copy(
        path = file,
        new_path = target,
        overwrite = FALSE
      )
    }
  }

  invisible(destination)
}


# Create a project from a bundled template.
use_template <- function(type, format = NULL, path = NULL) {
  allowed_templates <- list(
    report = c("html", "pdf"),
    presentation = c("revealjs")
  )

  # ---------------------------------------------------------------------------
  # Validate template type
  # ---------------------------------------------------------------------------

  if (!type %in% names(allowed_templates)) {
    stop(
      "`type` must be one of: ",
      paste(names(allowed_templates), collapse = ", "),
      call. = FALSE
    )
  }

  # ---------------------------------------------------------------------------
  # Choose default format
  # ---------------------------------------------------------------------------

  if (is.null(format)) {
    format <- allowed_templates[[type]][1]
  }

  # ---------------------------------------------------------------------------
  # Validate format
  # ---------------------------------------------------------------------------

  if (!format %in% allowed_templates[[type]]) {
    stop(
      "`format` must be one of: ",
      paste(allowed_templates[[type]], collapse = ", "),
      call. = FALSE
    )
  }

  # ---------------------------------------------------------------------------
  # Locate template
  # ---------------------------------------------------------------------------

  template <- system.file(
    "templates",
    type,
    format,
    package = "fctools"
  )

  if (template == "") {
    stop(
      "Template not found:\n",
      file.path(type, format),
      call. = FALSE
    )
  }

  # ---------------------------------------------------------------------------
  # Destination
  # ---------------------------------------------------------------------------

  destination <-
    if (is.null(path)) {
      getwd()
    } else if (fs::is_absolute_path(path)) {
      path
    } else {
      file.path(getwd(), path)
    }

  # ---------------------------------------------------------------------------
  # Copy
  # ---------------------------------------------------------------------------

  copy_template(
    template,
    destination
  )

  message(
    "Created ",
    type,
    " (",
    format,
    ") project."
  )

  invisible(destination)
}
