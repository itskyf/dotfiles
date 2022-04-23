require 'nvim-treesitter.configs'.setup {
	ensure_installed = { 'fish', 'lua', 'python', 'yaml' },
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	indent = { enable = true },
	sync_install = false
}
