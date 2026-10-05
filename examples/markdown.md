# Tidepool Demo

A **deep teal-navy** theme with _restrained_ scaffolding and `inline code`.

## Lists

- Lavender functions
- Gold types
  - Nested item with a [link](https://example.com)
- [x] Done task
- [ ] Open task

1. First
2. Second

> [!NOTE]
> Callouts render through render-markdown.nvim.

### Code

```lua
local tide = require("tidepool")
tide.setup({ palette = "hybrid" })
```

```ts
const height: number = 4.2;
```

### Table

| Group    | Color    | Role         |
| -------- | -------- | ------------ |
| Function | lavender | verbs        |
| Type     | gold     | shapes       |
| String   | sage     | data         |

---

Footnote reference[^1] and ~~strikethrough~~.

[^1]: Footnotes work too.
