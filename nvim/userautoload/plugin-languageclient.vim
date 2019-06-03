set hidden

let g:LanguageClient_autoStart = 1
let g:LanguageClient_serverCommands = {
			\ 'ruby': ['solargraph', 'stdio'],
			\}

" augroup LC_config
" 	autocmd!
" 	autocmd User LanguageClientStarted setlocal signcolumn=yes
" 	autocmd User LanguageClientStopped setlocal signcolumn=auto
" augroup END

" let g:LanguageClient_loadSettings=1
" let g:LanguageClient_hasSnippetSupport=0

nnoremap <silent> <Space>lh :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> <Space>ld :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <Space>lr :call LanguageClient_textDocument_rename()<CR>
nnoremap <silent> <Space>lf :call LanguageClient_textDocument_formatting()<CR>

" ===============
" Filetype Confs
" ===============
autocmd FileType ruby setlcoal omnifunc=LanguageClient#complete
