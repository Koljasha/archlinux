" ----------------------------------------
" Lsp for Vim
" ----------------------------------------

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

	nmap <buffer> [<space>  <plug>(lsp-document-diagnostics)
	nmap <buffer> [d <plug>(lsp-next-diagnostic)
	nmap <buffer> [D <plug>(lsp-previous-diagnostic)

	nmap <buffer> K <plug>(lsp-hover)
	nmap <buffer> gd <plug>(lsp-definition)
	nmap <buffer> gi <plug>(lsp-implementation)

	" for symbol-search use ctrl-p, ctrl-n
	nmap <buffer> gs <plug>(lsp-document-symbol-search)
	nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
	nmap <buffer> grf <plug>(lsp-references)
	nmap <buffer> grn <plug>(lsp-rename)

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

" ----------------------------------------
" ----------------------------------------

" vim:ft=vim

