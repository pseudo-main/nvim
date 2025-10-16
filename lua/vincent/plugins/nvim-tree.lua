local utils = require("vincent.core.utils")

-- [[ Functions ]]
-- Toggle git.ignore setting dynamically
local git_ignore = true
function ToggleNvimTreeGitIgnore()
	local view = require("nvim-tree.view")
	local was_open = view.is_visible() -- Check if the tree is open

	git_ignore = not git_ignore

	require("nvim-tree").setup({
		git = {
			enable = true,
			ignore = git_ignore,
		},
	})

	if was_open then
		vim.cmd("NvimTreeOpen") -- Reopen the tree if it was open
	end

	vim.cmd("NvimTreeRefresh")

	vim.notify(
		"Git ignore is now " .. (git_ignore and "ON (hiding ignored files)" or "OFF (showing ignored files)"),
		vim.log.levels.INFO
	)
end

-- [[ Keymaps ]]
utils.map("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
utils.map("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" })
utils.map("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" })
utils.map("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" })
utils.map("n", "<leader>gi", ToggleNvimTreeGitIgnore, { desc = "Toggle Git ignore filtering in NvimTree" })

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

			filters = {},

			git = {
				enable = true,
				ignore = git_ignore,
			},
		})
	end,
}
