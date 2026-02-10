
---@type LazySpec
return {
  "nvimtools/none-ls.nvim",
  opts = function(_, opts)
    local null_ls = require "null-ls"

    opts.sources = require("astrocore").list_insert_unique(opts.sources, {
      -- =====================
      -- FORMATTERS
      -- =====================

      -- C / C++
      null_ls.builtins.formatting.clang_format,

      -- Rust
      null_ls.builtins.formatting.rustfmt,

      -- Python
      null_ls.builtins.formatting.black,
      null_ls.builtins.formatting.isort,

      -- =====================
      -- LINTERS / DIAGNOSTICS
      -- =====================

      -- Python
      null_ls.builtins.diagnostics.ruff,
    })
  end,
}
