#!/bin/bash
set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

info()  { echo -e "${BLUE}[INFO]${NC} $1"; }
ok()    { echo -e "${GREEN}[OK]${NC} $1"; }
warn()  { echo -e "${YELLOW}[WARN]${NC} $1"; }

ensure_local_bin() {
	mkdir -p "$HOME/.local/bin"
}

install_mise() {
	if command -v mise &>/dev/null; then
		info "mise already installed at $(command -v mise), skipping."
		return 0
	fi
	info "Installing mise..."
	curl https://mise.jdx.dev/install.sh | sh
	ok "mise installed."
}

install_tools_via_mise() {
	info "Installing tools via mise..."
	eval "$(~/.local/bin/mise activate bash)"

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

install_fzf() {
	if command -v fzf &>/dev/null; then
		info "fzf already installed at $(command -v fzf), skipping."
		return 0
	fi
	info "Installing fzf..."
	git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
	yes | "$HOME/.fzf/install" --key-bindings --completion --no-update-rc
	ok "fzf installed. Key bindings and completion enabled."
}

install_nvim() {
	if [ -L "$HOME/.local/bin/nvim" ] && [ -e "$HOME/.local/bin/nvim" ]; then
		info "${HOME}/.local/bin/nvim already exists, skipping."
		return 0
	fi

	ensure_local_bin
	mkdir -p /tmp/nvim-dl
	info "Downloading neovim..."
	curl -L https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz \
		--output /tmp/nvim-dl/nvim-linux64.tar.gz
	curl -L https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz.sha256sum \
		--output /tmp/nvim-dl/nvim-linux64.tar.gz.sha256sum
	ok "Downloaded."

	info "Verifying checksum..."
	bash -c 'cd /tmp/nvim-dl && sha256sum -c "nvim-linux64.tar.gz.sha256sum"'
	ok "Checksum OK."

	info "Installing to ${HOME}/.local/bin..."
	tar -xf /tmp/nvim-dl/nvim-linux64.tar.gz -C "$HOME/.local/bin"
	ln -s "$HOME/.local/bin/nvim-linux64/bin/nvim" "$HOME/.local/bin/nvim"
	ok "Installed."

	rm -r /tmp/nvim-dl
}

install_lua_ls() {
	if command -v lua-language-server &>/dev/null; then
		info "lua-language-server already installed, skipping."
		return 0
	fi
	# LuaLS uses full version tag; grab latest from GitHub releases
	local latest
	latest=$(curl -s https://api.github.com/repos/LuaLS/lua-language-server/releases/latest \
		| grep '"tag_name":' | sed 's/.*"tag_name": "\(.*\)",.*/\1/')
	if [ -z "$latest" ]; then
		latest="3.13.9"  # fallback
	fi
	info "Installing lua-language-server (${latest})..."
	ensure_local_bin
	curl -L "https://github.com/LuaLS/lua-language-server/releases/download/${latest}/lua-language-server-${latest}-linux-x64.tar.gz" \
		--output /tmp/lua_ls.tar.gz
	mkdir -p "$HOME/.local/bin/lua_ls"
	tar -xf /tmp/lua_ls.tar.gz -C "$HOME/.local/bin/lua_ls"
	ln -f -s "$HOME/.local/bin/lua_ls/bin/lua-language-server" "$HOME/.local/bin/lua-language-server"
	rm /tmp/lua_ls.tar.gz
	ok "lua-language-server installed."
}

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

install_system_packages() {
	info "Installing system packages..."

	if command -v apt &>/dev/null; then
		sudo apt -y install tmux silversearcher-ag
	elif command -v dnf &>/dev/null; then
		sudo dnf -y install tmux the_silver_searcher
	else
		warn "Unknown package manager. Please install tmux and the_silver_searcher manually."
	fi

	ok "System packages done."
}

setup_mise_activation() {
	# Ensure mise is activated in bashrc if not already there
	if ! grep -q "mise activate" "$HOME/.bashrc" 2>/dev/null; then
		echo '' >> "$HOME/.bashrc"
		echo 'eval "$(~/.local/bin/mise activate bash)"' >> "$HOME/.bashrc"
		ok "Added mise activation to .bashrc"
	fi
}

# --- Main ---
echo ""
echo "# === Installing Tools ==="
echo ""

install_system_packages
echo ""

install_mise
echo ""

install_tools_via_mise
echo ""

setup_mise_activation
echo ""

install_fzf
echo ""

install_nvim
echo ""

install_lua_ls
echo ""

install_langservers_npm
echo ""

install_gopls
echo ""

echo ""
ok "All tools installed!"
echo "Restart your shell or run: source ~/.bashrc"