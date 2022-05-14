local telescope = require 'telescope'
telescope.setup {
	pickers = {
		find_files = { theme = 'dropdown', previewer = false },
		live_grep = { theme = 'ivy' }
	}
}
telescope.load_extension 'fzf'

local builtin = require 'telescope.builtin'
vim.keymap.set('n', '<leader>ff', builtin.find_files)
vim.keymap.set('n', '<leader>fg', builtin.live_grep)
vim.keymap.set('n', '<leader>fb', builtin.buffers)
vim.keymap.set('n', '<leader>fh', builtin.help_tags)
