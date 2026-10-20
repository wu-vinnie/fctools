// ============================================================
// Fullerton College (FC) Report — Typst Template
// Package:  fctools
// Template: report/pdf
//
// Quarto template partial (see `template-partials` in
// _quarto.yml). Replaces Quarto's default `article()` function
// with an FC-branded layout: logo + title block, blue headings,
// branded tables/quotes, callout boxes, and an OIE footer.
//
// Colors and fonts mirror _brand.yml, R/colors.R, and the HTML
// report's fullerton.css. Keep them in sync.
// ============================================================


// ---- Brand colors ----
#let fc-blue     = rgb("#0F406B")
#let fc-yellow   = rgb("#FFD600")
#let fc-sky      = rgb("#375E9E")
#let fc-gray     = rgb("#333333")
#let fc-bg-light = rgb("#F5F7FA")   // gray box, code
#let fc-stripe   = rgb("#F8F8F8")   // table stripes
#let fc-border   = rgb("#CCCCCC")


// ---- Callout boxes ----
// Used by template/fc-boxes.lua, which turns
// `::: {.blue-box}` / `.yellow-box` / `.gray-box` divs into
// calls to these functions. Boxes never split across pages.

#let fc-blue-box(body) = block(
  width: 100%, fill: fc-blue, inset: 14pt, radius: 8pt, breakable: false,
)[
  #set text(fill: white)
  #show strong: set text(fill: white)
  #show link: set text(fill: white)
  #show raw: set text(fill: white)
  #body
]

#let fc-yellow-box(body) = block(
  width: 100%, fill: fc-yellow, inset: 14pt, radius: 8pt, breakable: false,
)[
  #set text(fill: black)
  #show strong: set text(fill: black)
  #body
]

#let fc-gray-box(body) = block(
  width: 100%, fill: fc-bg-light, inset: 14pt, radius: 6pt, breakable: false,
  stroke: (left: 6pt + fc-blue),
)[#body]


// ---- Document layout ----

#let article(
  title: none,
  subtitle: none,
  authors: none,
  date: none,
  abstract: none,
  abstract-title: none,
  cols: 1,
  lang: "en",
  region: "US",
  font: ("Century Gothic",),
  fontsize: 11pt,
  logo: "../template/fc-oie.png",
  // Passed in by Quarto's default typst-show partial from
  // _brand.yml. Accepted for compatibility; the heading styles
  // below set these directly.
  title-size: none,
  subtitle-size: none,
  heading-family: none,
  heading-weight: none,
  heading-style: none,
  heading-color: none,
  heading-line-height: none,
  sectionnumbering: none,
  toc: false,
  toc_title: none,
  toc_depth: none,
  toc_indent: 1.5em,
  doc,
) = {

  // -- Page + footer (mirrors .fc-footer) --
  set page(
    footer: context {
      set text(size: 8.5pt, fill: fc-gray)
      line(length: 100%, stroke: 0.5pt + fc-border)
      v(-4pt)
      grid(
        columns: (1fr, auto),
        [*Office of Institutional Effectiveness* | Fullerton College],
        counter(page).display(),
      )
    },
  )

  // -- Body text --
  set par(justify: false, leading: 0.7em, spacing: 1.1em)
  set text(lang: lang, region: region, font: font, size: fontsize, fill: fc-gray)
  set heading(numbering: sectionnumbering)

  // -- Headings (mirror h1/h2/h3 in fullerton.css) --
  // `#` in the .qmd = level 1 (blue rule underneath),
  // `##` = level 2 (blue left bar), `###` = level 3 (italic sky).
  show heading: set text(fill: fc-blue, weight: "bold")
  show heading.where(level: 1): it => block(
    width: 100%, above: 1.6em, below: 0.9em, inset: (bottom: 5pt),
    stroke: (bottom: 2pt + fc-blue),
  )[#set text(size: 1.35em); #it.body]
  show heading.where(level: 2): it => block(
    above: 1.5em, below: 0.8em, inset: (left: 8pt, y: 2pt),
    stroke: (left: 5pt + fc-blue),
  )[#set text(size: 1.3em); #it.body]
  show heading.where(level: 3): it => block(
    above: 1.2em, below: 0.6em, inset: (left: 8pt, y: 1pt),
    stroke: (left: 3pt + fc-sky),
  )[#set text(size: 1.1em, fill: fc-sky, style: "italic"); #it.body]

  // -- Links + emphasis --
  show link: set text(fill: fc-blue)
  show strong: set text(fill: fc-blue)

  // -- Tables (mirror th/td/tr in fullerton.css) --
  set table(
    inset: 7pt,
    stroke: 0.5pt + fc-border,
    fill: (_, y) => if y == 0 { fc-blue } else if calc.even(y) { fc-stripe },
  )
  show table.cell.where(y: 0): set text(fill: white, weight: "bold")

  // -- Block quotes --
  show quote.where(block: true): it => block(
    width: 100%, fill: rgb("#F9F9F9"), inset: (left: 14pt, rest: 10pt),
    stroke: (left: 5pt + fc-blue),
  )[#set text(style: "italic"); #it.body]

  // -- Inline code --
  show raw.where(block: false): it => box(
    fill: fc-bg-light, inset: (x: 3pt), outset: (y: 3pt), radius: 2pt,
  )[#set text(fill: fc-blue); #it]

  // -- Title block (mirrors #title-block + sidebar logo) --
  if title != none {
    align(center)[
      #if logo != none { image(logo, width: 2.2in) }
      #v(1.2em)
      #text(size: 2.2em, weight: "bold", fill: fc-blue)[#title]
      #if subtitle != none {
        v(0.2em)
        text(size: 1.4em, weight: "bold", fill: fc-gray)[#subtitle]
      }
      #if authors != none or date != none {
        v(0.6em)
        set text(size: 0.95em, fill: rgb("#666666"))
        if authors != none [
          Prepared by #authors.map(a => a.name).join(", ") \
        ]
        if date != none [#date]
      }
    ]
    v(1.5em)
  }

  if abstract != none {
    block(inset: 2em)[
      #text(weight: "semibold")[#abstract-title] #h(1em) #abstract
    ]
  }

  if toc {
    block(above: 0em, below: 2em)[
      #outline(
        title: if toc_title == none { auto } else { toc_title },
        depth: toc_depth,
        indent: toc_indent,
      )
    ]
  }

  if cols == 1 { doc } else { columns(cols, doc) }
}
