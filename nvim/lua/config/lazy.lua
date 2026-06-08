-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = {
		{ import = "plugins" },
	},
	ui = {
		icons = {
			cmd = "Cmd",
			config = "Conf",
			event = "Event",
			ft = "Ft",
			init = "Init",
			keys = "Key",
			plugin = "Plugin",
			runtime = "RT",
			require = "Req",
			source = "Src",
			start = "Start",
			task = "Task",
			lazy = "Lazy ",
		},
	},
	checker = { enabled = true, notify = false },
})
