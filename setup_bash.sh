#!/bin/bash

echo -n "Copying prompt, extras, bashrc and profile to ${HOME}... "
cp bash/.bash_prompt bash/.bash_extras bash/.bashrc bash/.bash_profile "$HOME"
echo "Done."

echo -n "Sourcing extras in ${HOME}/.bashrc (if not already present)... "
if ! grep -q "source \$HOME/.bash_extras" "$HOME/.bashrc" 2>/dev/null; then
	echo -e '\nsource $HOME/.bash_extras' >> "$HOME/.bashrc"
	echo "Done."
else
	echo "Already present, skipping."
fi