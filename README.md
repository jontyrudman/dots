```
         _/              _/                
    _/_/_/    _/_/    _/_/_/_/    _/_/_/   
 _/    _/  _/    _/    _/      _/_/        
_/    _/  _/    _/    _/          _/_/     
 _/_/_/    _/_/        _/_/  _/_/_/


Here are my dot files! (The above font is 'Lean' from https://www.patorjk.com/software/taag/)
```

## Contents

| Path | Description |
|------|-------------|
| `bash/.bash_prompt` | Custom prompt with git status |
| `bash/.bash_extras` | Extra bash config (PATH, nvm, pnpm) |
| `bash/.bashrc` | Main .bashrc with mise activation, fzf opts |
| `bash/.bash_profile` | Profile sourcing .bashrc |
| `nvim/.config/nvim/` | Neovim config (lazy.nvim, LSP, cmp, etc.) |
| `pi/` | [pi](https://pi.ai) coding agent configuration |
| `config/mise/config.toml` | [mise](https://mise.jdx.dev) version manager config |
| `local/bin/sandbox` | Bubblewrap sandbox script for isolated shells |

## Setup

Run everything:
```bash
./run_all.sh
```

Or step by step:
```bash
./install_tools.sh   # Install mise, fzf, neovim, language servers, etc.
./setup_bash.sh      # Copy bash config to ~/
./setup_nvim.sh      # Copy nvim config to ~/.config/nvim
```

## What install_tools.sh does

1. **System packages** — tmux, silversearcher-ag
2. **[mise](https://mise.jdx.dev)** — polyglot tool version manager
3. **Node.js 24 and Python 3.12** — via mise
4. **[fzf](https://github.com/junegunn/fzf)** — fuzzy finder with key bindings and completion
5. **Neovim** — latest release from GitHub
6. **Language servers:**
   - [LuaLS](https://github.com/LuaLS/lua-language-server) — Lua language server
   - [pyright](https://github.com/microsoft/pyright) — Python type checking & LSP
   - [vtsls](https://github.com/yioneko/vtsls) — TypeScript/JavaScript LSP (faster than tsserver)
   - [vscode-langservers-extracted](https://github.com/hrsh7th/vscode-langservers-extracted) — HTML, CSS, JSON, ESLint
   - [gopls](https://github.com/golang/tools/tree/master/gopls) — Go language server