local M = {}

M.config = {
  -- "muted" original | "lifted" everything brighter | "hybrid" lifted content, muted scaffolding
  palette = "hybrid",
  transparent = false,
  styles = {
    bold = true,
    italic = true,
    -- Light rose-pine flavor: slant parameters and module names only.
    italic_identifiers = false,
  },
  -- Callback for last-word overrides: receives (groups, palette),
  -- mutate groups in place.
  on_highlights = nil,
}

function M.setup(opts)
  M.config = vim.tbl_deep_extend("force", M.config, opts or {})
end

function M.load()
  if vim.g.colors_name then
    vim.cmd("hi clear")
  end
  vim.o.termguicolors = true
  vim.g.colors_name = "tidepool"

  local p = require("tidepool.palette").get(M.config.palette)
  local groups = require("tidepool.theme").get(p, M.config)

  if type(M.config.on_highlights) == "function" then
    M.config.on_highlights(groups, p)
  end

  for name, attrs in pairs(groups) do
    vim.api.nvim_set_hl(0, name, attrs)
  end

  -- Terminal palette: same hues as the buffer, so :terminal blends in.
  local term = {
    [0] = p.surface,
    [1] = p.love,
    [2] = p.olive,
    [3] = p.gold,
    [4] = p.mint,
    [5] = p.iris,
    [6] = p.foam,
    [7] = p.text,
    [8] = p.muted,
    [9] = p.love,
    [10] = p.olive,
    [11] = p.gold,
    [12] = p.parameter,
    [13] = p.member,
    [14] = p.foam,
    [15] = "#d6e5ef",
  }
  for i, color in pairs(term) do
    vim.g["terminal_color_" .. i] = color
  end
end

return M
