" 基本設定

" =======================
"   エンコーディング
" =======================
scriptencoding utf-8
set encoding=utf-8

" =======================
"  Zenkaku visualization
" =======================
function! ZenkakuSpace()
    highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
endfunction

if has('syntax')
    augroup ZenkakuSpace
	autocmd!
	autocmd ColorScheme * call ZenkakuSpace()
	autocmd VimEnter,WinEnter,BufRead * let w:m1=matchadd('ZenkakuSpace', '?@')
    augroup END
    call ZenkakuSpace()
endif

" =======================
"      エディタ設定
" =======================
highlight Normal ctermbg=none
set tabstop=2
set noexpandtab
set backspace=indent,eol,start
set shiftwidth=2
set textwidth=70
set colorcolumn=80
set clipboard+=unnamedplus
set nobackup
set noswapfile
set modifiable
set write
set undodir=$XDG_CONFIG_HOME/nvim/undodir
set tw=0
set wildmenu
set wildmode=full
autocmd BufWritePre * :%s/\s\+$//ge

set mouse=h
set mousehide

" Auto save is all you need
set autowrite
set updatetime=500

autocmd CursorHold * wall
autocmd CursorHoldI * wall

" =======================
"        フォント
" =======================
set guifont=Ricty\ 14
set guifontwide=Ricty\ 14

set autoindent smartindent expandtab tabstop=4 softtabstop=4 shiftwidth=4
" *.coffeeはcoffeescriptとして扱う
autocmd BufRead,BufNewFile,BufWritePre *.coffee set filetype=coffee

" =======================
"         環境系
" =======================
let g:python3_host_prog=expand($HOME.'/.pyenv/versions/3.5.1/bin/python')

