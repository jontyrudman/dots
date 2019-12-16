#!/usr/bin/env bash

if [[ $PWD != /home/$USER/.dots ]]; then
  echo "You need to be in /home/$USER/.dots for this to work!"
  exit 1
fi

echo "Attempting to construct directories..."
mkdir -p nvim/.config/nvim/
mkdir -p bash/
echo "Attempting to grab dotfiles from this system..."
cp -r ~/.config/nvim/* nvim/.config/nvim/
cp -r ~/.bashrc bash/.bashrc
cp -r ~/.bash_prompt bash/.bash_prompt
cp -r ~/.bash_aliases bash/.bash_aliases
cp -r ~/.bash_path bash/.bash_path
