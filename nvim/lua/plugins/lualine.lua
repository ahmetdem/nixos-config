return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local custom_bg = "#142629"
			local cyber_blue = "#5fffe0"
			local cyber_pink = "#ff5ef1"
			local text_gray = "#707a7c"

			-- Create a custom theme table
			local custom_theme = {
				normal = {
					a = { bg = cyber_blue, fg = "#000000", gui = "bold" },
					b = { bg = "#1e3337", fg = cyber_blue },
					c = { bg = custom_bg, fg = text_gray },
				},
				insert = {
					a = { bg = cyber_pink, fg = "#000000", gui = "bold" },
					b = { bg = "#1e3337", fg = cyber_pink },
					c = { bg = custom_bg, fg = text_gray },
				},
				visual = {
					a = { bg = "#bd5eff", fg = "#000000", gui = "bold" },
					b = { bg = "#1e3337", fg = "#bd5eff" },
					c = { bg = custom_bg, fg = text_gray },
				},
				replace = {
					a = { bg = "#ff5e5e", fg = "#000000", gui = "bold" },
					b = { bg = "#1e3337", fg = "#ff5e5e" },
					c = { bg = custom_bg, fg = text_gray },
				},
				inactive = {
					a = { bg = custom_bg, fg = text_gray },
					b = { bg = custom_bg, fg = text_gray },
					c = { bg = custom_bg, fg = text_gray },
				},
			}

			local function lsp_status()
				local msg = "No LSP"
				local buf_ft = vim.api.nvim_get_option_value("filetype", { buf = 0 })
				local clients = vim.lsp.get_clients({ bufnr = 0 })
				if next(clients) == nil then
					return msg
				end
				for _, client in ipairs(clients) do
					local filetypes = client.config.filetypes
					if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
						return client.name
					end
				end
				return msg
			end

			require("lualine").setup({
				options = {
					theme = custom_theme,
					component_separators = { left = "|", right = "|" },
					section_separators = { left = "", right = "" },
					globalstatus = true,

					disabled_filetypes = {
						statusline = { "alpha" },
					},
				},

				sections = {
					lualine_a = { "mode" },
					lualine_b = { "diagnostics" },
					lualine_c = { { "filename", path = 1 } },
					lualine_x = {
						{ lsp_status, icon = " ", color = { fg = "#5fffe0" }, { "overseer" } },
					},
					lualine_z = { "location" },
				},
			})
		end,
	},
}
