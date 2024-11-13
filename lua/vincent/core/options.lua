-------------------
-- [[ Options ]] --
-------------------

local opt = vim.opt

-- [[ Appearance ]]
opt.relativenumber = true
opt.number = true
opt.signcolumn = "yes"
opt.termguicolors = true

-- [[ Formatting ]]
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true
opt.wrap = false

-- [[ Search ]]
opt.ignorecase = true
opt.smartcase = true
opt.cursorline = true

-- [[ Clipboard ]]
opt.clipboard:append("unnamedplus")
opt.swapfile = false

-- [[ Splits ]]
opt.splitright = true
opt.splitbelow = true
