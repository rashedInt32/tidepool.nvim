-- Regenerate README palette swatches from lua/tidepool/palette.lua.
--
--   nvim --headless -l scripts/palette.lua
--
-- Writes one SVG per color to assets/palette/ and rewrites the README block
-- between <!-- palette:start --> and <!-- palette:end -->. GitHub does not
-- render hex color chips in README files, so the swatches are images.

package.path = "./lua/?.lua;./lua/?/init.lua;" .. package.path
local p = require("tidepool.palette").get("hybrid")

-- { key, role } per group, in display order.
local groups = {
  {
    title = "Backgrounds and UI",
    colors = {
      { "base", "Editor background" },
      { "surface", "Floating windows, popup menu, statusline, tabline" },
      { "overlay", "Selected menu item, matching paren, quickfix line" },
      { "cursorline", "Cursor line, color column, folds" },
      { "visual", "Visual selection" },
      { "border", "Float borders, window separators, indent guides" },
      { "text", "Body text" },
      { "subtle", "Secondary UI text, statusline" },
      { "muted", "Line numbers, whitespace, fold column" },
      { "comment", "Comments" },
    },
  },
  {
    title = "Syntax",
    colors = {
      { "keyword", "Keywords, kept quiet" },
      { "keyword_module", "import and export" },
      { "operator", "Operators" },
      { "punctuation", "Brackets and delimiters" },
      { "iris", "Functions and method calls" },
      { "iris_bright", "Function definitions" },
      { "gold", "Type declarations, warnings, git changes" },
      { "gold_soft", "Type references, builtin types, constructors" },
      { "type_slot", "Names in TypeScript type slots" },
      { "olive", "Strings, hints, git additions" },
      { "pine", "Constants, numbers, booleans, readonly values" },
      { "foam", "Builtins, titles, info, active line number" },
      { "member", "Properties and fields" },
      { "parameter", "Parameters" },
      { "module", "Modules and namespaces" },
      { "rose", "Markup tags" },
      { "sql", "SQL keywords" },
      { "mint", "Links and directories" },
    },
  },
  {
    title = "Signals and diff",
    colors = {
      { "love", "Errors, git deletions" },
      { "effect_gen", "Effect.gen marker" },
      { "diff_add_bg", "Diff added line" },
      { "diff_change_bg", "Diff changed line" },
      { "diff_text_bg", "Diff changed text" },
      { "diff_delete_bg", "Diff deleted line" },
    },
  },
}

local function write(path, content)
  local f = assert(io.open(path, "w"))
  f:write(content)
  f:close()
end

-- A thin neutral stroke keeps the darkest swatches visible on GitHub dark mode.
local svg = [[<svg xmlns="http://www.w3.org/2000/svg" width="48" height="20" viewBox="0 0 48 20">]]
  .. [[<rect x="0.5" y="0.5" width="47" height="19" rx="4" fill="%s" stroke="#8b949e" stroke-opacity="0.4"/>]]
  .. "</svg>\n"

vim.fn.mkdir("assets/palette", "p")
for _, file in ipairs(vim.fn.glob("assets/palette/*.svg", false, true)) do
  os.remove(file)
end

local lines = {
  "Swatches show the default `hybrid` palette. Values for `muted` and `lifted`",
  "are in [PALETTE-LIFT.md](PALETTE-LIFT.md).",
}
for _, group in ipairs(groups) do
  vim.list_extend(lines, { "", "### " .. group.title, "", "| | Name | Hex | Used for |", "| --- | --- | --- | --- |" })
  for _, entry in ipairs(group.colors) do
    local key, role = entry[1], entry[2]
    local hex = assert(p[key], "palette has no color named " .. key)
    write(("assets/palette/%s.svg"):format(key), svg:format(hex))
    lines[#lines + 1] = ('| <img src="assets/palette/%s.svg" width="48" height="20" alt="%s" /> | `%s` | `%s` | %s |'):format(
      key, hex, key, hex, role
    )
  end
end

local readme = table.concat(vim.fn.readfile("README.md"), "\n") .. "\n"
local start, stop = "<!-- palette:start -->", "<!-- palette:end -->"
local s, e = readme:find(start, 1, true), readme:find(stop, 1, true)
assert(s and e and s < e, "README.md is missing the palette markers")
readme = readme:sub(1, s - 1) .. start .. "\n" .. table.concat(lines, "\n") .. "\n" .. readme:sub(e)
write("README.md", readme)

local count = 0
for _, g in ipairs(groups) do count = count + #g.colors end
print(("wrote %d swatches and the README palette block"):format(count))
