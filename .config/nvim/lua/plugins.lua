return require('packer').startup(function()
	use 'wbthomason/packer.nvim'
	use 'lukas-reineke/indent-blankline.nvim'
	use { 'khaveesh/vim-fish-syntax', ft = 'fish' }
	use { 'elkowar/yuck.vim', ft = 'yuck' }
end)
