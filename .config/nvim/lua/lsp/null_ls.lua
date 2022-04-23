local null_ls = require 'null-ls'

null_ls.setup {
	sources = {
		null_ls.builtins.code_actions.refactoring,
		null_ls.builtins.formatting.trim_newlines,
		null_ls.builtins.formatting.trim_whitespace,
		null_ls.builtins.diagnostics.fish,
		null_ls.builtins.formatting.fish_indent,
		null_ls.builtins.formatting.shfmt,
		null_ls.builtins.diagnostics.yamllint,
		null_ls.builtins.diagnostics.pylint,
		null_ls.builtins.formatting.autopep8,
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.isort
	}
}
