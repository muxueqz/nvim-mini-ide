M = {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    plugins = { spelling = true },
    defaults = {
      mode = { "n", "v" },
      ["g"] = { name = "+goto" },
      ["gs"] = { name = "+surround" },
      ["z"] = { name = "+fold" },
      ["]"] = { name = "+next" },
      ["["] = { name = "+prev" },
      ["<leader><tab>"] = { name = "+tabs" },
      -- ["<leader>a"] = {
      --   name = "+AI",
      --   p = { "<cmd>lua ai_ask('', '')<cr>", "Ask" },
      --   H = { "<cmd>lua ai_history()<cr>", "HistoryAI" },
      --   R = { "<cmd>lua ai_reload()<cr>", "ReloadAI" },
      --   c = { "<cmd>lua ai_change_bot()<cr>", "ChangeAI" },
      --   l = { "<cmd>lua ai_pick_chat()<cr>", "List Chat" },
      --   b = { [[<cmd>:BitoAiGenerate<cr>]], "BitoAiGenerate" },
      --   a = { "<cmd>lua ai_ask_by_claude('', '')<cr>", "Ask Claude" },
      --   h = { "<cmd>lua ai_history_by_claude(10)<cr>", "History Claude" },
      -- },
      ["<leader>b"] = { name = "+buffer" },
      ["<leader>c"] = { name = "+code" },
      ["<leader>f"] = { name = "+file/find" },
      ["<leader>g"] = { name = "+git" },
      ["<leader>gh"] = { name = "+hunks" },
      ["<leader>q"] = { name = "+quit/session" },
      ["<leader>s"] = { name = "+search" },
      ["<leader>u"] = { name = "+ui" },
      ["<leader>w"] = { name = "+windows" },
      ["<leader>x"] = { name = "+diagnostics/quickfix" },
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    wk.register(opts.defaults)
    local ai_mappings = {
      mode = { "n" },
      ["<leader>a"] = {
        name = "+AI",
        p = { "<cmd>lua ai_ask('', '')<cr>", "Ask" },
        H = { "<cmd>lua ai_history()<cr>", "HistoryAI" },
        R = { "<cmd>lua ai_reload()<cr>", "ReloadAI" },
        c = { "<cmd>lua ai_change_bot()<cr>", "ChangeAI" },
        l = { "<cmd>lua ai_pick_chat()<cr>", "List Chat" },
        b = { [[<cmd>:BitoAiGenerate<cr>]], "BitoAiGenerate" },
      },
    }
    wk.register(ai_mappings)
  end,
}
return M
