-----------------------
-- [[ tree plugin ]] --
-----------------------

return {
  "nvim-tree/nvim-tree.lua",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    -- Recommended settings from nvim-tree documentation
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- [[ Configuration ]]
    require("nvim-tree").setup({
      -- View settings
      view = {
        width = 35,
        relativenumber = true
      },

      -- Render settings
      renderer = {
        indent_markers = {
          enable = true,
        },
      },
        
      -- Actions settings
      actions = {
        open_file = {
          window_picker = {
            enable = false,
          },
        },
      },
      
      -- Filter settings
      filters = {
        custom = { ".DS_Store" },
      },

      -- Git settings
      git = {
        ignore = false,
      },
    })

    -- [[ Keymaps ]]
    local set = vim.keymap.set

    set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
    set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" })
    set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" })
    set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" })

  end,
}
