vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	local function print_workspace_folders()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end

	-- Mappings.
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = true })
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = true })
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = true })
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { buffer = true })
	vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { buffer = true })
	vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, { buffer = true })
	vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, { buffer = true })
	vim.keymap.set('n', '<space>wl', print_workspace_folders, { buffer = true })
	vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, { buffer = true })
	vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, { buffer = true })
	vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, { buffer = true })
	vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = true })
	vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, { buffer = true })
end

local lspconfig = require 'lspconfig'
local servers = { 'bashls', 'pyright', 'sumneko_lua', 'yamlls' }
for _, lsp in pairs(servers) do
	local status_ok, settings = pcall(require, 'lsp.' .. lsp)
	if status_ok then
		lspconfig[lsp].setup { on_attach = on_attach, settings = settings }
	else
		lspconfig[lsp].setup { on_attach = on_attach }
	end
end

require 'lsp.null_ls'
