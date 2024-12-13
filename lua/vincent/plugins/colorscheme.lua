-- [[ Colorscheme plugin(s) ]]
--  This holds all my colorscheme plugins.
--  Enable the one you want to use, leave the others commented out.
return {
	{
		-- [[ Plugin catppuccin ]]
		--   Settings have mostly been copied from the Github documentation.
		"catppuccin/nvim",
		name = "catppuccin", -- Otherwise the name is "nvim" in the plugin overview
		priority = 1000,

		config = function()
			require("catppuccin").setup({
				flavour = "macchiato",
			})

			vim.cmd.colorscheme("catppuccin")
		end,
	},
}
