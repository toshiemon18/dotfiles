" キーマッピング
" Vimのシステムに関係するキーマップだけ
" 各プラグインのキーマップは各プラグインのファイルに書く

nmap ; :

"vEsc2つで検索結果のハイライトを消す
nnoremap <ESC><ESC> :nohlsearch<CR>

" 新規バッファを横に開く
map vn :vnew<CR>

" インサートモードでもhjkl
imap <C-j> <Down>
imap <C-k> <Up>
imap <C-h> <Left>
imap <C-l> <Right>

" Reload config
nnoremap <Space>rv :source $HOME/.config/nvim/init.vim<CR>

" :UpdateRemotePlugins
nnoremap <Space>ur :UpdateRemotePlugins<CR>
