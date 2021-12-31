" =======================
"       Denite.nvim
" =======================
" Reference : http://replicity.hateblo.jp/entry/2017/06/03/140731

autocmd FileType denite call s:denite_my_settings()

function! s:denite_my_settings() abort
	" inoremap <silent><buffer><expr> <BS> denite#do_map('move_up_path')
	nnoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
	nnoremap <silent><buffer><expr> d denite#do_map('do_action', 'delete')
	nnoremap <silent><buffer><expr> p denite#do_map('toggle_auto_action', 'preview')
	nnoremap <silent><buffer><expr> i denite#do_map('open_filter_buffer')
	nnoremap <silent><buffer><expr> a denite#do_map('open_filter_buffer')
	nnoremap <silent><buffer><expr> <Tab> denite#do_map('choose_action')
	nnoremap <silent><buffer><expr> <Space> denite#do_map('toggle_select').'j'

	" ESCでdeniteからquit
	nnoremap <silent><buffer><expr> q denite#do_map('quit')
	nnoremap <silent><buffer><expr> <ESC><ESC> denite#do_map('quit')

	" C-j, C-kでbuffer内を移動
	nnoremap <silent><buffer> <C-j> j
	nnoremap <silent><buffer> <C-k> k
	nnoremap <silent><buffer><expr> <C-h> denite#do_map('do_action', 'split')
	nnoremap <silent><buffer><expr> <C-v> denite#do_map('do_action', 'vsplit')
endfunction

autocmd FileType denite-filter call s:denite_filter_my_settings()
function! s:denite_filter_my_settings() abort
	" inoremap <silent><buffer><expr> <BS> denite#do_map('move_up_path')

	" ESCでdeniteからquit
	nnoremap <silent><buffer><expr> <ESC> denite#do_map('move_up_path')
	inoremap <silent><buffer><expr> <ESC> denite#do_map('move_up_path')

	inoremap <silent><buffer> <C-j> <Down>
	inoremap <silent><buffer> <C-k> <Up>

	inoremap <silent><buffer> <C-j> <Esc><C-w>p:call cursor(line('.')+1,0)<CR><C-w>pA
	inoremap <silent><buffer> <C-k> <Esc><C-w>p:call cursor(line('.')-1,0)<CR><C-w>pA
endfunction

let s:denite_win_width_per = 0.4
let s:denite_win_height_per = 0.35

" call denite#custom#option('default', {
" 			\ 'split': 'floating',
" 			\ 'winwidth': float2nr(&columns * s:denite_win_width_per),
" 			\ 'winheight': float2nr(&lines * s:denite_win_height_per),
" 			\ 'wincol': float2nr((&columns - (&columns * s:denite_win_width_per)) / 2),
" 			\ 'winrow': float2nr((&lines - (&lines* s:denite_win_height_per)) / 2),
" 			\ 'prompt': '( ˘ω˘) >>> ',
" 			\ 'auto_action': 'preview',
" 			\ 'auto_preview': v:true,
" 			\ 'vertical_preview': v:true,
" 			\ 'floating_preview': v:true,
" 			\ 'preview_width': float2nr(&columns * s:denite_win_width_per),
" 			\ 'preview_height': float2nr(&lines * s:denite_win_height_per),
" 			\ 'preview_col': float2nr((&columns - (&columns * s:denite_win_width_per)) / 2),
" 			\ 'preview_row': float2nr((&lines - (&lines* s:denite_win_height_per)) / 2),
" 			\})

let s:floating_window_width_ratio = 1.0
let s:floating_window_height_ratio = 0.7

call denite#custom#option('default', {
	\ 'split': 'floating',
	\ 'prompt': '% ',
	\ 'auto_action': 'preview',
	\ 'floating_preview': v:true,
	\ 'match_highlight': v:true,
	\ 'vertical_preview': v:true,
	\ 'preview_height': float2nr(&lines * s:floating_window_height_ratio),
	\ 'preview_width': float2nr(&columns * s:floating_window_width_ratio / 2),
	\ 'wincol': float2nr((&columns - (&columns * s:floating_window_width_ratio)) / 2),
	\ 'winheight': float2nr(&lines * s:floating_window_height_ratio),
	\ 'winrow': float2nr((&lines - (&lines * s:floating_window_height_ratio)) / 2),
	\ 'winwidth': float2nr(&columns * s:floating_window_width_ratio / 2),
	\ })


call denite#custom#option('_', {
			\ 'prompt': '( ˘ω˘) >>> ',
			\ 'cursor_shape': v:true,
			\ 'cursor_wrap': v:true,
			\ 'highlight_filter_background': 'DeniteFilter',
			\ 'highlight_matched_char': 'Underlined',
			\ 'start_filter': v:true,
			\ 'statusline': v:false,
			\ 'split': 'floating'
			\})

call denite#custom#var('grep', 'command', ['ag'])
call denite#custom#var('grep', 'default_opts', ['-i', '--vimgrep'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', [])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

let s:ignore_globs = ['.git', 'node_modules']
call denite#custom#var(
			\ 'file/rec',
			\ 'command',
			\ ['ag',
			\  '--follow',
			\ ] + map(deepcopy(s:ignore_globs), {k, v -> '--ignore=' . v}) + [
			\	 '--nocolor',
			\	 '--no-group',
			\  '-g',
			\	 ''])
" file/recで検索から除外するディレクトリ名
call denite#custom#filter(
			\ 'matcher/ignore_globs',
			\ 'ignore_globs',
			\ s:ignore_globs
			\)

" " Denite用キーマップ
nnoremap [denite] <Nop>
nmap <Space>d [denite]
" ファイル一覧
noremap [denite]n :Denite file -floating-preview<CR>
" 最近使ったファイルの一覧
noremap [denite]z :Denite file/old -floating-preview<CR>
" カレントディレクトリ
noremap [denite]a :Denite file/rec -floating-preview<CR>
" カレントディレクトリ以下+buffer内から探す
noremap [denite]x :Denite file/rec buffer -floating-preview<CR>
"バッファ一覧
noremap [denite]b :<C-u>Denite buffer -buffer-name=buffer<CR>
" 開いているファイルのディレクトリ以下のファイル一覧
nnoremap [denite]f :<C-u>DeniteBufferDir -direction=topleft file file:new -floating-preview<CR>
" /をDeniteに任せる
" nnoremap <silent> / :<C-u>Denite -buffer-name=search -auto-resize line<CR>

" denite-git
noremap [denite-git] <Nop>
nmap 		<Space>G [denite-git]
nnoremap [denite-git]s :<C-u>Denite<Space>gitstatus<CR>
nnoremap [denite-git]c :<C-u>Denite<Space>gitchanged<CR>
nnoremap [denite-git]b :<C-u>Denite<Space>gitbranch<CR>
nnoremap [denite-git]l  :<C-u>Denite<Space>gitlog<CR>

" denite-rails
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
