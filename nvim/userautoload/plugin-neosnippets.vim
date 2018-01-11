" =======================
"       neosnippet
" =======================

" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 0
let g:neosnippet#snippets_directory='~/.config/nvim/dein/repos/github.com/Shougo/neosnippet-snippets/neosnippets'

" 自分用 snippet ファイルの場所
" let s:my_snippet = '~/dotfiles/.vim/snippets'
" let g:neosnippet#snippets_directory = s:my_snippet

" SuperTab like snippets behavior.
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
                \ "\<Plug>(neosnippet_expand_or_jump)"
                \: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
                \ "\<Plug>(neosnippet_expand_or_jump)"
                \: "\<TAB>"

imap <C-x> <Plug>(neosnippet_expand_or_jump)
smap <C-x> <Plug>(neosnippet_expand_or_jump)

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif
