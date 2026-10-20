-- ============================================================
-- Fullerton College (FC) Report — Callout Box Filter
-- Package:  fctools
-- Template: report/pdf
--
-- Turns `::: {.blue-box}`, `::: {.yellow-box}`, and
-- `::: {.gray-box}` divs into the matching Typst functions
-- defined in template/typst-template.typ, so the same markup
-- works in the HTML report, the slides, and this PDF.
-- ============================================================

local boxes = {
  ["blue-box"]   = "fc-blue-box",
  ["yellow-box"] = "fc-yellow-box",
  ["gray-box"]   = "fc-gray-box",
}

function Div(el)
  if not quarto.doc.is_format("typst") then
    return nil
  end

  for class, fn in pairs(boxes) do
    if el.classes:includes(class) then
      local blocks = pandoc.List({ pandoc.RawBlock("typst", "#" .. fn .. "[") })
      blocks:extend(el.content)
      blocks:insert(pandoc.RawBlock("typst", "]"))
      return blocks
    end
  end
end
