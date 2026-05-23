return {
  -- Native Treesitter Manager
  {
    "romus204/tree-sitter-manager.nvim",
    cmd = { "TSManager", "TSInstall", "TSUpdate", "TSUninstall" },
    config = function()
      require("tree-sitter-manager").setup({
        ensure_installed = { "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "bash", "python", "javascript", "typescript", "tsx", "json", "yaml", "html", "css", "c_sharp" },
        auto_install = true,
      })
    end,
  },
  -- Sticky headers
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufReadPost",
    opts = { mode = "cursor", max_lines = 3 },
  },
  -- Autotag
  {
    "windwp/nvim-ts-autotag",
    event = "BufReadPost",
    opts = {},
  },
  -- Rainbow delimiters
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "BufReadPost",
  },
}
