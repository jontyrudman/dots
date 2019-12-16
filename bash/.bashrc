#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source $HOME/.bash_prompt
source $HOME/.bash_aliases
source $HOME/.bash_path
export EDITOR=nvim

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Firefox fix
MOZ_ENABLE_WAYLAND=1; export MOZ_ENABLE_WAYLAND

# GHC
[ -f "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env" ] && source "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env"
