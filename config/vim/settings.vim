" ----------------------------------------
" Базовые настройки
" ----------------------------------------

" убираем совместимость с vi
set nocompatible

" 256 цветов
set t_Co=256

" мышь во всех режимах
set mouse=a

" автоматически обновлять файл при его изменении
set autoread

" отключение бекапов
set nobackup

" отключение swap-файлы
set noswapfile

" не выгружать буфер, когда переключаемся на другой файл
set hidden

" определение типа файла
filetype plugin indent on

" подсветка синтаксиса
syntax on

" цветовая схема - (через плагин)
set background=dark

" нумерация строк
set number

" показывать относительные номера строк
set relativenumber

" показывать имя буфера в заголовке терминала
set title

" показывать строку с позицией курсора
set ruler

" включаем отображение команды
set showcmd

" включить подсветку невидимых символов
set list

" табы и пробелы
set listchars=trail:.,tab:--

" 4 пробела на tab
set expandtab
set tabstop=4

" размер сдвига при нажатии на клавиши "<" и ">"
set shiftwidth=4

" включаем умную автоматическую расстановку отступов
set smartindent

" наследовать отступы предыдущей строки
set autoindent

" всегда показывать строку статуса
set laststatus=2

" показывать строку вкладок всегда
set showtabline=2

" включаем перенос строк
set wrap

" перенос по словам, а не по буквам
set linebreak

" автозавершение команд в командной строке
set wildmenu
set wcm=<TAB>

" подсветка поиска
set hlsearch

" автопоиск первого совпадения
set incsearch

" игнорировать регистр букв при поиске
set ignorecase

" кодировка по умолчанию
set encoding=utf-8
set termencoding=utf-8
set fileencodings=utf-8,cp1251

" :vsplit открывает окна справа
set splitright

" :split открывает окна снизу
set splitbelow

" .vimrc из каталога запуска
" set exrc
" set secure

" линия по колонке
" set colorcolumn=120

" подсветка текущей строки|колонки
set cursorline
" set cursorcolumn

" описание строки статуса
" set statusline=%<%r%m\ %f:%y\ %=\ %-15(%l,%c:%v\ %p%%%)
" set statusline+=\ %{strftime(\"%H:%M\ %d.%m.%Y\ %a\")}

" показывать первую парную скобку после ввода второй
" set showmatch

" вывести весь список сразу доступных вариантов
" set wildmode=list:longest,full

" останавливать поиск при достижении конца файла
" set nowrapscan

" список кодировок файлов для авто-определения
" set fileencodings=utf-8,koi8-r,cp1251,cp866

" сворачивание на основании отступов в начале строк
" set foldmethod=indent
" сворачивание на основании синтакса
" set foldmethod=syntax

" для корректной работы Vim в Alacritty(ctrl+left|right)
" if !has('nvim')
	" set term=xterm-256color
" endif

" ----------------------------------------
" ----------------------------------------

" vim:ft=vim

