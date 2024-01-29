#!/bin/bash

echo -n "Copying prompt and extras to ${HOME}... "
cp bash/.bash_prompt bash/.bash_extras $HOME
echo "Done."

echo -n "Sourcing extras in ${HOME}/.bashrc... "
echo -e '\nsource $HOME/.bash_extras' >> $HOME/.bashrc
echo "Done."
