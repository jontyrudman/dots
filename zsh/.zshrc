# =============================================================================
# .zshrc — macOS zsh configuration (ported from bash dotfiles)
# =============================================================================

# ---- Path -------------------------------------------------------------------
export PATH="$HOME/.local/bin:$HOME/go/bin:$PATH"

# ---- Editor -----------------------------------------------------------------
export EDITOR=nvim

# ---- History ----------------------------------------------------------------
HISTSIZE=100000
SAVEHIST=100000
HISTFILE="$HOME/.zsh_history"
setopt SHARE_HISTORY         # Share history across sessions
setopt HIST_IGNORE_DUPS      # Don't record duplicate entries
setopt HIST_IGNORE_SPACE     # Don't record lines starting with space

# ---- Completion -------------------------------------------------------------
autoload -Uz compinit
compinit -u

# ---- mise (https://mise.jdx.dev) -------------------------------------------
if command -v mise &>/dev/null; then
  eval "$(mise activate zsh)"
fi

# ---- fzf (https://github.com/junegunn/fzf) ----------------------------------
if command -v fzf &>/dev/null; then
  eval "$(fzf --zsh)"
fi
export FZF_DEFAULT_OPTS="--history=$HOME/.fzf_history"

# ---- Prompt with git status -------------------------------------------------
autoload -Uz vcs_info
zstyle ':vcs_info:git:*' formats '[%b%c%u] '
zstyle ':vcs_info:git:*' actionformats '[%b|%a%c%u] '
zstyle ':vcs_info:*' enable git

precmd() {
  vcs_info
  psvar[1]=$vcs_info_msg_0_
}

# Prompt: user@host cwd [branch] 
# $ on the next line (like the bash prompt)
# %1v expands to psvar[1] (set from vcs_info_msg_0_ above)
PROMPT=$'%{\e[01;32m%}%n%{\e[m%}@%{\e[01;32m%}%m%{\e[m%} %{\e[01;34m%}%~%{\e[m%} %{\e[01;32m%}%1v%{\e[m%}\n%{\e[01;32m%}$%{\e[m%} '

# ---- Aliases ----------------------------------------------------------------
alias ls='ls -G'
alias ll='ls -lh'
alias la='ls -lah'
alias ..='cd ..'

# ---- Local extras -----------------------------------------------------------
# Source ~/.zshrc.local if it exists (for machine-specific config)
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"
