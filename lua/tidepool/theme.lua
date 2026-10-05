local M = {}

---@param p table palette
---@param cfg table resolved config
function M.get(p, cfg)
  local bold = cfg.styles.bold
  local italic = cfg.styles.italic
  local italic_ids = italic and cfg.styles.italic_identifiers
  local bg = cfg.transparent and "NONE" or p.base
  local float_bg = cfg.transparent and "NONE" or p.surface

  local groups = {
    ----------------------------------------------------------------
    -- EDITOR UI
    ----------------------------------------------------------------
    Normal = { fg = p.text, bg = bg },
    NormalNC = { fg = p.text, bg = bg },
    NormalFloat = { fg = p.text, bg = float_bg },
    FloatBorder = { fg = p.border, bg = float_bg },
    FloatTitle = { fg = p.foam, bg = float_bg, bold = bold },
    WinSeparator = { fg = p.border },
    EndOfBuffer = { fg = p.base },
    SignColumn = { bg = "NONE" },
    ColorColumn = { bg = p.cursorline },
    Conceal = { fg = p.muted },

    Cursor = { fg = p.base, bg = p.text },
    CursorLine = { bg = p.cursorline },
    CursorColumn = { bg = p.cursorline },
    CursorLineNr = { fg = p.foam, bold = bold },
    LineNr = { fg = p.muted },

    Visual = { bg = p.visual },
    VisualNOS = { bg = p.visual },

    Search = { fg = p.base, bg = p.gold },
    IncSearch = { fg = p.base, bg = p.love },
    CurSearch = { fg = p.base, bg = p.love },
    Substitute = { fg = p.base, bg = p.love },
    MatchParen = { fg = p.foam, bg = p.overlay, bold = bold },

    Pmenu = { fg = p.subtle, bg = p.surface },
    PmenuSel = { fg = p.text, bg = p.overlay, bold = bold },
    PmenuSbar = { bg = p.overlay },
    PmenuThumb = { bg = p.muted },
    WildMenu = { fg = p.text, bg = p.overlay },

    StatusLine = { fg = p.subtle, bg = float_bg },
    StatusLineNC = { fg = p.muted, bg = float_bg },
    TabLine = { fg = p.subtle, bg = p.surface },
    TabLineFill = { bg = p.surface },
    TabLineSel = { fg = p.text, bg = p.overlay, bold = bold },
    WinBar = { fg = p.subtle, bg = "NONE" },
    WinBarNC = { fg = p.muted, bg = "NONE" },

    Folded = { fg = p.subtle, bg = p.cursorline },
    FoldColumn = { fg = p.muted },

    NonText = { fg = p.muted },
    Whitespace = { fg = p.muted },
    SpecialKey = { fg = p.foam },
    Directory = { fg = p.mint },
    Title = { fg = p.foam, bold = bold },
    QuickFixLine = { bg = p.overlay },

    ErrorMsg = { fg = p.love, bold = bold },
    WarningMsg = { fg = p.gold, bold = bold },
    MoreMsg = { fg = p.olive },
    Question = { fg = p.foam },
    ModeMsg = { fg = p.subtle },
    MsgArea = { fg = p.text },

    SpellBad = { sp = p.love, undercurl = true },
    SpellCap = { sp = p.gold, undercurl = true },
    SpellLocal = { sp = p.foam, undercurl = true },
    SpellRare = { sp = p.iris, undercurl = true },

    ----------------------------------------------------------------
    -- DIFF / GIT
    ----------------------------------------------------------------
    DiffAdd = { bg = p.diff_add_bg },
    DiffChange = { bg = p.diff_change_bg },
    DiffText = { bg = p.diff_text_bg },
    DiffDelete = { fg = p.love, bg = p.diff_delete_bg },
    Added = { fg = p.olive },
    Changed = { fg = p.gold },
    Removed = { fg = p.love },
    diffAdded = { link = "Added" },
    diffChanged = { link = "Changed" },
    diffRemoved = { link = "Removed" },

    GitSignsAdd = { fg = p.olive },
    GitSignsChange = { fg = p.gold },
    GitSignsDelete = { fg = p.love },
    GitSignsCurrentLineBlame = { fg = p.muted, italic = italic },

    ----------------------------------------------------------------
    -- LEGACY SYNTAX (fallback for non-treesitter buffers)
    ----------------------------------------------------------------
    Comment = { fg = p.comment, italic = italic },
    Constant = { fg = p.pine },
    String = { fg = p.olive },
    Character = { fg = p.olive },
    Number = { fg = p.pine },
    Boolean = { fg = p.pine },
    Float = { fg = p.pine },
    Identifier = { fg = p.text },
    Function = { fg = p.iris },
    Statement = { fg = p.keyword },
    Conditional = { fg = p.keyword },
    Repeat = { fg = p.keyword },
    Label = { fg = p.keyword },
    Operator = { fg = p.operator },
    Keyword = { fg = p.keyword },
    Exception = { fg = p.keyword },
    PreProc = { fg = p.pine },
    Include = { fg = p.pine },
    Define = { fg = p.pine },
    Macro = { fg = p.pine },
    Type = { fg = p.gold },
    StorageClass = { fg = p.keyword },
    Structure = { fg = p.gold },
    Typedef = { fg = p.gold },
    Special = { fg = p.foam },
    SpecialChar = { fg = p.pine },
    Tag = { fg = p.rose },
    Delimiter = { fg = p.punctuation },
    SpecialComment = { fg = p.comment, italic = italic },
    Debug = { fg = p.love },
    Underlined = { underline = true },
    Error = { fg = p.love, bold = bold },
    Todo = { fg = p.base, bg = p.gold, bold = bold },

    ----------------------------------------------------------------
    -- TREESITTER: STRUCTURAL SCAFFOLDING — quiet slate.
    -- Keywords/operators/punctuation recede so verbs and data lead.
    ----------------------------------------------------------------
    ["@keyword"] = { fg = p.keyword },
    ["@keyword.function"] = { fg = p.keyword },
    ["@keyword.type"] = { fg = p.keyword },
    ["@keyword.modifier"] = { fg = p.keyword },
    ["@keyword.conditional"] = { fg = p.keyword },
    ["@keyword.repeat"] = { fg = p.keyword },
    -- Muted mint-blue, not pine (pine belongs to readonly consts) and
    -- not slate (module boundary deserves a whisper of distinction).
    ["@keyword.import"] = { fg = p.keyword_module },
    ["@keyword.export"] = { fg = p.keyword_module },
    ["@keyword.return"] = { fg = p.keyword },
    ["@keyword.operator"] = { fg = p.keyword },
    ["@keyword.coroutine"] = { fg = p.keyword },
    ["@keyword.exception"] = { fg = p.keyword },
    ["@keyword.directive"] = { fg = p.pine },
    ["@keyword.debug"] = { fg = p.love },
    ["@keyword.sql"] = { fg = p.sql, bold = bold },

    ["@operator"] = { fg = p.operator },
    ["@punctuation.bracket"] = { fg = p.punctuation },
    ["@punctuation.delimiter"] = { fg = p.punctuation },
    ["@punctuation.special"] = { fg = p.foam },

    ----------------------------------------------------------------
    -- TREESITTER: DEFINITIONS — most prominent. Bold only here.
    ----------------------------------------------------------------
    ["@function"] = { fg = p.iris },
    ["@function.call"] = { fg = p.iris },
    ["@function.method"] = { fg = p.iris },
    ["@function.method.call"] = { fg = p.iris },
    ["@function.builtin"] = { fg = p.iris },
    ["@function.macro"] = { fg = p.iris },
    ["@function.definition"] = { fg = p.iris_bright, bold = bold },
    ["@constructor"] = { fg = p.gold_soft },

    -- References soft, declarations bright and bold: gold stays the type
    -- color without flooding schema-heavy files.
    ["@type"] = { fg = p.gold_soft },
    ["@type.builtin"] = { fg = p.gold_soft },
    ["@type.definition"] = { fg = p.gold, bold = bold },
    -- Names in type slots (generic args, annotations, unions). Captured by
    -- queries/typescript/highlights.scm above semantic-token priority, so a
    -- class used as a type reads neutral gray while the same class as a value
    -- (Schema.String) stays pine. Neutral, not gold: Effect.Effect<A, E>
    -- turned into one wall of gold.
    ["@type.reference"] = { fg = p.type_slot },

    -- Namespaces are containers, not types — calmer mauve.
    ["@module"] = { fg = p.module, italic = italic_ids },
    ["@module.builtin"] = { fg = p.module, italic = italic_ids },
    ["@label"] = { fg = p.foam },
    ["@attribute"] = { fg = p.pine },

    ----------------------------------------------------------------
    -- TREESITTER: DATA / VALUES
    ----------------------------------------------------------------
    ["@string"] = { fg = p.olive },
    ["@string.regexp"] = { fg = p.gold },
    ["@string.escape"] = { fg = p.pine },
    ["@string.special"] = { fg = p.pine },
    ["@string.special.url"] = { fg = p.mint, underline = true },
    ["@string.documentation"] = { fg = p.olive, italic = italic },
    ["@character"] = { fg = p.olive },
    ["@character.special"] = { fg = p.pine },

    ["@number"] = { fg = p.pine },
    ["@number.float"] = { fg = p.pine },
    ["@boolean"] = { fg = p.pine },
    ["@constant"] = { fg = p.pine },
    ["@constant.builtin"] = { fg = p.pine },
    ["@constant.macro"] = { fg = p.pine },

    ----------------------------------------------------------------
    -- TREESITTER: IDENTIFIERS
    ----------------------------------------------------------------
    ["@variable"] = { fg = p.text },
    ["@variable.builtin"] = { fg = p.foam, bold = bold },
    ["@variable.parameter"] = { fg = p.parameter, italic = italic_ids },
    ["@variable.member"] = { fg = p.member },
    ["@property"] = { fg = p.member },

    ----------------------------------------------------------------
    -- TREESITTER: JSX / MARKUP TAGS
    ----------------------------------------------------------------
    ["@tag"] = { fg = p.rose },
    ["@tag.builtin"] = { fg = p.pine },
    ["@tag.attribute"] = { fg = p.foam },
    ["@tag.delimiter"] = { fg = p.punctuation },
    ["@_jsx_attribute"] = { fg = p.foam },

    ----------------------------------------------------------------
    -- TREESITTER: COMMENTS
    ----------------------------------------------------------------
    ["@comment"] = { fg = p.comment, italic = italic },
    ["@comment.documentation"] = { fg = p.comment, italic = italic },
    ["@comment.error"] = { fg = p.base, bg = p.love, bold = bold },
    ["@comment.warning"] = { fg = p.base, bg = p.gold, bold = bold },
    ["@comment.todo"] = { fg = p.base, bg = p.foam, bold = bold },
    ["@comment.note"] = { fg = p.base, bg = p.foam, bold = bold },

    ----------------------------------------------------------------
    -- TREESITTER: PROSE (markdown, help)
    ----------------------------------------------------------------
    ["@markup.heading"] = { fg = p.foam, bold = bold },
    ["@markup.heading.1"] = { fg = p.foam, bold = bold },
    ["@markup.heading.2"] = { fg = p.iris, bold = bold },
    ["@markup.heading.3"] = { fg = p.gold, bold = bold },
    ["@markup.heading.4"] = { fg = p.pine, bold = bold },
    ["@markup.strong"] = { bold = true },
    ["@markup.italic"] = { italic = true },
    ["@markup.strikethrough"] = { strikethrough = true },
    ["@markup.link"] = { fg = p.mint },
    ["@markup.link.url"] = { fg = p.mint, underline = true },
    ["@markup.link.label"] = { fg = p.foam },
    ["@markup.raw"] = { fg = p.pine },
    ["@markup.quote"] = { fg = p.subtle, italic = italic },
    ["@markup.list"] = { fg = p.punctuation },
    ["@markup.list.checked"] = { fg = p.olive },
    ["@markup.list.unchecked"] = { fg = p.subtle },
    ["@diff.plus"] = { link = "Added" },
    ["@diff.minus"] = { link = "Removed" },
    ["@diff.delta"] = { link = "Changed" },

    ----------------------------------------------------------------
    -- LSP SEMANTIC TOKENS
    -- Static links; no LspAttach autocmd needed.
    ----------------------------------------------------------------
    ["@lsp.type.function"] = { link = "@function" },
    ["@lsp.typemod.function.declaration"] = { link = "@function.definition" },
    ["@lsp.typemod.function.definition"] = { link = "@function.definition" },
    ["@lsp.typemod.function.defaultLibrary"] = { link = "@function" },

    -- Methods: declarations bold, calls (incl. built-in containers) lavender.
    ["@lsp.type.method"] = { link = "@function.method.call" },
    ["@lsp.typemod.method.declaration"] = { link = "@function.definition" },
    ["@lsp.typemod.method.definition"] = { link = "@function.definition" },
    ["@lsp.typemod.method.defaultLibrary"] = { link = "@function.method.call" },

    ["@lsp.type.parameter"] = { link = "@variable.parameter" },
    ["@lsp.type.property"] = { link = "@property" },
    ["@lsp.type.variable"] = { link = "@variable" },

    -- Classes are runtime values that name a type: pine, like readonly
    -- consts. Matches SqlClient.SqlClient with Schema.String/Number.
    -- Pure types (interface, alias, typeParameter) stay gold below.
    ["@lsp.type.class"] = { link = "@constant" },
    ["@lsp.type.interface"] = { link = "@type" },
    ["@lsp.type.enum"] = { link = "@type" },
    ["@lsp.type.type"] = { link = "@type" },
    ["@lsp.type.typeParameter"] = { link = "@type" },
    -- Deliberately member-violet, NOT @type.definition: vtsls labels Effect
    -- schema object-literal keys (Schema.Class/Struct fields) as class
    -- declarations, so gold-bold here would paint every key gold.
    ["@lsp.typemod.class.declaration"] = { link = "@variable.member" },
    ["@lsp.typemod.class.definition"] = { link = "@variable.member" },
    ["@lsp.typemod.interface.declaration"] = { link = "@type.definition" },
    ["@lsp.typemod.interface.definition"] = { link = "@type.definition" },
    ["@lsp.typemod.enum.declaration"] = { link = "@type.definition" },
    ["@lsp.typemod.enum.definition"] = { link = "@type.definition" },
    ["@lsp.typemod.type.declaration"] = { link = "@type.definition" },
    ["@lsp.typemod.type.definition"] = { link = "@type.definition" },

    -- Namespaces are NOT types.
    ["@lsp.type.namespace"] = { link = "@module" },
    ["@lsp.type.enumMember"] = { link = "@constant" },
    ["@lsp.type.decorator"] = { link = "@function" },
    ["@lsp.type.macro"] = { link = "@constant.macro" },
    ["@lsp.type.keyword"] = { link = "@keyword" },
    -- TS marks every `const` readonly, so const names read as constants: pine.
    -- Owner's call: the green belongs to consts; import/export stay slate.
    -- Deliberately the bare modifier: it outranks @lsp.type.*, so readonly
    -- functions like Schema.TaggedError stay pine too (owner's preference).
    ["@lsp.mod.readonly"] = { link = "@constant" },

    ----------------------------------------------------------------
    -- DIAGNOSTICS
    ----------------------------------------------------------------
    DiagnosticError = { fg = p.love, bold = bold },
    DiagnosticWarn = { fg = p.gold, bold = bold },
    DiagnosticInfo = { fg = p.foam, bold = bold },
    DiagnosticHint = { fg = p.olive, bold = bold },
    DiagnosticOk = { fg = p.olive },
    DiagnosticUnderlineError = { sp = p.love, undercurl = true },
    DiagnosticUnderlineWarn = { sp = p.gold, undercurl = true },
    DiagnosticUnderlineInfo = { sp = p.foam, undercurl = true },
    DiagnosticUnderlineHint = { sp = p.olive, undercurl = true },
    DiagnosticVirtualTextError = { fg = p.love, italic = italic },
    DiagnosticVirtualTextWarn = { fg = p.gold, italic = italic },
    DiagnosticVirtualTextInfo = { fg = p.foam, italic = italic },
    DiagnosticVirtualTextHint = { fg = p.olive, italic = italic },
    DiagnosticUnnecessary = { fg = p.muted },
    DiagnosticDeprecated = { sp = p.muted, strikethrough = true },
    LspReferenceText = { bg = p.overlay },
    LspReferenceRead = { bg = p.overlay },
    LspReferenceWrite = { bg = p.overlay, bold = bold },
    LspInlayHint = { fg = p.muted, italic = italic },
    LspSignatureActiveParameter = { fg = p.foam, bold = bold },
    LspCodeLens = { fg = p.muted, italic = italic },

    ----------------------------------------------------------------
    -- PLUGINS
    ----------------------------------------------------------------
    -- blink.cmp (LazyVim default completion)
    BlinkCmpMenu = { link = "Pmenu" },
    BlinkCmpMenuBorder = { link = "FloatBorder" },
    BlinkCmpMenuSelection = { link = "PmenuSel" },
    BlinkCmpDoc = { link = "NormalFloat" },
    BlinkCmpDocBorder = { link = "FloatBorder" },
    BlinkCmpSignatureHelp = { link = "NormalFloat" },
    BlinkCmpSignatureHelpBorder = { link = "FloatBorder" },
    BlinkCmpLabel = { fg = p.subtle },
    BlinkCmpLabelMatch = { fg = p.foam, bold = bold },
    BlinkCmpLabelDeprecated = { fg = p.muted, strikethrough = true },
    BlinkCmpKind = { fg = p.iris },
    BlinkCmpKindFunction = { fg = p.iris },
    BlinkCmpKindMethod = { fg = p.iris },
    BlinkCmpKindVariable = { fg = p.text },
    BlinkCmpKindClass = { fg = p.gold },
    BlinkCmpKindInterface = { fg = p.gold },
    BlinkCmpKindKeyword = { fg = p.keyword },
    BlinkCmpKindConstant = { fg = p.pine },
    BlinkCmpKindProperty = { fg = p.member },
    BlinkCmpKindField = { fg = p.member },
    BlinkCmpKindSnippet = { fg = p.rose },
    BlinkCmpKindText = { fg = p.subtle },
    BlinkCmpGhostText = { fg = p.muted, italic = italic },

    -- Telescope / pickers
    TelescopeNormal = { fg = p.text, bg = float_bg },
    TelescopeBorder = { fg = p.border, bg = float_bg },
    TelescopeTitle = { fg = p.foam, bold = bold },
    TelescopePromptPrefix = { fg = p.foam },
    TelescopeSelection = { bg = p.overlay },
    TelescopeSelectionCaret = { fg = p.foam, bg = p.overlay },
    TelescopeMatching = { fg = p.gold, bold = bold },

    -- snacks.nvim
    SnacksPickerMatch = { fg = p.gold, bold = bold },
    SnacksPickerDir = { fg = p.muted },
    SnacksPickerBorder = { link = "FloatBorder" },
    SnacksIndent = { fg = p.border },
    SnacksIndentScope = { fg = p.keyword },
    SnacksNotifierBorderInfo = { link = "FloatBorder" },
    SnacksDashboardHeader = { fg = p.foam },
    SnacksDashboardDesc = { fg = p.subtle },
    SnacksDashboardIcon = { fg = p.iris },
    SnacksDashboardKey = { fg = p.gold },

    -- flash.nvim
    FlashLabel = { fg = p.base, bg = p.love, bold = bold },
    FlashMatch = { fg = p.foam, bg = p.overlay },
    FlashCurrent = { fg = p.gold, bg = p.overlay },
    FlashBackdrop = { fg = p.muted },

    -- which-key
    WhichKey = { fg = p.foam },
    WhichKeyGroup = { fg = p.iris },
    WhichKeyDesc = { fg = p.subtle },
    WhichKeySeparator = { fg = p.muted },

    -- noice
    NoiceCmdlineIcon = { fg = p.foam },
    NoiceCmdlinePopupBorder = { link = "FloatBorder" },
    NoiceMini = { fg = p.subtle, bg = float_bg },

    -- lazy.nvim / mason
    LazyH1 = { fg = p.base, bg = p.foam, bold = bold },
    LazyButton = { fg = p.subtle, bg = p.surface },
    LazyButtonActive = { fg = p.base, bg = p.foam, bold = bold },
    LazySpecial = { fg = p.foam },
    LazyProgressDone = { fg = p.foam },
    LazyProgressTodo = { fg = p.muted },

    -- indent-blankline
    IblIndent = { fg = p.border },
    IblScope = { fg = p.keyword },

    -- trouble
    TroubleNormal = { link = "NormalFloat" },
    TroubleText = { fg = p.subtle },
    TroubleCount = { fg = p.gold, bold = bold },

    -- oil / file browsers
    OilDir = { fg = p.mint },
    OilFile = { fg = p.text },

    -- render-markdown code blocks
    RenderMarkdownCode = { bg = p.cursorline },
    RenderMarkdownCodeInline = { fg = p.pine, bg = p.cursorline },

    -- No RainbowDelimiter* groups on purpose: the owner prefers the plugin's
    -- own built-in colors, which it defines with `default = true` and only
    -- applies when the theme leaves these groups undefined.

    ----------------------------------------------------------------
    -- CUSTOM
    ----------------------------------------------------------------
    -- Effect.gen opens a program scope. Warm rose-pink advances
    -- against the cool base, so the marker leaps off the page.
    EffectGen = { fg = p.effect_gen, bold = bold },
  }

  return groups
end

return M
