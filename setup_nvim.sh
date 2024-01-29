#!/bin/bash

echo -n "Copying nvim setup to ${HOME}/.config/nvim... "
mkdir -p $HOME/.config/nvim
cp nvim/.config/nvim/* $HOME/.config/nvim
echo "Done."
