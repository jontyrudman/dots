#!/bin/bash

chmod +x setup_bash.sh
chmod +x install_tools.sh
chmod +x setup_nvim.sh

./install_tools.sh

# Bash config
./setup_bash.sh

# Neovim config
./setup_nvim.sh

# Pi agent config
echo -n "Copying pi config to ${HOME}/.pi... "
mkdir -p "$HOME/.pi/agent/npm" "$HOME/.pi/pi-acp"
cp pi/agent/settings.json "$HOME/.pi/agent/settings.json"
cp pi/agent/auth.json "$HOME/.pi/agent/auth.json"
cp pi/agent/npm/package.json "$HOME/.pi/agent/npm/package.json"
cp pi/pi-acp/session-map.json "$HOME/.pi/pi-acp/session-map.json"
echo "Done."

# Mise config
echo -n "Copying mise config to ${HOME}/.config/mise... "
mkdir -p "$HOME/.config/mise"
cp config/mise/config.toml "$HOME/.config/mise/config.toml"
echo "Done."

# Sandbox script
echo -n "Copying sandbox script to ${HOME}/.local/bin... "
mkdir -p "$HOME/.local/bin"
cp local/bin/sandbox "$HOME/.local/bin/sandbox"
chmod +x "$HOME/.local/bin/sandbox"
echo "Done."