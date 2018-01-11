" 見た目の設定

set t_Co=256
syntax enable
colorscheme monokai
set cmdheight=2
set title
set wildmenu
set laststatus=2
set noswapfile
set showmatch
set showcmd

set ruler
set number
set cursorline
set cursorcolumn

augroup vimrc_change_cursorline_color
    autocmd!
    " インサートモードに入った時にカーソル行の色をブルーグリーンにする
    "autocmd InsertEnter * highlight CursorLine ctermbg=green
    autocmd InsertEnter * hi CursorLineNr ctermbg = 11 ctermfg = 0
    autocmd InsertLeave * hi CursorLineNr ctermbg = 235 ctermfg = 243
augroup END
