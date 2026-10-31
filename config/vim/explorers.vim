" ----------------------------------------
" Терминал и Проводник
" ----------------------------------------

"  Terminal
" ---------------
if ! has('nvim')
    nnoremap <Leader>t :vertical terminal<CR>
    nnoremap <Leader>T :terminal<CR><C-\><C-n><C-w>Ti
else
    nnoremap <Leader>t :vsplit term://fish<CR>:startinsert<CR>
    nnoremap <Leader>T :split term://fish<CR><C-w>Ti
    " nnoremap <Leader>T :term fish<CR>:startinsert<CR>
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
" <Leader>o - закрыть|открыть

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
" открывать с левой стороны
let g:NERDTreeWinPos = "left"
" ширина окна
let g:NERDTreeWinSize = 35
" закрыть после открытия файла
" let NERDTreeQuitOnOpen = 1

" переназначение клавиш для vsplit
let g:NERDTreeMapOpenVSplit = 'v'
let g:NERDTreeMapPreviewVSplit = 'gv'

nnoremap <Leader>o :NERDTreeToggle <CR>

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
nnoremap <Leader>fb :Buffers<CR>
" FZF Files
nnoremap <Leader>ff :Files<CR>
" FZF Windows
nnoremap <Leader>fw :Windows<CR>

" FZF Blines
nnoremap <Leader>f/ :BLines<CR>
" FZF Rg
nnoremap <Leader>fr :Rg<CR>
" FZF Btags
nnoremap <Leader>ft :BTags<CR>

" FZF Jumps
nnoremap <Leader>fj :Jumps<CR>
" FZF Changes
nnoremap <Leader>fc :Changes<CR>
" FZF Marks
nnoremap <Leader>fm :Marks<CR>
" FZF History
nnoremap <Leader>fh :History<CR>

" FZF GFiles? (git status)
nnoremap <Leader>fg :GFiles?<CR>

" f? - help
" FZF Helptags
nnoremap <Leader>f?h :Helptags<CR>
" FZF Normal mode mappings
nnoremap <Leader>f?m :Maps<CR>

" fs - settings
" FZF Color schemes
nnoremap <Leader>fsc :Colors<CR>
" FZF Filetypes
nnoremap <Leader>fsf :Filetypes<CR>

" ----------------------------------------
" ----------------------------------------

" vim:ft=vim

