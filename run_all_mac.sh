#!/bin/bash
# run_all_mac.sh — macOS setup: tools + zsh + nvim + config
set -e

chmod +x install_tools_mac.sh
chmod +x setup_zsh.sh
chmod +x setup_nvim.sh

echo ""
echo "# === macOS Dotfiles Setup ==="
echo ""

# Tools
./install_tools_mac.sh
echo ""

# Zsh config (does NOT overwrite your existing .zshrc.local)
./setup_zsh.sh
echo ""

# Neovim config
./setup_nvim.sh
echo ""

# Pi agent config
echo -n "Copying pi config to ${HOME}/.pi... "
mkdir -p "$HOME/.pi/agent/npm" "$HOME/.pi/pi-acp" 2>/dev/null || true
[ -f pi/agent/settings.json ] && cp pi/agent/settings.json "$HOME/.pi/agent/settings.json"
[ -f pi/agent/auth.json ] && cp pi/agent/auth.json "$HOME/.pi/agent/auth.json"
[ -f pi/agent/npm/package.json ] && cp pi/agent/npm/package.json "$HOME/.pi/agent/npm/package.json"
[ -f pi/pi-acp/session-map.json ] && cp pi/pi-acp/session-map.json "$HOME/.pi/pi-acp/session-map.json"
echo "Done."

# Mise config
echo -n "Copying mise config to ${HOME}/.config/mise... "
mkdir -p "$HOME/.config/mise"
cp config/mise/config.toml "$HOME/.config/mise/config.toml"
echo "Done."

# Sandbox script (macOS variant) — does NOT overwrite if ~/.local/bin/sandbox exists
echo -n "Copying macOS sandbox script to ${HOME}/.local/bin... "
mkdir -p "$HOME/.local/bin"
if [ -f "$HOME/.local/bin/sandbox" ]; then
  echo "Skipping (already exists)."
else
  cp local/bin/sandbox.mac "$HOME/.local/bin/sandbox"
  chmod +x "$HOME/.local/bin/sandbox"
  echo "Done."
fi

# Bin scripts
echo -n "Copying bin scripts to ${HOME}/.local/bin... "
cp local/bin/coding "$HOME/.local/bin/coding"
cp local/bin/agent "$HOME/.local/bin/agent"
chmod +x "$HOME/.local/bin/coding" "$HOME/.local/bin/agent"
echo "Done."

# Zellij config
echo -n "Copying zellij config to ${HOME}/.config/zellij... "
mkdir -p "$HOME/.config/zellij/layouts"
[ -f config/zellij/config.kdl ] && cp config/zellij/config.kdl "$HOME/.config/zellij/config.kdl"
[ -f config/zellij/layouts/coding.kdl ] && cp config/zellij/layouts/coding.kdl "$HOME/.config/zellij/layouts/coding.kdl"
echo "Done."

echo ""
echo "# === Setup Complete ==="
echo "Open a new terminal tab or run: source ~/.zshrc"
