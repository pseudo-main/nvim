-- [[ Plugins lspconfig, mason, mason-lspconfig, mason-tool-installer, cmp-nvim-lsp ]]
--  Settings have mostly been copied from the kickstart.nvim Github documentation.
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
				-- [[ Utilities for keymaps ]]
				-- Helper function to easily define mappings
				local map = function(keys, func, desc, mode)
					mode = mode or "n"
					vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end

				-- [[ Keymaps ]]
				-- "Go to" keymaps
				map("<leader>gd", require("telescope.builtin").lsp_definitions, "[g]o to [d]efinition")
				map("<leader>gr", require("telescope.builtin").lsp_references, "[g]o to [r]eferences")
				map("<leader>gi", require("telescope.builtin").lsp_implementations, "[g]o to [i]mplementation")
				map("<leader>gt", require("telescope.builtin").lsp_implementations, "[g]o to [t]ype")

				-- "Find" keymaps
				map("<leader>sd", require("telescope.builtin").lsp_document_symbols, "find [s]ymbols in [d]ocument")
				map("<leader>sw", require("telescope.builtin").lsp_workspace_symbols, "find [s]ymbols in [w]orkspace")

				-- "Other" keymaps
				map("<leader>sr", vim.lsp.buf.rename, "[s]ymbol [r]ename")

				-- [[ Other ]]
				-- "Hover highlight" function
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
			"black",
			"isort",
			"pylint",
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
