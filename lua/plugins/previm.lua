return {
  "muxueqz/previm",
  require = { "folke/which-key.nvim" },
  event = "VeryLazy",
  ft = "markdown",
  config = function()
    -- vim.g.previm_open_cmd = "xdg-open"
    vim.g.previm_open_cmd = "x-www-browser"
    vim.g.previm_custom_preview_base_dir = "/dev/shm/previm_cache/"
    vim.keymap.set("n", "<leader>cp", ":PrevimOpen<cr>", { desc = "Preview Markdown", silent = true })
  end,
}
