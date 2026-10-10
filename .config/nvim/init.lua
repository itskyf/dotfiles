vim.opt.tabstop = 4
vim.opt.shiftwidth = 0

vim.opt.autocomplete = true
vim.opt.complete:prepend("o")

vim.pack.add({
	{ src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/ibhagwan/fzf-lua",
	"https://github.com/nvim-treesitter/nvim-treesitter",
})

vim.cmd.colorscheme("catppuccin")

require("fzf-lua").setup({ "skim" })

-- Keep parsers compatible when nvim-treesitter updates.
vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		if ev.data.spec.name == "nvim-treesitter" and ev.data.kind == "update" then
			vim.cmd.TSUpdate()
		end
	end,
})

-- Install parsers automatically when opening new languages.
vim.api.nvim_create_autocmd("FileType", {
	callback = function(ev)
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

		ts.install(lang):await(function(err, ok)
			if
				not err
				and ok
				and vim.api.nvim_buf_is_valid(ev.buf)
				and vim.bo[ev.buf].filetype == ev.match
				and vim.treesitter.language.add(lang)
			then
				vim.treesitter.start(ev.buf)
			end
		end)
	end,
})

vim.lsp.config("emmylua_ls", {
	settings = {
		emmylua = {
			runtime = { version = "LuaJIT" },
			diagnostics = { globals = { "vim" } },
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
		},
	},
})

vim.lsp.enable({ "emmylua_ls", "ty", "ruff", "tombi" })
