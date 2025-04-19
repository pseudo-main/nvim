-- [[ Keymaps ]]
local keymaps = {
	{
		"<leader>f",
		function()
			require("conform").format({ async = true })
		end,
		mode = "",
		desc = "[f]ormat buffer",
	},
}

-- [[ Plugin configuration ]]
return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = keymaps,

	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "ruff_fix", "ruff_format" },
		},

		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback",
		},

		notify_on_error = true,
	},
}
