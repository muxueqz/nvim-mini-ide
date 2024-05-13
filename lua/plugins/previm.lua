return {
  "muxueqz/previm",
  require = { "folke/which-key.nvim" },
  event = "VeryLazy",
  ft = "markdown",
  config = function()
    vim.g.previm_open_cmd = "xdg-open"
    vim.g.previm_custom_preview_base_dir = "/dev/shm/previm_cache/"
    -- vim.api.nvim_set_keymap("n", "<Space>mp", ":PrevimOpen<cr>", { silent = true })
    -- vim.keymap.set("n", "<leader>mp", ":PrevimOpen<cr>", { silent = true })
    local wk = require("which-key")
    wk.register({
      ["<leader>lp"] = { "<cmd>PrevimOpen<cr>", "Preview markdown" },
    })
    -- vim.keymap.set("n", "<leader>Tm", "<cmd>PrevimOpen<cr>", { silent = true })
    --     -- vim.cmd [[
    --     --   nmap <Space>mp <Plug>MarkdownPreview
    --     -- ]]
  end,
}
