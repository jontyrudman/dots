#!/bin/bash
# setup_zsh.sh — Copy zsh configuration to $HOME

echo -n "Copying .zshrc to ${HOME}... "
cp zsh/.zshrc "$HOME/.zshrc"
echo "Done."

echo -n "Copying .zprofile to ${HOME}... "
cp zsh/.zprofile "$HOME/.zprofile"
echo "Done."
