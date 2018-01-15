" キーマッピング
" Vimのシステムに関係するキーマップだけ
" 各プラグインのキーマップは各プラグインのファイルに書く

nnoremap ; :

"vEsc2つで検索結果のハイライトを消す
nnoremap <ESC><ESC> :nohlsearch<CR>

" 新規バッファを横に開く
noremap vn :vnew<CR>

" インサートモードでもhjkl
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

" Shift + hjklで行末へ
noremap <S-h> ^
noremap <S-j> }
noremap <S-k> {
noremap <S-l> $

" Reload config
nnoremap <Space>rv :source $HOME/.config/nvim/init.vim<CR>

" :UpdateRemotePlugins
nnoremap <Space>ur :UpdateRemotePlugins<CR>
