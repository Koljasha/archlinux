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
      delay = 550, -- Задержка перед показом окна (в миллисекундах)
      -- Настройка окна
      win = {
        border = "rounded", -- Стиль границы: "none", "single", "double", "rounded"
        padding = { 1, 2 }, -- Отступы внутри окна [top/bottom, left/right]
      },
    },
  },

}

