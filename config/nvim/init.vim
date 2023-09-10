" ----------------------------------------
" run config from Vim
" ----------------------------------------

" start with Vim config
" set runtimepath^=~/.vim runtimepath+=~/.vim/after
" let &packpath = &runtimepath
" ----------------------------------------

" Базовые настройки
source ~/.config/vim/settings.vim

" Привязки клавиш
source ~/.config/vim/mappings.vim

" Терминал и Проводник
source ~/.config/vim/explorers.vim

" ----------------------------------------
" ----------------------------------------
" Плагины
" ----------------------------------------

" Vim-plug - менеджер плагинов
" ---------------
" https://github.com/junegunn/vim-plug
" Reload .vimrc and :PlugInstall to install plugins
" --------------

" Initialize plugin system
call plug#begin()

" ----------------------------------------

" Основные плагины
source ~/.config/vim/pluggins.vim

" IDE плагины общие
source ~/.config/vim/ide_main.vim

" IDE плагины NeoVim
source ~/.config/nvim/ide.vim

" ----------------------------------------

" Initialize plugin system
call plug#end()

" ----------------------------------------
" ----------------------------------------

" Цветовая схема (через плагин)
source ~/.config/vim/colors.vim

" ----------------------------------------

" Neovim LSP Settings
lua require("lsp")

" ----------------------------------------
" ----------------------------------------

" vim:ft=vim

