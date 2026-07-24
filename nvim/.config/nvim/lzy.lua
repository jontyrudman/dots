local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{
		"joshdick/onedark.vim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.g.onedark_hide_endofbuffer = 1
			vim.cmd([[colorscheme onedark]])
		end,
	},
	{ "sheerun/vim-polyglot" },
	{ "neovim/nvim-lspconfig" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-cmdline" },
	{
		"hrsh7th/nvim-cmp",
		event = { "InsertEnter", "CmdlineEnter" },
	},
	{ "hrsh7th/cmp-vsnip" },
	{ "hrsh7th/vim-vsnip" },
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
    opts = {}, -- this is equalent to setup({}) function
	},
	{ "airblade/vim-gitgutter" },
	{ "tpope/vim-commentary" },
	{ "tpope/vim-fugitive" },
	{ "nvim-tree/nvim-tree.lua" },
	{ "sbdchd/neoformat" },
	{ "junegunn/fzf" },
	{ "junegunn/fzf.vim" },
	{
		"itchyny/lightline.vim",
		config = function()
			-- Show repo-relative path in status line within git repos
			function _G.LightlineRelativePath()
				local filename = vim.fn.expand("%:t")
				if filename == "" then
					return ""
				end

				local full_path = vim.fn.expand("%:p")
				-- Return cached result if the file path hasn't changed
				if vim.b.lightline_rel_cache and vim.b.lightline_rel_cache.path == full_path then
					return vim.b.lightline_rel_cache.result
				end

				-- Only run git when the file actually changed
				local ok, result = pcall(vim.fn.system, "git rev-parse --show-prefix 2>/dev/null")
				if not ok or vim.v.shell_error ~= 0 then
					vim.b.lightline_rel_cache = { path = full_path, result = filename }
					return filename
				end
				local relative = result:gsub("\n$", "")
				local final = (relative == "") and filename or (relative .. filename)
				vim.b.lightline_rel_cache = { path = full_path, result = final }
				return final
			end

			vim.g.lightline = {
				colorscheme = "onedark",
				active = {
					left = {
						{ "mode", "paste" },
						{ "git_relative_path", "modified" },
					},
				},
				component_function = {
					git_relative_path = "v:lua.LightlineRelativePath",
				},
			}
		end,
	},
  {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"}
})

vim.keymap.set("n", "<C-p>", ":Files<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-h>", ":Ag<CR>", { noremap = true, silent = true })

require("nvim-tree").setup({
	renderer = {
		icons = {
			show = {
				file = false,
				folder = false,
				folder_arrow = false,
				git = false,
				modified = false,
				diagnostics = false,
				bookmarks = false,
			},
		},
	},
})
