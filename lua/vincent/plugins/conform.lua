-- [[ Plugin conform ]]
--  Settings have mostly been copied from the Github documentation.
return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },

	-- [[ Keymaps ]]
	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({ async = true })
			end,
			mode = "",
			desc = "[f]ormat buffer",
		},
	},

	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "black", "isort", "pylint" },
		},

		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback",
		},

		notify_on_error = true,
	},
}
