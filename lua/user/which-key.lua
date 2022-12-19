local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
  b = {
    name = "Buffer",
    c = { [[<cmd>lua require("mini.bufremove").delete()<cr>]], "Close buffer" },
    n = { "<cmd>bnext<cr>", "Next Buffer" },
    p = { "<cmd>bprevious<cr>", "Previous Buffer" },
  },
  c = { [[<cmd>lua require("mini.bufremove").delete()<cr>]], "Close buffer" },
  -- t = {
  --   name = "Trouble",
  --   t = { "<cmd>TroubleToggle<cr>", "Toggle Trouble" },
  --   w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Toggle Workspace Diagnostics" },
  --   d = { "<cmd>TroubleToggle document_diagnostics<cr>", "Toggle Document Diagnostics" },
  --   q = { "<cmd>TroubleToggle quickfix<cr>", "Toggle Quickfix" },
  --   l = { "<cmd>TroubleToggle loclist<cr>", "Toggle Location List" },
  --   r = { "<cmd>TroubleToggle lsp_references<cr>", "Toggle LSP Reference" },
  -- },
  ["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
  ["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
  ["/"] = { "<cmd>lua require('mini.comment').toggle_lines(vim.fn.line('.'), vim.fn.line('.'))<cr>", "Toggle Comments" },
  -- ["s"] = { "<cmd>SymbolsOutline<cr>", "Toggle Symbols Outline" },

  f = {
    name = "Find",
    b = { "<cmd>Telescope buffers <cr>", "Buffers" },
    c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
    C = { "<cmd>Telescope commands<cr>", "Commands" },
    f = { "<cmd>Telescope find_files<cr>", "Files", },
    g = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
    k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
    M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
    p = { "<cmd>Telescope projects<cr>", "Projects" },
    r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
    R = { "<cmd>Telescope registers<cr>", "Registers" },
    t = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },
    T = { "<cmd>Telescope<cr>", "Telescope" },
  },

  p = {
    name = "Packer",
    c = { "<cmd>PackerCompile<cr>", "Compile" },
    i = { "<cmd>PackerInstall<cr>", "Install" },
    s = { "<cmd>PackerSync<cr>", "Sync" },
    S = { "<cmd>PackerStatus<cr>", "Status" },
    u = { "<cmd>PackerUpdate<cr>", "Update" },
  },

  g = {
    name = "Git",
    -- g = { "<cmd>lua require 'neogit'.open({ kind = 'vsplit' })<cr>", "Open Neogit" },
    g = { "<cmd>lua _GITUI_TOGGLE()<cr>", "Open GitUI" },
    j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
    k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
    l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
    s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
    u = {
      "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
      "Undo Stage Hunk",
    },
    o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
    d = {
      "<cmd>Gitsigns diffthis HEAD<cr>",
      "Diff",
    },
    m = { "<cmd>:Git commit %<cr>", "Commit" },
    L = { "<cmd>:Git log --full-history %<cr>", "Log" },
    --
    -- config.mappings.n["<Leader>gg"] = { function() astronvim.toggle_term_cmd "gitui" end, desc = "ToggleTerm gitui" }
  },

  l = {
    name = "LSP",
    a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
    d = {
      "<cmd>Telescope lsp_document_diagnostics<cr>",
      "Document Diagnostics",
    },
    w = {
      "<cmd>Telescope lsp_workspace_diagnostics<cr>",
      "Workspace Diagnostics",
    },
    f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format" },
    i = { "<cmd>LspInfo<cr>", "Info" },
    I = { "<cmd>Mason<cr>", "Installer Info" },
    j = {
      "<cmd>lua vim.diagnostic.goto_next()<CR>",
      "Next Diagnostic",
    },
    k = {
      "<cmd>lua vim.diagnostic.goto_prev()<cr>",
      "Prev Diagnostic",
    },
    l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
    q = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Quickfix" },
    r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
    s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
    S = {
      "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
      "Workspace Symbols",
    },
  },

  C = {
    name = "GoTools",
    i = { "<cmd>GoInstallDeps<Cr>", "Install Go Dependencies" },
    t = { "<cmd>GoMod tidy<cr>", "Tidy" },
    a = { "<cmd>GoTestAdd<Cr>", "Add Test" },
    A = { "<cmd>GoTestsAll<Cr>", "Add All Tests" },
    e = { "<cmd>GoTestsExp<Cr>", "Add Exported Tests" },
    g = { "<cmd>GoGenerate<Cr>", "Go Generate" },
    f = { "<cmd>GoGenerate %<Cr>", "Go Generate File" },
    c = { "<cmd>GoCmt<Cr>", "Generate Comment" },
    E = { "<cmd>GoIfErr<Cr>", "Generate IfErr" },
    T = { "<cmd>GoTagAdd json<CR>", "Modify struct tags" },
    I = { "<cmd>GoImpl<CR>", "Interface implementation" },
  },
  -- T = {
  --   name = "Terminal",
  --   -- n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" },
  --   -- p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
  --   f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
  --   h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
  --   v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
  -- },

  w = {
    name = "Window",
    s = { "<cmd>split<cr>", "Split" },
    v = { "<cmd>vsplit<cr>", "VSplit" },
  },
  -- DAP
  d = {
    name = "Debug",
    R = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run to Cursor" },
    E = { "<cmd>lua require'dapui'.eval(vim.fn.input '[Expression] > ')<cr>", "Evaluate Input" },
    C = { "<cmd>lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<cr>", "Conditional Breakpoint" },
    U = { "<cmd>lua require'dapui'.toggle()<cr>", "Toggle UI" },
    b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
    c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
    d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
    e = { "<cmd>lua require'dapui'.eval()<cr>", "Evaluate" },
    g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
    h = { "<cmd>lua require'dap.ui.widgets'.hover()<cr>", "Hover Variables" },
    S = { "<cmd>lua require'dap.ui.widgets'.scopes()<cr>", "Scopes" },
    i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
    o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
    p = { "<cmd>lua require'dap'.pause.toggle()<cr>", "Pause" },
    q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
    r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
    s = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
    t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
    T = { "<cmd>lua require('dap-go').debug_test()<cr>", "Run This Test" },
    x = { "<cmd>lua require'dap'.terminate()<cr>", "Terminate" },
    u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
  },


  -- keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
  -- keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", opts)
  -- keymap("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", opts)
  -- keymap("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", opts)
  -- keymap("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", opts)
  -- keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", opts)
  -- keymap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", opts)
  -- keymap("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", opts)
  -- keymap("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", opts)
}

which_key.setup()
which_key.register(mappings, opts)
which_key.register({
  ["<F5>"] = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
  ["<F10>"] = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
  ["<F11>"] = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },

  -- F23 = Shift + F11
  ["<F23>"] = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
})
