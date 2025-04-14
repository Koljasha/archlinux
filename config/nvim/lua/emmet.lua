-- ~/.config/nvim/lua/emmet.lua

local emmet_filetypes = { "html", "htmldjango", "css" }

return {
  {
    "mattn/emmet-vim",
    ft = emmet_filetypes, -- Используем только для нужных файлов
    init = function()
      -- Базовые настройки Emmet
      vim.g.user_emmet_mode = "i" -- Режим вставки
      vim.g.user_emmet_install_global = 0 -- Не устанавливать глобально
      vim.g.user_emmet_leader_key = "," -- Лидер-ключ для Emmet

      -- Кастомные настройки Emmet
      vim.g.user_emmet_settings = {
        variables = {
          lang = "ru",
          title = "MySite",
        },
        html = {
          default_attributes = {
            option = { value = vim.NIL },
            textarea = { id = vim.NIL, name = vim.NIL, cols = 10, rows = 10 },
          },
          snippets = {
            ["html:5"] = table.concat({
              "<!DOCTYPE html>",
              '<html lang="${lang}">',
              "<head>",
              '\t<meta charset="${charset}">',
              "\t<title>${title}</title>",
              '\t<meta name="viewport" content="width=device-width, initial-scale=1.0">',
              "</head>",
              "<body>",
              "\t${child}|",
              "</body>",
              "</html>",
            }, "\n"),
          },
        },
      }
    end,

    config = function()
      -- Устанавливаем Emmet только для нужных типов файлов
      vim.api.nvim_create_autocmd("FileType", {
        pattern = emmet_filetypes, -- Используем только для нужных файлов
        callback = function()
          vim.cmd("EmmetInstall")
        end,
      })
    end,
  },
}

