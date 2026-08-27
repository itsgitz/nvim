# 💤 LazyVim

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

## Prerequisites

Mason (LazyVim's package manager) will auto-install most LSP servers, but it downloads
and runs prebuilt binaries — it does **not** provide the underlying language runtimes or
compilers. Missing tools show up as cryptic LSP/Mason errors on a fresh machine, so install
these first.

### Core (required regardless of language)

| Tool | Why |
| --- | --- |
| [Neovim](https://neovim.io/) >= 0.11 | This config uses `vim.lsp.config()` ([`lua/config/options.lua`](lua/config/options.lua)), added in 0.11. |
| `git` | Plugin manager ([lazy.nvim](https://github.com/folke/lazy.nvim)) and Mason both shell out to git. |
| A [Nerd Font](https://www.nerdfonts.com/) | Icons in the statusline, file explorer, completion menu, etc. Set it as your terminal font. |
| `ripgrep` (`rg`) | Live grep / search in Telescope. |
| `fd` (`fd-find` on Debian/Ubuntu) | Fast file finding in Telescope. |
| A C compiler (`gcc` or `clang`) + `make` | Builds `telescope-fzf-native` and any Mason package compiled from source. |
| `unzip`, `tar`, `curl` (or `wget`) | Used by Mason to download and extract packages. |
| Node.js + `npm` | Runtime for several Mason-installed LSP servers (see below) and other npm-based tools. |
| `lazygit` (optional) | Powers the `<leader>gg` git UI keymap from LazyVim core. |

### Language-specific tooling

Only the languages actually configured under [`lua/plugins/`](lua/plugins/) are listed —
each maps to a real LSP/formatter entry, so skipping one for a language you don't use is fine.

| Language | Config | LSP / formatter | Needs installed manually |
| --- | --- | --- | --- |
| C / C++ | [`c.lua`](lua/plugins/c.lua) | `clangd` (auto-installed by Mason) | A C/C++ toolchain (`gcc`/`clang`) on your `PATH` so `clangd` can resolve system headers and `compile_commands.json` builds work. |
| TypeScript / JavaScript | [`vtsls.lua`](lua/plugins/vtsls.lua) | `vtsls` (auto-installed by Mason) | Node.js + `npm` (see Core). |
| Prisma | [`prisma.lua`](lua/plugins/prisma.lua) | `prismals` (auto-installed by Mason) | Node.js + `npm` (see Core). |
| Zig | [`zig.lua`](lua/plugins/zig.lua) | `zls` (auto-installed by Mason) | The [Zig toolchain](https://ziglang.org/download/) on your `PATH` so `zls` can resolve the standard library. |
| PHP / Laravel | [`php.lua`](lua/plugins/php.lua) | Formatting only: [Pint](https://laravel.com/docs/pint) → falls back to `php-cs-fixer` (via `conform.nvim`) | PHP CLI + [Composer](https://getcomposer.org/). Pint comes from the project's `vendor/bin/pint` (run `composer require laravel/pint --dev`); if it's absent, install `php-cs-fixer` globally (e.g. `composer global require friendsofphp/php-cs-fixer`) as the fallback. Note: there is currently no PHP language server (diagnostics/go-to-definition) configured, only formatting. |
| Smarty | [`smarty.lua`](lua/plugins/smarty.lua) | Syntax/indent only ([`smarty.vim`](https://github.com/shadowwa/smarty.vim)) | Nothing extra — pure Vimscript plugin, no external binary. |
| HTML/CSS (Emmet) | [`emmet.lua`](lua/plugins/emmet.lua) | [`emmet-vim`](https://github.com/mattn/emmet-vim) | Nothing extra — pure Vimscript plugin, no external binary. |

### Notes

- `:checkhealth` and `:Mason` inside Neovim are the fastest way to confirm what's actually
  missing after installing the above.
- Treesitter parsers (`lua/plugins/treesitter.lua`) are downloaded as precompiled binaries
  (`prefer_git = false`), so they don't require a C compiler. `ensure_installed` covers
  `lua, typescript, javascript, tsx, astro, json, yaml, php, go, html, python, blade, vue,
  css, c, cpp, bash, graphql, zig, rust, ron, prisma, svelte` — note that highlighting for
  Go, Python, Rust, and Svelte is treesitter-only; those languages have no LSP configured
  in this setup (see the language table above).
