local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
  git = {
    cmd = 'git', -- The base command for git operations
    subcommands = { -- Format strings for git subcommands
      update         = 'pull --ff-only --progress --rebase=false',
      install        = 'clone --depth %i --no-single-branch --progress',
      -- install        = 'clone --depth 1 --no-single-branch --progress',
      fetch          = 'fetch --depth 10 --progress',
      checkout       = 'checkout %s --',
      update_branch  = 'merge --ff-only @{u}',
      current_branch = 'branch --show-current',
      diff           = 'log --color=never --pretty=format:FMT --no-show-signature HEAD@{1}...HEAD',
      diff_fmt       = '%%h %%s (%%cr)',
      get_rev        = 'rev-parse --short HEAD',
      get_msg        = 'log --color=never --pretty=format:FMT --no-show-signature HEAD -n 1',
      submodules     = 'submodule update --init --recursive --progress'
    },
    depth = 1, -- Git clone depth
    clone_timeout = 600, -- Timeout, in seconds, for git clones
    default_url_format = 'https://github.com/%s' -- Lua format string used for "aaa/bbb" style plugins
    -- default_url_format = 'https://gitclone.com/github.com/%s' -- Lua format string used for "aaa/bbb" style plugins
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use { 'echasnovski/mini.nvim', branch = 'stable',
  }

  use { "wbthomason/packer.nvim", commit = "00ec5adef58c5ff9a07f11f45903b9dbbaa1b422" } -- Have packer manage itself
  use { "nvim-lua/plenary.nvim", commit = "968a4b9afec0c633bc369662e78f8c5db0eba249" } -- Useful lua functions used by lots of plugins
  use { "kyazdani42/nvim-web-devicons", commit = "8d2c5337f0a2d0a17de8e751876eeb192b32310e" }
  use { "kyazdani42/nvim-tree.lua", commit = "bdb6d4a25410da35bbf7ce0dbdaa8d60432bc243" }
  use { "akinsho/bufferline.nvim", commit = "c78b3ecf9539a719828bca82fc7ddb9b3ba0c353" }
  use { "akinsho/toggleterm.nvim", commit = "aaeed9e02167c5e8f00f25156895a6fd95403af8" }
  use { "ahmedkhalf/project.nvim", commit = "541115e762764bc44d7d3bf501b6e367842d3d4f" }
  use { "lewis6991/impatient.nvim", commit = "969f2c5c90457612c09cf2a13fee1adaa986d350" }

  -- Colorschemes
  use { 'navarasu/onedark.nvim', }

  -- cmp plugins
  use { "hrsh7th/nvim-cmp", commit = "df6734aa018d6feb4d76ba6bda94b1aeac2b378a" } -- The completion plugin
  use { "hrsh7th/cmp-buffer", commit = "62fc67a2b0205136bc3e312664624ba2ab4a9323" } -- buffer completions
  use { "hrsh7th/cmp-path", commit = "466b6b8270f7ba89abd59f402c73f63c7331ff6e" } -- path completions
  use { "saadparwaiz1/cmp_luasnip", commit = "a9de941bcbda508d0a45d28ae366bb3f08db2e36" } -- snippet completions
  use { "hrsh7th/cmp-nvim-lsp", commit = "affe808a5c56b71630f17aa7c38e15c59fd648a8" }
  use { "hrsh7th/cmp-nvim-lua", commit = "d276254e7198ab7d00f117e88e223b4bd8c02d21" }

  -- snippets
  use { "L3MON4D3/LuaSnip", commit = "79b2019c68a2ff5ae4d732d50746c901dd45603a" } --snippet engine
  use { "rafamadriz/friendly-snippets", commit = "d27a83a363e61009278b6598703a763ce9c8e617" } -- a bunch of snippets to use

  -- LSP
  use { "neovim/nvim-lspconfig", commit = "148c99bd09b44cf3605151a06869f6b4d4c24455" } -- enable LSP
  -- use { "williamboman/nvim-lsp-installer", commit = "e9f13d7acaa60aff91c58b923002228668c8c9e6" } -- simple to use language server installer

  use { "williamboman/mason.nvim", config = function()
    require("mason").setup()
  end }
  use { "williamboman/mason-lspconfig.nvim", }
  --   use {
  --     "williamboman/mason.nvim",
  --     "williamboman/mason-lspconfig.nvim",
  --     "neovim/nvim-lspconfig",
  -- config = function ()
  --       require("mason").setup()
  -- require("mason-lspconfig").setup()
  --   end
  -- }

  use { "jose-elias-alvarez/null-ls.nvim", commit = "ff40739e5be6581899b43385997e39eecdbf9465" } -- for formatters and linters
  use { "RRethy/vim-illuminate", commit = "c82e6d04f27a41d7fdcad9be0bce5bb59fcb78e5" }

  -- Telescope
  use { "nvim-telescope/telescope.nvim", commit = "d96eaa914aab6cfc4adccb34af421bdd496468b0" }

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    commit = "518e27589c0463af15463c9d675c65e464efc2fe",
  }

  -- Git
  use { "lewis6991/gitsigns.nvim", commit = "c18e016864c92ecf9775abea1baaa161c28082c3" }

  -- DAP
  -- use { "mfussenegger/nvim-dap", commit = "014ebd53612cfd42ac8c131e6cec7c194572f21d" }
  use { "mfussenegger/nvim-dap", }
  use { "leoluz/nvim-dap-go", }
  use { "rcarriga/nvim-dap-ui", commit = "d76d6594374fb54abf2d94d6a320f3fd6e9bb2f7" }

  use { "folke/which-key.nvim", }
  use {
    "preservim/vim-markdown",
    ft = "markdown",
    config = function()
      vim.g.vim_markdown_auto_insert_bullets = 1
      vim.g.vim_markdown_new_list_item_indent = 1
    end,
  }
  use {
    "tpope/vim-fugitive",
    cmd = {
      "G",
      "Git",
      "Gdiffsplit",
      "Gread",
      "Gwrite",
      "Ggrep",
      "GMove",
      "GDelete",
      "GBrowse",
      "GRemove",
      "GRename",
      "Glgrep",
      "Gedit"
    },
    ft = { "fugitive" }
  }
  use {
    "wsdjeg/vim-nim",
    ft = "nim",
    config = function()
      vim.g.nvim_nim_enable_default_binds = 0
      local opts = { cmd = {
        "nimlsp",
        "/data/work/projects/nim-src/",
      } }
      -- local opts = {cmd={
      --     "/dev/shm/temp-workspaces/langserver/nimls",
      --   }}
      require("lspconfig")["nimls"].setup(opts)
      vim.api.nvim_set_keymap("n", "gd", ":lua vim.lsp.buf.definition()<cr>", { silent = true })
      vim.api.nvim_set_keymap("n", "gr", ":lua vim.lsp.buf.references()<cr>", { silent = true })
      vim.api.nvim_set_keymap("n", "K", ":lua vim.lsp.buf.hover()<cr>", { silent = true })
      vim.api.nvim_set_keymap("n", "gi", ":lua vim.lsp.buf.implementation()<cr>", { silent = true })
      -- vim.api.nvim_set_keymap("n", "gr", ":Telescope lsp_references<cr>", { silent = true })
    end,
  }
  -- use {
  --   "phaazon/hop.nvim",
  --   event = "BufRead",
  --   config = function()
  --     require("hop").setup()
  --     vim.api.nvim_set_keymap("n", "s", ":HopChar2<cr>", { silent = true })
  --     vim.api.nvim_set_keymap("n", "f", ":HopWord<cr>", { silent = true })
  --   end,
  -- }
  use {
    "muxueqz/previm",
    require = { "folke/which-key.nvim", },
    ft = "markdown",
    config = function()
      vim.g.previm_open_cmd = 'xdg-open'
      vim.g.previm_custom_preview_base_dir = '/dev/shm/previm_cache/'
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
  -- use {
  --   "folke/trouble.nvim",
  --   cmd = "TroubleToggle",
  --   -- config = function()
  --   --   require("miniature.diag")
  --   -- end
  -- }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
