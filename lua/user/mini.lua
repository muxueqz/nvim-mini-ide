require("mini.comment").setup()
require("mini.starter").setup({ header = [[
                               __
  ___     ___    ___   __  __ /\_\    ___ ___
 / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\
/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \
\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\
 \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]]
})
-- require("mini.starter").setup()
require("mini.pairs").setup()
require("mini.statusline").setup()
require("mini.jump2d").setup({
  -- spotter = MiniJump2d.gen_pattern_spotter('[，？；。！：、《》（）%p]'),
  -- mappings = {
  --   start_jumping = 'f',
  -- },
  allowed_lines = {
    blank = false, -- Blank line (not sent to spotter even if `true`)
    cursor_before = true, -- Lines before cursor line
    cursor_at = true, -- Cursor line
    cursor_after = true, -- Lines after cursor line
    fold = true, -- Start of fold (not sent to spotter even if `true`)
  },
  -- Which windows from current tabpage are used for visible lines
  allowed_windows = {
    current = true,
    not_current = false,
  },
})
-- vim.api.nvim_set_keymap("n", "f",
--   ":lua MiniJump2d.start(MiniJump2d.builtin_opts.word_start)<cr>", { silent = true })
vim.api.nvim_set_keymap("n", "f",
  ":lua MiniJump2d.start({spotter = MiniJump2d.gen_pattern_spotter('[，？；。！：、《》（）%p%w]')})<cr>"
  , { silent = true })
-- vim.api.nvim_set_keymap("n", "f",
--   ":lua MiniJump2d.start()<cr>", { silent = true })

require("mini.indentscope").setup()
-- require("mini.tabline").setup()
