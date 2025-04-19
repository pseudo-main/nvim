local M = {}

-- General-purpose keymap wrapper
function M.map(mode, lhs, rhs, opts)
	opts = opts or {}
	vim.keymap.set(mode, lhs, rhs, opts)
end

-- Buffer-local keymap wrapper
function M.map_buf(bufnr, mode, lhs, rhs, opts)
	opts = opts or {}
	opts.buffer = bufnr
	vim.keymap.set(mode, lhs, rhs, opts)
end

return M
