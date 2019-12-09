" =======================
"       neosnippet
" =======================

" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#snippets_directory='~/.config/nvim/dein/repos/github.com/Shougo/neosnippet-snippets/neosnippets'

" 自分用 snippet ファイルの場所
" let s:my_snippet = '~/dotfiles/.vim/snippets'
" let g:neosnippet#snippets_directory = s:my_snippet


" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif
