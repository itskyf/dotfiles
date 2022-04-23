vim.cmd 'packadd packer.nvim'

vim.cmd [[
	augroup packer_user_config
		autocmd!
		autocmd BufWritePost plugins.lua source <afile> | PackerSync
	augroup end
]]

return require 'packer'.startup(function(use)
	use { 'wbthomason/packer.nvim', opt = true }
	use 'catppuccin/nvim'

	use 'neovim/nvim-lspconfig'
	use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
	use {
		'jose-elias-alvarez/null-ls.nvim',
		requires = { 'nvim-lua/plenary.nvim' }
	}
	use {
		'nvim-telescope/telescope.nvim',
		requires = 'nvim-lua/plenary.nvim'
	}

	use { 'elkowar/yuck.vim', ft = 'yuck' }
end)
