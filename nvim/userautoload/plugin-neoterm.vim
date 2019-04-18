" ======================
"       neoterm
" ======================

" settings
" Auto return
let g:neoterm_autoscroll=1
" Open terminal mode buffer on horizontal position
let g:neoterm_default_mod="belowright"
" Terminal split size
let g:neoterm_size=15
" Auto-jump
let g:neoterm_autojump=1
" Auto-insert
let neoterm_autoinsert=1

" keymapping
noremap [neoterm] <Nop>
nmap <Space>n [neoterm]

" Exit terminal mode with ESC
tnoremap <silent> <ESC> <C-\><C-n>
" Running current file
nnoremap <silent> [neoterm]rf :TREPLSendFile<CR>
" Running current line on normal mode
nnoremap <silent> [neoterm]rl :TREPLSendLine<CR>
" Running selected lines on visual mode
vnoremap <silent> [neoterm]rs :TREPLSendSelection<CR>

" Send make command
nnoremap <silent> [neoterm]m :T make<CR>:echo("Execute command: make")<CR>

" Toggle vertical terminal
nnoremap <silent> [neoterm]tt :Ttoggle<CR>
