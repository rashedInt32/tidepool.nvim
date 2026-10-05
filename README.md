# tidepool.nvim

A deep teal-navy Neovim theme built for eye comfort and hierarchy through
restraint. Scaffolding (keywords, operators, punctuation) recedes into quiet
slate. Verbs and data lead: lavender functions, gold types, sage strings,
pine constants. Bold is reserved for definitions.

## Screenshots

![TypeScript](assets/screenshots/typescript.png)

<table>
  <tr>
    <th>TSX / React</th>
    <th>Rust</th>
  </tr>
  <tr>
    <td><img src="assets/screenshots/tsx.png" alt="TSX / React" /></td>
    <td><img src="assets/screenshots/rust.png" alt="Rust" /></td>
  </tr>
</table>

## Design principles

- Dark but never pure black base (`#011627`): softer on halation and astigmatism.
- Body text sits near 8:1 contrast (above WCAG AAA's 7:1 for dark surfaces).
- Desaturated accents: saturated hues fail contrast on dark backgrounds.
- Few hues, used consistently, so color carries meaning instead of decoration.
- One warm accent (`EffectGen`) advances against the cool base for markers
  that must leap off the page.

## Palette

<!-- palette:start -->
Swatches show the default `hybrid` palette. Values for `muted` and `lifted`
are in [PALETTE-LIFT.md](PALETTE-LIFT.md).

### Backgrounds and UI

| | Name | Hex | Used for |
| --- | --- | --- | --- |
| <img src="assets/palette/base.svg" width="48" height="20" alt="#011627" /> | `base` | `#011627` | Editor background |
| <img src="assets/palette/surface.svg" width="48" height="20" alt="#0b2233" /> | `surface` | `#0b2233` | Floating windows, popup menu, statusline, tabline |
| <img src="assets/palette/overlay.svg" width="48" height="20" alt="#102a3f" /> | `overlay` | `#102a3f` | Selected menu item, matching paren, quickfix line |
| <img src="assets/palette/cursorline.svg" width="48" height="20" alt="#061e33" /> | `cursorline` | `#061e33` | Cursor line, color column, folds |
| <img src="assets/palette/visual.svg" width="48" height="20" alt="#2d5a7e" /> | `visual` | `#2d5a7e` | Visual selection |
| <img src="assets/palette/border.svg" width="48" height="20" alt="#1d3b52" /> | `border` | `#1d3b52` | Float borders, window separators, indent guides |
| <img src="assets/palette/text.svg" width="48" height="20" alt="#a4c0d2" /> | `text` | `#a4c0d2` | Body text |
| <img src="assets/palette/subtle.svg" width="48" height="20" alt="#88a8be" /> | `subtle` | `#88a8be` | Secondary UI text, statusline |
| <img src="assets/palette/muted.svg" width="48" height="20" alt="#48708c" /> | `muted` | `#48708c` | Line numbers, whitespace, fold column |
| <img src="assets/palette/comment.svg" width="48" height="20" alt="#86a8a8" /> | `comment` | `#86a8a8` | Comments |

### Syntax

| | Name | Hex | Used for |
| --- | --- | --- | --- |
| <img src="assets/palette/keyword.svg" width="48" height="20" alt="#3e80a8" /> | `keyword` | `#3e80a8` | Keywords, kept quiet |
| <img src="assets/palette/keyword_module.svg" width="48" height="20" alt="#7d9ede" /> | `keyword_module` | `#7d9ede` | import and export |
| <img src="assets/palette/operator.svg" width="48" height="20" alt="#56738a" /> | `operator` | `#56738a` | Operators |
| <img src="assets/palette/punctuation.svg" width="48" height="20" alt="#6f94a6" /> | `punctuation` | `#6f94a6` | Brackets and delimiters |
| <img src="assets/palette/iris.svg" width="48" height="20" alt="#d2bdff" /> | `iris` | `#d2bdff` | Functions and method calls |
| <img src="assets/palette/iris_bright.svg" width="48" height="20" alt="#d0c0ff" /> | `iris_bright` | `#d0c0ff` | Function definitions |
| <img src="assets/palette/gold.svg" width="48" height="20" alt="#e9b873" /> | `gold` | `#e9b873` | Type declarations, warnings, git changes |
| <img src="assets/palette/gold_soft.svg" width="48" height="20" alt="#d6b477" /> | `gold_soft` | `#d6b477` | Type references, builtin types, constructors |
| <img src="assets/palette/type_slot.svg" width="48" height="20" alt="#a9adb2" /> | `type_slot` | `#a9adb2` | Names in TypeScript type slots |
| <img src="assets/palette/olive.svg" width="48" height="20" alt="#9cce8b" /> | `olive` | `#9cce8b` | Strings, hints, git additions |
| <img src="assets/palette/pine.svg" width="48" height="20" alt="#66a394" /> | `pine` | `#66a394` | Constants, numbers, booleans, readonly values |
| <img src="assets/palette/foam.svg" width="48" height="20" alt="#6cc0e5" /> | `foam` | `#6cc0e5` | Builtins, titles, info, active line number |
| <img src="assets/palette/member.svg" width="48" height="20" alt="#c1a2fa" /> | `member` | `#c1a2fa` | Properties and fields |
| <img src="assets/palette/parameter.svg" width="48" height="20" alt="#96bdff" /> | `parameter` | `#96bdff` | Parameters |
| <img src="assets/palette/module.svg" width="48" height="20" alt="#b49cd1" /> | `module` | `#b49cd1` | Modules and namespaces |
| <img src="assets/palette/rose.svg" width="48" height="20" alt="#d083e8" /> | `rose` | `#d083e8` | Markup tags |
| <img src="assets/palette/sql.svg" width="48" height="20" alt="#c0e396" /> | `sql` | `#c0e396` | SQL keywords |
| <img src="assets/palette/mint.svg" width="48" height="20" alt="#7aa2f7" /> | `mint` | `#7aa2f7` | Links and directories |

### Signals and diff

| | Name | Hex | Used for |
| --- | --- | --- | --- |
| <img src="assets/palette/love.svg" width="48" height="20" alt="#e67680" /> | `love` | `#e67680` | Errors, git deletions |
| <img src="assets/palette/effect_gen.svg" width="48" height="20" alt="#eaa6ba" /> | `effect_gen` | `#eaa6ba` | Effect.gen marker |
| <img src="assets/palette/diff_add_bg.svg" width="48" height="20" alt="#0e2f29" /> | `diff_add_bg` | `#0e2f29` | Diff added line |
| <img src="assets/palette/diff_change_bg.svg" width="48" height="20" alt="#14283e" /> | `diff_change_bg` | `#14283e` | Diff changed line |
| <img src="assets/palette/diff_text_bg.svg" width="48" height="20" alt="#274a6b" /> | `diff_text_bg` | `#274a6b` | Diff changed text |
| <img src="assets/palette/diff_delete_bg.svg" width="48" height="20" alt="#2e1f2d" /> | `diff_delete_bg` | `#2e1f2d` | Diff deleted line |
<!-- palette:end -->

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
mason, indent-blankline, trouble, oil, render-markdown, todo-comments.

TypeScript and TSX ship an extra query that paints `Effect.gen(...)` calls
with the warm `EffectGen` accent. TODO/FIXME badges in comments need the
`comment` treesitter parser (`:TSInstall comment`).

## Examples

The [`examples/`](examples/) folder has demo files in 18 languages for
previewing the theme. Open any of them after loading the colorscheme:

```sh
nvim -c 'colorscheme tidepool' examples/typescript.ts
```

## License

MIT. See [LICENSE](LICENSE).
