vim.cmd 'packadd packer.nvim'

vim.api.nvim_create_augroup('packer_user_config', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
	group = 'packer_user_config',
	pattern = 'plugins.lua',
	command = 'source | PackerSync'
})

return require 'packer'.startup(function(use)
	use { 'wbthomason/packer.nvim', opt = true }
	use { 'catppuccin/nvim', as = 'catppuccin' }

	use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
	use 'lukas-reineke/indent-blankline.nvim'

	use 'neovim/nvim-lspconfig'
	use 'jose-elias-alvarez/null-ls.nvim'

	use { 'nvim-telescope/telescope.nvim', requires = 'nvim-lua/plenary.nvim' }
	use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

	use { 'elkowar/yuck.vim', ft = 'yuck' }
end)
