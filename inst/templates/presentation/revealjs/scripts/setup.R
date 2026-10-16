# ============================================================
# Fullerton College (FC) Report — Setup
# Template: report (shared across html + pdf formats)
# Package:  fctools
#
# Loaded via source("setup.R") from index.qmd's setup chunk.
# Anything that would otherwise clutter the top of the .qmd
# (package loads, theme/font registration, options) goes here.
# ============================================================

library(tidyverse)
library(plotly)
library(fctools)
library(extrafont)

loadfonts(device = "win")

use_fc_theme()

# PDF rendering needs fonts embedded in the graphics device.
# HTML rendering gets Century Gothic from fullerton.css instead, so
# this only actually matters when this report is rendered to PDF —
# but it's harmless to run unconditionally for either format.
use_fc_fonts()

# Uncomment if this report uses flextable for publication-quality
# tables (e.g. faculty reports, MIS/state reporting summaries).
# use_fc_flextable()
