-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)
keymap("n", "<C-s>", ":w!<cr>")

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)


-- Clear highlights
keymap("n", "<leader>h", "<cmd>nohlsearch<CR>", opts)

-- Close buffers
keymap("n", "<S-q>", "<cmd>Bdelete!<CR>", opts)

-- Better paste
keymap("v", "p", '"_dP', opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Plugins --

-- NvimTree
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- Telescope
keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>ft", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>fp", ":Telescope projects<CR>", opts)
keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)

-- Git
keymap("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", opts)

---- Comment
-- keymap("n", "<leader>/", "<cmd>lua require('mini.comment').toggle_current_linewise()<CR>", opts)
keymap("x", "<leader>/", [[<esc><cmd>lua require("mini.comment").toggle_lines(vim.fn.line("'<"), vim.fn.line("'>"))<cr>]]
, opts)
-- miniature.nvim/lua/miniature/which-key.lua:  ["/"] = { "<cmd>lua require('mini.comment').toggle_lines(vim.fn.line('.'), vim.fn.line('.'))<cr>", "Toggle Comments" },
-- keymap("x", "/", [[<esc><cmd>lua require("mini.comment").toggle_lines(vim.fn.line("'<"), vim.fn.line("'>"))<cr>]], opts)

function GofmtSelected(start_line, end_line)
  if vim.bo.filetype ~= 'go' then
    vim.api.nvim_echo('Current buffer is not a Go source file', true, {})
    return
  end
  local input = table.concat(vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false), "\n")
  local fmtted = vim.fn.system({ 'gofmt' }, input)
  vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, true, vim.split(fmtted, '\n'))
end

keymap("v", "<leader>lf", [[<esc><cmd>lua GofmtSelected(vim.fn.line("'<"), vim.fn.line("'>"))<cr>]],
  { desc = 'Range Format' })

for i = 1, 9 do
  local key = string.format("<A-%s>", i)
  local value = string.format(":BufferLineGoToBuffer %s<CR>", i)
  keymap("n", key, value)
end
vim.cmd [[
  set nofoldenable
]]
vim.api.nvim_create_autocmd("BufNewFile", {
  desc = "make a go test",
  -- group = "packer_conf",
  pattern = "*_test.go",
  command = "0r ~/workspaces/code-templates/test.go",
  -- { "BufNewFile", "*_test.go", "0r ~/workspaces/code-templates/test.go" },
})
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = "go.mod",
  callback = function()
    vim.cmd "set ft=go"
  end,
})
