" キーマッピング
" Vimのシステムに関係するキーマップだけ
" 各プラグインのキーマップは各プラグインのファイルに書く


" Configure <leader> to <Space>
" map <leader> <Space>

" For US keyboard
nnoremap ; :

" disable searching highlight
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
" noremap <S-j> 3j
" noremap <S-k> 3k
noremap <S-l> $

" Reload config
" nnoremap <Space>rr :source $HOME/.config/nvim/init.vim<CR>

" :UpdateRemotePlugins
nnoremap <Space>ur :UpdateRemotePlugins<CR>

" :DeinUpdate
nnoremap <Space>du :DeinUpdate<CR>
