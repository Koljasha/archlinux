-- ~/.config/nvim/lua/lsp.lua

---------------
-- nvim-lspconfig
-- settings from https://github.com/neovim/nvim-lspconfig
---------------
-- nvim-cmp
-- settings from: https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion
---------------

return {
  -- LSP
  {
    'neovim/nvim-lspconfig',

    config = function()
      -- Mappings.
      -- See `:help vim.diagnostic.*` for documentation on any of the below functions
      local opts = { noremap = true, silent = true }

      vim.api.nvim_set_keymap('n', '[ ', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
      vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
      vim.api.nvim_set_keymap('n', '[D', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)

      -- Use an on_attach function to only map the following keys
      -- after the language server attaches to the current buffer
      local on_attach = function(client, bufnr)
        -- Enable completion triggered by <c-x><c-o>
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

        -- Mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)

        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'grf', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'grn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
      end

      -- Add additional capabilities supported by nvim-cmp
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local lspconfig = require('lspconfig')

      -- !!! Need install LSP Server
      -- https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md
      -- >sudo npm i -g pyright
      -- >sudo npm i -g bash-language-server
      -- >sudo npm i -g emmet-ls

      -- Enable some language servers with the additional completion capabilities offered by nvim-cmp
      local servers = { 'pyright', 'bashls', 'emmet_ls' }
      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup {
          on_attach = on_attach,
          capabilities = capabilities,

          filetypes = (lsp == 'emmet_ls') and { 'html', 'htmldjango', 'css' } or nil,

          init_options = (lsp == 'emmet_ls') and {
            html = {
              options = {
                ["bem.enabled"] = false,
                ["output.selfClosingStyle"] = "xhtml",
              },
            },
          } or nil,

          settings = (lsp == 'emmet_ls') and {
            emmet = {
              showSuggestionsAsSnippets = true,
              includeLanguages = {
                htmldjango = "html",
              },
            },
          } or nil,
        }
      end
    end,
  },

  -- Автодополнение
  { 'hrsh7th/nvim-cmp' },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/cmp-buffer' },

  -- Сниппеты
  {
    'L3MON4D3/LuaSnip',

    config = function()
      -- Neovim Snippets: ~/.config/nvim/lua/snippets.lua
      local ok, _ = pcall(require, "snippets")
      if not ok then
        print("Failed to load snippets.lua")
      end
    end,
  },

  {
    'saadparwaiz1/cmp_luasnip',

    config = function()
      local cmp = require 'cmp'
      cmp.setup {
        snippet = {
          expand = function(args)
            local luasnip = require('luasnip')
            if luasnip then
              luasnip.lsp_expand(args.body)
            end
          end,
        },

        mapping = cmp.mapping.preset.insert({
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          },
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif require('luasnip').expand_or_jumpable() then
              require('luasnip').expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif require('luasnip').jumpable(-1) then
              require('luasnip').jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        }),

        sources = {
          { name = 'nvim_lsp', max_item_count = 10 },
          { name = 'luasnip', max_item_count = 5 },
          { name = 'buffer', max_item_count = 5 },
        },
      }
    end,
  },
}

