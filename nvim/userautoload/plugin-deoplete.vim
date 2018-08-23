" =======================
"       deoplete
" =======================

" deopleteを使う
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_delay = 0
let g:deoplete#auto_complete_start_length = 1
let g:deoplete#enable_camel_case = 0
let g:deoplete#enable_ignore_case = 0
let g:deoplete#enable_refresh_always = 0
let g:deoplete#enable_smart_case = 1
let g:deoplete#file#enable_buffer_path = 1
let g:deoplete#max_list = 10000
" set completeopt-=preview

let g:deoplete#sources#omni#input_patterns = {
    \ "ruby" : '[^. *\t]\.\w*\|\h\w*::',
    \ "python" : '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
    \}

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

" set hidden
" let g:LanguageClient_serverCommands = {
" 			\ 'ruby': ['tcp://localhost:7658']
" 			\}
" let g:LanguageClient_autoStop=0
" autocmd FileType ruby setlocal omnifunc=LanguageClient#complete
"
" call deoplete#custom#source('LanguageClient', 'min_pattern_length', 1)
