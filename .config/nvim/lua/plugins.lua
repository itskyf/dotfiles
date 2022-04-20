vim.cmd 'packadd packer.nvim'

vim.cmd [[
	augroup packer_user_config
		autocmd!
		autocmd BufWritePost plugins.lua source <afile> | PackerSync
	augroup end
]]

return require('packer').startup(function()
	use { 'wbthomason/packer.nvim', opt = true }

	use 'neovim/nvim-lspconfig'
	use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

	use { 'elkowar/yuck.vim', ft = 'yuck' }
end)
