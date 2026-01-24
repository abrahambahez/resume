local function cell_to_latex(cell, bold)
  local text = pandoc.utils.stringify(cell.contents[1])
  if bold then
    return "\\textbf{" .. text .. "}"
  end
  return text
end

function Span(el)
  if el.classes:includes("grey") then
    return {
      pandoc.RawInline("latex", "\\textcolor{black!70}{"),
      el,
      pandoc.RawInline("latex", "}")
    }
  end
end

function Div(el)
  if el.classes:includes("center") then
    return {
      pandoc.RawBlock("latex", "\\begin{center}"),
      el,
      pandoc.RawBlock("latex", "\\end{center}")
    }
  end

  if el.classes:includes("languages") or el.classes:includes("ponencias") then
    for _, block in ipairs(el.content) do
      if block.t == "Table" then
        local cols
        if el.classes:includes("ponencias") then
          cols = "p{0.08\\textwidth}p{0.85\\textwidth}"
        else
          local ncols = #block.colspecs
          local width = string.format("%.2f", 0.9 / ncols)
          cols = string.rep("p{" .. width .. "\\textwidth}", ncols)
        end
        local lines = {"{\\renewcommand{\\arraystretch}{1.5}", "\\begin{tabular}{" .. cols .. "}"}

        if block.head and block.head.rows and #block.head.rows > 0 then
          local header_cells = {}
          for _, cell in ipairs(block.head.rows[1].cells) do
            table.insert(header_cells, cell_to_latex(cell, true))
          end
          table.insert(lines, table.concat(header_cells, " & ") .. " \\\\")
        end

        for _, body in ipairs(block.bodies) do
          for _, row in ipairs(body.body) do
            local row_cells = {}
            for _, cell in ipairs(row.cells) do
              table.insert(row_cells, cell_to_latex(cell, false))
            end
            table.insert(lines, table.concat(row_cells, " & ") .. " \\\\")
          end
        end

        table.insert(lines, "\\end{tabular}}")
        return pandoc.RawBlock("latex", table.concat(lines, "\n"))
      end
    end
  end
end
