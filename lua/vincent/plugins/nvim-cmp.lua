-- [[ Keymaps ]]
local keymaps = {
	["<C-j>"] = { action = "select_next_item" },
	["<C-k>"] = { action = "select_prev_item" },
	["<C-b>"] = { action = "scroll_docs", args = -4 },
	["<C-f>"] = { action = "scroll_docs", args = 4 },
	["<C-y>"] = { action = "confirm", args = { select = true } },
	["<C-Space>"] = { action = "complete", args = {} },

	["<C-l>"] = {
		fn = function(luasnip)
			return function()
				if luasnip.expand_or_locally_jumpable() then
					luasnip.expand_or_jump()
				end
			end
		end,
		modes = { "i", "s" },
	},

	["<C-h>"] = {
		fn = function(luasnip)
			return function()
				if luasnip.locally_jumpable(-1) then
					luasnip.jump(-1)
				end
			end
		end,
		modes = { "i", "s" },
	},
}

-- [[ Plugin configuration ]]
return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",

	dependencies = {
		{
			"L3MON4D3/LuaSnip",
			build = (function()
				if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
					return
				end
				return "make install_jsregexp"
			end)(),
		},
		"saadparwaiz1/cmp_luasnip",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-path",
	},

	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		luasnip.config.setup({})

		local mappings = {}
		for key, map in pairs(keymaps) do
			if map.fn then
				mappings[key] = cmp.mapping(map.fn(luasnip), map.modes)
			else
				local args = map.args or {}
				mappings[key] = cmp.mapping[map.action](args)
			end
		end

		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			completion = { completeopt = "menu,menuone,noinsert" },
			mapping = cmp.mapping.preset.insert(mappings),
			sources = {
				{ name = "lazydev", group_index = 0 },
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "path" },
			},
		})
	end,
}
