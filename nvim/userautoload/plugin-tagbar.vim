" ================
"  tagbar
" ================

let g:tagbar_width=20
let g:tagbar_left = 0
let g:tagbar_autofocus=1

" CoffeeScript
let g:tagbar_type_coffee = {
    \ 'ctagstype': 'coffee',
    \ 'kinds': [
        \ 'c:classes',
        \ 'm:methods',
        \ 'functions',
        \ 'v:variables',
        \ 'f:fields'
    \ ]
    \}

" Elixir
let g:tagbar_type_elixir = {
    \ 'ctagstype' : 'elixir',
    \ 'kinds' : [
        \ 'f:functions',
        \ 'functions:functions',
        \ 'c:callbacks',
        \ 'd:delegates',
        \ 'e:exceptions',
        \ 'i:implementations',
        \ 'a:macros',
        \ 'o:operators',
        \ 'm:modules',
        \ 'p:protocols',
        \ 'r:records',
        \ 't:tests'
    \ ]
    \ }

" CSS
let g:tagbar_type_css = {
\ 'ctagstype' : 'Css',
    \ 'kinds'     : [
        \ 'c:classes',
        \ 's:selectors',
        \ 'i:identities'
    \ ]
\ }

" Markdown
let g:tagbar_type_markdown = {
    \ 'ctagstype' : 'markdown',
    \ 'ctagsbin' : '~/markdown2ctags/markdown2ctags.py',
    \ 'ctagargs' : '-f - --sort=yes',
    \ 'kinds' : [
        \ 'h:Heading_L1',
        \ 'i:Heading_L2',
        \ 'k:Heading_L3'
    \ ],
    \ 'sro' : '|',
    \ 'kind2scope' : {
        \ 's' : 'section',
    \ },
    \ 'sort': 0,
\ }

let g:tagbar_type_ruby = {
    \ 'kinds' : [
        \ 'm:modules',
        \ 'c:classes',
        \ 'd:describes',
        \ 'C:contexts',
        \ 'f:methods',
        \ 'F:singleton methods'
    \ ]
\ }
