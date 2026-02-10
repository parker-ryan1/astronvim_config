---@type LazySpec
return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        -- =====================
        -- PYTHON (FIXED)
        -- =====================
        "pyright",
        "ruff",
        "black",
        "isort",
        "debugpy",

        -- =====================
        -- C / C++
        -- =====================
        "clangd",
        "clang-format",
        "codelldb",

        -- =====================
        -- Rust
        -- =====================
        "rust-analyzer",
        "rustfmt",

        -- =====================
        -- Lua
        -- =====================
        "lua-language-server",
        "stylua",

        -- =====================
        -- Misc
        -- =====================
        "tree-sitter-cli",
        "cmake",
      },
      run_on_start = true,
    },
  },
}
