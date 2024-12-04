-- [[ treesitter plugin ]]

return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = { "bash", "json", "lua", "markdown", "python", "rust" },
      highlight = { enable = true },
      indent = { enable = false },
      auto_install = false,
    })
  end,
}
