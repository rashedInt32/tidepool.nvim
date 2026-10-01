# Accent lift, 2026-09-30

`muted` = original palette. `lifted` = lifted ~4-6% lightness, up to +9 saturation,
hues preserved (<2° shift). Backgrounds identical in both.

**`hybrid` (ACTIVE, default):** `lifted` for content (text, functions, types,
constants, strings, members, parameters, comments, export), `muted` for
scaffolding (keyword `#3e80a8`, operator `#56738a`, punctuation `#6f94a6`).
Rationale: keywords like `const`/`return`/`yield*` repeat constantly and must
not catch the eye while scanning; widening the scaffolding-vs-content gap
beats lifting or muting everything uniformly.

| Role | muted | lifted |
|---|---|---|
| body text | `#9bb5c7` | `#a4c0d2` |
| secondary UI text (subtle) | `#7f9db2` | `#88a8be` |
| comments | `#7a9a9a` | `#86a8a8` |
| foam (builtins, info) | `#5fb3d9` | `#6cc0e5` |
| gold (type declarations, warn) | `#e0af68` | `#e9b873` |
| soft gold (type references) | `#c9a96e` | `#d6b477` |
| iris (functions) | `#cbb4ff` | `#d2bdff` |
| bright iris (function definitions) | `#c8b6ff` | `#d0c0ff` |
| pine (consts, numbers, class refs) | `#6fb1a0` | `#7bc0ae` |
| olive (strings, hint) | `#8fbf7f` | `#9cce8b` |
| sql keywords | `#b5d98c` | `#c0e396` |
| love (errors) | `#e06c75` | `#e67680` |
| rose (tags) | `#c678dd` | `#d083e8` |
| keyword slate | `#3e80a8` | `#4a92bd` |
| export/import | `#7292c9` | `#7d9ede` |
| operators | `#56738a` | `#628099` |
| punctuation | `#6f94a6` | `#7aa2b5` |
| module mauve | `#a890c4` | `#b49cd1` |
| parameters | `#8bb4ff` | `#96bdff` |
| members/properties | `#b794f6` | `#c1a2fa` |
| EffectGen marker | `#e09cb0` | `#eaa6ba` |

Untouched in both: backgrounds (base/surface/overlay/cursorline/visual/border),
diff tints, muted line numbers `#48708c`, mint `#7aa2f7`.
