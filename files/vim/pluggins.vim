" ----------------------------------------
" Плагины
" ----------------------------------------

" Vim-plug - менеджер плагинов
" ---------------
" https://github.com/junegunn/vim-plug
" Reload .vimrc and :PlugInstall to install plugins
" --------------

" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

" ----------------------------------------

" Основные плагины
source ~/.vim/init/modules.vim

" IDE плагины общие
source ~/.vim/init/ide_main.vim

" IDE плагины Vim
if !has('nvim')
    source ~/.vim/init/ide_vim.vim
endif

" IDE плагины NeoVim
if has('nvim')
    source ~/.vim/init/ide_nvim.vim
endif

" ----------------------------------------

" Initialize plugin system
call plug#end()

" ----------------------------------------
" ----------------------------------------

" vim:ft=vim

