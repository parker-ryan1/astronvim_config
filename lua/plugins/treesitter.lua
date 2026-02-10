
---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      -- Core / AstroVim
      "lua",
      "vim",
      "vimdoc",
      "query",

      -- C / C++
      "c",
      "cpp",

      -- Rust
      "rust",

      -- Python
      "python",

      -- Build / config files
      "cmake",
      "toml",
      "yaml",
      "json",

      -- Shell / misc
      "bash",
      "markdown",
      "markdown_inline",
    },

    highlight = {
      enable = true,
    },

    indent = {
      enable = true,
    },
  },
}
