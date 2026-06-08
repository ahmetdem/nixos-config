return {
	{
		"seblyng/roslyn.nvim",
		ft = "cs",
		config = function()
			require("roslyn").setup({
				-- This points to the Mason-installed binary
				exe = vim.fn.stdpath("data") .. "/mason/bin/roslyn",
				args = {
					"--logLevel=Information",
					"--extensionLogDirectory=" .. vim.fs.dirname(vim.lsp.get_log_path()),
				},
			})
		end,
	},
}
