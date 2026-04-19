# My Neovim Config (2026)

Modern, production-quality Neovim configuration built around **lazy.nvim +
blink.cmp + snacks.nvim + vim.lsp.config**. Targeted at Swift / TypeScript /
Python development on macOS. No AI plugins.

## Prerequisites

| Tool          | Purpose                                   | Install (macOS)                        |
|---------------|-------------------------------------------|----------------------------------------|
| Neovim ≥ 0.11 | Editor (0.12 recommended for TS `main` branch) | `brew install neovim` (stable) or `brew install neovim --HEAD` |
| Git           | Plugin manager uses git clones            | Pre-installed with Xcode CLT           |
| Xcode CLT     | Gives you `xcrun sourcekit-lsp`, clangd   | `xcode-select --install`               |
| Xcode (full)  | Required for iOS builds via xcodebuild    | Mac App Store                          |
| A Nerd Font   | For icons in statusline/dashboard/picker  | `brew install --cask font-jetbrains-mono-nerd-font` (or SF Mono Nerd, FiraCode Nerd) |
| ripgrep       | Fast project grep (snacks.picker)         | `brew install ripgrep`                 |
| fd            | Fast file find (snacks.picker)            | `brew install fd`                      |
| lazygit       | TUI git integration                       | `brew install lazygit`                 |
| Node ≥ 18     | Runs many LSPs (vtsls, basedpyright, …)   | `brew install node`                    |
| Python ≥ 3.10 | For ruff / basedpyright integration       | `brew install python@3.12`             |
| Rust toolchain (optional) | Fallback build for blink.cmp matcher | `brew install rustup && rustup-init`   |
| Swift         | Any recent Xcode ships Swift 5.9+         | Via Xcode                              |
| xcode-build-server | Makes SourceKit-LSP understand `.xcodeproj`/`.xcworkspace` | `brew install xcode-build-server` |
| swift-format  | Apple formatter (or swiftformat alt.)     | `brew install swift-format`            |
| swiftlint     | Linter (optional)                         | `brew install swiftlint`               |
| prettierd     | Faster web-formatter daemon               | `brew install prettierd` or `npm i -g @fsouza/prettierd` |

Set your terminal font to a Nerd Font variant so icons render correctly.

## Installation

This config lives in `~/.dotfiles/neovim/` and is symlinked to `~/.config/nvim`
by the dotfiles bootstrap. If you are migrating from a different Neovim config
on this machine, back up any stale state first:

```bash
mv ~/.local/share/nvim  ~/.local/share/nvim.bak 2>/dev/null
mv ~/.local/state/nvim  ~/.local/state/nvim.bak 2>/dev/null
mv ~/.cache/nvim        ~/.cache/nvim.bak       2>/dev/null
```

Then run the dotfiles bootstrap (`./bootstrap.sh --yes`). It:
1. Installs the required Homebrew formulae (`neovim`, `lazygit`, `prettierd`,
   `xcode-build-server`, `ripgrep`, `fd`, `swift-format`, `swiftlint`, etc.).
2. Symlinks this directory to `~/.config/nvim`.
3. Pre-runs `nvim --headless "+Lazy! sync" +qa` so plugins install before your
   first interactive launch.

After that, just `nvim`. Mason installs the LSPs / formatters / linters
listed in `lua/plugins/lsp.lua` and `lua/plugins/formatting.lua` on first
language use.

Verify everything with:

```vim
:checkhealth
:Mason
:LspInfo
```

## What's where

- `init.lua` — Entry point. Loads options/keymaps, bootstraps lazy, loads autocmds.
- `lua/config/options.lua` — Vim options + leader keys.
- `lua/config/keymaps.lua` — Global keymaps (non-plugin).
- `lua/config/autocmds.lua` — Autocommands (yank highlight, last-cursor, trim whitespace, …).
- `lua/config/lazy.lua` — lazy.nvim bootstrap.
- `lua/plugins/*.lua` — One file per concern (colorscheme, lsp, completion, …). Every file returns a plugin spec table; lazy auto-imports them.
- `lsp/*.lua` — Per-server LSP configs, auto-discovered by Neovim 0.11+.
- `.archive/init.vim` — the previous vim-plug-based config, kept for reference.

## Keymap cheatsheet

Leader is `<Space>`.

### Finding things (snacks.picker)

| Keys              | Action                |
|-------------------|-----------------------|
| `<leader><space>` | Smart files           |
| `<leader>ff`      | Find files            |
| `<leader>fg`      | Git files             |
| `<leader>fr`      | Recent files          |
| `<leader>fb`      | Buffers               |
| `<leader>fc`      | Config files          |
| `<leader>/`       | Live grep             |
| `<leader>sw`      | Grep current word     |
| `<leader>sh`      | Help tags             |
| `<leader>sk`      | Keymaps               |
| `<leader>sd`      | Workspace diagnostics |
| `<leader>ss`      | LSP document symbols  |
| `<leader>sr`      | Resume last picker    |

### Files / navigation

| Keys         | Action                                   |
|--------------|------------------------------------------|
| `<leader>e`  | snacks.explorer (tree view)              |
| `-`          | oil.nvim (buffer-style parent directory) |
| `<leader>fe` | oil.nvim                                 |
| `<leader>fE` | oil.nvim (floating)                      |
| `<S-h>/<S-l>`| Prev/next buffer                         |

### LSP

| Keys          | Action                     |
|---------------|----------------------------|
| `gd / gr / gI / gy` | Definition / references / implementation / type-def (picker) |
| `K`           | Hover docs                 |
| `<leader>ca`  | Code action                |
| `<leader>cr`  | Rename                     |
| `<leader>cf`  | Format                     |
| `<leader>cd`  | Line diagnostics (float)   |
| `[d / ]d`     | Prev/next diagnostic       |
| `<leader>uh`  | Toggle inlay hints         |
| `<leader>xx`  | Trouble diagnostics        |

### Git

| Keys         | Action                           |
|--------------|----------------------------------|
| `<leader>gg` | Lazygit (via snacks)             |
| `<leader>gB` | Open current line on GitHub/GitLab |
| `<leader>gd` | Diffview                         |
| `]h / [h`    | Next/prev git hunk               |
| `<leader>ghs / <leader>ghr` | Stage / reset hunk |
| `<leader>ghb`| Line blame                       |

### UI toggles

| Keys         | Action                      |
|--------------|-----------------------------|
| `<leader>uC` | Colorscheme picker (live preview) |
| `<leader>uh` | Inlay hints on/off          |
| `<leader>ud` | Diagnostics on/off          |
| `<leader>us` | Spelling on/off             |
| `<leader>uw` | Wrap on/off                 |
| `<leader>z`  | Zen mode                    |
| `<C-/>`      | Toggle floating terminal    |

### Swift / Xcode (buffer-local in `.swift` files)

| Keys         | Action                     |
|--------------|----------------------------|
| `<leader>Xp` | Xcode action picker (use this first) |
| `<leader>Xs` | Select scheme              |
| `<leader>Xd` | Select device              |
| `<leader>Xb` | Build                      |
| `<leader>Xr` | Build & Run                |
| `<leader>Xt` | Run tests                  |
| `<leader>Xc` | Toggle code coverage       |

## Language support

### Swift

SourceKit-LSP is invoked through `xcrun sourcekit-lsp` so it always uses the
Xcode-selected toolchain. For **Xcode projects** (`.xcodeproj`/`.xcworkspace`),
run this once in your project root so SourceKit-LSP can resolve UIKit/SwiftUI
and your app's modules:

```bash
cd path/to/YourApp
xcode-build-server config -workspace YourApp.xcworkspace -scheme YourApp
# → generates buildServer.json
```

For Swift packages (`Package.swift`), no extra setup is needed.

Build/test/run from inside Neovim with `xcodebuild.nvim` — press `<leader>Xp`
for the full picker.

### TypeScript / JavaScript

`vtsls` is the LSP (VS Code's TS extension wrapped as a language server).
Inlay hints are on by default; toggle per buffer with `<leader>uh`.
Formatting uses `prettierd`; linting uses `eslint_d`.

### Python

`basedpyright` (type checker; better defaults + inlay hints vs. pyright) plus
`ruff` LSP (linting, formatting, import sorting). basedpyright owns hover;
ruff owns diagnostics, format, and imports. Formatter-on-save runs
`ruff organize-imports` → `ruff format`.

## Customization tips

- **Change default theme** — edit the `vim.cmd.colorscheme(...)` call in
  `lua/plugins/colorscheme.lua`, or just press `<leader>uC` to live-preview
  and swap.
- **Add an LSP server** — install it via `:Mason`, then add its name to
  `ensure_installed` in `lua/plugins/lsp.lua` and (optionally) create
  `lsp/<server>.lua` with any settings overrides.
- **Disable format-on-save** — run `:FormatDisable` (buffer with `!`), or
  `:FormatEnable` to re-enable.
- **Pick blink.cmp keymap style** — change `keymap.preset` in
  `lua/plugins/completion.lua` to `"super-tab"` (Tab accepts) or `"enter"`
  (Enter accepts) if you prefer those.
- **Swap snacks.picker for Telescope or fzf-lua** — replace the bindings in
  `editor.lua`. The Telescope spec is already present for xcodebuild.nvim.

## Troubleshooting

- `:checkhealth` should come back clean. If not, read it top-to-bottom.
- **Icons are tofu / boxes?** Your terminal isn't using a Nerd Font.
- **SourceKit-LSP not starting?** Ensure `xcrun --find sourcekit-lsp` works.
  If it doesn't: `sudo xcode-select -s /Applications/Xcode.app`.
- **Swift completion missing UIKit/SwiftUI?** You need `xcode-build-server`
  to generate `buildServer.json` (see Swift section).
- **blink.cmp Rust binary warning?** On first run it downloads a prebuilt
  binary. If your network blocks it, set
  `fuzzy.prebuilt_binaries.download = false` and install Rust so it can
  build locally.
- **Treesitter errors after upgrading Neovim?** Run `:TSUpdate`.

## Credits

Built on the shoulders of folke, Saghen, stevearc, mfussenegger, the
mason-org and nvim-treesitter teams, and everyone in the Neovim community
who has made this ecosystem what it is in 2026.
