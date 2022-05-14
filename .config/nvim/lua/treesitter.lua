require 'nvim-treesitter.configs'.setup {
	ensure_installed = {
		'bash',
		'c',
		'cmake',
		'cpp',
		'css',
		'cuda',
		'dockerfile',
		'fish',
		'html',
		'javascript',
		'json5',
		'latex',
		'lua',
		'make',
		'ninja',
		'python',
		'scss',
		'svelte',
		'toml',
		'vim',
		'yaml'
	},
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	indent = { enable = true },
	sync_install = false
}
