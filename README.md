# tidepool.nvim

A deep teal-navy Neovim theme built for eye comfort and hierarchy through
restraint. Scaffolding (keywords, operators, punctuation) recedes into quiet
slate. Verbs and data lead: lavender functions, gold types, sage strings,
pine constants. Bold is reserved for definitions.

## Design principles

- Dark but never pure black base (`#011627`): softer on halation and astigmatism.
- Body text sits near 8:1 contrast (above WCAG AAA's 7:1 for dark surfaces).
- Desaturated accents: saturated hues fail contrast on dark backgrounds.
- Few hues, used consistently, so color carries meaning instead of decoration.
- One warm accent (`EffectGen`) advances against the cool base for markers
  that must leap off the page.

## Install (lazy.nvim)

```lua
{
  "rashedInt32/tidepool.nvim",
  lazy = false,
  priority = 1000,
  opts = { transparent = true },
  config = function(_, opts)
    require("tidepool").setup(opts)
    vim.cmd.colorscheme("tidepool")
  end,
}
```

## Options

```lua
require("tidepool").setup({
  -- "muted" original | "lifted" everything brighter | "hybrid" (default) lifted content
  -- over muted scaffolding. See PALETTE-LIFT.md.
  palette = "hybrid",
  transparent = false,
  styles = { bold = true, italic = true, italic_identifiers = false },
  on_highlights = function(groups, palette)
    groups.Comment = { fg = palette.subtle, italic = true }
  end,
})
```

## Coverage

Editor UI, legacy syntax, full treesitter captures, LSP semantic tokens
(static links, no autocmd), diagnostics, diff/git, terminal palette, and:
blink.cmp, telescope, snacks, gitsigns, flash, which-key, noice, lazy,
mason, indent-blankline, trouble, oil, render-markdown.
