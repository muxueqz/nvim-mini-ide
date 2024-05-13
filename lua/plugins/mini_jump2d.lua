return {
  "echasnovski/mini.jump2d",
  version = "*",
  event = "VeryLazy",
  config = function()
    require("mini.jump2d").setup({
      -- spotter = MiniJump2d.gen_pattern_spotter("[，？；。！：、《》（）%p]"),
      -- mappings = {
      --   start_jumping = "f",
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
      -- mappings = {
      --   start_jumping = "f",
      -- },

      -- Functions to be executed at certain events
      -- hooks = {
      --   before_start = nil, -- Before jump start
      --   after_jump = nil, -- After jump was actually done
      -- },
    })
    -- vim.api.nvim_set_keymap("n", "f",
    --   ":lua MiniJump2d.start(MiniJump2d.builtin_opts.word_start)<cr>", { silent = true })
    --
    --
    vim.keymap.del("n", "f")
    vim.keymap.set(
      "n",
      -- "<cr>",
      "f",
      -- ":lua MiniJump2d.start({spotter = MiniJump2d.gen_pattern_spotter('[，？；。！：、《》（）%p%w]')})<cr>"
      -- ":lua MiniJump2d.start({spotter = MiniJump2d.gen_pattern_spotter('[^，？；。！：、《》（）%p%w]')})<cr>"
      ":lua MiniJump2d.start({spotter = MiniJump2d.gen_pattern_spotter('[^，？；。！：、《》（）%s%p]+')})<cr>",
      -- MiniJump2d.gen_pattern_spotter('[^%s%p]+')
      { silent = true }
    )
    -- vim.api.nvim_set_keymap("n", "f",
    --   ":lua MiniJump2d.start()<cr>", { silent = true })
  end,
}
