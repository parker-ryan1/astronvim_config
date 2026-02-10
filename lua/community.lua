
---@type LazySpec
return {
  "AstroNvim/astrocommunity",

  -- =====================
  -- CORE COMMUNITY PACKS
  -- =====================
  { import = "astrocommunity.pack.lua" },

  -- =====================
  -- LANGUAGE SUPPORT
  -- =====================

  -- C / C++
  { import = "astrocommunity.pack.cpp" },

  -- Rust
  { import = "astrocommunity.pack.rust" },

  -- Python
  { import = "astrocommunity.pack.python" },

  -- =====================
  -- OPTIONAL (VERY USEFUL)
  -- =====================

  -- Debugging UI & extras
  { import = "astrocommunity.debugging.nvim-dap-virtual-text" },

  -- Better diagnostics list
  { import = "astrocommunity.diagnostics.trouble-nvim" },

  -- Symbol outline
  { import = "astrocommunity.code-outline.aerial-nvim" },
}
