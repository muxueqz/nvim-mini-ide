local vimgrep_arguments = vim.fn.expand("$HOME/.config/nvim/lua/config/vimgrep.lua")

return {
  "nvim-telescope/telescope.nvim",
  keys = {
    -- disable the keymap to grep files
    { "<leader>/", false },
    { "<leader>fs", LazyVim.telescope("live_grep"), desc = "Grep" },
  },
  opts = {
    defaults = {
      vimgrep_arguments = { vimgrep_arguments },
    },
  },
}
