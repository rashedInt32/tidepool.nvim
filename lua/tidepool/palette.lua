-- Tidepool palette — a deep teal-navy ocean at night.
-- Design rules (from research + owner's taste):
--   * Base is dark but never pure black: softens halation, easier on astigmatism.
--   * Body text targets ~7:1 contrast (WCAG AAA for dark surfaces).
--   * Accents are desaturated; saturated hues fail contrast on dark bases.
--   * Few hues, used consistently: scaffolding recedes, verbs and data lead.
--
-- Three accent rows, selectable via setup({ palette = "muted" | "lifted" | "hybrid" }):
--   muted  — original muted row.
--   lifted — everything lifted ~4-6% lightness, hues preserved.
--   hybrid — (default) lifted content over muted scaffolding: keywords/operators/
--        punctuation stay quiet so `const`/`return`/`yield*` never catch
--        the eye while scanning. See PALETTE-LIFT.md for the comparison.
local M = {}

-- Identical in every variant.
local shared = {
  -- backgrounds
  base = "#011627",
  surface = "#0b2233", -- floats, statusline, sidebars
  overlay = "#102a3f", -- pmenu, selection surfaces
  cursorline = "#061e33",
  visual = "#2d5a7e",
  border = "#1d3b52",

  muted = "#48708c", -- line numbers, whitespace, folds (always quiet)
  mint = "#7aa2f7", -- links, directories
  type_slot = "#a9adb2", -- names in type slots (generic args, annotations): neutral gray

  -- diff backgrounds (low-lightness tints, never fight the text)
  diff_add_bg = "#0e2f29",
  diff_change_bg = "#14283e",
  diff_text_bg = "#274a6b",
  diff_delete_bg = "#2e1f2d",
}

local muted = {
  text = "#9bb5c7",
  subtle = "#7f9db2",
  comment = "#7a9a9a",

  foam = "#5fb3d9", -- builtins, info, active line number, tag attrs
  gold = "#e0af68", -- type declarations, regex, warn
  gold_soft = "#c9a96e", -- type references; keeps schema-heavy files calm
  iris = "#cbb4ff", -- functions
  iris_bright = "#c8b6ff", -- function definitions
  pine = "#6fb1a0", -- numbers, constants, imports, escapes
  olive = "#8fbf7f", -- strings, hint, git add
  sql = "#b5d98c",
  love = "#e06c75", -- errors, git delete
  rose = "#c678dd", -- tags

  keyword = "#3e80a8",
  keyword_module = "#7292c9", -- import/export
  operator = "#56738a",
  punctuation = "#6f94a6",
  module = "#a890c4",

  parameter = "#8bb4ff",
  member = "#b794f6",

  effect_gen = "#e09cb0", -- warm advances against the cool base
}

local lifted = {
  text = "#a4c0d2",
  subtle = "#88a8be",
  comment = "#86a8a8",

  foam = "#6cc0e5",
  gold = "#e9b873",
  gold_soft = "#d6b477",
  iris = "#d2bdff",
  iris_bright = "#d0c0ff",
  pine = "#7bc0ae",
  olive = "#9cce8b",
  sql = "#c0e396",
  love = "#e67680",
  rose = "#d083e8",

  keyword = "#4a92bd",
  keyword_module = "#7d9ede",
  operator = "#628099",
  punctuation = "#7aa2b5",
  module = "#b49cd1",

  parameter = "#96bdff",
  member = "#c1a2fa",

  effect_gen = "#eaa6ba",
}

-- lifted content, muted scaffolding. export keeps lifted (module boundary stays visible).
local hybrid = vim.tbl_extend("force", {}, lifted, {
  keyword = muted.keyword,
  operator = muted.operator,
  punctuation = muted.punctuation,
  -- Pine colors every readonly const and Effect API call, so it is one of the
  -- most frequent hues; the lifted shade made it pop.
  pine = "#66a394",
})

local variants = { muted = muted, lifted = lifted, hybrid = hybrid }

---@param name? "muted"|"lifted"|"hybrid"
function M.get(name)
  local accents = variants[name]
  if not accents then
    if name ~= nil then
      vim.notify(
        ("tidepool: unknown palette %q, using \"hybrid\" (muted | lifted | hybrid)"):format(tostring(name)),
        vim.log.levels.WARN
      )
    end
    accents = hybrid
  end
  return vim.tbl_extend("force", {}, shared, accents)
end

return M
