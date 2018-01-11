" ======================
"       neoterm
" ======================

" settings
" Auto return
let g:neoterm_autoscroll=1
" Open terminal mode buffer on horizontal position
let g:neoterm_position='vertical'

" keymapping
" Exit terminal mode with ESC
tnoremap <silent> <ESC> <C-\><C-n>
" Running current file
nnoremap <silent> <Leader>rf :TREPLSendFile<CR>
" Running current line on normal mode
nnoremap <silent> <Leader>rl :TREPLSendLine<CR>
" Running selected lines on visual mode
vnoremap <silent> <Leader>rs :TREPLSendSelection<CR>

" Toggle vertical terminal
nnoremap <silent> <Leader>tt :Ttoggle<CR><C-w><C-w>
