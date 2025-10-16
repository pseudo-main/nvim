local utils = require("vincent.core.utils")

-- [[ Plugin configuration ]]
return {
	"NeogitOrg/neogit",

	dependencies = {
		"nvim-lua/plenary.nvim",
		"sindrets/diffview.nvim",
		"nvim-telescope/telescope.nvim",
	},

	config = function()
		require("neogit").setup({
			kind = "split",
			utils.map("n", "<leader>G", "<cmd>Neogit<CR>", { desc = "Open Neogit" }),

			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "NeogitStatus" },
				callback = function()
					vim.opt_local.colorcolumn = ""
				end,
			}),
		})
	end,
}
