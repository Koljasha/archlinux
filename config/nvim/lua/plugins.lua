-- ~/.config/nvim/lua/plugins.lua

return {
  {
    -- Цветовая схема Catppuccin для (Neo)vim : https://github.com/catppuccin/nvim
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
        { "<leader>b", desc = "Buffer Switch", icon = "" },
        { "<leader>B", desc = "Buffer Next", icon = "󰒭" },

        { "<leader>o", desc = "Explorer NERDTree", icon = "" },
        { "<leader>O", desc = "Explorer netrw", icon = "󱉆" },

        { "<leader>Q", desc = "Delete Buffer", icon = "󱂦" },
        { "<leader>S", desc = "Save Buffer", icon = "" },

        { "<leader>t", desc = "Terminal Split", icon = "" },
        { "<leader>T", desc = "Terminal Tab", icon = "" },

        { "<leader>v", desc = "Window Vsplit", icon = "" },
        { "<leader>V", desc = "Tab Split", icon = "" },

        { "<leader>W", desc = "Save Buffer", icon = "" },
        { "<leader>X", desc = "Delete Buffer", icon = "󱂦" },

        { "<leader>/", desc = "NoHlSearch", icon = "" },
        { "<leader><space>", desc = "EasyMotion", icon = "" },

        { "<leader>c", group = " NerdCommenter", icon = "" },
        { "<leader>c<space>", desc = "Toggle comment" },
        { "<leader>cc", desc = "Comment" },
        { "<leader>cu", desc = "Uncomment" },

        { "<leader>f", group = " Fzf", icon = "󱎸" },
        { "<leader>fb", desc = "FZF Buffers" },
        { "<leader>ff", desc = "FZF Files" },
        { "<leader>fw", desc = "FZF Windows" },
        { "<leader>f/", desc = "FZF Blines" },
        { "<leader>fr", desc = "FZF Rg" },
        { "<leader>ft", desc = "FZF Btags" },
        { "<leader>fj", desc = "FZF Jumps" },
        { "<leader>fc", desc = "FZF Changes" },
        { "<leader>fm", desc = "FZF Marks" },
        { "<leader>fh", desc = "FZF History" },
        { "<leader>fg", desc = "FZF Git status" },
        { "<leader>f?h", desc = "FZF Helptags" },
        { "<leader>f?m", desc = "FZF Maps" },
        { "<leader>fsc", desc = "FZF Colors" },
        { "<leader>fsf", desc = "FZF Filetypes" },

        { "ge", desc = "Diagnostic float" },
      })
    end,
  },

}

