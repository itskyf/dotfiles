local null_ls = require 'null-ls'
null_ls.setup {
	sources = {
		-- General
		null_ls.builtins.code_actions.gitsigns,
		null_ls.builtins.code_actions.refactoring,
		-- C++
		null_ls.builtins.diagnostics.cppcheck,
		null_ls.builtins.formatting.cmake_format,
		-- Configuration
		null_ls.builtins.diagnostics.yamllint,
		null_ls.builtins.formatting.taplo,
		-- Markdown
		null_ls.builtins.diagnostics.markdownlint,
		null_ls.builtins.formatting.markdownlint,
		-- Python
		null_ls.builtins.diagnostics.pyproject_flake8,
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.isort,
		-- Shell
		null_ls.builtins.code_actions.shellcheck,
		null_ls.builtins.diagnostics.fish,
		null_ls.builtins.diagnostics.shellcheck,
		null_ls.builtins.formatting.shfmt,
	}
}
