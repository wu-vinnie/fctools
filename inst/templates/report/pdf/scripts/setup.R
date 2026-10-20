# ============================================================
# Fullerton College (FC) Report — Setup
# Template: report/pdf (Typst)
# Package:  fctools
#
# Loaded via source("setup.R") from index.qmd's setup chunk.
# Anything that would otherwise clutter the top of the .qmd
# (package loads, theme/font registration, options) goes here.
# ============================================================

library(fctools)
library(tidyverse)

# Register Century Gothic with the graphics device so ggplot2
# charts (rendered as PNGs) use FC's brand font.
use_fc_fonts()

# Make theme_fc() the default ggplot2 theme for this report.
use_fc_theme()

# Uncomment if this report uses flextable for publication-quality
# tables (e.g. faculty reports, MIS/state reporting summaries).
# use_fc_flextable()
