local function stringify(inlines)
  local result = {}
  for _, inline in ipairs(inlines) do
    if inline.t == "Str" then
      table.insert(result, inline.text)
    elseif inline.t == "Space" then
      table.insert(result, " ")
    elseif inline.t == "Strong" then
      table.insert(result, stringify(inline.content))
    end
  end
  return table.concat(result)
end

local function cell_to_latex(cell, bold)
  local text = stringify(cell.contents[1].content or cell.contents[1].c or {})
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

  if el.classes:includes("languages") then
    for _, block in ipairs(el.content) do
      if block.t == "Table" then
        local ncols = #block.colspecs
        local width = string.format("%.2f", 0.9 / ncols)
        local cols = string.rep("p{" .. width .. "\\textwidth}", ncols)
        local lines = {"\\begin{tabular}{" .. cols .. "}"}

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

        table.insert(lines, "\\end{tabular}")
        return pandoc.RawBlock("latex", table.concat(lines, "\n"))
      end
    end
  end
end
