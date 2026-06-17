#!/bin/bash
# install_tools_mac.sh — macOS tool installer using Homebrew + mise + npm
set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

info()  { echo -e "${BLUE}[INFO]${NC} $1"; }
ok()    { echo -e "${GREEN}[OK]${NC} $1"; }
warn()  { echo -e "${YELLOW}[WARN]${NC} $1"; }

ensure_local_bin() {
  mkdir -p "$HOME/.local/bin"
}

# ---- Homebrew packages ------------------------------------------------------
install_brew_packages() {
  info "Installing Homebrew packages..."

  local packages=()

  if ! command -v mise &>/dev/null; then
    packages+=(mise)
  else
    info "mise already installed, skipping."
  fi

  if ! command -v fzf &>/dev/null; then
    packages+=(fzf)
  else
    info "fzf already installed, skipping."
  fi

  if ! command -v nvim &>/dev/null; then
    packages+=(neovim)
  else
    info "neovim already installed, skipping."
  fi

  # System tools
  packages+=(tmux the_silver_searcher ripgrep)

  if [ ${#packages[@]} -gt 0 ]; then
    brew install "${packages[@]}"
    ok "Homebrew packages installed."
  else
    ok "All Homebrew packages already present."
  fi

  # fzf post-install (key bindings and completion for zsh)
  if [ ! -f "$HOME/.fzf.zsh" ]; then
    info "Setting up fzf key bindings and completion..."
    "$(brew --prefix)/opt/fzf/install" --key-bindings --completion --no-update-rc --no-bash --no-fish --no-nushell
    ok "fzf key bindings and completion installed."
  fi
}

# ---- Tools via mise ---------------------------------------------------------
install_tools_via_mise() {
  info "Installing tools via mise..."

  eval "$(mise activate bash)"

  if ! mise ls node &>/dev/null; then
    mise use --global node@24
    ok "Node.js 24 installed via mise"
  else
    info "Node.js already configured in mise, skipping."
  fi

  if ! mise ls python &>/dev/null; then
    mise use --global python@3.12
    ok "Python 3.12 installed via mise"
  else
    info "Python already configured in mise, skipping."
  fi
}

# ---- npm-based language servers ---------------------------------------------
install_langservers_npm() {
  info "Installing npm-based language servers..."

  npm install -g pyright
  ok "pyright installed."

  npm install -g @vtsls/language-server
  ok "vtsls installed."

  npm install -g vscode-langservers-extracted
  ok "vscode-langservers-extracted installed (html, cssls, etc.)."

  info "npm-based language servers done."
}

# ---- Lua language server (macOS arm64) --------------------------------------
install_lua_ls() {
  if command -v lua-language-server &>/dev/null; then
    info "lua-language-server already installed, skipping."
    return 0
  fi

  local latest
  latest=$(curl -s https://api.github.com/repos/LuaLS/lua-language-server/releases/latest \
    | grep '"tag_name":' | sed 's/.*"tag_name": "\(.*\)",.*/\1/')
  [ -z "$latest" ] && latest="3.13.9"

  info "Installing lua-language-server (${latest})..."
  ensure_local_bin
  curl -L "https://github.com/LuaLS/lua-language-server/releases/download/${latest}/lua-language-server-${latest}-darwin-arm64.tar.gz" \
    --output /tmp/lua_ls.tar.gz
  mkdir -p "$HOME/.local/bin/lua_ls"
  tar -xf /tmp/lua_ls.tar.gz -C "$HOME/.local/bin/lua_ls"
  ln -f -s "$HOME/.local/bin/lua_ls/bin/lua-language-server" "$HOME/.local/bin/lua-language-server"
  rm /tmp/lua_ls.tar.gz
  ok "lua-language-server installed."
}

# ---- gopls ------------------------------------------------------------------
install_gopls() {
  if command -v gopls &>/dev/null; then
    info "gopls already installed, skipping."
    return 0
  fi
  if ! command -v go &>/dev/null; then
    warn "Go is not installed. Skipping gopls. Install Go first, then run: go install golang.org/x/tools/gopls@latest"
    return 1
  fi
  info "Installing gopls..."
  go install golang.org/x/tools/gopls@latest
  ok "gopls installed."
}

# ---- mise activation in .zshrc (if not already present) ----------------------
setup_mise_activation() {
  if ! grep -q "mise activate" "$HOME/.zshrc" 2>/dev/null; then
    echo '' >> "$HOME/.zshrc"
    echo '# mise' >> "$HOME/.zshrc"
    echo 'eval "$(~/.local/bin/mise activate zsh)"' >> "$HOME/.zshrc"
    ok "Added mise activation to .zshrc"
  fi
}

# ===== Main ==================================================================
echo ""
echo "# === Installing Tools (macOS) ==="
echo ""

install_brew_packages
echo ""

install_tools_via_mise
echo ""

setup_mise_activation
echo ""

install_lua_ls
echo ""

install_langservers_npm
echo ""

install_gopls
echo ""

echo ""
ok "All macOS tools installed!"
echo "Restart your shell or run: source ~/.zshrc"
