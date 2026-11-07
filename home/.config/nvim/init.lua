-- Disable netrw to avoid conflicts with nvim-tree.
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Editor options
vim.opt.autocomplete = true
vim.opt.complete:prepend("o")
vim.opt.completeopt:append("noselect")

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 0

vim.opt.termguicolors = true

-- Keep parsers compatible with nvim-treesitter updates.
vim.api.nvim_create_autocmd("PackChanged", {
	callback = function (ev)
		if ev.data.spec.name ~= "nvim-treesitter" then
			return
		end

		if ev.data.kind == "install" or ev.data.kind == "update" then
			vim.cmd.packadd(ev.data.spec.name)
			require("nvim-treesitter").update()
		end
	end
})

-- Plugins
vim.pack.add({
	{ src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/ibhagwan/fzf-lua",
	"https://github.com/nvim-mini/mini.icons",
	"https://github.com/nvim-tree/nvim-tree.lua"
})

-- Appearance
vim.cmd.colorscheme("catppuccin-nvim")
require("mini.icons").setup()

-- Fuzzy finding
local fzf = require("fzf-lua")
fzf.setup({
	[1] = "skim",
	winopts = {
		preview = {
			default = "bat"
		}
	}
})

-- Ctrl-P follows the common Quick Open convention used by many editors.
vim.keymap.set("n", "<C-p>", fzf.global, { desc = "Find files, buffers, symbols" })
vim.keymap.set("n", "<leader>sf", fzf.blines, { desc = "Find lines in buffer" })
vim.keymap.set("n", "<leader>sp", fzf.live_grep, { desc = "Search text in project" })
vim.keymap.set("n", "<leader>sg", fzf.grep_cword, { desc = "Grep word under cursor in project" })
vim.keymap.set("x", "<leader>sg", fzf.grep_visual, { desc = "Grep selection in project" })

-- File tree
require("nvim-tree").setup()
vim.keymap.set("n", "<leader>e", vim.cmd.NvimTreeToggle, { desc = "Toggle file tree" })

-- Install parsers only for opened filetypes.
vim.api.nvim_create_autocmd("FileType", {
	callback = function (ev)
		local lang = vim.treesitter.language.get_lang(ev.match)
		if not lang then
			return
		end

		if vim.treesitter.language.add(lang) then
			vim.treesitter.start(ev.buf)
			return
		end

		local ts = require("nvim-treesitter")
		if not vim.list_contains(ts.get_available(), lang) then
			return
		end

		ts.install(lang):await(function (err, ok)
			if not err and ok and vim.api.nvim_buf_is_valid(ev.buf) and vim.bo[ev.buf].filetype == ev.match
				and vim.treesitter.language.add(lang) then
				vim.treesitter.start(ev.buf)
			end
		end)
	end
})

-- LSP configuration
vim.lsp.config("emmylua_ls", {
	settings = {
		emmylua = {
			runtime = { version = "LuaJIT" },
			diagnostics = { globals = { "vim" } },
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true)
			}
		}
	}
})

vim.lsp.config("mise", {
	init_options = {
		formatting = false,
		hover = false,
		completion = false
	}
})

-- LSP servers
vim.lsp.enable({
	"bashls",
	"biome",
	"docker_language_server",
	"emmylua_ls",
	"fish_lsp",
	"lemminx",
	"mise",
	"ruff",
	"tombi",
	"ty",
	"yamlls"
})
