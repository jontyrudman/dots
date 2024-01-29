#!/bin/bash
set -e

install_nvim () {
	if [ -L $HOME/.local/bin/nvim ] && [ -e $HOME/.local/bin/nvim ]; then
		echo "${HOME}/.local/bin/nvim already exists, skipping."
		return 0
	fi

	echo -n "Downloading..."
	mkdir -p /tmp/nvim-dl &> /dev/null
	curl -L https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz --output /tmp/nvim-dl/nvim-linux64.tar.gz &> /dev/null
	curl -L https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz.sha256sum --output /tmp/nvim-dl/nvim-linux64.tar.gz.sha256sum &> /dev/null
	echo " Done."

	echo -n "Checksum..."
	bash -c 'cd /tmp/nvim-dl && sha256sum -c "nvim-linux64.tar.gz.sha256sum"' &> /dev/null
	echo " Done."

	echo -n "Installing to ${HOME}/.local/bin..."
	mkdir -p $HOME/.local/bin
	tar -xf /tmp/nvim-dl/nvim-linux64.tar.gz -C $HOME/.local/bin
	ln -s $HOME/.local/bin/nvim-linux64/bin/nvim $HOME/.local/bin/nvim
	echo " Done."

	echo -n "Cleaning up..."
	rm -r /tmp/nvim-dl
	echo " Done."
}

install_node () {
	if [ -d $HOME/.nvm ]; then
		echo "${HOME}/.nvm already exists, skipping."
		return 0
	fi

	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
	source $HOME/.bashrc
	nvm install node
	nvm use node
}

echo "# Install neovim latest"
install_nvim

echo "# Install node version manager and latest version of node"
install_node

echo "# Install tmux, fzf, ag"
sudo apt -y install tmux || sudo dnf -y install tmux
sudo apt -y install fzf || sudo dnf -y install fzf
sudo apt -y install silversearcher-ag || sudo dnf -y install the_silver_searcher

echo "# Install language servers"

echo -n "LuaLS... "
curl -L https://github.com/LuaLS/lua-language-server/releases/download/3.7.4/lua-language-server-3.7.4-linux-x64.tar.gz --output /tmp/lua_ls.tar.gz &> /dev/null
mkdir -p $HOME/.local/bin/lua_ls
tar -xf /tmp/lua_ls.tar.gz -C $HOME/.local/bin/lua_ls
ln -f -s $HOME/.local/bin/lua_ls/bin/lua-language-server $HOME/.local/bin/lua-language-server
echo "Done."

echo "Pyright... "
npm install -g pyright
echo "Done."

echo "Typescript... "
npm install -g typescript typescript-language-server
echo "Done."

echo "Angular... "
npm install -g @angular/language-server
echo "Done."

echo "Base vscode langservers... "
npm install -g vscode-langservers-extracted
echo "Done."
