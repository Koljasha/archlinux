" ----------------------------------------
" run config from Vim
" ----------------------------------------

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

" ----------------------------------------

" Neovim LSP Settings
source ~/.config/nvim/init/lsp.vim

" ----------------------------------------
" ----------------------------------------

