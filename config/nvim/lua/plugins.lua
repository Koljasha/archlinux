-- ~/.config/nvim/lua/plugins.lua

return {
  {
    -- Catppuccin colorscheme for (Neo)vim : https://github.com/catppuccin/nvim
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000, -- Загружаем раньше для цветовых схем

    config = function()
      -- Настройка catppuccin
      require('catppuccin').setup({
        flavour = 'mocha', -- Выбираем вариант mocha
        transparent_background = true, -- Включаем прозрачность
      })
      require('catppuccin').load() -- Применяем цветовую схему
    end,
  },

  -- Dracula colorscheme : https://github.com/Mofiqul/dracula.nvim
  -- { 'Mofiqul/dracula.nvim' },

  -- Which Key : https://github.com/folke/which-key.nvim
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      -- Основные настройки
      preset = "helix", -- Выбор стиля: "classic", "modern", "helix"
      delay = 350, -- Задержка перед показом окна (в миллисекундах)
      -- Настройка окна
      win = {
        border = "rounded", -- Стиль границы: "none", "single", "double", "rounded"
        padding = { 1, 2 }, -- Отступы внутри окна [top/bottom, left/right]
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)

      -- Регистрация префиксов
      wk.add({
        { "<leader>c", group = " NerdCommenter" },
        { "<leader>f", group = " Fzf" },

        { "<leader>b", desc = "Buffer Next" },
        { "<leader>B", desc = "Buffer Prev" },

        { "<leader>o", desc = "Explorer Files" },
        { "<leader>O", desc = "Explorer Files Vsplit" },

        { "<leader>Q", desc = "Delete Buffer" },
        { "<leader>S", desc = "Save Buffer" },

        { "<leader>t", desc = "Terminal Split" },
        { "<leader>T", desc = "Terminal Vsplit" },

        { "<leader>v", desc = "Window Vsplit" },
        { "<leader>V", desc = "Window Buffer Vsplit" },

        { "<leader>/", desc = "NoHlSearch" },
        { "<leader><space>", desc = "EasyMotion" },
      })
    end,
  },

}

