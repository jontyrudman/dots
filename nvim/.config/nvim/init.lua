--                _/                
--   _/      _/      _/_/_/  _/_/   
--  _/      _/  _/  _/    _/    _/  
--   _/  _/    _/  _/    _/    _/   
--    _/      _/  _/    _/    _/    


-- Standard vim setup
dofile(vim.fn.stdpath("config") .. "/std.lua")

-- Plugins
dofile(vim.fn.stdpath("config") .. "/lzy.lua")

-- Completion setup
dofile(vim.fn.stdpath("config") .. "/cmp.lua")

-- LSP setup
dofile(vim.fn.stdpath("config") .. "/lsp.lua")

-- Use Neoformat for formatting because not all LSPs (Pyright) do it
dofile(vim.fn.stdpath("config") .. "/fmt.lua")
