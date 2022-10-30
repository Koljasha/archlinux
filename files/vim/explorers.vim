" ----------------------------------------
" Терминал и Проводник
" ----------------------------------------

"  Terminal
" ---------------
if has('nvim')
	nmap <leader>tt :split term://fish <CR> :startinsert <CR>
	nmap <leader>tv :vsplit term://fish <CR> :startinsert <CR>
else
	nmap <leader>tt :terminal <CR>
	nmap <leader>tv :vertical terminal <CR>
endif

" ctrl-\ + ctrl-n - выйти из terminal -> на Esc
tnoremap <Esc> <C-\><C-n>
" ----------------------------------------

" Explore
" ---------------
" встроенный проводник :Exp :Rex :Tex :Lex :Vex :Sex
" gn - сделать каталог корнем
" ctrl-l - обновить каталог

let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'
let g:netrw_browse_split = 0
let g:netrw_liststyle = 3
" let g:netrw_preview   = 1
" let g:netrw_alto = 0
" let g:netrw_winsize   = 30

noremap <leader>oo :Exp <CR>
noremap <leader>OO :Vex <CR>

" ----------------------------------------
" ----------------------------------------

" vim:ft=vim

