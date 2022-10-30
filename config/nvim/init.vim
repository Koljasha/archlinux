" ----------------------------------------
" run config from Vim
" ----------------------------------------

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
" ----------------------------------------

" Базовые настройки
source ~/.vim/init/settings.vim

" Привязки клавиш
source ~/.vim/init/bindkeys.vim

" Терминал и Проводник
source ~/.vim/init/explorers.vim

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
source ~/.vim/init/pluggins.vim

" IDE плагины общие
source ~/.vim/init/ide_main.vim

" IDE плагины NeoVim
source ~/.config/nvim/ide.vim

" ----------------------------------------

" Initialize plugin system
call plug#end()

" ----------------------------------------
" ----------------------------------------

" Цветовая схема (через плагин)
source ~/.vim/init/colors.vim

" ----------------------------------------

" Neovim LSP Settings
lua << EOF
    require("lsp")
EOF

" ----------------------------------------
" ----------------------------------------

" vim:ft=vim

