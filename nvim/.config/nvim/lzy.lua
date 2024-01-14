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
			vim.g.lightline = {
				colorscheme = "onedark",
			}
		end,
	},
  {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"}
})

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
