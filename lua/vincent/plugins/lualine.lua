--------------------------
-- [[ lualine plugin ]] --
--------------------------

return {
  "nvim-lualine/lualine.nvim",

  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "AndreM222/copilot-lualine",
  },

  -- [[ Configuration ]]
  config = function()
    require("lualine").setup({
      -- Sections
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { "encodig", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },

      -- Inactive sections
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },

      -- Disabled filetypes
      disabled_filetypes = {
        "NvimTree",
      },

      -- Extensions
      extensions = {
        "nvim-tree",
      },
    })
  end,
}
