-- ~/.config/nvim/lua/colors.lua

return {
  {
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

  -- { 'Mofiqul/dracula.nvim' },
}

