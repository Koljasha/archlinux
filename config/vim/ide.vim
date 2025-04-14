" ----------------------------------------
" IDE
" ----------------------------------------

" Emmet
" ---------------
" https://github.com/mattn/emmet-vim
Plug 'mattn/emmet-vim'
" использование в режиме вставки: ,,
" ---------------
let g:user_emmet_mode='i'
let g:user_emmet_install_global = 0
autocmd FileType html,htmldjango,css EmmetInstall
let g:user_emmet_leader_key=','

let g:user_emmet_settings = {
\  'variables': {
\    'lang': 'ru',
\    'title': 'Django'
\    },
\  'html': {
\    'default_attributes': {
\      'option': {'value': v:null},
\      'textarea': {'id': v:null, 'name': v:null, 'cols': 10, 'rows': 10},
\    },
\    'snippets': {
\      'html:5': "<!DOCTYPE html>\n"
\              ."<html lang=\"${lang}\">\n"
\              ."<head>\n"
\              ."\t<meta charset=\"${charset}\">\n"
\              ."\t<title>${title}</title>\n"
\              ."\t<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n"
\              ."</head>\n"
\              ."<body>\n\t${child}|\n</body>\n"
\              ."</html>",
\    },
\  },
\}
" ----------------------------------------

" Black - форматирование кода Python
" для Neovim нужно: pip install pynvim
" ---------------
" https://github.com/psf/black
" Plug 'psf/black', { 'branch': 'stable', 'for': 'python' }
" ---------------
" nmap <Leader>bl :Black <CR>

" run Black on save
" augroup black_on_save
  " autocmd!
  " autocmd BufWritePre *.py Black
" augroup end
" ----------------------------------------

" ----------------------------------------
" ----------------------------------------

" vim:ft=vim

