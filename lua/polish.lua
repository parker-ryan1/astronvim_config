-- Auto-format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.cpp", "*.c", "*.h", "*.hpp", "*.rs", "*.py" },
  callback = function() vim.lsp.buf.format { timeout_ms = 2000 } end,
})

-- Better diagnostics popup
vim.diagnostic.config {
  float = {
    border = "rounded",
  },
}

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function() vim.highlight.on_yank { timeout = 200 } end,
})
