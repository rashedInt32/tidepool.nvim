# Examples

Demo files for previewing tidepool across languages. Each file exercises
keywords, types, functions, strings, numbers, constants, comments, and
`TODO`/`FIXME` markers so you can judge hierarchy at a glance.

```sh
nvim -c 'colorscheme tidepool' examples/typescript.ts
```

Install the matching treesitter parsers for full highlighting:

```vim
:TSInstall comment lua typescript tsx javascript python rust go c java ruby bash html css json yaml toml markdown markdown_inline sql
```

| File | Language |
| --- | --- |
| `lua.lua` | Lua |
| `typescript.ts` | TypeScript (includes `Effect.gen` for the `EffectGen` group) |
| `react.tsx` | TSX / React |
| `javascript.js` | JavaScript |
| `python.py` | Python |
| `rust.rs` | Rust |
| `go/main.go` | Go (own module, so gopls stays quiet) |
| `c.c` | C |
| `java.java` | Java |
| `ruby.rb` | Ruby |
| `shell.sh` | Bash |
| `html.html` | HTML |
| `css.css` | CSS |
| `json.json` | JSON |
| `yaml.yaml` | YAML |
| `toml.toml` | TOML |
| `markdown.md` | Markdown |
| `sql.sql` | SQL |
