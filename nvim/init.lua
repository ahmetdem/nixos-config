require("config.options")
require("config.keymaps")
require("config.lazy")

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank({
			higroup = "IncSearch",
			timeout = 150,
		})
	end,
})

vim.api.nvim_create_autocmd("DirChanged", {
	callback = function()
		local cwd = vim.fn.getcwd()
		local osc7 = string.format("\27]7;file://%s%s\27\\", vim.fn.hostname(), cwd)
		io.stdout:write(osc7)
	end,
})

local function copy_file_to_clipboard()
  local filepath = vim.fn.expand('%:p')
  if filepath == '' then
    print('No file name')
    return
  end
  -- For Wayland (GNOME)
  vim.fn.jobstart({'wl-copy', '--type', 'text/uri-list', 'file://' .. filepath})
end

vim.keymap.set('n', '<leader>cp', copy_file_to_clipboard)
