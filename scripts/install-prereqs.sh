#!/usr/bin/env bash
# Installs/checks the system-level tooling this LazyVim config expects.
# See README.md's "Prerequisites" section for the full rationale per tool.
#
# Targets Debian/Ubuntu (apt). On any other distro, skip straight to the
# manual instructions in README.md instead of running this.
#
# Safe to re-run: every step checks whether the tool is already present
# before installing anything.

set -euo pipefail

log() { printf '\n\033[1;34m==>\033[0m %s\n' "$1"; }
have() { command -v "$1" >/dev/null 2>&1; }

if ! have apt-get; then
  echo "This script only supports Debian/Ubuntu (apt-get not found)." >&2
  echo "Follow the manual steps in README.md for your distro instead." >&2
  exit 1
fi

mkdir -p "$HOME/.local/bin"
case ":$PATH:" in
  *":$HOME/.local/bin:"*) ;;
  *)
    echo "NOTE: add this to your shell rc file, then restart your shell:"
    echo '  export PATH="$HOME/.local/bin:$PATH"'
    ;;
esac

APT_PACKAGES=()

log "Checking build toolchain (gcc, make)..."
have gcc || APT_PACKAGES+=(build-essential)
have make || APT_PACKAGES+=(build-essential)

log "Checking git..."
have git || APT_PACKAGES+=(git)

log "Checking ripgrep..."
have rg || APT_PACKAGES+=(ripgrep)

log "Checking fd..."
if ! have fd && ! have fdfind; then
  APT_PACKAGES+=(fd-find)
fi

log "Checking unzip/curl..."
have unzip || APT_PACKAGES+=(unzip)
have curl || APT_PACKAGES+=(curl)

if [ "${#APT_PACKAGES[@]}" -gt 0 ]; then
  # dedupe
  mapfile -t APT_PACKAGES < <(printf '%s\n' "${APT_PACKAGES[@]}" | sort -u)
  log "Installing via apt: ${APT_PACKAGES[*]}"
  sudo apt-get update
  sudo apt-get install -y "${APT_PACKAGES[@]}"
else
  log "All apt-installable prerequisites already present."
fi

# fd-find on Debian/Ubuntu installs the binary as `fdfind` (name clash).
if ! have fd && have fdfind; then
  ln -sf "$(command -v fdfind)" "$HOME/.local/bin/fd"
  log "Symlinked fdfind -> ~/.local/bin/fd"
fi

log "Checking PHP CLI..."
if ! have php; then
  # Ubuntu's own repo only ships one PHP version. ondrej/php lets you install
  # multiple versions side by side (php8.1, php8.3, ...) and switch with
  # update-alternatives, which is the standard setup for PHP work.
  have add-apt-repository || sudo apt-get install -y software-properties-common
  sudo add-apt-repository -y ppa:ondrej/php
  sudo apt-get update
  sudo apt-get install -y php-cli php-mbstring php-xml php-curl
else
  log "PHP already installed: $(php --version | head -1)"
fi

log "Checking Composer..."
if ! have composer; then
  tmp_installer="$(mktemp -t composer-setup-XXXXXX.php)"
  php -r "copy('https://getcomposer.org/installer', '$tmp_installer');"
  php "$tmp_installer" --install-dir="$HOME/.local/bin" --filename=composer
  rm -f "$tmp_installer"
else
  log "Composer already installed: $(composer --version)"
fi

log "Checking Zig..."
if ! have zig; then
  if have snap; then
    sudo snap install zig --classic --edge
  else
    echo "snap not found — install Zig manually: https://ziglang.org/download/"
  fi
else
  log "Zig already installed: $(zig version)"
fi

# --- Tools with multiple valid install methods (version managers, etc.) ---
# We only report status for these; installing them here would fight
# whatever method (fnm/nvm, rustup, asdf, ...) you already prefer.
log "Status of remaining tools (install these yourself if missing):"
report() {
  local name="$1" cmd="$2" version_args="$3" url="$4"
  if have "$cmd"; then
    printf '  [x] %-10s %s\n' "$name" "$($cmd $version_args 2>&1 | head -1)"
  else
    printf '  [ ] %-10s not found — %s\n' "$name" "$url"
  fi
}
report "Node.js" node "--version" "https://nodejs.org/ (or fnm/nvm/volta)"
report "Go" go "version" "https://go.dev/dl/"
report "Rust" rustc "--version" "https://rustup.rs/"
report "Python" python3 "--version" "https://www.python.org/downloads/"
report "lazygit" lazygit "--version" "https://github.com/jesseduffield/lazygit#installation"

log "Done. Now open Neovim and let Mason install the LSP servers:"
echo "  nvim +Lazy! sync +qa"
echo "  nvim +Mason   # press I to install everything queued"
echo "  nvim +checkhealth"
