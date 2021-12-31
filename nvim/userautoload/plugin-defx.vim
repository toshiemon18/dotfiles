" defx.nvim

nnoremap <silent> <Space>f :<C-u>Defx -listed -resume -buffer-name=tab`tabpagenr()` <CR>
nnoremap <silent> <Space>F :<C-u>Defx -listed -resume -buffer-name=tab`tabpagenr()` -split=floating <CR>

set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Nerd\ Font\ Complete\ 12

" フォルダアイコンを表示できるようにする
let g:WebDevIconsNerdTreeBeforeGlyphPadding=""
let g:WebDevIconsUnicodeDecorateFolderNodes = v:true
if exists('g:loaded_webdevicons')
	call webdevicons#refresh()
endif

call defx#custom#column('git', 'indicators', {
	\ 'Modified'  : '●',
	\ 'Staged'    : '✚',
	\ 'Untracked' : '✭',
	\ 'Renamed'   : '➜',
	\ 'Unmerged'  : '═',
	\ 'Ignored'   : '☒',
	\ 'Deleted'   : '✖',
	\ 'Unknown'   : '?'
	\ })

call defx#custom#option('_', {
	\ 'winwidth': 40,
	\ 'split': 'vertical',
	\ 'direction': 'topleft',
	\ 'buffer_name': 'explorer',
	\ 'columns': 'indent:git:icons:filename',
	\ 'show_ignored_files': 1,
	\ })
let g:defx_icons_column_length = 1

autocmd FileType defx call s:defx_my_settings()
autocmd BufWritePost * call defx#redraw()
autocmd BufEnter * call defx#redraw()

function! s:defx_my_settings() abort
	" Define mappings
	nnoremap <silent><buffer><expr> <CR>
	\ defx#do_action('drop')
	noremap <silent><buffer><expr> c
	\ defx#do_action('copy')
	nnoremap <silent><buffer><expr> m
	\ defx#do_action('move')
	nnoremap <silent><buffer><expr> p
	\ defx#do_action('paste')
	nnoremap <silent><buffer><expr> l
	\ defx#do_action('drop')
	nnoremap <silent><buffer><expr> t
				\ defx#do_action('open', 'tabnew')
	nnoremap <silent><buffer><expr> E
	\ defx#do_action('drop', 'vsplit')
	nnoremap <silent><buffer><expr> H
	\ defx#do_action('drop', 'split')
	nnoremap <silent><buffer><expr> P
	\ defx#do_action('drop', 'pedit')
	nnoremap <silent><buffer><expr> o
	\ defx#do_action('open_or_close_tree')
	nnoremap <silent><buffer><expr> K
	\ defx#do_action('new_directory')
	nnoremap <silent><buffer><expr> N
	\ defx#do_action('new_file')
	nnoremap <silent><buffer><expr> M
	\ defx#do_action('new_multiple_files')
	nnoremap <silent><buffer><expr> C
	\ defx#do_action('toggle_columns',
	\                'mark:indent:icon:filename:type:size:time')
	nnoremap <silent><buffer><expr> S
	\ defx#do_action('toggle_sort', 'time')
	nnoremap <silent><buffer><expr> d
	\ defx#do_action('remove')
	nnoremap <silent><buffer><expr> r
	\ defx#do_action('rename')
	nnoremap <silent><buffer><expr> !
	\ defx#do_action('execute_command')
	nnoremap <silent><buffer><expr> x
	\ defx#do_action('execute_system')
	nnoremap <silent><buffer><expr> yy
	\ defx#do_action('yank_path')
	nnoremap <silent><buffer><expr> .
	\ defx#do_action('toggle_ignored_files')
	nnoremap <silent><buffer><expr> ;
	\ defx#do_action('repeat')
	nnoremap <silent><buffer><expr> h
	\ defx#do_action('cd', ['..'])
	nnoremap <silent><buffer><expr> ~
	\ defx#do_action('cd')
	nnoremap <silent><buffer><expr> q
	\ defx#do_action('quit')
	nnoremap <silent><buffer><expr> <Space>
	\ defx#do_action('toggle_select') . 'j'
	nnoremap <silent><buffer><expr> *
	\ defx#do_action('toggle_select_all')
	nnoremap <silent><buffer><expr> j
	\ line('.') == line('$') ? 'gg' : 'j'
	nnoremap <silent><buffer><expr> k
	\ line('.') == 1 ? 'G' : 'k'
	nnoremap <silent><buffer><expr> <C-l>
	\ defx#do_action('redraw')
	nnoremap <silent><buffer><expr> <C-g>
	\ defx#do_action('print')
	nnoremap <silent><buffer><expr> cd
	\ defx#do_action('change_vim_cwd')

	" defx-git mappings
	" go to the next file that has a git status
	nnoremap <buffer><silent> [c <Plug>(defx-git-prev)
	" go to the previous file that has a git status
	nnoremap <buffer><silent> ]c <Plug>(defx-git-next)
	" Stages the file/directory under cursor
	nnoremap <buffer><silent> ]a <Plug>(defx-git-stage)
	" Unstages the file/directory under cursor
	nnoremap <buffer><silent> ]r <Plug>(defx-git-reset)
	" Discards all changes to file/directory under cursor
	nnoremap <buffer><silent> ]d <Plug>(defx-git-discard)
endfunction

