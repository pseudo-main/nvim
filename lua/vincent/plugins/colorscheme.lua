-------------------------------
-- [[ Colorscheme Plugins ]] --
-------------------------------

return {
  "catppuccin/nvim",
  name = "catppuccin",  -- Otherwise the name is "nvim" in the plugin overview
  priority = 1000,

  config = function()
    require("catppuccin").setup({
      flavour = "macchiato",
    })

    vim.cmd.colorscheme("catppuccin")
  end,
}
