local utils = require("vincent.core.utils")

-- [[ Keymaps ]]
utils.map("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
utils.map("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" })
utils.map("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" })
utils.map("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" })

-- [[ Plugin configuration ]]
return {
	"nvim-tree/nvim-tree.lua",

	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},

	config = function()
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		require("nvim-tree").setup({
			view = {
				width = 35,
				relativenumber = true,
			},

			renderer = {
				indent_markers = {
					enable = true,
				},
			},

			actions = {
				open_file = {
					window_picker = {
						enable = false,
					},
				},
			},

			filters = {
				custom = { ".DS_Store" },
			},

			git = {
				ignore = false,
			},
		})
	end,
}
