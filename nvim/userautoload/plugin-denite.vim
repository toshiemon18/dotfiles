" =======================
"       Denite.nvim
" =======================
" Reference : http://replicity.hateblo.jp/entry/2017/06/03/140731

autocmd FileType denite call s:denite_my_settings()

function! s:denite_my_settings() abort
	nnoremap <silent><buffer><expr> <CR>  denite#do_map('do_action')
	nnoremap <silent><buffer><expr> d denite#do_map('do_action', 'delete')
	nnoremap <silent><buffer><expr> p denite#do_map('do_action', 'preview')
	nnoremap <silent><buffer><expr> i denite#do_map('open_filter_buffer')
	nnoremap <silent><buffer><expr> <Tab>   denite#do_map('choose_action')

	" ESCでdeniteからquit
	nnoremap <silent><buffer><expr> <ESC> denite#do_map('quit')

	" C-j, C-kでbuffer内を移動
	nnoremap <silent><buffer> <C-j> j
	nnoremap <silent><buffer> <C-k> k
	nnoremap <silent><buffer> <C-h> denite#do_map('do_action', 'split')
	nnoremap <silent><buffer> <C-v> denite#do_map('do_action', 'vsplit')
endfunction

autocmd FileType denite-filter call s:denite_filter_my_settings()
function! s:denite_filter_my_settings() abort
	" ESCでdeniteからquit
	nnoremap <silent><buffer><expr> <ESC> denite#do_map('quit')
	inoremap <silent><buffer><expr> <ESC> denite#do_map('quit')
	" nnoremap <silent><buffer><expr> q denite#do_map('quit')
	inoremap <silent><buffer> <C-j>   <Esc><C-w>p:call cursor(line('.')+1,0)<CR><C-w>pA
	inoremap <silent><buffer> <C-k>   <Esc><C-w>p:call cursor(line('.')-1,0)<CR><C-w>pA
endfunction


" " Denite用キーマップ
nnoremap [denite] <Nop>
nmap <Space>d [denite]

" バッファ一覧
noremap [denite]p :Denite buffer<CR>

" ファイル一覧
noremap [denite]n :Denite -buffer-name=file file<CR>
" 最近使ったファイルの一覧
noremap [denite]z :Denite file_old<CR>
" カレントディレクトリ
noremap [denite]a :Denite file_rec<CR>
"バッファ一覧
noremap [denite]b :<C-u>Denite buffer -buffer-name=file<CR>:
" 開いているファイルのディレクトリ以下のファイル一覧
nnoremap [denite]f :<C-u>DeniteBufferDir
            \ -direction=topleft file file:new<CR>
" /をDeniteに任せる
nnoremap <silent> / :<C-u>Denite -buffer-name=search -auto-resize line<CR>

" Sources
" rails
noremap [rails] <Nop>
nmap     <Space>r [rails]
nnoremap [rails]r :Denite<Space>rails:
nnoremap <silent> [rails]r :<C-u>Denite<Space>rails:dwim<Return>
nnoremap <silent> [rails]m :<C-u>Denite<Space>rails:model<Return>
nnoremap <silent> [rails]c :<C-u>Denite<Space>rails:controller<Return>
nnoremap <silent> [rails]v :<C-u>Denite<Space>rails:view<Return>
nnoremap <silent> [rails]h :<C-u>Denite<Space>rails:helper<Return>
nnoremap <silent> [rails]r :<C-u>Denite<Space>rails:test<Return>
nnoremap <silent> [rails]s :<C-u>Denite<Space>rails:spec<Return>

" denite-git
noremap [denite-git] <Nop>
nmap 		<Space>g [denite-git]
nnoremap [denite-git]s :<C-u>Denite<Space>gitstatus<CR>
nnoremap [denite-git]c :<C-u>Denite<Space>gitchanged<CR>
nnoremap [denite-git]b :<C-u>Denite<Space>gitbranch<CR>
