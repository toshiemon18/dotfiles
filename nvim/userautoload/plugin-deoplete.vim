" =======================
"       deoplete
" =======================

" deopleteを使う
let g:deoplete#enable_at_startup = 1
set completeopt-=preview " vim-lspとかでPreview bufferで結果を表示したくない

let g:deoplete#sources#omni#input_patterns = {
    \ "ruby" : '[^. *\t]\.\w*\|\h\w*::',
    \ "python" : '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
    \}

call deoplete#custom#var('file', 'enable_buffer_path', 1)
call deoplete#custom#option('enable_smart_case', 1)
call deoplete#custom#option('enable_refresh_always', 0)
call deoplete#custom#option('enable_ignore_case', 0)
call deoplete#custom#option('enable_camel_case', 0)
call deoplete#custom#option('auto_complete_start_length', 1)
call deoplete#custom#option('auto_complete_delay', 0)
call deoplete#custom#option('max_list', 10000)

" call deoplete#custom#source('languageClient', 'min_pattern_length', '2')

" =======================
"        sources
" =======================
" ruby

" Python
" jedi-vim
autocmd FileType python setlocal completeopt-=preview
let g:deoplete#sources#jedi#enable_cache=1
let g:jedi#completions_enabled=0
let g:jedi#documentation_command = "<F9><F10>"
let g:jedi#auto_vim_configuration = 0
let g:deoplete#sources#jedi#extra_path = [
			\$XDG_CONFIG_HOME. "/nvim/dein/repos/github.com/Shougo/deoplete.nvim/rplugin/python3/deoplete",
			\$XDG_CONFIG_HOME. "/nvim/dein/repos/github.com/Shougo/deoplete.nvim/rplugin/python/deoplete/sources"
			\]

" =======================
"      Key bindings
" =======================
inoremap <silent><expr> <TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <silent><expr> <TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"
