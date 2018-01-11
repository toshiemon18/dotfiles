" =====================
"     vim-fugitive
" =====================

nmap [fugitive] <Nop>
map <Leader>g [fugitive]
nmap <silent> [fugitive]s :<C-u>Gstatus<CR>
nmap <silent> [fugitive]d :<C-u>Gdiff<CR>
nmap <silent> [fugitive]l :<C-u>Glog<CR>
