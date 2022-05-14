require 'catppuccin'.setup {
	transparent_background = true
}
vim.cmd 'colorscheme catppuccin'
vim.opt.termguicolors = true

vim.opt.cmdheight = 1
vim.opt.cursorline = true
vim.opt.laststatus = 3
vim.opt.list = true
vim.opt.number = true
vim.opt.showtabline = 2
vim.opt.wrap = false

vim.opt.tabstop = 3
vim.opt.shiftwidth = 3

vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldlevelstart = 1
vim.opt.foldnestmax = 1

vim.opt.scrolloff = 6
vim.opt.sidescrolloff = 6
vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.cindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.api.nvim_create_autocmd('BufWritePre', { pattern = '*', command = [[:%s/\s\+$//e]] })
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')
