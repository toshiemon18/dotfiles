" =======================
"       Denite.nvim
" =======================
" Reference : http://replicity.hateblo.jp/entry/2017/06/03/140731

let s:denite_win_width_per = 0.4
let s:denite_win_height_per = 0.35

call denite#custom#option('default', {
			\ 'split': 'floating',
			\ 'winwidth': float2nr(&columns * s:denite_win_width_per),
			\ 'wincol': float2nr((&columns - (&columns * s:denite_win_width_per)) / 2),
			\ 'winheight': float2nr(&lines * s:denite_win_height_per),
			\ 'winrow': float2nr((&lines - (&lines* s:denite_win_height_per)) / 2),
			\})

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

