return {
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },

    opts = {
      keymaps = {
        ["<C-c>"] = false,
      },
      cleanup_delay_ms = false,
      buf_options = {
        buflisted = true,
        bufhidden = "hide",
      },
    }
  },
}
