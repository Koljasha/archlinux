-- init.lua

-- Базовые настройки
vim.cmd('source ~/.config/vim/settings.vim')

-- Привязки клавиш
vim.cmd('source ~/.config/vim/mappings.vim')

-- Терминал и Проводник
vim.cmd('source ~/.config/vim/explorers.vim')

-- Плагины (vim-plug)
-- https://github.com/junegunn/vim-plug
-- Reload .vimrc and :PlugInstall to install plugins
local plug_path = vim.fn.stdpath('data') .. '/site/autoload/plug.vim'

-- Инициализация vim-plug
vim.fn['plug#begin']()

-- Основные плагины
vim.cmd('source ~/.config/vim/pluggins.vim')

-- IDE плагины общие
vim.cmd('source ~/.config/vim/ide_main.vim')

-- IDE плагины NeoVim
vim.cmd('source ~/.config/nvim/ide.vim')

-- Завершение инициализации vim-plug
vim.fn['plug#end']()

-- Цветовая схема
vim.cmd('source ~/.config/vim/colors.vim')

-- Neovim LSP Settings
require('lsp')

