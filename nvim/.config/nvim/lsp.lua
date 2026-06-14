------------------------------------
-- LSPCONFIG PLUGIN CONFIGURATION --
-- Using vim.lsp.config API (Nvim 0.11+)
------------------------------------
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- See :help lspconfig-nvim-0.11
vim.lsp.config('lua_ls', {
	capabilities = capabilities,
})
vim.lsp.enable('lua_ls')

vim.lsp.config('pyright', {
	capabilities = capabilities,
})
vim.lsp.enable('pyright')

-- tsserver was renamed to ts_ls, but vtsls is faster
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#ts_ls
vim.lsp.config('vtsls', {
	capabilities = capabilities,
})
vim.lsp.enable('vtsls')

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#angularls
-- vim.lsp.config('angularls', {
-- 	capabilities = capabilities,
-- })
-- vim.lsp.enable('angularls')

-- npm i -g vscode-langservers-extracted
vim.lsp.config('html', {
	capabilities = capabilities,
})
vim.lsp.enable('html')

vim.lsp.config('cssls', {
	capabilities = capabilities,
})
vim.lsp.enable('cssls')

-- go install gopls
vim.lsp.config('gopls', {
	capabilities = capabilities,
})
vim.lsp.enable('gopls')


--------------------------------
-- BUILT-IN LSP CONFIGURATION --
--------------------------------
-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
		vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
		vim.keymap.set("n", "<space>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
		vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
		vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
	end,
})