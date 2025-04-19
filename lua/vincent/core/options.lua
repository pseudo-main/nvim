local opt = vim.opt

-- Appearance
opt.relativenumber = true
opt.number = true
opt.signcolumn = "yes"
opt.termguicolors = true

-- Indentation C-like
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = false
opt.smartindent = false

-- Indentation Python
vim.g.python_indent = {
	open_paren = "shiftwidth()",
	nested_paren = "shiftwidth()",
	continue = "shiftwidth()",
	closed_paren_align_last_line = false,
}

-- Text wrapping
opt.wrap = false

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.incsearch = true

-- Clipboard
opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true

-- Splits
opt.splitright = true
opt.splitbelow = true
