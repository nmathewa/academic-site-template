-- Number figures and tables ("Figure 1.", "Table 1.") and turn @fig:id / @tbl:id into links.
--   ![Caption](img/x.svg){#fig:x}     ... see @fig:x
--   Table: Caption {#tbl:y}           ... see @tbl:y
-- Runs before --citeproc, so these ids never reach the bibliography.

local labels = {}
local counts = { fig = 0, tbl = 0 }

local function prefix(caption, text)
  local lead = { pandoc.Strong(text), pandoc.Space() }
  if #caption.long == 0 then
    caption.long = { pandoc.Plain(lead) }
  else
    local first = caption.long[1]
    if first.t == "Plain" or first.t == "Para" then
      first.content = lead .. first.content
    end
  end
  return caption
end

local number = {
  Figure = function(el)
    counts.fig = counts.fig + 1
    local name = "Figure " .. counts.fig
    if el.identifier ~= "" then labels[el.identifier] = name end
    el.caption = prefix(el.caption, name .. ".")
    return el
  end,
  Table = function(el)
    counts.tbl = counts.tbl + 1
    local name = "Table " .. counts.tbl
    if el.identifier ~= "" then labels[el.identifier] = name end
    el.caption = prefix(el.caption, name .. ".")
    return el
  end,
}

local link = {
  Cite = function(el)
    local out = {}
    for i, c in ipairs(el.citations) do
      local name = labels[c.id]
      if not name then return nil end        -- a real citation: leave it for citeproc
      if i > 1 then table.insert(out, pandoc.Str(", ")) end
      table.insert(out, pandoc.Link(name, "#" .. c.id))
    end
    return out
  end,
}

return { number, link }
