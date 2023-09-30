" ----------------------------------------
" Терминал и Проводник
" ----------------------------------------

"  Terminal
" ---------------
if has('nvim')
	nmap <Leader>tt :split term://fish <CR> :startinsert <CR>
	nmap <Leader>tv :vsplit term://fish <CR> :startinsert <CR>
else
	nmap <Leader>tt :terminal <CR>
	nmap <Leader>tv :vertical terminal <CR>
endif

" ctrl-\ + ctrl-n - выйти из terminal -> на Esc
tnoremap <Esc> <C-\><C-n>
" ----------------------------------------

" Explore
" ---------------
" встроенный проводник :Exp :Rex | :Tex | :Hex :Vex |:Lex :Sex
" gn - сделать каталог корнем
" ctrl-l - обновить каталог
" enter - открыть в этом окне
" o - открыть как split
" v - открыть как vsplit
" t - открыть как tabs

let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'
let g:netrw_browse_split = 0
let g:netrw_liststyle = 3
" let g:netrw_preview   = 1
" let g:netrw_alto = 0
" let g:netrw_winsize   = 30

function ToggleExplorer()
    if &ft == "netrw"
        if exists("w:netrw_rexlocal")
            Rexplore
        else
            if exists("w:netrw_rexfile")
                exec 'e ' . w:netrw_rexfile
            endif
        endif
    else
        Explore
    endif
endfun

" noremap <Leader>oo :Exp <CR>
noremap <Leader>oo :call ToggleExplorer() <CR>
noremap <Leader>OO :Vex <CR>

" ----------------------------------------

" FZF Commands
" ---------------
" :help fzf-vim-commands
" ctrl-c - закрыть окно
" ctrl-t - открыть tab
" ctrl-x - открыть split
" ctrl-v - открыть vsplit
" ---------------

" FZF Files
nmap <Leader>f<Leader> :Files<CR>
" FZF Buffers
nmap <Leader>ff :Buffers<CR>
" FZF Windows
nmap <Leader>fw :Windows<CR>
" FZF Rg
nmap <Leader>fr :Rg<CR>
" FZF Blines
nmap <Leader>f/ :BLines<CR>
" FZF Btags
nmap <Leader>ft :BTags<CR>
" FZF Jumps
nmap <Leader>fj :Jumps<CR>
" FZF History
nmap <Leader>fh :History<CR>
" FZF GFiles? (git status)
nmap <Leader>fs :GFiles?<CR>

" ----------------------------------------
" ----------------------------------------

" vim:ft=vim

