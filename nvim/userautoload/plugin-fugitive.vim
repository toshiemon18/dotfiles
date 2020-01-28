" =====================
"     vim-fugitive
" =====================

nmap [fugitive] <Nop>
map <Space>g [fugitive]
nmap <silent> [fugitive]s :<C-u>Gstatus<CR><C-W>T
nmap <silent> [fugitive]d :<C-u>Gdiff<CR>
nmap <silent> [fugitive]l :<C-u>Glog<CR>

" Gstatus reference
" how this help
" <C-N> next file
" <C-P> previous file
" <CR>  |:Gedit|
" -     |:Git| add
" -     |:Git| reset (staged files)
" cA    |:Gcommit| --amend --reuse-message=HEAD
" ca    |:Gcommit| --amend
" cc    |:Gcommit|
" cva   |:Gcommit| --amend --verbose
" cvc   |:Gcommit| --verbose
" D     |:Gdiff|
" ds    |:Gsdiff|
" dp    |:Git!| diff (p for patch; use :Gw to apply)
" dp    |:Git| add --intent-to-add (untracked files)
" dv    |:Gvdiff|
" O     |:Gtabedit|
" o     |:Gsplit|
" p     |:Git| add --patch
" p     |:Git| reset --patch (staged files)
" q     close status
" r     reload status
" S     |:Gvsplit|
" U     |:Git| checkout
" U     |:Git| checkout HEAD (staged files)
" U     |:Git| clean (untracked files)
" U     |:Git| rm (unmerged files)
