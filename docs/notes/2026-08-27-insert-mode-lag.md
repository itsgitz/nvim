# INSERT mode lag / occasional hangs (2026-08-27)

## Symptom

Opening `nvim` and switching to INSERT mode felt slow; occasionally the
editor would hang for several seconds. Also noticed a one-off laggy feeling
on the first `:w` in a session.

## Root causes found (in the order they were fixed)

1. **Duplicate autopairs plugin.** `lua/plugins/nvim-autopairs.lua` added
   `windwp/nvim-autopairs`, lazy-loaded on `InsertEnter` — but LazyVim's
   default `mini.pairs` (wired to `blink.cmp`) already does this job and
   loads on the same event. Two plugins were loading and registering
   bracket/quote keymaps on every first `InsertEnter` of a session.
   - **Fix:** deleted `lua/plugins/nvim-autopairs.lua` (commit `eb52562`).

2. **Mason stuck in a silent retry-and-fail loop.** `python3-venv` was
   missing on this machine, so `python3 -m venv` always failed. Mason
   needs it to install four pip-based tools pulled in by the pre-existing
   `ansible`/`cmake`/`sql` LazyVim extras: `ansible-lint`, `cmakelang`,
   `cmakelint`, `sqlfluff`. Every Neovim startup, Mason retried installing
   all four, each attempt spawning failing `python3` processes and doing
   error-formatting work on the main thread — regardless of which file was
   open (confirmed by reproducing the freeze in a plain `.zshrc` buffer
   with zero LSP clients attached). This was the actual cause of the
   generic "open nvim, feel lag/hangs" symptom.
   - **Fix:** `sudo apt install python3.12-venv`, then let Mason's queue
     drain. All four packages now install cleanly; verified via
     `~/.local/state/nvim/mason.log` and
     `~/.local/share/nvim/mason/packages/`. No config change needed.

## Investigated and ruled out

- **rust-analyzer / rustaceanvim / native LSP folding & inlay hints**:
  real, measurable stalls *do* happen in Rust buffers (confirmed with an
  in-process libuv heartbeat timer + LSP trace logging), tied to
  rust-analyzer's own cold-start/indexing burstiness. Disabling
  `buildScripts`/`loadOutDirsFromCheck` and disabling native LSP
  folds/inlay-hints did **not** reliably reduce it. Turned out to be a
  red herring for the actual complaint — the user only edits `.zshrc`
  day-to-day, which has no LSP client attached at all. Left as-is; revisit
  only if Rust editing specifically becomes a problem.
- **First-save-of-session lag**: confirmed to happen only on the *first*
  `:w`/completion per session, not every save. This is lazy.nvim loading
  `conform.nvim` and `blink.cmp`'s providers on first real use — a
  deliberate LazyVim trade-off (faster startup, small one-time hitch on
  first use), not a bug. No action taken.

## Method notes (useful if this comes up again)

- Headless Neovim + `--listen`/`--server --remote-send`/`--remote-expr`
  gives a scriptable way to drive real editor sessions and time RPC
  round-trips.
- An in-process `vim.uv.new_timer()` heartbeat (ticking every 50ms,
  logging `vim.uv.now()` to a file) is the most reliable way to prove the
  *entire* main loop is blocked, not just one RPC channel — `ptrace`/
  `strace` was not available in this sandbox.
- `vim.lsp.set_log_level("trace")` + `~/.local/state/nvim/lsp.log` shows
  every RPC message with timestamps — useful for correlating stalls with
  specific LSP traffic.
- `~/.local/state/nvim/mason.log` records every install attempt/failure;
  check it first for any "why does startup feel slow" report before
  chasing editor-internals theories.
- A `debug.sethook(fn, "", N)` count-hook that logs a timestamp + one-line
  traceback whenever the delta since the last hook call exceeds a
  threshold is a decent poor-man's profiler when `strace`/a real profiler
  isn't available: silence during a stall means the block is inside a
  native/C call; frequent firing with a traceback pinpoints the hot Lua
  path.
