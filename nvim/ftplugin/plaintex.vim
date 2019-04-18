" =======================
"          Tex
" =======================

augroup MyGroup
	autocmd!
	autocmd BufWinEnter,BufNewFile,BufRead *.tex setfiletype tex
augroup END

autocmd BufNewFile,BufRead *.tex set filetype=tex

set formatoptions+=mM
set textwidth=80
set nocindent
set autoindent
set smartindent
set tabstop=2
set expandtab
set shiftwidth=2
set softtabstop=2

set conceallevel=0
