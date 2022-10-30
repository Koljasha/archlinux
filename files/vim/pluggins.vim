" ----------------------------------------
" Плагины
" ----------------------------------------

" Vim-plug - менеджер плагинов

" ---------------
" PaperColor - цветовая схема
" Lightline-Bufferline - отображение буферов в Lightline
" Lightline - строка статуса
" Vim-Devicons - иконки Nerd
" CSS Color - цвета css

" Startify - стартовый экран
" NERD Tree - файловый менеджер
" MRU - последние открытые файлы
" Buffer Explorer - переключение открытых буферов
" FZF - нечеткий поиск

" Auto Pairs - парные скобки и ковычки
" NERD Commenter - комментирование для различных языков

" EasyMotion - простые перемещения
" Tagbar - окно-список тегов
" Repeat - расширенный повтор по "."
" Supertab - дополнение по <Tab>
" Matchit - перемещение по тегам HTML (%) (для HTML)
" Matchtag - подсветка тегов HTML (для HTML)

" Polyglot - коллекция языковых пакетов для Vim
" Xkbswitch - смена на En при переходе в командный режим
"
" ----------------------------------------
" IDE
" ----------------------------------------
" IDE for Vim
" ----------------------------------------
" IDE for Neovim
" ----------------------------------------

" ----------------------------------------
" ----------------------------------------

" Vim-plug - менеджер плагинов
" ---------------
" https://github.com/junegunn/vim-plug
" Reload .vimrc and :PlugInstall to install plugins
" --------------

" Specify a directory for plugins
call plug#begin('~/.vim/plugged')
" ----------------------------------------
" ----------------------------------------

" PaperColor - цветовая схема
" ---------------
" https://github.com/NLKNguyen/papercolor-theme
Plug 'nlknguyen/papercolor-theme'
" ---------------
" ----------------------------------------

" Lightline-Bufferline - отображение буферов в Lightline
" ---------------
" https://github.com/mengelbrecht/lightline-bufferline
Plug 'mengelbrecht/lightline-bufferline'
" ---------------
let g:lightline#bufferline#show_number = 1
let g:lightline#bufferline#enable_devicons = 1
" clickable only for nvim
let g:lightline#bufferline#clickable = 1
" ----------------------------------------

" Lightline - строка статуса
" ---------------
" https://github.com/itchyny/lightline.vim
Plug 'itchyny/lightline.vim'
" ---------------
let g:lightline = {
	  \ 'tabline': {
	  \   'left': [ ['buffers'] ],
	  \   'right': [ ['close'], ['tabs'] ]
	  \ },
	  \ 'component_expand': {
	  \   'buffers': 'lightline#bufferline#buffers'
	  \ },
	  \ 'component_type': {
	  \   'buffers': 'tabsel'
	  \ },
	  \ 'component_raw': {
	  \   'buffers': 1
	  \ },
	  \ }
" ----------------------------------------

" Vim-Devicons - иконки Nerd
" ---------------
" https://github.com/ryanoasis/vim-devicons
Plug 'ryanoasis/vim-devicons'
" ---------------
" ----------------------------------------

" CSS Color - цвета css
" ---------------
" https://github.com/ap/vim-css-color
Plug 'ap/vim-css-color'
" ---------------
" ----------------------------------------

" ----------------------------------------
" ----------------------------------------

" Startify - стартовый экран
" ---------------
" https://github.com/mhinz/vim-startify
Plug 'mhinz/vim-startify'
" ---------------
" ----------------------------------------

" NERD Tree - файловый менеджер
" ---------------
" https://github.com/scrooloose/nerdtree
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
" ---------------
" автоматически обновлять буфер после переименовывания файла
let NERDTreeAutoDeleteBuffer = 1
" показать скрытые файлы
let NERDTreeShowHidden = 1
" нумерация строк
let NERDTreeShowLineNumbers = 1
" открывать с правой стороны
let g:NERDTreeWinPos = "left"
" NERDTreeToggle - <Leader>op
map <Leader>op :NERDTreeToggle <CR>
" ----------------------------------------

" MRU - последние открытые файлы
" ---------------
" https://github.com/vim-scripts/mru.vim
Plug 'vim-scripts/mru.vim'
" ---------------
" <Leader>ol - показать список последних файлов
map <Leader>ol :MRU <CR>
" ----------------------------------------

" Buffer Explorer - переключение открытых буферов
" ---------------
" https://github.com/vim-scripts/bufexplorer.zip
Plug 'vim-scripts/bufexplorer.zip'
" ---------------
" <Leader>be - открыть Buffer Explorer
" <Leader>bs - открыть Buffer Explorer (горизонтально)
" <Leader>bv - открыть Buffer Explorer (вертикально)
" ----------------------------------------

" FZF - нечеткий поиск
" ---------------
" https://github.com/junegunn/fzf.vim
Plug 'junegunn/fzf.vim'
" ---------------
nmap <Leader>zz :FZF <CR>
" for close use Ctrl-c
" ---------------
" ----------------------------------------

" ----------------------------------------
" ----------------------------------------

" Auto Pairs - парные скобки и ковычки
" ---------------
" https://github.com/jiangmiao/auto-pairs
Plug 'jiangmiao/auto-pairs'
" ---------------
let g:AutoPairsShortcutToggle = '<Leader>pp'  " Toggle Autopairs
let g:AutoPairsShortcutFastWrap = ''  " Fast Wrap
let g:AutoPairsShortcutJump = ''  " Jump to next closed pair
let g:AutoPairsShortcutBackInsert = ''  " BackInsert
" ----------------------------------------

" NERD Commenter - комментирование для различных языков
" ---------------
" https://github.com/scrooloose/nerdcommenter
Plug 'scrooloose/nerdcommenter'
" ---------------
" отменить двойной комментарий
" let g:NERDDefaultNesting = 0
" добавить пробелы после комментария
let g:NERDSpaceDelims = 1
" изменение знака комментария
" \ 'lang': { 'left': '//', 'leftAlt': '/*', 'rightAlt': '*/' },
let g:NERDCustomDelimiters = {
    \ 'python': { 'left': '#'}
    \}
" комментировать
" [count]|<leader>|cc |NERDComComment|
" раскомментировать
" [count]|<Leader>|cu |NERDComUncommentLine|
" комментировать/раскомментировать
" [count]|<Leader>|c<space> |NERDComToggleComment|
" блочный форматированный комментарий
" [count]<leader>cs |NERDComSexyComment|
" смена комментировано на раскомментировано и наоборот
" [count]|<Leader>|ci |NERDComInvertComment|
" комментарий в конец строки
" |<Leader>|cA |NERDComAppendComment|
" ----------------------------------------

" ----------------------------------------
" ----------------------------------------

" EasyMotion - простые перемещения
" ---------------
" https://github.com/easymotion/vim-easymotion
Plug 'easymotion/vim-easymotion'
" ---------------
" отключаем зависимость от регистра
let g:EasyMotion_smartcase = 1
" стандартные клавиши, где <Leader> - это <Leader><Leader>
" Default Mapping      | Details
"    ---------------------|----------------------------------------------
"    <Leader>f{char}      | Find {char} to the right. See |f|.
"    <Leader>F{char}      | Find {char} to the left. See |F|.
"    <Leader>t{char}      | Till before the {char} to the right. See |t|.
"    <Leader>T{char}      | Till after the {char} to the left. See |T|.
"    <Leader>w            | Beginning of word forward. See |w|.
"    <Leader>W            | Beginning of WORD forward. See |W|.
"    <Leader>b            | Beginning of word backward. See |b|.
"    <Leader>B            | Beginning of WORD backward. See |B|.
"    <Leader>e            | End of word forward. See |e|.
"    <Leader>E            | End of WORD forward. See |E|.
"    <Leader>ge           | End of word backward. See |ge|.
"    <Leader>gE           | End of WORD backward. See |gE|.
"    <Leader>j            | Line downward. See |j|.
"    <Leader>k            | Line upward. See |k|.
"    <Leader>n            | Jump to latest "/" or "?" forward. See |n|.
"    <Leader>N            | Jump to latest "/" or "?" backward. See |N|.
"    <Leader>s            | Find(Search) {char} forward and backward.
" ----------------------------------------

" Tagbar - окно-список тегов
" (нужен установленный ctags)
" список поддерживаемых языков
" ctags --list-languages
" список тегов для конкретного языка
" ctags --list-kinds=<Lang>
" ---------------
" https://github.com/majutsushi/tagbar
Plug 'majutsushi/tagbar'
" ---------------
nmap <Leader>tb :TagbarToggle<CR>
let g:tagbar_sort = 0
let g:tagbar_show_linenumbers = 2
" ----------------------------------------

" Repeat - расширенный повтор по "."
" ---------------
" https://github.com/tpope/vim-repeat
Plug 'tpope/vim-repeat'
" ---------------
" ----------------------------------------

" Supertab - дополнение по <Tab>
" ---------------
" https://github.com/ervandew/supertab
Plug 'ervandew/supertab'
" ---------------
let g:SuperTabDefaultCompletionType = "<c-n>"
let g:SuperTabContextDefaultCompletionType = "<c-n>"
" ----------------------------------------

" Matchit - перемещение по тегам HTML (%)
" Matchtag - подсветка тегов HTML
" " ---------------
" https://github.com/tmhedberg/matchit
" https://github.com/gregsexton/MatchTag
" ---------------
Plug 'tmhedberg/matchit', { 'for': 'html' }
Plug 'gregsexton/MatchTag', { 'for': 'html' }
" ----------------------------------------

" ----------------------------------------
" ----------------------------------------

" Polyglot - коллекция языковых пакетов для Vim
" ---------------
" https://github.com/sheerun/vim-polyglot
Plug 'sheerun/vim-polyglot'
" ---------------
" ----------------------------------------

" Xkbswitch - смена на En при переходе в командный режим
" ---------------
" библиотека
" https://github.com/ierton/xkb-switch - для *nix
" https://github.com/DeXP/xkb-switch-win - для Win
" https://github.com/myshov/xkbswitch-macosx - для Mac
" плагин
" https://github.com/lyokha/vim-xkbswitch
Plug 'lyokha/vim-xkbswitch'
" ---------------
let g:XkbSwitchEnabled = 1
let g:XkbSwitchIMappings = ['ru']
let g:XkbSwitchIMappingsTr = {
          \ 'ru':
          \ {'<': 'qwertyuiopasdfghjkl;zxcvbnm.`/'.
          \       'QWERTYUIOPASDFGHJKL:ZXCVBNM<>?~@#$^&|',
          \  '>': 'йцукенгшщзфывапролджячсмитьюё.'.
          \       'ЙЦУКЕНГШЩЗФЫВАПРОЛДЖЯЧСМИТЬБЮ,Ё"№;:?/'},
          \ }
" путь к библиотеке
	let g:XkbSwitchLib = '/usr/lib/libxkbswitch.so'
" ----------------------------------------

" ----------------------------------------
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

" IDE for Vim
" ----------------------------------------

if !has('nvim')
	" ----------------------------------------
	" https://github.com/prabirshrestha/vim-lsp -- Async Language Server Protocol plugin for vim8 and neovim
	" https://github.com/mattn/vim-lsp-settings -- Auto configurations for Language Servers for vim-lsp

	" https://github.com/prabirshrestha/asyncomplete.vim -- Async autocompletion for Vim 8 and Neovim
	" https://github.com/prabirshrestha/asyncomplete-lsp.vim -- Provide Language Server Protocol autocompletion source
	" ---------------
	Plug 'prabirshrestha/vim-lsp'
	Plug 'mattn/vim-lsp-settings'

	let g:lsp_diagnostics_float_cursor = 1

	function! s:on_lsp_buffer_enabled() abort
		setlocal omnifunc=lsp#complete
		setlocal signcolumn=yes
		if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif

		nmap <buffer> K <plug>(lsp-hover)
		nmap <buffer> gd <plug>(lsp-definition)
		nmap <buffer> gi <plug>(lsp-implementation)

		" for symbol-search use ctrl-p, ctrl-n
		nmap <buffer> gs <plug>(lsp-document-symbol-search)
		nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
		nmap <buffer> gr <plug>(lsp-references)

		nmap <buffer> <space>rn <plug>(lsp-rename)

		nmap <buffer> <space>d <plug>(lsp-document-diagnostics)
		nmap <buffer> [d <plug>(lsp-previous-diagnostic)
		nmap <buffer> ]d <plug>(lsp-next-diagnostic)

		" nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
		" nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

		let g:lsp_format_sync_timeout = 1000
		autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
	endfunction

	augroup lsp_install
		au!
		" call s:on_lsp_buffer_enabled only for languages that has the server registered.
		autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
	augroup END

	Plug 'prabirshrestha/asyncomplete.vim'
	Plug 'prabirshrestha/asyncomplete-lsp.vim'

	" inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
	" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
	inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
" ----------------------------------------
endif

" ----------------------------------------
" ----------------------------------------

" IDE for Neovim
" Neovim Plugins for LSP Server
" настройки в конце файла

if has('nvim')
	" ----------------------------------------
	" https://github.com/neovim/nvim-lspconfig -- Collection of configurations for built-in LSP client
	" https://github.com/hrsh7th/cmp-nvim-lsp -- LSP source for nvim-cmp
	" https://github.com/hrsh7th/cmp-buffer -- nvim-cmp source for buffer words
	" https://github.com/hrsh7th/nvim-cmp -- Autocompletion plugin

	" https://github.com/rafamadriz/friendly-snippets -- Snippets collection

	" https://github.com/saadparwaiz1/cmp_luasnip -- Snippets source for nvim-cmp
	" https://github.com/L3MON4D3/LuaSnip -- Snippets plugin
	" ---------------
	Plug 'neovim/nvim-lspconfig'
	Plug 'hrsh7th/cmp-nvim-lsp'
	Plug 'hrsh7th/cmp-buffer'
	Plug 'hrsh7th/nvim-cmp'

	" Plug 'rafamadriz/friendly-snippets'

	Plug 'L3MON4D3/LuaSnip'
	Plug 'saadparwaiz1/cmp_luasnip'
	" ----------------------------------------
endif

" ----------------------------------------
" ----------------------------------------

" Initialize plugin system
call plug#end()

" ----------------------------------------
" ----------------------------------------

" vim:ft=vim

