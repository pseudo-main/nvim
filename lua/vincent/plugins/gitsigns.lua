local utils = require("vincent.core.utils")

-- [[ Keymaps ]]
local function set_keymaps(bufnr)
	local gitsigns = require("gitsigns")

	-- Navigation
	utils.map_buf(bufnr, "n", "]c", function()
		if vim.wo.diff then
			vim.cmd.normal({ "]c", bang = true })
		else
			gitsigns.nav_hunk("next")
		end
	end, { desc = "Next git hunk" })

	utils.map_buf(bufnr, "n", "[c", function()
		if vim.wo.diff then
			vim.cmd.normal({ "[c", bang = true })
		else
			gitsigns.nav_hunk("prev")
		end
	end, { desc = "Previous git hunk" })

	-- Hunk
	utils.map_buf(bufnr, "n", "<leader>hs", gitsigns.stage_hunk, { desc = "Stage hunk" })
	utils.map_buf(bufnr, "n", "<leader>hr", gitsigns.reset_hunk, { desc = "Reset hunk" })
	utils.map_buf(bufnr, "n", "<leader>hu", gitsigns.undo_stage_hunk, { desc = "Undo stage hunk" })
	utils.map_buf(bufnr, "n", "<leader>hp", gitsigns.preview_hunk, { desc = "Preview hunk" })

	utils.map_buf(bufnr, "v", "<leader>hs", function()
		gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
	end, { desc = "Stage hunk (visual)" })

	utils.map_buf(bufnr, "v", "<leader>hr", function()
		gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
	end, { desc = "Reset hunk (visual)" })

	-- Buffer
	utils.map_buf(bufnr, "n", "<leader>hS", gitsigns.stage_buffer, { desc = "Stage buffer" })
	utils.map_buf(bufnr, "n", "<leader>hR", gitsigns.reset_buffer, { desc = "Reset buffer" })

	-- Blame
	utils.map_buf(bufnr, "n", "<leader>hb", function()
		gitsigns.blame_line({ full = true })
	end, { desc = "Blame line (full)" })

	utils.map_buf(bufnr, "n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "Toggle line blame" })

	-- Diff
	utils.map_buf(bufnr, "n", "<leader>hd", gitsigns.diffthis, { desc = "Diff against index" })

	utils.map_buf(bufnr, "n", "<leader>hD", function()
		gitsigns.diffthis("~")
	end, { desc = "Diff against last commit" })

	-- Deleted
	utils.map_buf(bufnr, "n", "<leader>td", gitsigns.toggle_deleted, { desc = "Toggle deleted lines" })
end

-- [[ Plugin configuration ]]
return {
	"lewis6991/gitsigns.nvim",

	config = function()
		require("gitsigns").setup({
			on_attach = function(bufnr)
				set_keymaps(bufnr)
			end,
		})
	end,
}
