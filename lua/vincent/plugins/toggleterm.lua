return {
	"akinsho/toggleterm.nvim",
	version = "*",

	config = function()
		require("toggleterm").setup({
			size = 20,
			direction = "horizontal",
			start_in_insert = true,
			close_on_exit = false,
			open_mapping = [[<C-\>]],

			vim.api.nvim_create_autocmd("TermOpen", {
				pattern = "*",
				callback = function()
					vim.opt_local.colorcolumn = ""
				end,
			}),
		})
	end,
}
