-- ~/.config/nvim/lua/lsp.lua

---------------
-- nvim-lspconfig
-- See: https://github.com/neovim/nvim-lspconfig
---------------
-- nvim-cmp
-- See: https://github.com/hrsh7th/nvim-cmp
-- settings from https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion
---------------
-- mason.nvim
-- See: https://github.com/mason-org/mason.nvim
-- mason-lspconfig.nvim
-- See: https://github.com/mason-org/mason-lspconfig.nvim
---------------

return {
  -- Mason для установки LSP-серверов
  -- See: https://github.com/mason-org/mason.nvim
  {
    'mason-org/mason.nvim',
    -- Убедитесь, что setup вызывается до mason-lspconfig.nvim
    config = function()
      require("mason").setup()
    end
  },

  -- Интеграция Mason с lspconfig
  -- See: https://github.com/mason-org/mason-lspconfig.nvim
  {
    'mason-org/mason-lspconfig.nvim',
    dependencies = {
      'mason-org/mason.nvim', -- Mason manager
      'neovim/nvim-lspconfig', -- LSP configurations
      'hrsh7th/cmp-nvim-lsp',  -- LSP capabilities for nvim-cmp
    },
    -- Using opts for configuration with lazy.nvim is recommended.
    -- This setup automatically calls require('mason-lspconfig').setup()
    opts = {
      -- Automatically install listed servers if they are not already installed
      ensure_installed = {
        'pyright',
        'bashls',
        -- 'dockerls',
        -- 'docker_compose_language_service',
        -- 'emmet_ls',
      },
      -- Disable automatic enabling of servers installed via Mason.
      -- We configure and enable them manually below using vim.lsp.config/enable.
      -- This avoids potential conflicts with our custom setup.
      automatic_enable = false,
    },
  },

  -- LSP
  -- Provides default configurations for various LSP servers.
  -- See: https://github.com/neovim/nvim-lspconfig
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Mason packages are handled by mason-lspconfig.nvim above
      'mason-org/mason-lspconfig.nvim',
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      local opts = { noremap = true, silent = true }

      -- Диагностические маппинги
      vim.keymap.set('n', '[ ', vim.diagnostic.setloclist, opts)
      vim.keymap.set('n', '[d', vim.diagnostic.goto_next, opts)
      vim.keymap.set('n', '[D', vim.diagnostic.goto_prev, opts)

      -- Функция on_attach
      local on_attach = function(client, bufnr)
        -- Set omnifunc for buffer
        vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'
        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
        vim.keymap.set('n', 'E', vim.diagnostic.open_float, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
        vim.keymap.set('n', 'grf', vim.lsp.buf.references, bufopts)
        vim.keymap.set('n', 'grn', vim.lsp.buf.rename, bufopts)
      end

      -- Настройка capabilities для nvim-cmp
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- Автокоманда для установки filetype для docker-compose файлов
      vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
        pattern = {"docker-compose.yml", "docker-compose.yaml"},
        callback = function()
          vim.bo.filetype = "yaml.docker-compose"
        end,
      })

      -- Список серверов и их конфигураций
      local servers = {

        pyright = {
          settings = {
            python = {
              analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = 'workspace',
              },
            },
          },
        },

        bashls = {
          -- No specific overrides needed beyond defaults
        },

        dockerls = {
          filetypes = { 'dockerfile' },
          settings = {
            docker = {
              languages = {
                dockerfile = {
                  enable = true,
                },
              },
            },
          },
        },

        docker_compose_language_service = {
          filetypes = { 'yaml.docker-compose' },
          settings = {
            telemetry = {
              enable = false, -- Отключаем телеметрию, если не нужна
            },
          },
        },

        emmet_ls = {
          filetypes = { 'html', 'htmldjango', 'css' },
          init_options = {
            html = {
              options = {
                ['bem.enabled'] = false,
                ['output.selfClosingStyle'] = 'xhtml',
              },
            },
          },
          settings = {
            emmet = {
              showSuggestionsAsSnippets = true,
              includeLanguages = {
                htmldjango = 'html',
              },
            },
          },
        },

      }

      -- Настройка и запуск серверов
      for lsp, config in pairs(servers) do
        -- Регистрируем конфигурацию с on_attach и capabilities
        -- The base configuration (cmd, root_dir, etc.) comes implicitly from nvim-lspconfig.
        vim.lsp.config(lsp, vim.tbl_extend('force', {
          on_attach = on_attach,
          capabilities = capabilities,
        }, config))

        -- Запускаем сервер
        vim.lsp.enable(lsp)
      end
    end,
  },

  -- Плагины для автодополнения
  { 'hrsh7th/nvim-cmp' },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/cmp-buffer' },

  -- Сниппеты
  {
    'L3MON4D3/LuaSnip',
    config = function()
      -- Neovim Snippets: ~/.config/nvim/lua/snippets.lua
      local ok, _ = pcall(require, 'snippets')
      if not ok then
        print('Failed to load snippets.lua')
      end
    end,
  },

  {
    'saadparwaiz1/cmp_luasnip',
    config = function()
      local cmp = require('cmp')
      cmp.setup({
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }),
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
      })
    end,
  },
}

