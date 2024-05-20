" ----------------------------------------
" Цветовая схема
" ----------------------------------------

" настройка цветовой схемы
if has('nvim')
    colorscheme dracula
else
    colorscheme PaperColor
endif

" прозрачность
highlight Normal guibg=NONE ctermbg=NONE

" ----------------------------------------

" Орфография - цвет шрифта при проверке

" красный цвет - орфографические ошибки
" highlight clear SpellBad
" highlight SpellBad ctermfg=Red

" синий цвет - отсутствие заглавной буквы
" highlight clear SpellCap
" highlight SpellCap ctermfg=Blue

" ----------------------------------------
" ----------------------------------------

" vim:ft=vim

