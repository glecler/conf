-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

  { "nvim-lua/plenary.nvim" },

  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

  { "neovim/nvim-lspconfig" },

  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },

  { "L3MON4D3/LuaSnip" },
  { "saadparwaiz1/cmp_luasnip" },

  { "nvim-telescope/telescope.nvim" },

  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        view = { width = 30 },
        update_focused_file = { enable = true },
      })
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  { "folke/which-key.nvim" },
  { "voldikss/vim-floaterm" },
  { "tpope/vim-fugitive" },
  { "lewis6991/gitsigns.nvim" },

  { "slugbyte/lackluster.nvim" },
})

-- theme
require("lackluster").setup({
  tweak_background = {
    normal = "none",
    telescope = "default",
    menu = "default",
    popup = "default",
  },
})
vim.cmd("colorscheme lackluster")

require("lualine").setup({
  options = { theme = "lackluster" },
})

-- global options
vim.g.mapleader = ","
vim.o.number = true
vim.o.mouse = "a"
vim.o.foldmethod = "indent"
vim.o.background = "dark"
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.autoindent = true

-- keymaps
vim.keymap.set("n", "<F12>", ":FloatermToggle<CR>", { silent = true })
vim.keymap.set("n", "<C-l>", ":NvimTreeToggle<CR>", { silent = true })

-- indentation

vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function()
    vim.bo.expandtab = false
    vim.bo.tabstop = 8
    vim.bo.softtabstop = 8
    vim.bo.shiftwidth = 8
  end,
})

-- =========================
-- COMPLETION (nvim-cmp)
-- =========================
local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  },
})

-- =========================
-- LSP (Neovim 0.11 style)
-- =========================
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

vim.lsp.config("gopls", {
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_markers = { "go.mod", ".git" },
  capabilities = capabilities,
})

vim.lsp.config("ts_ls", {
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  root_markers = { "package.json", "tsconfig.json", ".git" },
  capabilities = capabilities,
})

vim.lsp.config("lua_ls", {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { ".luarc.json", ".git" },
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = { globals = { "vim" } },
      workspace = { checkThirdParty = false },
    },
  },
})

vim.lsp.enable({ "gopls", "ts_ls", "lua_ls" })
