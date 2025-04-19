" ----------------------------------------
" Терминал и Проводник
" ----------------------------------------

"  Terminal
" ---------------
if ! has('nvim')
	nmap <Leader>t :terminal <CR>
	nmap <Leader>T :vertical terminal <CR>
else
	nmap <Leader>t :split term://fish <CR> :startinsert <CR>
	nmap <Leader>T :vsplit term://fish <CR> :startinsert <CR>
endif

" ctrl-\ + ctrl-n - выйти из terminal -> на Esc
tnoremap <Esc> <C-\><C-n>

" ----------------------------------------
" ----------------------------------------

" Explore
" ---------------
" встроенный проводник :Exp :Rex | :Tex | :Hex :Vex |:Lex :Sex
" gn - сделать каталог корнем
" ctrl-l - обновить каталог
" enter - открыть в этом окне

" t - открыть как tabs
" v - открыть как vsplit
" o - открыть как split
" ---------------

let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'
let g:netrw_browse_split = 0        " Открывать файлы в текущем окне
let g:netrw_liststyle = 3           " Древовидный стиль отображения
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
" noremap <Leader>O :Vex <CR>
noremap <Leader>O :call ToggleExplorer() <CR>

" ----------------------------------------
" ----------------------------------------

" NERD Tree
" ---------------
" <Leader>p - закрыть|открыть

" t - открыть tab
" v - открыть vsplit
" i - открыть split
" ---------------

" автоматически обновлять буфер после переименовывания файла
let NERDTreeAutoDeleteBuffer = 1
" показать скрытые файлы
let NERDTreeShowHidden = 1
" нумерация строк
let NERDTreeShowLineNumbers = 1
" открывать с правой стороны
let g:NERDTreeWinPos = "left"
" ширина окна
let g:NERDTreeWinSize = 35
" закрыть после открытия файла
" let NERDTreeQuitOnOpen = 1
" NERDTreeToggle - <Leader>op
" переназначение клавиш для vsplit
let g:NERDTreeMapOpenVSplit = 'v'
let g:NERDTreeMapPreviewVSplit = 'gv'

map <Leader>o :NERDTreeToggle <CR>

" ----------------------------------------
" ----------------------------------------

" FZF
" ---------------
" :help fzf-vim-commands
" ctrl-c - закрыть окно

" ctrl-t - открыть tab
" ctrl-x - открыть split
" ctrl-v - открыть vsplit
" ---------------

" FZF Buffers
nmap <Leader>fb :Buffers<CR>
" FZF Files
nmap <Leader>ff :Files<CR>
" FZF Windows
nmap <Leader>fw :Windows<CR>

" FZF Blines
nmap <Leader>f/ :BLines<CR>
" FZF Rg
nmap <Leader>fr :Rg<CR>
" FZF Btags
nmap <Leader>ft :BTags<CR>

" FZF Jumps
nmap <Leader>fj :Jumps<CR>
" FZF Changes
nmap <Leader>fc :Changes<CR>
" FZF Marks
nmap <Leader>fm :Marks<CR>
" FZF History
nmap <Leader>fh :History<CR>

" FZF GFiles? (git status)
nmap <Leader>fg :GFiles?<CR>

" f? - help
" FZF Helptags
nmap <Leader>f?h :Helptags<CR>
" FZF Normal mode mappings
nmap <Leader>f?m :Maps<CR>

" fs - settings
" FZF Color schemes
nmap <Leader>fsc :Colors<CR>
" FZF Filetypes
nmap <Leader>fsf :Filetypes<CR>

" ----------------------------------------
" ----------------------------------------

" vim:ft=vim

