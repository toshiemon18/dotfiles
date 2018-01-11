" =================
"   quickrun.vim
" =================
let g:quickrun_config = get(g:, 'quickrun_config', {})
let g:quickrun_config._ = {
\ 'runner'    : 'vimproc',
\ 'runner/vimproc/updatetime' : 60,
\ 'outputter' : 'error',
\ 'outputter/error/success' : 'buffer',
\ 'outputter/error/error'   : 'quickfix',
\ 'outputter/buffer/split'  : ':rightbelow 8sp',
\ 'outputter/buffer/close_on_empty' : 1,
\ }

au FileType qf nnoremap <silent><buffer>q :quit<CR>

" \rで保存してからQuickRunで実行
let g:quickrun_no_default_key_mappings = 1
nnoremap \r :write<CR>:QuickRun -mode n<CR>
xnoremap \r :<C-U>write<CR>gv:QuickRun -mode v<CR>

" \rでquickfixを閉じてQuickRunで実行
let g:quickrun_no_default_key_mappings = 1
nnoremap \r :cclose<CR>:write<CR>:QuickRun -mode n<CR>
xnoremap \r :<C-U>cclose<CR>:write<CR>gv:QuickRun -mode v<CR>

" <C-c>でquickrunによる実行を強制終了
nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"
nnoremap <Space>q :<C-u>bw! \[quickrun\ output\]<CR>
