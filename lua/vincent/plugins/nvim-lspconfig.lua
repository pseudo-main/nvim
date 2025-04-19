local utils = require("vincent.core.utils")
local telescope = require("telescope.builtin")

-- [[ Keymaps ]]
local keymaps = {
	{
		mode = "n",
		lhs = "<leader>gd",
		rhs = telescope.lsp_definitions,
		opts = { desc = "[G]o to [d]efinition" },
	},
	{
		mode = "n",
		lhs = "<leader>gr",
		rhs = telescope.lsp_references,
		opts = { desc = "[G]o to [r]eferences" },
	},
	{
		mode = "n",
		lhs = "<leader>gi",
		rhs = telescope.lsp_implementations,
		opts = { desc = "[G]o to [i]mplementation" },
	},
	{
		mode = "n",
		lhs = "<leader>gt",
		rhs = telescope.lsp_implementations,
		opts = { desc = "[G]o to [t]ype" },
	},
	{
		mode = "n",
		lhs = "<leader>sd",
		rhs = telescope.lsp_document_symbols,
		opts = { desc = "Find [s]ymbols in [d]ocument" },
	},
	{
		mode = "n",
		lhs = "<leader>sw",
		rhs = telescope.lsp_workspace_symbols,
		opts = { desc = "Find [s]ymbols in [w]orkspace" },
	},
	{
		mode = "n",
		lhs = "<leader>sr",
		rhs = vim.lsp.buf.rename,
		opts = { desc = "[S]ymbol [r]ename" },
	},
}

-- [[ Plugins lspconfig, mason, mason-lspconfig, mason-tool-installer, cmp-nvim-lsp ]]
return {
	"neovim/nvim-lspconfig",

	dependencies = {
		{
			"folke/lazydev.nvim",

			-- Recommended settings from lazydev documentation
			ft = "lua",
			opts = {
				library = {
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				},
			},
		},

		{
			"Bilal2453/luvit-meta",
			lazy = true,
		},

		"williamboman/mason.nvim", -- External editor tooling integration manager (LSPs, DAPs, linting, formatters)
		"williamboman/mason-lspconfig.nvim", -- Simplify integration between nvim-lspconfig and mason
		"WhoIsSethDaniel/mason-tool-installer.nvim", -- External editor tooling installation manager
		"hrsh7th/cmp-nvim-lsp", -- Extra capabilities provided by nvim-cmp
	},

	config = function()
		-- Run this function when LSP attaches to buffer
		vim.api.nvim_create_autocmd("LSPAttach", {
			group = vim.api.nvim_create_augroup("user-lsp-config", { clear = true }),

			callback = function(event)
				for _, keymap in ipairs(keymaps) do
					utils.map_buf(event.buf, keymap.mode, keymap.lhs, keymap.rhs, keymap.opts)
				end

				-- Hover highlight
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
					local highlight_augroup = vim.api.nvim_create_augroup("user-lsp-hover-highlight", { clear = false })

					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.document_highlight,
					})

					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.clear_references,
					})

					vim.api.nvim_create_autocmd("LspDetach", {
						group = vim.api.nvim_create_augroup("user-lsp-detach", { clear = true }),
						callback = function(event2)
							vim.lsp.buf.clear_references()
							vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-hover-highlight", buffer = event2.buf })
						end,
					})
				end
			end,
		})

		-- Required to broadcast additional capabilities to LSP servers
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

		-- [[ LSP servers configurations ]]
		local servers = {
			lua_ls = {
				settings = {
					Lua = {
						completion = {
							callSnippet = "Replace",
						},

						diagnostics = {
							disable = {
								"missing-fields",
							},
						},
					},
				},
			},

			pyright = {},
		}

		-- [[ Tool installations ]]
		-- Add additional stylers to install
		local ensure_installed = vim.tbl_keys(servers)
		vim.list_extend(ensure_installed, {
			"stylua",
			"ruff",
		})

		-- Install all tools
		require("mason").setup()
		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
		require("mason-lspconfig").setup({
			handlers = {
				function(server_name)
					local server = servers[server_name] or {}
					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
					require("lspconfig")[server_name].setup(server)
				end,
			},
		})
	end,
}
