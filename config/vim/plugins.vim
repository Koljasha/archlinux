" ----------------------------------------
" Основные плагины
" ----------------------------------------

" ----------------------------------------
" Lightline-Bufferline - отображение буферов в Lightline
" Lightline - строка статуса
" Vim-Devicons - иконки Nerd
" CSS Color - цвета css

" FZF - нечеткий поиск
" EasyMotion - простые перемещения

" Auto Pairs - парные скобки и ковычки
" Repeat - расширенный повтор по "."
" Match-up - перемещение по тегам, скобкам...
" NERD Commenter - комментирование для различных языков

" Polyglot - коллекция языковых пакетов для Vim
" Xkbswitch - смена на En при переходе в командный режим
" ----------------------------------------
" только для Vim
" ----------------------------------------
" PaperColor - цветовая схема
" Supertab - дополнение по <Tab>
" ----------------------------------------
" отключено
" ----------------------------------------
" Startify - стартовый экран
" NERD Tree - файловый менеджер
" MRU - последние открытые файлы
" Buffer Explorer - переключение открытых буферов
" Tagbar - окно-список тегов
" ----------------------------------------
" ----------------------------------------

" Lightline-Bufferline - отображение буферов в Lightline
" ---------------
" https://github.com/mengelbrecht/lightline-bufferline
Plug 'mengelbrecht/lightline-bufferline'
" ---------------
let g:lightline#bufferline#show_number = 1
let g:lightline#bufferline#enable_devicons = 1
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
	  \ }

" clickable only for nvim (now not work - bug)
" let g:lightline.component_raw = {'buffers': 1}
" let g:lightline#bufferline#clickable = 1
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

" FZF - нечеткий поиск
" ---------------
" https://github.com/junegunn/fzf.vim
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
" ---------------
" смотреть команды ~/.config/vim/explorers.vim
" ---------------
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

" ----------------------------------------
" ----------------------------------------

" Auto Pairs - парные скобки и ковычки
" ---------------
" https://github.com/jiangmiao/auto-pairs
Plug 'jiangmiao/auto-pairs'
" ---------------
let g:AutoPairsShortcutFastWrap = ''  " Fast Wrap
let g:AutoPairsShortcutJump = ''  " Jump to next closed pair
let g:AutoPairsShortcutBackInsert = ''  " BackInsert
" Toggle Autopairs
" let g:AutoPairsShortcutToggle = '<Leader>pp'
" ----------------------------------------

" Repeat - расширенный повтор по "."
" ---------------
" https://github.com/tpope/vim-repeat
Plug 'tpope/vim-repeat'
" ---------------
" ----------------------------------------

" Match-up - перемещение по тегам, скобкам...
" клавиша %
" " ---------------
" https://github.com/andymass/vim-matchup
Plug 'andymass/vim-matchup'
" ---------------
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

" только для Vim
if ! has('nvim')
	" PaperColor - цветовая схема
	" ---------------
	" https://github.com/NLKNguyen/papercolor-theme
	Plug 'nlknguyen/papercolor-theme'
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
endif

" ----------------------------------------
" ----------------------------------------

" " Startify - стартовый экран
" " ---------------
" " https://github.com/mhinz/vim-startify
" Plug 'mhinz/vim-startify'
" " ---------------
" " ----------------------------------------

" " NERD Tree - файловый менеджер
" " ---------------
" " https://github.com/scrooloose/nerdtree
" Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
" " ---------------
" " автоматически обновлять буфер после переименовывания файла
" let NERDTreeAutoDeleteBuffer = 1
" " показать скрытые файлы
" let NERDTreeShowHidden = 1
" " нумерация строк
" let NERDTreeShowLineNumbers = 1
" " открывать с правой стороны
" let g:NERDTreeWinPos = "left"
" " закрыть после открытия файла
" let NERDTreeQuitOnOpen = 1
" " NERDTreeToggle - <Leader>op
" map <Leader>op :NERDTreeToggle <CR>
" " ----------------------------------------

" " MRU - последние открытые файлы
" " ---------------
" " https://github.com/vim-scripts/mru.vim
" Plug 'vim-scripts/mru.vim'
" " ---------------
" " <Leader>ol - показать список последних файлов
" map <Leader>ol :MRU <CR>
" " ----------------------------------------

" " Buffer Explorer - переключение открытых буферов
" " ---------------
" " https://github.com/vim-scripts/bufexplorer.zip
" Plug 'vim-scripts/bufexplorer.zip'
" " ---------------
" " <Leader>be - открыть Buffer Explorer
" " <Leader>bs - открыть Buffer Explorer (горизонтально)
" " <Leader>bv - открыть Buffer Explorer (вертикально)
" " ----------------------------------------

" " Tagbar - окно-список тегов
" " (нужен установленный ctags)
" " список поддерживаемых языков
" " ctags --list-languages
" " список тегов для конкретного языка
" " ctags --list-kinds=<Lang>
" " ---------------
" " https://github.com/majutsushi/tagbar
" Plug 'majutsushi/tagbar'
" " ---------------
" nmap <Leader>tb :TagbarToggle<CR>
" let g:tagbar_sort = 0
" let g:tagbar_show_linenumbers = 2
" " ----------------------------------------

" ----------------------------------------
" ----------------------------------------

" vim:ft=vim

