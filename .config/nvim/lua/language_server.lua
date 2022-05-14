vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	local function print_workspace_folders()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end

	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = bufnr })
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr })
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr })
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { buffer = bufnr })
	vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { buffer = bufnr })
	vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, { buffer = bufnr })
	vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, { buffer = bufnr })
	vim.keymap.set('n', '<space>wl', print_workspace_folders, { buffer = bufnr })
	vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, { buffer = bufnr })
	vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, { buffer = bufnr })
	vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, { buffer = bufnr })
	vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = bufnr })
	vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, { buffer = bufnr })
end

local lspconfig = require 'lspconfig'
local servers = {
	'clangd',
	'dockerls',
	'pyright',
	'taplo',
	'texlab',
	'yamlls'
}
for _, lsp in pairs(servers) do
	lspconfig[lsp].setup { on_attach = on_attach }
end

servers = { 'cssls', 'html', 'jsonls' }
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
for _, lsp in pairs(servers) do
	lspconfig[lsp].setup { on_attach = on_attach, capabilities = capabilities }
end

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')
lspconfig.sumneko_lua.setup {
	on_attach = on_attach,
	settings = {
		Lua = {
			runtime = {
				version = 'LuaJIT',
				path = runtime_path
			},
			-- Get the language server to recognize the 'vim' global
			diagnostics = { globals = { 'vim' } },
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file('', true),
			}
		}
	}
}
