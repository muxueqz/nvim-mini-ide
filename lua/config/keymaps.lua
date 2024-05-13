-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
--
-- use `vim.keymap.set` instead
--local map = LazyVim.safe_keymap_set
local map = vim.keymap.set
-- --  AI
-- map("n", "<leader>al", "<cmd>lua ai_pick_chat()<cr>", { desc = "List Chat" })
--

map("x", "<leader>p", [[<esc><cmd>lua ai_ask(vim.fn.line("'<"), vim.fn.line("'>"))<cr>]], { desc = "Ask AI" })
map("x", "<leader>ab", [[<esc><cmd>lua ai_ask_bybito(vim.fn.line("'<"), vim.fn.line("'>"))<cr>]], { desc = "Ask Bito" })
-- vim.keymap.del('n', 'lhs')

-- vim.keymap.del({ "x" }, "<leader>b", {})
-- vim.keymap.del("x", "<leader>b")
map("x", "<leader>ab", [[<cmd>lua ai_ask_bybito(vim.fn.line("'<"), vim.fn.line("'>"))<cr>]], { desc = "Ask Bito" })

local lazyterm = function()
  LazyVim.terminal(nil, { cwd = LazyVim.root() })
end
vim.keymap.del("n", "<c-/>")
vim.keymap.del("t", "<C-/>")
map("n", "<c-t>", lazyterm, { desc = "Terminal (Root Dir)" })
map("t", "<C-t>", "<cmd>close<cr>", { desc = "Hide Terminal" })

for i = 1, 9 do
  local key = string.format("<A-%s>", i)
  local value = string.format(":BufferLineGoToBuffer %s<CR>", i)
  map("n", key, value)
end
